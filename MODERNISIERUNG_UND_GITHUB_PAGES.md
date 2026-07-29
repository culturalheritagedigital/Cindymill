# Cindymill — Technische Modernisierung & Umzug zu GitHub Pages

**Stand:** 30.07.2026 (Rev. 5 — AP 0, 1, 2 und 3 ausgeführt)
**Arbeitsordner (Jekyll-Quellcode):** `/Users/nikoplath/Code/2026_Website_Cindymill`
**Backup des Ionos-Servers:** `/Users/nikoplath/Code/2026_Backup_Website_Cindymill_Ionos` (FTP-Spiegel inkl. `logs/`, 995 MB)

> Der frühere Quellordner `/Users/nikoplath/Daten/Website/Cindymill/work/` ist leer — der Quellcode liegt jetzt vollständig im Arbeitsordner. Der FTP-Spiegel ist ins Backup ausgelagert. Damit ist die Ausgangslage sauber getrennt.

## Rahmenbedingungen (Entscheidungen vom 29.07.2026)

| Entscheidung | Konsequenz |
|---|---|
| **Inhalt bleibt 1:1 erhalten**, die Seite wird **nicht erweitert** | Rein technischer Umzug. Keine neuen Seiten, keine neuen Medien, kein Reaktivieren auskommentierter Inhalte (Videos, Suche). |
| **Ionos-Webspace *und* Domain `cindymill.xyz` werden gekündigt** | Kein Custom-Domain-Setup, kein DNS, kein CNAME. Zieladresse ist dauerhaft `https://culturalheritagedigital.github.io/Cindymill/`. Siehe Risiken. |
| **Die Website zieht in das bestehende Repo `culturalheritagedigital/Cindymill`** | Das Repo wird umgewidmet: Website im Root, Modelldaten im Unterordner `model/`. Sterne, Forks, Issues und die 54 Commits Historie bleiben erhalten. `baseurl` ist `/Cindymill` (Groß-/Kleinschreibung beachten). |
| **Nicht genutzte Assets werden gelöscht** | 346 Dateien / 708 MB entfallen ersatzlos, inkl. **aller Videos**. |
| **Google Analytics wird ersatzlos entfernt** | Keine Cookies, kein Consent-Banner, Analytics-Abschnitt der Datenschutzerklärung entfällt. |

---

## 1. Ist-Zustand

### 1.1 Hosting (Ionos) — wird abgelöst

| Merkmal | Befund |
|---|---|
| Server | Apache, `217.160.0.21` / `2001:8d8:100f:f000::200` |
| Protokoll | nur HTTP/1.1, kein HTTP/2 |
| Letzte Änderung | `Last-Modified: Sun, 09 Oct 2022` — die Seite ist seit ~3,8 Jahren unverändert |
| Kompression | **keine** (kein `Content-Encoding: gzip/br`) |
| Caching | **keine** `Cache-Control`/`Expires`-Header |
| HTTPS | **defekt** — Port 443 offen, aber TLS-Handshake bricht bei SNI ab (`tlsv1 alert internal error`). Dem vHost ist kein Zertifikat zugeordnet. |

Da Webspace und Domain gekündigt werden, ist an keinem dieser Punkte etwas zu reparieren. GitHub Pages liefert HTTP/2, Kompression, Caching und ein Let's-Encrypt-Zertifikat für `*.github.io` ab Werk.

### 1.2 Technologie-Stack

Ausgangslage (vor AP 3) und Stand nach AP 3:

| Komponente | vorher | nachher (AP 3) |
|---|---|---|
| Jekyll | 4.2.1 (Okt 2021) | **4.4.1**, gepinnt auf `~> 4.4` |
| Theme | `jekyll-theme-basically-basic` 1.4.5 — seit ~2019 nicht gepflegt, **lokal nicht installiert** | **vendort im Repo**, kein Gem mehr |
| jekyll-seo-tag | 2.7.1 | 2.9.0 |
| jekyll-sass-converter | 2.1.0 (via `sassc`) — **kritisch**, native Extension, baut auf Ruby 3.4 / arm64 nicht mehr | **3.1.0 via `sass-embedded` 1.102** |
| `Gemfile.lock` | Plattform `x64-mingw32` (Windows) | neu aufgelöst, `arm64-darwin`/`ruby` |
| jekyll-algolia | im Gemfile, ungenutzt (`search: false`) | entfernt |
| `wdm` | Windows-Only | entfernt |
| html-proofer | nicht vorhanden | 5.2.2 in der Test-Gruppe |

Lokal: Ruby 3.4.1, Bundler 2.6.6, `gh` 2.96.0 (seit AP 0 installiert). Der Arbeitsordner ist seit AP 0 ein Klon von `culturalheritagedigital/Cindymill` auf dem Branch `website-migration`.

> ✅ **Der Build läuft seit AP 3.** Vorher fehlte das Theme-Gem lokal und damit `_layouts/` und `_sass/` komplett — im Projekt lagen nur 70 überschriebene `_includes/`. Das Gem wurde einmal von rubygems.org geholt und sofort vendort (AP 3.4); danach besteht keine Abhängigkeit von ihm mehr.

### 1.3 Technische Fehler — verifiziert

#### 🔴 A) Galerie und CAD-Download sind live kaputt (Windows-Backslashes)

**73 Pfade in 3 gebauten Quelldateien** verwenden Windows-Trenner:

| Datei | Backslash-Pfade |
|---|---:|
| `gallery.md` | 68 |
| `files.md` | 3 |
| `community.md` | 2 |

```html
<a href="#"><img src="../assets\images\gallery\frame/frame2.jpg" alt=""></a>
```

Verifiziert:

```
http://cindymill.xyz/assets%5Cimages%5Cgallery%5Cframe/frame2.jpg  → 404
http://cindymill.xyz/assets/images/gallery/frame/frame2.jpg        → 200
```

Betroffen: die **komplette Galerie** sowie der Download `2021_09_22_Cindymill_Complete_Model.zip` auf `files.html`. Schwerwiegendster inhaltlicher Defekt der Seite.

> **Korrektur gegenüber Rev. 1:** Dort war von „171 Pfaden in 4 Dateien" die Rede. 98 davon liegen in `_gallery_fancy.md` — siehe Befund F, diese Datei wird gar nicht gebaut. Live kaputt sind 73 Pfade.

#### 🔴 B) MathJax von einem seit 2017 abgeschalteten CDN

In `_includes/head.html`, dadurch auf **allen 27 Seiten**:

```html
<script async src="http://cdn.mathjax.org/mathjax/latest/MathJax.js?config=TeX-AMS-MML_HTMLorMML">
```

`cdn.mathjax.org` existiert nicht mehr (Abschaltung 2017), zusätzlich `http://` → unter HTTPS Mixed-Content-Blockade. Die Seite enthält keine Formeln: ersatzlos streichen.

#### 🔴 C) `url`/`baseurl` leer → SEO-Metadaten unbrauchbar

`_config.yml` hat `url: ""` und `baseurl: ""`. Folgen im Build:

```html
<link rel="canonical" href="/" />
<meta property="og:url" content="/" />
<meta property="og:image" content="/assets/images/front.jpg" />
```

`sitemap.xml` enthält `<loc>/assembly/…/</loc>` (relativ = ungültig), `robots.txt` verweist auf `Sitemap: /sitemap.xml` (ungültig).

#### 🔴 D) NEU: Absolute Asset-Pfade brechen unter dem `/Cindymill/`-Unterpfad

Weil die Domain entfällt, läuft die Seite unter einem **Projekt-Unterpfad** (`baseurl: "/Cindymill"`). Damit werden alle Pfade der Form `/assets/…` und `../assets/…` ungültig — sie zeigen dann auf `culturalheritagedigital.github.io/assets/…` statt in das Projekt.

