# frozen_string_literal: true

require 'cgi'

# Bild-Attribute automatisch ergaenzen (AP 4)
#
# Ergaenzt in jeder gerenderten HTML-Seite an allen <img>-Tags:
#   * loading="lazy"      - Bilder ausserhalb des Viewports werden erst
#                           geladen, wenn sie gebraucht werden
#   * decoding="async"    - Dekodierung blockiert das Rendern nicht
#   * width= / height=    - Originalmasse aus der Bilddatei, damit der Browser
#                           den Platz vorab reservieren kann (kein Layout-Shift)
#
# Warum als Plugin und nicht in den Quelldateien?
# Die 181 Bilder des Builds stammen aus drei Quellen: Markdown-Kurzschreibweise
# (95x), rohe <img>-Tags im Fliesstext (74x) und Theme-Includes (page-intro,
# entry, about). Nur ein Nachbearbeitungsschritt erreicht alle drei. Vor allem
# aber muessten width/height sonst als feste Zahlen im Text stehen und wuerden
# beim naechsten Neuskalieren eines Bildes still falsch - hier werden sie bei
# jedem Build aus der Datei gelesen.
#
# Bereits vorhandene Attribute werden nie ueberschrieben: Das Hero-Bild in
# _includes/page-intro.html setzt loading="eager" und fetchpriority="high"
# selbst und behaelt das auch.
#
# GitHub Pages fuehrt eigene Plugins nur beim Build ueber GitHub Actions aus
# (AP 6) - genau so wird die Seite gebaut. Der klassische Pages-Build wuerde
# _plugins/ ignorieren; er scheidet wegen Jekyll 3.9 ohnehin aus.

