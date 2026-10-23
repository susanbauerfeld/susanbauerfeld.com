# susanbauerfeld.com — static clone

A dependency-free, hand-built static copy of [susanbauerfeld.com](https://susanbauerfeld.com)
(Susan Bauerfeld, PhD — *Skills for Life*). The original is WordPress + Beaver Builder;
this is plain HTML and one stylesheet, with every image stored locally.

**No JavaScript, no build step, no server.** Open `index.html` in a browser, or drop the
folder on any static host (GitHub Pages, Netlify, S3, Cloudflare Pages).

## Pages

| File | Original URL |
| --- | --- |
| `index.html` | `/` |
| `about.html` | `/about/` |
| `media-appearances.html` | — (new; not on the original) |
| `base-camp-parenting-book.html` | `/base-camp-parenting-book/` |
| `workshops-and-groups.html` | `/workshops-and-groups/` |
| `booking-requests.html` | `/booking-requests/` |
| `sign-up-for-my-mailing-list.html` | `/sign-up-for-my-mailing-list/` |
| `upcoming-events.html` | `/upcoming-events/` |

## Layout

```
index.html, about.html, …   the pages
css/style.css               the only stylesheet
images/                     every photo, logo, background and the audio sample
```

Type is Open Sans (body) and Poppins (headings), loaded from Google Fonts — the same two
families the original uses. That is the only external request the pages make; remove the
`<link>` in each page's `<head>` if you want the site to be fully self-contained.

## Differences from the original

Everything here is deliberate, and each item is a consequence of there being no server:

- **No contact page.** The original `/contact/` page (a Gravity Forms form) is not part of
  this site. "Get in Touch" buttons and the footer link go straight to
  `mailto:susan@susanbauerfeld.com`; her email and phone are in the footer of every page.
- **The mailing-list form doesn't post anywhere.** It uses
  `action="mailto:susan@susanbauerfeld.com"`, so submitting opens the visitor's mail client.
  The original used Constant Contact. To make it work for real, either paste Constant
  Contact's own inline embed (Audience Growth -> Signup Forms -> Actions -> View Inline
  Code), which posts to their servers and needs no backend but adds third-party JavaScript,
  or point the `action` at a form service such as Formspree or Netlify Forms.
- **Testimonial sliders are CSS-only.** The original uses a jQuery carousel that
  auto-advances. Here the quotes sit in a horizontal scroll-snap track with anchor-link dots
  beneath — swipe, scroll, or click a dot. Same shape, no script.
- **Icons are inline SVG** instead of Font Awesome, so no icon font is downloaded.
- **Section layouts are rebuilt, not copied.** The Beaver Builder markup (thousands of
  generated `fl-node-*` classes) was replaced with semantic HTML and a small set of reusable
  classes. Colors, fonts, spacing, background images and overlays were read off the
  original's compiled CSS, so the result reads the same but the source is editable by hand.
- **Content for four pages came from the Internet Archive.** As of this writing
  `/workshops-and-groups/`, `/booking-requests/`, `/upcoming-events/` and
  `/sign-up-for-my-mailing-list/` return *"There has been a critical error on this website"*
  on the live site. Their text was recovered from the December 2025 Wayback Machine capture,
  so it may lag the live content once those pages are fixed.
- **The "Make A Payment" button** still points at the original Stripe payment link.
- Third-party chrome from the original (GoDaddy badge, "Scroll to top" widget, the
  "Helpful Links" page that only appears in the archived footer menu) is not carried over.

## Local development

Any static file server works — `python3 -m http.server 8000` is enough to click through
the site. For editing, use one that reloads the browser for you:

```sh
npx --yes live-server --port=8000 --host=127.0.0.1 --no-browser .
```

Save an HTML file and the page reloads; save `css/style.css` and the styles swap in without
a reload, so scroll position survives. `live-server` injects its reload client into the
response as it serves — nothing is written to disk and nothing is added to these files, so
the site stays JavaScript-free and there is nothing to strip out before deploying.

## Caching

GitHub Pages serves everything with `cache-control: max-age=600` and gives you no
way to set headers. Within that ten-minute window a browser can pair freshly
fetched HTML with a stylesheet it cached earlier, which renders the site wrong
until a hard reload.

To avoid that, the stylesheet URL carries a content hash — `css/style.css?v=3c8e93e4`.
A changed stylesheet is a different URL, so it can never be served from a stale
cache entry. After editing `css/style.css`, run:

```sh
./bin/cachebust.sh
```

It rewrites the hash in every page. Forgetting to run it is not fatal —
caches still expire after ten minutes — but visitors may see a stale layout
until then.

## Editing

`css/style.css` starts with the palette as custom properties:

```css
--teal: #2198a0;   /* headings, buttons, rings */
--blue: #6aa3d8;   /* links */
--text: #808080;   /* body copy */
```

Page sections are composed from a handful of classes — `.section`, `.wrap`, `.cols`,
`.checklist`, `.panel`, `.cta-band`, `.quotes` — all documented by use in the markup.

## Credits

All text, photographs and artwork belong to Susan Bauerfeld, PhD. The portrait on the home
and about pages is by [Laurie Klein](https://www.laurieklein.com).