Betroffen sind **185 Asset-Referenzen in 23 gebauten Quelldateien**:

| Pfadform | Vorkommen | Problem |
|---|---:|---|
| `assets\…` (Backslash) | 73 | schon heute tot (Befund A) |
| `/assets/…` (absolut) | 106 | bricht unter `baseurl` |
| `../assets/…` (relativ) | 66 | bricht zusätzlich bei `permalink`-Änderungen |

Die drei Kategorien überlappen sich teilweise (`../assets\images\…`). Alle müssen in einem Durchgang auf `relative_url` normalisiert werden — das ist jetzt ein **Blocker**, nicht mehr nur eine Aufräumarbeit. Hinzu kommen 8 Referenzen in `_includes/head.html` und `author.picture`/`logo` in `_config.yml`.

#### 🟠 E) Google Analytics — wird entfernt

- `_includes/head.html` lädt **hart codiert** GA4 `G-6J78SX32JE` — ohne Consent, ohne Opt-out.
- `_config.yml` enthält zusätzlich `google_analytics: G-EFN1CTB4WB`.
- `legal_notice.md` beschreibt **Universal Analytics** mit `_gat._anonymizeIp` und Opt-out-Add-on — beschreibt weder GA4 noch die Realität.

Entscheidung: beides ersatzlos entfernen, Rechtstext entsprechend kürzen (AP 5).

> 🔴 **Korrektur (bei AP 3 belegt): `G-EFN1CTB4WB` ist keine Leiche.** Rev. 4 hielt die ID für nicht ausgeliefert. Das galt nur, weil bisher ohne `JEKYLL_ENV=production` gebaut wurde: `_includes/scripts.html` zieht `google-analytics.html` unter der Bedingung `jekyll.environment == 'production' and site.google_analytics`. Gegengeprüft mit einem Produktionsbuild:
>
> ```
> JEKYLL_ENV=production bundle exec jekyll build
>   → 2× G-6J78SX32JE  (hart codiert in head.html)
>   → 1× G-EFN1CTB4WB  (aus _config.yml via scripts.html)
> ```
>
> Der geplante Actions-Workflow setzt `JEKYLL_ENV=production` (AP 6). Die Seite hätte also **zwei** Analytics-Properties ohne Consent ausgeliefert — mehr als die alte Seite je hatte, ausgelöst durch den Umzug selbst. AP 4 muss deshalb **beide** Stellen entfernen; das Löschen des `head.html`-Snippets allein genügt nicht.

#### 🟠 F) NEU: Zwei tote Quelldateien im Projekt

`_gallery_fancy.md` (16 KB) und `_about_us.md` beginnen mit einem Unterstrich. Jekyll ignoriert solche Dateien im Root — sie erzeugen **keine Seite**, bestätigt gegen `_site/`. Es sind unfertige Entwürfe. Sie sind zu löschen; Assets, die *nur* dort referenziert werden, gelten als verwaist.

#### 🟠 G) Weitere Befunde

- `legal_notice.md`: `href="www.cindymill.xyz"` ohne Schema → wird als relativer Pfad interpretiert, tot. Muss ohnehin auf die neue Adresse.
- `assets/stylesheets/main.css.map` (218 KB) öffentlich abrufbar — unnötig.
- Ungültiges HTML: `<meta name='ir-site-verification-token' value='276008534' />` — `value` statt `content`.
- IE-Altlasten: `<meta http-equiv="X-UA-Compatible">`, „cut the mustard"-Script, `no-js`-Klasse.
- Bilder ohne `loading="lazy"`, ohne `width`/`height` → Layout-Shift und langsames Laden.
- Google Fonts (Fira Sans) vom Google-Server → DSGVO-Thema (LG München 2022) und Render-Blocking.
- Lunr-Suchdateien werden ausgeliefert, obwohl `search: false` — tote Fracht.
- `_config.yml` deklariert eine Collection `gallery`, ein Ordner `_gallery/` existiert nicht.
- Auskommentierter `<video>`-Block in `gallery.md` (Zeile 591) — bleibt auskommentiert bzw. wird gelöscht (Inhalt wird nicht erweitert).

#### 🟠 H) NEU (bei AP 2 gefunden): Icon-Pfade in `site.webmanifest` und `browserconfig.xml`

Beide Dateien liegen unter `assets/images/favicons/` und enthalten absolute `/assets/…`-Pfade auf die App-Icons. Da sie **kein Front Matter** haben, behandelt Jekyll sie als statische Dateien und kopiert sie unverändert — Liquid wird darin nicht ausgewertet. Unter `/Cindymill/` hätten sie damit auf tote Pfade gezeigt, ohne dass es im HTML sichtbar geworden wäre. Behoben in AP 2.

#### 🟠 I) NEU (bei AP 3 gefunden): `_includes/image-gallery.html` — toter Include mit Fremd-Proxy

Ein lokal hinzugefügter Include (nicht Teil des Themes), der **von keiner Seite eingebunden** wird. Er hätte auch nicht funktioniert: die Bild-URLs laufen über den externen Proxy `images.weserv.nl` mit **fest verdrahteter Fremddomain** `jekyllcodex.org/{{ file.path }}` — also über eine Seite, die die Cindymill-Bilder nie hatte. Gelöscht in AP 3.

#### 🟠 J) NEU (bei AP 3 gefunden): leerer Markdown-Link in `_parts/mechanical_parts.md`

`[Amazon](){:target="_blank"}` in Zeile 179 baute zu `<a href="" target="_blank">` — ein Link auf die Seite selbst. Vorbestehender Inhaltsfehler, der einzige seiner Art im Projekt. Behoben in AP 3 nach der im Dokument selbst etablierten Konvention: fehlt ein Amazon-Link, bleibt die Tabellenzelle leer (so wie in Zeile 182). Es wurde **kein** Link erfunden.

#### 🔴 K) NEU (bei AP 3 gefunden): `.gitignore` hätte 38 Theme-Dateien verschluckt

Der Eintrag `vendor/` aus AP 0 war **nicht verankert**. Git-Ignore-Muster ohne führenden Slash greifen auf *jeder* Ebene — der Eintrag war für Bundlers `vendor/bundle` gedacht, hätte aber auch `_sass/basically-basic/vendor/` erfasst: die 38 Sass-Dateien von **susy** und **breakpoint**, die das vendorte Theme zum Bauen braucht.

Das ist die unangenehmste Fehlerklasse dieses Umzugs: **lokal wäre nichts aufgefallen** (die Dateien liegen ja im Arbeitsordner), erst der CI-Build hätte mit „Can't find stylesheet to import" abgebrochen — nach dem Push, ohne lokal reproduzierbar zu sein. Verifiziert mit `git check-ignore -v`, behoben durch Verankerung auf `/vendor/` und `/.bundle/`. `logs/`, `*.log` und `.htaccess` bleiben **bewusst unverankert**: sie sollen auf jeder Ebene greifen.

### 1.4 Assets — neu vermessen

Referenzen wurden gegen das **gebaute `_site/`** geprüft (maßgeblich, weil Entwurfsdateien nicht zählen) und Backslash-Pfade normalisiert:

| | Dateien | Größe |
|---|---:|---:|
| Assets gesamt | 513 | **955,6 MB** |
| davon **referenziert** | 167 | **247,8 MB** |
| davon **verwaist** | 346 | **707,7 MB** |

**Videos: 11 Dateien, 196 MB — davon 0 referenziert.** Die einzige Einbindung steht im auskommentierten Block. Da die Seite nicht erweitert wird, werden **alle Videos gelöscht**:

| Typ | Dateien | Größe |
|---|---:|---:|
| `.mov` | 2 | 111 MB (größte: `gallery/milling/milling1.mov`, 94 MB) |
| `.mp4` | 2 | 63 MB |
| `.avi` | 7 | 17 MB (im Browser ohnehin nicht abspielbar) |