module Cindymill
  # Liest Bildmasse aus den Dateikoepfen. Bewusst ohne zusaetzliches Gem
  # (fastimage o. ae.) - im Projekt kommen nur vier Formate vor.
  module ImageSize
    module_function

    # @return [Array(Integer, Integer), nil] [Breite, Hoehe] oder nil
    def read(path)
      File.open(path, 'rb') do |io|
        case File.extname(path).downcase
        when '.jpg', '.jpeg' then jpeg(io)
        when '.png'          then png(io)
        when '.gif'          then gif(io)
        when '.svg'          then svg(io)
        end
      end
    rescue StandardError
      nil
    end

    def png(io)
      head = io.read(24)
      return nil unless head && head[0, 8] == "\x89PNG\r\n\x1A\n".b && head[12, 4] == 'IHDR'

      head[16, 8].unpack('N2')
    end

    def gif(io)
      head = io.read(10)
      return nil unless head && head[0, 3] == 'GIF'

      head[6, 4].unpack('v2')
    end

    # JPEG: Segmente durchlaufen, bis ein SOF-Marker kommt - dort stehen die
    # Masse. SOF4 (DHT), SOF8 (JPG) und SOFC (DAC) sind keine Frame-Header.
    def jpeg(io)
      return nil unless io.read(2) == "\xFF\xD8".b

      loop do
        byte = io.read(1)
        return nil if byte.nil?
        next unless byte == "\xFF".b

        marker = io.read(1)
        return nil if marker.nil?

        code = marker.ord
        next if code == 0xFF || code.zero?           # Fuellbytes
        next if code.between?(0xD0, 0xD9)            # RSTn/SOI ohne Laenge

        length = io.read(2)&.unpack1('n')
        return nil if length.nil? || length < 2

        if code.between?(0xC0, 0xCF) && ![0xC4, 0xC8, 0xCC].include?(code)
          frame = io.read(5)
          return nil if frame.nil? || frame.bytesize < 5

          height, width = frame[1, 4].unpack('n2')
          return [width, height]
        end

        io.seek(length - 2, IO::SEEK_CUR)
      end
    end

    # SVG: width/height nur verwenden, wenn sie in px (oder einheitenlos)
    # angegeben sind. Sonst aus der viewBox ableiten - das Seitenverhaeltnis
    # ist das, worauf es dem Browser hier ankommt.
    def svg(io)
      head = io.read(4096).to_s
      tag = head[/<svg\b[^>]*>/m]
      return nil unless tag

      w = tag[/\bwidth\s*=\s*["']([\d.]+)(?:px)?["']/, 1]
      h = tag[/\bheight\s*=\s*["']([\d.]+)(?:px)?["']/, 1]
      return [w.to_f.round, h.to_f.round] if w && h

      box = tag[/\bviewBox\s*=\s*["']([^"']+)["']/, 1]
      return nil unless box

      parts = box.split(/[\s,]+/)
      return nil unless parts.size == 4

      [parts[2].to_f.round, parts[3].to_f.round]
    end
  end

  # Schreibt die Attribute in die fertige HTML-Ausgabe.
  class ImageAttributes
    IMG_TAG = /<img\b[^>]*>/i

    def initialize(site)
      @site = site
      @baseurl = site.config['baseurl'].to_s
      @dimensions = {}
    end

    def process(html)
      html.gsub(IMG_TAG) { |tag| rewrite(tag) }
    end

    private

    def rewrite(tag)
      additions = +''
      additions << ' loading="lazy"' unless tag.match?(/\bloading\s*=/i)
      additions << ' decoding="async"' unless tag.match?(/\bdecoding\s*=/i)

      additions << missing_dimensions(tag)

      return tag if additions.empty?

      # Vor dem schliessenden > einfuegen, self-closing />-Form erhalten.
      tag.sub(%r{\s*/?>\z}) { |close| "#{additions}#{close.strip == '/>' ? ' />' : '>'}" }
    end

    # Ergaenzt fehlende Masse. Steht im Quelltext schon eine der beiden
    # Angaben (drei Icons tun das), wird die andere aus dem Seitenverhaeltnis
    # der Datei abgeleitet - erst das Paar verhindert den Layout-Shift.
    def missing_dimensions(tag)
      given_w = tag[/\bwidth\s*=\s*["']?(\d+)/i, 1]
      given_h = tag[/\bheight\s*=\s*["']?(\d+)/i, 1]
      return '' if given_w && given_h

      size = dimensions_for(tag[/\bsrc\s*=\s*["']([^"']+)["']/i, 1])
      return '' if size.nil? || size[0].to_i.zero? || size[1].to_i.zero?

      if given_w
        %( height="#{(given_w.to_i * size[1].to_f / size[0]).round}")
      elsif given_h
        %( width="#{(given_h.to_i * size[0].to_f / size[1]).round}")
      else
        %( width="#{size[0]}" height="#{size[1]}")
      end
    end

    def dimensions_for(src)
      return nil if src.nil? || src.empty?

      @dimensions.fetch(src) { @dimensions[src] = lookup(src) }
    end

    def lookup(src)
      path = local_path(src)
      path && File.file?(path) ? ImageSize.read(path) : nil
    end

    # Wandelt eine gerenderte src-URL in einen Pfad im Quellverzeichnis.
    # Fremde Hosts (Badges von shields.io, Zenodo, licensebuttons.net) und
    # data:-URIs haben keine lokale Entsprechung.
    def local_path(src)
      return nil if src.start_with?('http://', 'https://', '//', 'data:')

      url = src.split(/[?#]/).first.to_s
      url = CGI.unescape(url)
      return nil unless url.start_with?('/')

      unless @baseurl.empty?
        return nil unless url.start_with?("#{@baseurl}/")

        url = url.delete_prefix(@baseurl)
      end

      File.join(@site.source, url)
    end
  end
end

# Pro Build eine frische Instanz - sonst haelt der Masse-Cache unter
# `jekyll serve` an einem inzwischen ausgetauschten Bild fest.
Jekyll::Hooks.register :site, :pre_render do |site|
  site.config[:cindymill_image_attributes] = Cindymill::ImageAttributes.new(site)
end

Jekyll::Hooks.register %i[pages documents], :post_render do |item|
  next unless item.output_ext == '.html'
  next if item.output.nil?

  rewriter = item.site.config[:cindymill_image_attributes]
  item.output = rewriter.process(item.output) if rewriter
end
