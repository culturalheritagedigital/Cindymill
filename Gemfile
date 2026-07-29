source "https://rubygems.org"

# Jekyll selbst - explizit gepinnt, damit lokaler Build und CI identisch bleiben.
gem "jekyll", "~> 4.4"

# Sass ueber sass-embedded statt des auf Ruby 3.4 / arm64 nicht mehr
# baubaren sassc.
gem "jekyll-sass-converter", "~> 3.0"

# Kein Theme-Gem mehr: "basically-basic" 1.4.5 ist unmaintained und liegt
# seit AP 3.4 vendort im Repo.

# Jekyll plugins
group :jekyll_plugins do
  gem "jekyll-feed"
  gem "jekyll-seo-tag"
  gem "jekyll-sitemap"
  gem "jekyll-paginate"
end

# WEBrick ist seit Ruby 3.0 nicht mehr Teil der Standardbibliothek,
# wird aber von `jekyll serve` gebraucht.
gem "webrick", "~> 1.8"

group :test do
  gem "html-proofer", "~> 5.0"
end