**CAD-ZIPs:**

| Datei | Größe | Status |
|---|---:|---|
| `assets/cad/2021_09_22_Cindymill_Complete_Model.zip` | 21,1 MB | referenziert (`files.md`) |
| `assets/cad/Cindymill_Drawings.zip` | 1,0 MB | referenziert (`files.md`) |
| `assets/cad/Cindymill_Plates.zip` | 24 KB | **verwaist** → löschen |

**71 referenzierte Dateien sind größer als 1 MB** (unkomprimierte Handy-Originale, größte 5,8 MB), zusammen 231 MB.

**GitHub-Pages-Limits nach der Diät:**

| Limit | Wert | Prognose |
|---|---|---|
| Größe der veröffentlichten Site | 1 GB (hart) | ~50 MB — unkritisch |
| Einzeldatei | 100 MB (hart), Warnung ab 50 MB | max. 21 MB (CAD-ZIP) — unkritisch |
| Bandbreite | 100 GB/Monat (weich) | unkritisch |
| Builds | 10/Stunde (weich) | unkritisch |

### 1.5 Was nicht ins Repository gehört

Diese Dateien liegen jetzt **nur noch im Backup** (`2026_Backup_Website_Cindymill_Ionos/logs/`, 1,6 MB) und dürfen nie ins Repo:

- `logs/access.log.*` — Rohlogs mit **Besucher-IP-Adressen** (personenbezogene Daten)
- `logs/.htaccess` — enthält einen Ionos-Serverpfad zur `htpasswd` samt Kundennummer und den Systembenutzernamen des Webspace (hier bewusst nicht zitiert, da dieses Dokument im öffentlichen Repository liegt; Original im Backup)
- `logs/info.php5`, `logs/info.pl`, `logs/info.py`, `logs/traffic.db`, `logs/sftp.log`

Im Arbeitsordner sind sie bereits nicht mehr vorhanden — beim Anlegen des Repos ist das zu verifizieren, nicht zu unterstellen. Ebenfalls draußen bleiben: `_site/`, `.DS_Store`, `jekyll-theme-basically-basic.gemspec` (Theme-Artefakt).

---

## 2. Zielarchitektur

```
culturalheritagedigital/Cindymill (public)  ──►  GitHub Actions (Jekyll 4.4)  ──►  GitHub Pages
        │                                                                             │
   Root:   Jekyll-Quellcode                        culturalheritagedigital.github.io/Cindymill/
           + vendortes Theme                       HTTPS automatisch (*.github.io-Wildcard)
           + optimierte assets/                    kein DNS, keine Domain, kein Zertifikatsthema
           + .github/workflows/
   model/: CAD-/Modelldaten (per exclude: nicht Teil des Builds)
   Root:   README.md, LICENSE, cindymill_front_1.jpg (ebenfalls excluded)
```

**Warum GitHub Actions und nicht der klassische Pages-Jekyll-Build?**
`jekyll-theme-basically-basic` steht **nicht** auf GitHubs Liste unterstützter Themes, und die Pages-Build-Umgebung ist auf Jekyll 3.9 festgenagelt. Mit einem Actions-Workflow läuft aktuelles Jekyll 4.4 mit beliebigen Gems.

**Kosten:** GitHub Pages ist für **öffentliche** Repositories kostenlos. Pages aus einem *privaten* Repo erfordert GitHub Pro/Team — das Repo muss also public sein. Bei einem CC-BY-NC-SA-Projekt ohnehin stimmig. **Laufende Kosten nach dem Umzug: 0 €** (Ionos-Webspace und Domain gekündigt).

**Repo-Name = sichtbare URL.** Ohne eigene Domain wird der Repository-Name Teil der Adresse. Entschieden: **das bestehende `culturalheritagedigital/Cindymill` wird umgewidmet** → `https://culturalheritagedigital.github.io/Cindymill/`.

Das hat drei Konsequenzen, die im weiteren Plan berücksichtigt sind:

1. **`baseurl: "/Cindymill"`** — mit großem C. GitHub Pages bildet den Repo-Namen unverändert auf den Pfad ab; ein kleingeschriebenes `/cindymill` liefert 404.
2. **Die Modelldaten liegen jetzt unter `model/`.** Bestehende Links auf CAD-Dateien (Forks, Foren, das alte README) zeigen ins Leere und müssen umgebogen werden, soweit sie in eigener Hand sind. Die 14 Forks behalten die alte Struktur — das ist unvermeidbar.
3. **Der Repo-Root ist die Jekyll-Wurzel.** Alles, was nicht zur Website gehört (`model/`, `README.md`, `LICENSE`, `cindymill_front_1.jpg`, die Projektdoku), muss in `_config.yml` unter `exclude:` stehen, sonst landet es im Build und im Pages-Deployment.

---

## 3. Arbeitspakete

### AP 0 — Repository vorbereiten ✅ weitgehend erledigt (29.07.2026)

| # | Schritt | Status |
|---|---|---|
| 1 | Vollbackup des Ionos-Webspace | ✅ `2026_Backup_Website_Cindymill_Ionos` (995 MB) |
| 2 | Arbeitsordner auf Server-Artefakte prüfen | ✅ `logs/`, `.htaccess`, Rohlogs, `info.php5` etc. **nicht vorhanden**; 4× `.DS_Store` gelöscht |
| 3 | `.gitignore` anlegen | ✅ inkl. `logs/`, `*.log`, `.htaccess`, `_site/`, `.DS_Store`, `vendor/`, `.bundle/` |
| 4 | Bestehendes Repo anbinden statt neu initialisieren | ✅ `origin` = `culturalheritagedigital/Cindymill`, 54 Commits geholt (`.git` nur 11 MB) |
| 5 | Arbeitsbranch `website-migration` | ✅ angelegt — `main` bleibt bis zum Livegang unangetastet |
| 6 | Modelldaten nach `model/` verschieben | ✅ Commit `178fca3`, 81 Dateien, von Git als reine Renames erkannt (0 Insertions/Deletions) → Historie bleibt nachvollziehbar |
| 7 | Website-Quellcode aufnehmen | ✅ Commit `74e6bbf`, 116 Dateien, **ohne `assets/`** |
| 8 | `exclude:` in `_config.yml` setzen | ✅ `model/`, `README.md`, `LICENSE`, `cindymill_front_1.jpg`, Projektdoku + Jekyll-Standardliste |
| 9 | GitHub CLI installieren | ✅ `gh` 2.96.0 via Homebrew |
| 10 | `gh auth login` | ⬜ **offen — muss interaktiv ausgeführt werden** |
| 11 | Ionos-Vertragsdaten sichern | ⬜ **offen** — Paket, Domain-Auth-Code, Kündigungsfristen, Rechnungen ins Backup. Nach der Kündigung ist der Zugang weg. |

**Wichtige Abweichung von Rev. 2:** Dort war ein frisches `git init` vorgesehen. Da die Website in das *bestehende* Repo zieht, wäre das falsch gewesen — es hätte die 54 Commits, die Sterne und die Forks verworfen. Stattdessen wurde das vorhandene Repo als `origin` angebunden und die Historie fortgeschrieben.

**`assets/` fehlt bewusst im Commit.** Erst AP 1 ausführen, dann `git add assets/`. Andernfalls lägen die 708 MB verworfener Dateien dauerhaft in der Historie und jeder Clone — auch jeder der 14 Forks — zöge sie mit. Der Rollback-Punkt ist das Backup, nicht ein Initial-Commit.

**Noch nicht gepusht.** Branch `website-migration` liegt nur lokal. Der Push ist der erste nach außen sichtbare Schritt und sollte erst erfolgen, wenn AP 1 durch ist — sonst ist ein Zwischenstand mit halb aufgeräumten Assets öffentlich.

### AP 1 — Asset-Diät (Blocker, vor dem Commit von `assets/`)

Ziel: von 955,6 MB auf **< 50 MB**.

1. **Tote Quelldateien löschen:** `_gallery_fancy.md`, `_about_us.md` (Befund F) — sonst zählt die Referenzprüfung 98 Backslash-Pfade fälschlich als „in Benutzung".
2. **Verwaiste Assets entfernen** (346 Dateien, 707,7 MB). Das Prüfskript muss Backslash-Pfade normalisieren und URL-dekodieren, sonst wird die halbe Galerie fälschlich als verwaist erkannt. Referenzen gegen das gebaute `_site/` prüfen, nicht gegen die Quelldateien.
3. **Alle Videos löschen** (11 Dateien, 196 MB) — 0 davon sind eingebunden, die Seite wird nicht erweitert. Die Originale bleiben im Backup.
4. **`Cindymill_Plates.zip`** löschen (verwaist).
5. **Bilder optimieren** (71 referenzierte Dateien > 1 MB, 231 MB):
   - Längste Kante auf max. 1600 px (Galerie) bzw. 2000 px (Detailfotos) begrenzen.
   - JPEG mit Qualität ~82 neu kodieren, EXIF strippen.
   - Erwartetes Ergebnis: 226 MB Bilder → **ca. 25–35 MB**.
   - WebP zusätzlich erzeugen und via `<picture>` ausliefern: **optional** — bringt weitere ~30 %, kostet aber Umbauten in allen Galerie-Templates. Bei „Inhalt bleibt wie er ist" vertretbar, aber nicht zwingend.
6. **CAD-ZIPs (22 MB) bleiben im Repo** — bei 1 GB Pages-Limit unkritisch, und der Download-Link bleibt stabil. Alternative bei künftigem Wachstum: als GitHub **Release-Assets** ablegen (zählen nicht gegen das Pages-Limit).
7. `main.css.map` nicht mehr ausliefern; Lunr-Dateien entfallen mit dem Vendoring (AP 3).
   ✅ Beides in AP 3 erledigt: `sass: sourcemap: never` in `_config.yml`, und die 21 Lunr-JS-Dateien wurden beim Vendoring gar nicht erst mitkopiert.

**Ergebnis AP 1 (29.07.2026):** `assets/` von 913 MB auf **62 MB**, 172 Dateien — davon 41 MB Bilder und 21 MB CAD-ZIPs. Commit `72ee937`.

Das Ziel „< 50 MB" ist damit knapp verfehlt, dominiert vom 20-MB-CAD-ZIP. Bei 1 GB Pages-Limit ist das folgenlos; zwei Hebel bleiben, falls es doch stören sollte:

- `2021_09_22_Cindymill_Complete_Model.zip` als **GitHub-Release-Asset** ablegen → Site fällt auf 41 MB (Release-Assets zählen nicht gegen das Pages-Limit).
- Die fünf PNG-Renderings (`rend5`–`rend11`, zusammen ~6 MB) mit `pngquant` verlustbehaftet quantisieren → ca. 4 MB weniger.

### AP 2 — Asset-Pfade reparieren und `baseurl`-fest machen ✅ ausgeführt (29.07.2026)

Alle 185 Asset-Referenzen in einem automatisierten Durchgang normalisieren (Befunde A und D):

1. Alle `\` in Asset-Pfaden durch `/` ersetzen (73 live betroffene Vorkommen in `gallery.md`, `files.md`, `community.md`).
2. Alle absoluten (`/assets/…`, 106×) und relativen (`../assets/…`, 66×) Pfade auf Jekyll-Filter umstellen — **zwingend**, weil die Seite unter `/Cindymill/` läuft:
   ```liquid
   {{ '/assets/images/gallery/frame/frame2.jpg' | relative_url }}
   ```
   In Markdown funktioniert das auch in der Bild-Kurzschreibweise:
   ```markdown
   ![limit]({{ '/assets/images/addons/limitswitches/limitswitch1.jpg' | relative_url }})
   ```
3. Gleiches für `_includes/head.html` (8 Referenzen) sowie `author.picture` und `logo` in `_config.yml`.
4. Alle internen Seitenlinks (`href="/gallery.html"` o. ä.) ebenfalls auf `relative_url` prüfen — sie brechen unter `baseurl` genauso.
5. `legal_notice.md`: `href="www.cindymill.xyz"` → neue Adresse (AP 5).
6. **Zwei vorbestehende tote Links in `gallery.md` beheben** (bei der Prüfung in AP 1 gefunden): `assets/images/gallery/milling1.mp4` und `assets/images/gallery/stuff1.jpg` existieren weder im Projekt noch im Ionos-Backup — sie waren schon live kaputt. Entweder Referenz entfernen oder auf eine vorhandene Datei zeigen lassen.
7. Nach dem Build mit **html-proofer** verifizieren: 0 gebrochene interne Links.

> Der letzte Punkt ist der eigentliche Test dieses Arbeitspakets. Ohne ihn merkt man den `baseurl`-Bruch erst live.

#### Ergebnis AP 2 (29.07.2026) — Commit `dc92a38`

23 Dateien geändert, **199 Asset-Referenzen** plus **17 interne Seitenlinks** normalisiert.

| Kategorie | Anzahl | Behandlung |
|---|---:|---|
| Body-Asset-Referenzen (`.md`/`.html`) | 172 | → `{{ '/assets/…' \| relative_url }}` |
| davon vorher mit Windows-Backslash | 75 | zusätzlich `\` → `/` |
| Front-Matter-Pfade (`image`, `path`, `thumbnail`) | 27 | nur normalisiert (führender `/`), **kein** Liquid |
| Interne Seitenlinks | 17 | → `{{ '/parts/' \| relative_url }}` usw. |
| Favicon-Referenzen in `_includes/head.html` | 7 | → `relative_url` |
| Referenzen in `site.webmanifest` / `browserconfig.xml` | 3 | Front Matter ergänzt + `relative_url` (neuer Befund H) |

**Warum Front Matter anders behandelt wird.** Jekyll wertet in Front Matter kein Liquid aus — `image: "{{ … | relative_url }}"` wäre wirkungslos. Die maßgeblichen Includes liegen bereits lokal im Projekt und wenden den Filter selbst an:

| Include | Zeile |
|---|---|
| `_includes/page-intro.html` | `page.image.path \| default: page.image \| relative_url` |
| `_includes/entry.html` | `post.image.thumbnail \| relative_url` |
| `_includes/author` | `author_picture \| relative_url` |
| `_includes/masthead.html` | `site.logo \| relative_url` |

Damit sind auch **`author.picture` und `logo` in `_config.yml` bereits `baseurl`-fest** — Punkt 3 der Liste oben erledigt sich dort ohne Änderung. `_includes/navigation.html` und `masthead.html` waren schon korrekt.

**Neuer Befund H: `site.webmanifest` und `browserconfig.xml` waren ebenfalls betroffen.** Beide Dateien enthalten absolute `/assets/…`-Pfade auf Icons und wurden als statische Dateien unverändert kopiert. Ohne Front Matter rendert Jekyll darin kein Liquid; sie hätten unter `/Cindymill/` auf tote Icon-Pfade gezeigt. Lösung: leeres Front Matter (`---` / `---`) vorangestellt, damit Jekyll sie rendert, und die drei Pfade auf `relative_url` umgestellt.

**Interne Seitenlinks auf die tatsächlich gebauten URLs gezogen.** Die 17 Links waren nicht nur `baseurl`-unfest, sondern teilweise auch formal ungenau (`/parts` statt `/parts/`, `/gallery` statt `/gallery.html`). Unter Apache mit MultiViews fiel das nicht auf; GitHub Pages ist toleranter als html-proofer. Die Ziele sind jetzt gegen das gebaute `_site/` abgeglichen:

`/parts/`, `/assembly/`, `/assembly/{portal,z_axis,electronics}_assembly/`, `/parts/electronic_parts/`, `/gallery.html`, `/accessories.html`, `/start/2021/07/24/Rigidity.html`, `/start/2021/08/01/SpeedsAndFeeds.html`

**Punkt 6 (zwei tote Links) erledigt — Präzisierung.** Beide lagen in **auskommentierten** Blöcken, waren also nie live sichtbar. Die Blöcke wurden gelöscht statt umgebogen (Inhalt wird nicht erweitert):

- `<video>`-Block mit `assets/images/gallery/milling1.mp4` (zugleich der auskommentierte Video-Block aus Befund G)
- `<figure>`-Block mit `assets/images/gallery/stuff1.jpg`

**Punkt 5 (`legal_notice.md`) teilweise erledigt.** Der schemalose und damit tote Link `href="www.cindymill.xyz"` zeigt jetzt auf `https://culturalheritagedigital.github.io/Cindymill/`. Die restlichen ~20 Nennungen von `cindymill.xyz` stehen im Fließtext der Datenschutzerklärung und gehören zur Textüberarbeitung in **AP 5**.

**Verifikation.** Statisch gegen die Dateisystem-Wirklichkeit geprüft (Skript löst jede Referenz auf, URL-dekodiert):

```
221 Ziele aufgelöst, 2 fehlend
  /assets/stylesheets/main.css   (_includes/head.html)
  /assets/javascripts/main.js    (_includes/scripts.html)
```

Beide fehlenden Dateien sind **erwartet**: sie werden aus den Sass-/JS-Quellen des Theme-Gems erzeugt und kommen mit dem Vendoring in **AP 3.4** ins Projekt. Ansonsten: 0 Backslash-Pfade, 0 rohe `/assets/`- oder `../assets/`-Pfade im Body, 0 rohe interne Links.

> ✅ **Punkt 7 (html-proofer) ist mit AP 3 nachgeholt.** Der Lauf war blockiert, weil der Build nicht lief (Theme-Gem fehlte, `sassc` brach auf Ruby 3.4). Ergebnis nach AP 3: **0 Fehler, auch unter `--baseurl /Cindymill`** — die einzige Meldung war ein leerer Markdown-Link, der nicht aus AP 2 stammte (Befund J). Details im Ergebnisbericht zu AP 3. Dauerhaft im CI: AP 6.

**Offener Nebenbefund aus der Prüfung.** `assets/images/gallery/frame/plates2.jpg` und `frame3.jpg` existieren noch, werden aber nur in zwei auskommentierten `<figure>`-Blöcken in `gallery.md` referenziert. Die Referenzprüfung in AP 1 hat Kommentare nicht ausgewertet, deshalb sind sie der Asset-Diät entgangen. Folgenlos (zusammen < 1 MB), gehört aber sauber gelöscht, falls AP 1 noch einmal angefasst wird.

### AP 3 — Toolchain aktualisieren ✅ ausgeführt (30.07.2026)

1. `Gemfile.lock` löschen und neu auflösen (die alte Datei ist Windows-spezifisch, `x64-mingw32`).
2. `Gemfile`:
   - Jekyll explizit auf `~> 4.4` pinnen.
   - `jekyll-sass-converter` auf `~> 3.0` heben → nutzt `sass-embedded` statt des kaputten `sassc`. **Voraussetzung dafür, dass der Build auf Ruby 3.4/arm64 überhaupt läuft.**
   - `jekyll-algolia` entfernen (ungenutzt).
   - `wdm` (Windows) entfernen.
   - `jekyll-paginate` beibehalten — die Blog-Paginierung bleibt wie sie ist.
   - `webrick` behalten (für `jekyll serve` unter Ruby ≥ 3).
   - `html-proofer` in einer Test-Gruppe ergänzen.
3. `.ruby-version` auf `3.4` festlegen, damit lokaler Build und CI identisch sind.
4. **Theme vendorn.** `jekyll-theme-basically-basic` 1.4.5 ist unmaintained und lokal nicht installiert; `_layouts/` und `_sass/` fehlen im Projekt völlig.
   - `bundle install` einmal laufen lassen, um das Gem von rubygems.org zu holen.
   - `_layouts/`, `_sass/` und die fehlenden `_includes/` aus dem Gem ins Repo kopieren (70 Includes sind bereits lokal überschrieben).
   - `theme:`-Zeile aus `_config.yml` und das Gem aus dem `Gemfile` entfernen.
   - Lunr-Suchdateien und Algolia-Includes beim Kopieren weglassen (`search: false`).
   - Danach gibt es keine Abhängigkeit von einem toten Gem mehr, und AP 4 ist direkt umsetzbar.
5. `jekyll-theme-basically-basic.gemspec` aus dem Projektroot löschen (Theme-Artefakt).
6. Leere Collection `gallery` aus `_config.yml` entfernen (kein `_gallery/`-Ordner vorhanden). Beim selben Durchgang den auskommentierten Algolia-Block entfernen — er enthält einen `search_only_api_key` im Klartext. Der Schlüssel ist zwar nur lesend und war ohnehin schon öffentlich, gehört aber nicht in ein Repo; bei der Gelegenheit im Algolia-Konto widerrufen.
7. Erster Testlauf: `bundle install && bundle exec jekyll build` — Fehler der Anhebung 4.2 → 4.4 abarbeiten (v. a. Sass-Deprecations; `liquid: error_mode: strict` greift strenger).

#### Ergebnis AP 3 (30.07.2026) — Commit `e4f591e`

106 Dateien, +7292/−334. **Der Build läuft — erstmals seit dem Umzug in den Arbeitsordner — lokal durch, in 0,22 s.**

| # | Schritt | Ergebnis |
|---|---|---|
| 1 | `Gemfile.lock` neu auflösen | ✅ gelöscht, neu aufgelöst: 61 Gems, Plattformen `ruby`/`arm64-darwin` statt `x64-mingw32` |
| 2 | `Gemfile` neu fassen | ✅ Jekyll `~> 4.4` (→ 4.4.1), `jekyll-sass-converter ~> 3.0` (→ 3.1.0), `jekyll-algolia` und `wdm` raus, `webrick ~> 1.8`, `jekyll-paginate` bleibt, `html-proofer ~> 5.0` in `group :test` |
| 3 | `.ruby-version` | ✅ `3.4` — und in `exclude:` nachgezogen |
| 4 | Theme vendorn | ✅ siehe unten |
| 5 | `…gemspec` löschen | ✅ gelöscht, Eintrag aus `exclude:` entfernt |
| 6 | Collection `gallery` + Algolia-Block | ✅ beide raus, dazu die drei `search*`-Schlüssel und der `_gallery`-Front-Matter-Default |
| 7 | Erster Testbuild | ✅ 27 Seiten, `main.css` (53 KB) wird erzeugt, `model/` sauber ausgeschlossen |

**Vendoring (3.4) — die `_includes/` waren schon vollständig.** Erwartet waren „70 überschriebene Includes, Rest fehlt". Tatsächlich lagen **alle** 70 Gem-Includes bereits lokal (Abgleich mit `comm`), plus zwei lokale Extras. Zu kopieren waren daher nur:

| Kopiert aus dem Gem | Umfang |
|---|---:|
| `_layouts/` | 12 Dateien |
| `_sass/` | 81 Dateien (davon 38 in `vendor/`: susy + breakpoint) |
| `assets/stylesheets/main.scss` | 1 |
| `assets/javascripts/main.js` | 1 |
| `assets/javascripts/lunr/` | **nicht kopiert** (21 Dateien, `search: false`) |

Die MIT-Lizenz des Themes liegt als `_sass/basically-basic/THEME-LICENSE.txt` bei — im Repo, aber außerhalb des Builds, da Jekyll `_sass/` nicht ausliefert. Der Urheberhinweis auf Michael Rose steht unverändert im Kopf von `_layouts/default.html`.

**Suche restlos entfernt.** `search: false` galt schon vorher, die Fracht lag aber noch da — `_includes/search-form.html` wurde von `default.html` sogar **ungated** eingebunden, rendert also auf jeder Seite einen leeren `<div class="search-content">`. Entfernt: `_includes/search/` (Lunr + Algolia), `search-form.html`, `_sass/basically-basic/_search.scss` samt `@import`, die Such-Blöcke in `_layouts/default.html` (Toggle-Button und `search-content`-Div) und in `_includes/scripts.html`.

**Der Algolia-API-Key ist aus `_config.yml` verschwunden** (`search_only_api_key: 9d5014e5bbc77372547bce778dfa5663`, auskommentiert). ⚠️ Er steht weiterhin in der **Git-Historie** und war ohnehin öffentlich — **im Algolia-Konto widerrufen** bleibt offen, siehe Checkliste.

**Sass-Deprecations: 231 → 2.** Der Umstieg auf `sass-embedded` bringt Dart Sass 1.102 mit, das die Altlasten des Themes anmeckert — `@import`, `$a / $b`, `lighten()`, globale Builtins, `if()`, unäre Operatoren. Es sind **Warnungen, keine Fehler**; sie kündigen den Bruch in Dart Sass 3.0 an. Sie alle zu beheben hieße, 38 Dateien fremden Vendor-Codes (susy, breakpoint) zu migrieren — hoher Aufwand, hohes Regressionsrisiko, kein sichtbarer Nutzen, und in einem „rein technischen Umzug" nicht vorgesehen. Gewählt:

```yaml
sass:
  sourcemap: never    # keine oeffentliche main.css.map (erledigt AP 1.7)
  quiet_deps: true    # Deprecations des vendorten Themes stumm
```

`quiet_deps` schweigt nur über Dateien, die *nicht* der Einstiegspunkt sind — die zwei verbleibenden Warnungen stammen aus `assets/stylesheets/main.scss` selbst und bleiben als Erinnerung sichtbar. Der Bruch kann nicht unbemerkt einziehen: `jekyll-sass-converter ~> 3.0` verlangt `sass-embedded ~> 1.75`, also `< 2.0`. Ein zusätzlicher Pin wäre Redundanz.

**`sourcemap: never` erledigt AP 1.7** — `main.css.map` (bisher 218 KB öffentlich abrufbar) wird nicht mehr erzeugt.

**Verifikation — html-proofer, zweimal.** Damit ist der bis hierher aufgeschobene Punkt **AP 2.7** eingelöst:

```
bundle exec jekyll build                      → 27 Seiten
bundle exec htmlproofer ./_site --disable-external
  → 3 Checks (Images, Links, Scripts), 27 Dateien, 44 interne Links
  → HTML-Proofer finished successfully

bundle exec jekyll build --baseurl /Cindymill
bundle exec htmlproofer ./_site --disable-external --swap-urls '^/Cindymill/:/'
  → HTML-Proofer finished successfully
```

Der **zweite Lauf ist der wichtige**: er beweist, dass AP 2 gehalten hat und die Seite unter dem Projekt-Unterpfad nicht bricht — der Befund D war als Blocker eingestuft. Stichprobe aus dem `baseurl`-Build: `href="/Cindymill/assets/stylesheets/main.css"`, `src="/Cindymill/assets/images/gallery/frame_bw.jpg"`.

> ⚠️ **Zur Aussagekraft:** html-proofer meldet die Bildprüfung nur im Fehlerfall, die Zeile „44 interne Links" zählt allein `<a>`-Ziele. Dass die **181 `<img>`** im Build wirklich geprüft werden, wurde eigens gegengetestet (Fixture mit kaputtem `src` → „internal image does not exist"). Ohne diesen Test wäre „0 Fehler" eine Scheinsicherheit gewesen.

**Zwei Funde nebenbei:** der tote Include `image-gallery.html` (Befund I) und der leere Markdown-Link in `_parts/mechanical_parts.md` (Befund J) — letzterer war die einzige echte html-proofer-Meldung überhaupt. Und ein Fund, der ohne Prüfung erst im CI aufgeschlagen wäre: die **`.gitignore`-Falle** (Befund K) — `vendor/` unverankert hätte 38 der gerade vendorten Theme-Dateien aus dem Commit gehalten.

**Offen aus AP 3:** nichts. Nicht Teil von AP 3 und weiterhin offen sind die Aufräumarbeiten, die die Planung AP 4/5 zuordnet — der GA4-Block und MathJax stehen noch in `_includes/head.html`, `google_analytics: G-EFN1CTB4WB` noch in `_config.yml`. Solange dieser Schlüssel gesetzt ist, zieht `_includes/scripts.html` unter `JEKYLL_ENV=production` zusätzlich `_includes/google-analytics.html` — beides fällt mit AP 4 weg. Ebenfalls noch da: die Google-Fonts-Einbindung über `_data/theme.yml` (`google_fonts: Fira Sans`), die AP 4 auf Self-Hosting umstellt.

### AP 4 — `_config.yml` und `head.html` modernisieren

**`_config.yml`:**
```yaml
url: "https://culturalheritagedigital.github.io"
baseurl: "/Cindymill"      # großes C – GitHub Pages bildet den Repo-Namen
                           # unverändert ab, /cindymill liefert 404
google_analytics:          # entfernt, s. AP 5
```
Die `exclude:`-Liste steht bereits (AP 0.8). Sie ist bei jedem neuen Root-Element im Repo nachzuziehen — Jekyll kopiert sonst alles Unbekannte ins `_site/`.
Damit werden `canonical`, `og:url`, `og:image`, `sitemap.xml` und `robots.txt` erstmals korrekt absolut.

> **`permalink` bleibt unverändert.** Rev. 1 schlug `permalink: pretty` vor, um die Extensionless-URLs des Apache nachzubilden. Mit der Aufgabe der Domain gibt es keine URLs mehr zu erhalten — jede Änderung wäre reines Risiko ohne Nutzen. `jekyll-redirect-from` entfällt damit ebenfalls.

**`_includes/head.html`:**
- MathJax-Block **ersatzlos löschen** (totes CDN, Mixed Content).
- GA4-Snippet `G-6J78SX32JE` **ersatzlos löschen** — und zusätzlich `google_analytics` aus `_config.yml`, sonst liefert der Produktionsbuild über `_includes/scripts.html` → `google-analytics.html` weiter `G-EFN1CTB4WB` aus (siehe Korrektur zu Befund E). Danach ist `_includes/google-analytics.html` toter Code und kann mit weg.
- `<meta http-equiv="X-UA-Compatible">` löschen.
- „Cut the mustard"-Script löschen.
- eBay-Verifizierungs-Tag: `value=` → `content=` korrigieren, oder löschen, falls das Partnerprogramm nicht mehr aktiv ist.
- Google Fonts **self-hosten**: Fira Sans als WOFF2 in `assets/fonts/`, `@font-face` mit `font-display: swap`. Löst DSGVO-Thema und Render-Blocker zugleich.
- `<link rel="preload">` für die Hauptschrift, `rel="preconnect"` zu Google entfernen.
- ~~Die 8 Asset-Referenzen auf `relative_url` umstellen (AP 2.3).~~ ✅ in AP 2 erledigt (7 Favicon-Pfade; `main.css` war bereits korrekt).

**Templates/Layouts (nach dem Vendoring):**
- Bilder: `loading="lazy"` und `decoding="async"` ergänzen (Hero-Bild stattdessen `fetchpriority="high"`).
- `width`/`height` an allen `<img>` setzen (verhindert Layout-Shift).
- Nur falls WebP in AP 1.5 gewählt wurde: Galerie auf `<picture>` mit JPEG-Fallback umstellen.

### AP 5 — Datenschutz & Rechtstexte

Die Entscheidung ist getroffen: **kein Tracking**. Damit vereinfacht sich dieses Paket erheblich.

1. GA4-Snippet aus `_includes/head.html` **und** `google_analytics: G-EFN1CTB4WB` aus `_config.yml` entfernen (AP 4). Die zweite ID ist entgegen Rev. 4 **nicht** tot — sie würde im Produktionsbuild ausgeliefert, siehe Korrektur zu Befund E.
2. `legal_notice.md` — **Analytics-Abschnitt streichen.** Er beschreibt Universal Analytics mit `_gat._anonymizeIp` und dem Opt-out-Browser-Add-on; beides existiert seit Juli 2023 nicht mehr und beschrieb ohnehin nie das, was lief.
3. **Hosting-Angabe im Impressum** von Ionos auf **GitHub Inc.** ändern (Auftragsverarbeitung, US-Transfer). Ergänzen: GitHub Pages protokolliert Besucher-IP-Adressen — ein kurzer Absatz dazu gehört in die Datenschutzerklärung.
4. **Alle Nennungen von `cindymill.xyz` ersetzen** (3 Stellen in `legal_notice.md`, u. a. „Internet address: www.cindymill.xyz" und die Verantwortlichen-Bezeichnung „the cindymill.xyz") durch `https://culturalheritagedigital.github.io/Cindymill/`.
   ✅ Geprüft: Die Kontakt-E-Mail lautet `cindymill@culturalheritage.digital` — **andere Domain, von der Kündigung nicht betroffen.**
5. **Affiliate-Kennzeichnung prüfen:** 115× `amzn.to`, 102× `ebay.us`, 94× AliExpress-Links. Kennzeichnungspflicht besteht unabhängig vom Hosting. Ebenso die LinkedIn- und Facebook-Abschnitte auf Aktualität prüfen.
6. Konsequenz aus dem Wegfall des Trackings: keine Cookies, kein Consent-Banner, keine Cookie-Richtlinie nötig.

### AP 6 — GitHub-Actions-Workflow

`.github/workflows/pages.yml`:

- Trigger: `push` auf `main` + `workflow_dispatch`
- Job **build**: `actions/checkout` → `ruby/setup-ruby` mit `bundler-cache: true` → `bundle exec jekyll build` (mit `JEKYLL_ENV=production`) → `bundle exec htmlproofer ./_site` → `actions/upload-pages-artifact`
- Job **deploy**: `actions/deploy-pages` mit `permissions: pages: write, id-token: write`
- Repo-Einstellungen: **Settings → Pages → Source: GitHub Actions**

`htmlproofer` im Build ist der wichtigste Teil — genau so wären die 73 Backslash-Links nie live gegangen, und genau so fällt ein `baseurl`-Fehler künftig sofort auf. Externe Links im CI ausschließen (`--ignore-status-codes` bzw. `--disable-external`), Laufzeit.

### AP 7 — Livegang und Ionos-Kündigung (Reihenfolge einhalten!)

Ohne eigene Domain entfällt der gesamte DNS-Teil. Es bleibt:

1. Branch `website-migration` nach `main` mergen und pushen, Workflow deployt → Site läuft unter `https://culturalheritagedigital.github.io/Cindymill/`.
2. **Vollständig durchklicken:** alle 27 Seiten, Galerie, beide CAD-Downloads, Blog-Paginierung, `atom.xml`, `404`. HTTPS ist über das `*.github.io`-Wildcard-Zertifikat automatisch aktiv — nichts zu konfigurieren.
3. **Externe Verweise auf die alte Domain umbiegen**, solange sie noch erreichbar ist:
   - `README.md` im Repo-Root — verlinkt aktuell `www.cindymill.xyz` und beschreibt nur die Maschine. Neu fassen: Website *und* Modelldaten unter `model/`, neuer Link auf die Pages-URL.
   - das „Website"-Feld in den Repo-Einstellungen (zeigt auf `www.cindymill.xyz`)
   - eigene Profile, Foren-Signaturen, YouTube-Beschreibungen, Thingiverse/Printables-Einträge
   - der Zenodo-DOI-Eintrag (`10.5281/zenodo.5118794`) verweist auf das Repo — Metadaten prüfen
4. **Backup gegenprüfen:** Ist `2026_Backup_Website_Cindymill_Ionos` vollständig, und sind die Ionos-Vertrags-/Zugangsdaten gesichert (AP 0.1)? Nach der Kündigung ist beides nicht mehr abrufbar.
5. **Erst danach bei Ionos kündigen:** Hosting-Paket **und** Domain `cindymill.xyz`. Kündigungsfrist und Vertragsende beachten — Ionos kündigt Domains üblicherweise zum Laufzeitende; bis dahin bleibt die alte Seite ggf. erreichbar.
6. Nach Ablauf: Ionos-Zugangsdaten aus dem Passwortmanager entfernen bzw. archivieren.

> ⚠️ **Kein Weg zurück.** Mit dem Ablauf der Registrierung wird `cindymill.xyz` für Dritte frei registrierbar. Siehe Risiken.

### AP 8 — Nach dem Umzug

1. `robots.txt` und `sitemap.xml` auf absolute URLs prüfen (ergibt sich aus AP 4).
2. Google Search Console: neue Property für `https://culturalheritagedigital.github.io/Cindymill/` anlegen, Sitemap einreichen. **Eine Adressänderung ist nicht möglich** (nur zwischen eigenen Properties, und die alte Domain wird aufgegeben) — die Suchmaschinen-Historie startet neu.
3. Lighthouse-Messung (Performance/Accessibility/SEO/Best Practices) als Beleg.
4. Externe Links prüfen: 115 Amazon-, 102 eBay-, 94 AliExpress-Links aus 2021 sind mit hoher Wahrscheinlichkeit größtenteils tot. `htmlproofer` mit externer Prüfung einmalig manuell laufen lassen. Tote Affiliate-Links sind auch rechtlich unschön.
5. FTP-Spiegel und Rohlogs im Backup **verschlüsselt** ablegen oder die `logs/` daraus löschen — sie enthalten Besucher-IP-Adressen (AP 1.5).

---

## 4. Reihenfolge und Aufwand

| # | Arbeitspaket | Abhängig von | Aufwand (grob) | Status |
|---|---|---|---|---|
| 0 | Repo anbinden, `model/`-Umbau, `.gitignore`, `gh` | — | 1 h | ✅ bis auf `gh auth login` und die Ionos-Vertragsdaten |
| 1 | Asset-Diät (tote Dateien, Videos, Bildoptimierung) | 0 | 3–4 h | ✅ 913 MB → 62 MB |
| 2 | Asset-Pfade normalisieren (`relative_url`) | 0 | 2–3 h | ✅ 199 Referenzen + 17 interne Links; html-proofer mit AP 3 nachgeholt: 0 Fehler |
| 3 | Toolchain (Jekyll 4.4, sass-embedded, Theme vendorn) | 0 | 3–4 h | ✅ Build läuft, html-proofer 0 Fehler |
| 4 | `_config.yml` + `head.html` modernisieren | 3 | 2–3 h | offen |
| 5 | Datenschutz/Rechtstexte | 4 | 1–2 h | offen |
| 6 | GitHub-Actions-Workflow | 2–4 | 1–2 h | offen |
| 7 | Livegang, externe Links umbiegen, Ionos kündigen | 6 | 1–2 h | offen |
| 8 | Nacharbeiten, SEO, Linkpflege | 7 | 2–4 h | offen |

> **`assets/` wird erst nach AP 1 committet.** Wer die 708 MB verwaister Assets erst committet und dann löscht, trägt sie dauerhaft in der Git-History mit — jeder Clone und jeder der 14 Forks zieht sie. Das Backup ist der Rollback-Punkt.

**AP 1, 2 und 3 waren die kritischen Blocker** — ohne sie wäre der Umzug entweder unnötig teuer geworden (Größe), oder er hätte die kaputte Galerie zementiert und zusätzlich an allen absoluten Pfaden gebrochen. **Alle drei sind seit dem 30.07.2026 erledigt und gegen den gebauten `/Cindymill`-Unterpfad verifiziert.** Ab hier ist nichts mehr blockierend: AP 4–6 sind Aufräum- und Konfigurationsarbeit auf einem laufenden Build.

---

## 5. Risiken

| Risiko | Bewertung | Gegenmaßnahme |
|---|---|---|
| **`cindymill.xyz` wird nach Ablauf von Dritten registriert** | hoch, dauerhaft | Bewusste Entscheidung. Alle eigenen Verweise vorher umbiegen (AP 7.3). Bekannt ist: die Domain kann danach beliebig belegt werden — alte Links in Foren, Videos und Fremdseiten zeigen dann auf Inhalte Dritter. Wer das vermeiden will, müsste die Domain zu einem günstigeren Registrar transferieren statt zu kündigen. |
| **Verlust der Suchmaschinen-Historie und aller Backlinks** | hoch | Unvermeidbare Folge der Domain-Aufgabe. Ohne die alte Domain ist keine 301-Weiterleitung möglich. |
| Absolute Pfade brechen unter `baseurl` | hoch, aber beherrschbar | AP 2 vollständig ausführen, `htmlproofer` im CI als Dauerkontrolle (AP 6) |
| ~~Theme-Gem nicht mehr installierbar~~ | ✅ **erledigt** | Vendoring in AP 3.4 durchgeführt, das Zeitfenster wurde genutzt. Das Gem ist keine Abhängigkeit mehr. |
| ~~Jekyll 4.2 → 4.4 bricht das Theme~~ | ✅ **erledigt** | Eingetreten ist nur, was erwartet war: Sass-Deprecations, keine Fehler. Build und html-proofer laufen durch. |
| ~~Sass-Build scheitert auf Ruby 3.4~~ | ✅ **erledigt** | `jekyll-sass-converter 3.1.0` mit `sass-embedded` — `sassc` ist raus. |
| Dart Sass 3.0 entfernt `@import` und Slash-Division | mittel, aber nicht akut | Das vendorte Theme nutzt beides. In AP 3 bewusst nur stummgeschaltet (`quiet_deps`) statt migriert. Schutz: `jekyll-sass-converter ~> 3.0` verlangt `sass-embedded < 2.0`, der Bruch kann nicht per `bundle update` einziehen. Fällig wird die Migration erst, wenn eine neue Converter-Generation erscheint — dann via `sass-migrator`. |
| `.gitignore`-Muster greifen tiefer als gedacht | niedrig, aber unsichtbar | Befund K: `vendor/` hätte 38 Theme-Dateien verschluckt, sichtbar erst im CI. Behoben. **Regel für künftige Einträge:** Werkzeug-Ordner auf den Root verankern (`/vendor/`), Sicherheitsmuster (`logs/`, `*.log`, `.htaccess`) absichtlich nicht. Neue Einträge mit `git check-ignore -v` gegenprüfen. |
| Bild-Optimierung zerstört Bildqualität | niedrig | Originale liegen im Backup (nicht im Repo), Stichproben visuell prüfen |
| Personenbezogene Daten im öffentlichen Repo | niedrig, aber gravierend | `logs/` liegt bereits nur im Backup; vor dem ersten Push manuell prüfen und Git-History kontrollieren |
| Kündigung vor funktionierendem Ersatz | niedrig | Reihenfolge in AP 7 strikt einhalten: erst Site live und geprüft, dann kündigen |
| **Links auf CAD-Dateien brechen durch den `model/`-Umbau** | mittel | Folge der Umwidmung. Eigene Verweise (README, Website, Foren) mit umbiegen; die 14 Forks behalten die alte Struktur und sind nicht erreichbar. Der Umzug ist von Git als Rename erfasst, die Historie bleibt also nachvollziehbar. |
| Repo-Root vermischt Website und Modelldaten | niedrig | `exclude:` in `_config.yml` hält `model/` aus dem Build; bei jedem neuen Root-Element nachziehen. `htmlproofer` im CI deckt Fehlkonfigurationen auf. |

---

## 6. Kurzcheckliste

- [x] Backup Ionos-Webspace gezogen (`2026_Backup_Website_Cindymill_Ionos`)
- [x] Arbeitsordner auf Server-Artefakte geprüft, `.gitignore` gesetzt
- [x] Bestehendes Repo angebunden, Branch `website-migration`, Modelldaten nach `model/`
- [x] Website-Quellcode committet (ohne `assets/`), `exclude:` gesetzt
- [x] `gh` installiert
- [ ] `gh auth login` ausgeführt
- [ ] Ionos-Vertragsdaten/Zugänge gesichert
- [x] `_gallery_fancy.md` und `_about_us.md` (tote Entwürfe) gelöscht
- [x] 340 verwaiste Assets (708 MB) entfernt, alle 11 Videos gelöscht
- [x] 115 Bilder optimiert (183 MB gespart), `assets/` committet → 62 MB
- [x] 199 Asset-Referenzen normalisiert (172 Body auf `relative_url`, 27 Front Matter) + 17 interne Seitenlinks
- [x] `site.webmanifest` / `browserconfig.xml` `baseurl`-fest gemacht (Befund H)
- [x] Tote Links `milling1.mp4` / `stuff1.jpg` samt auskommentierter Blöcke entfernt
- [x] html-proofer-Lauf über den Build: **0 Fehler**, auch unter `--baseurl /Cindymill`
- [x] Jekyll 4.4.1 + sass-embedded, `Gemfile.lock` auf macOS neu aufgelöst, `.ruby-version` 3.4
- [x] Theme vendort (`_layouts/` 12, `_sass/` 81, `main.scss`, `main.js`), Theme-Gem und `theme:`-Zeile entfernt
- [x] Suche restlos entfernt (Includes, `_search.scss`, Layout-Blöcke), Algolia-Key aus `_config.yml`
- [x] `main.css.map` wird nicht mehr ausgeliefert (`sass: sourcemap: never`)
- [x] `.gitignore` verankert (`/vendor/`) — sonst wären 38 Theme-Dateien aus dem Commit gefallen
- [ ] Algolia `search_only_api_key` im Algolia-Konto widerrufen (steht noch in der Git-Historie)
- [ ] MathJax-Block gelöscht, GA4-Snippet gelöscht, Google Fonts self-hosted (Quelle: `_data/theme.yml`)
- [ ] `url` + `baseurl: /Cindymill` gesetzt, sitemap/canonical/OG korrekt
- [ ] Datenschutzerklärung: Analytics-Abschnitt raus, Hosting auf GitHub Inc., cindymill.xyz ersetzt
- [ ] Affiliate-Kennzeichnung geprüft
- [ ] GitHub-Actions-Workflow deployt, htmlproofer meldet 0 tote interne Links
- [ ] Site unter `culturalheritagedigital.github.io/Cindymill/` vollständig durchgeklickt
- [ ] `README.md` neu gefasst (Website + `model/`, Link auf die Pages-URL)
- [ ] Externe Verweise auf cindymill.xyz umgebogen (Repo-Website-Feld, Zenodo, Profile, Foren)
- [ ] Ionos-Hosting-Paket gekündigt
- [ ] Ionos-Domain `cindymill.xyz` gekündigt
