# Jekyll to Zola Migration Plan

## Overview
Migrate Xavier Balloy's dev blog from Jekyll (Minima theme) to Zola (Linkita theme) while preserving all 5 existing blog posts and maintaining feature parity.

## Current Site Analysis
- **Posts**: 5 markdown files in `_posts/`
- **Theme**: Minima (Jekyll default)
- **Features**: RSS feed, Fathom Analytics, Disqus comments, social links
- **Assets**: 6 images in `assets/`

## Migration Tasks

### 1. Initialize Zola Project Structure
Create the required Zola directory structure:
```
├── config.toml
├── content/
│   ├── _index.md          # Homepage (shows blog posts)
│   └── blog/
│       ├── _index.md      # Blog section config
│       └── [posts...]     # Posts at /blog/slug/
├── static/
│   └── images/            # Migrated assets
├── themes/
│   └── linkita/
└── templates/
    └── injects/           # Custom template injections
```

### 2. Install Linkita Theme
```bash
git submodule add -b v4 https://codeberg.org/salif/linkita.git themes/linkita
```

### 3. Configure `config.toml`
Key settings to configure:
- `base_url = "https://xballoy.github.io"`
- `title = "Xavier Balloy Dev Blog"`
- `default_language = "en"`
- `theme = "linkita"`
- `generate_feeds = true`
- Taxonomies: tags, authors
- Linkita-specific extras (social links, author info)

### 4. Migrate Content

#### 4.1 Convert Post Front Matter (YAML → TOML)

**Jekyll format:**
```yaml
---
layout: post
title: "Post Title"
description: "Description"
author: Xavier Balloy
tags:
  - tag1
  - tag2
---
```

**Zola format:**
```toml
+++
title = "Post Title"
description = "Description"
date = 2017-11-19

[taxonomies]
tags = ["tag1", "tag2"]
authors = ["Xavier Balloy"]

[extra]
first_published_site = "..."  # if applicable
first_published_link = "..."  # if applicable
+++
```

#### 4.2 Posts to Migrate
| Jekyll File | Zola File | URL |
|-------------|-----------|-----|
| `2017-11-19-my-global-day-of-code-retreat-2017.md` | `content/blog/my-global-day-of-code-retreat-2017.md` | `/blog/my-global-day-of-code-retreat-2017/` |
| `2017-11-29-how-to-avoid-conditional-in-your-code.md` | `content/blog/how-to-avoid-conditional-in-your-code.md` | `/blog/how-to-avoid-conditional-in-your-code/` |
| `2019-09-12-git-from-beginner-to-advanced-user.md` | `content/blog/git-from-beginner-to-advanced-user.md` | `/blog/git-from-beginner-to-advanced-user/` |
| `2019-11-15-socrates-france-2019.md` | `content/blog/socrates-france-2019.md` | `/blog/socrates-france-2019/` |
| `2021-09-28-redux-saga-with-callback.md` | `content/blog/redux-saga-with-callback.md` | `/blog/redux-saga-with-callback/` |

#### 4.3 Content Adjustments
- Remove `<!--more-->` excerpt markers (Zola uses `<!-- more -->` with spaces, or `description` field)
- Update image paths from `/assets/` to `/images/` or colocated assets
- Verify all internal links work

### 5. Migrate Static Assets
Move images from `assets/` to `static/images/`:
- `2017-11-19-my-global-day-of-code-retreat-2017-1.jpeg`
- `2019-09-12-git-from-beginner-to-advanced-user-1.png`
- `2019-09-12-git-from-beginner-to-advanced-user-2.png`
- `2019-11-15-socrates-france-2019-1.jpeg`
- `2019-11-15-socrates-france-2019-2.jpeg`
- `2019-11-15-socrates-france-2019-3.png`

### 6. Create Section Index Files

#### `content/_index.md` (Homepage)
Homepage that displays posts from the blog section:
```toml
+++
title = "Xavier Balloy Dev Blog"
template = "blog.html"
redirect_to = "/blog/"
# OR: Configure to render blog posts on homepage using a custom template
+++
```

#### `content/blog/_index.md` (Blog section)
```toml
+++
title = "Blog"
sort_by = "date"
paginate_by = 10
template = "blog.html"
page_template = "blog_page.html"
+++
```

**Note**: Future pages can be added at root level (e.g., `/about/`, `/projects/`) without conflicting with blog URLs.

### 7. Configure Integrations

#### Analytics (Fathom)
Linkita supports custom HTML injection. Create `templates/injects/head.html`:
```html
{% if config.extra.fathom_site_id %}
<script src="https://cdn.usefathom.com/script.js" data-site="{{ config.extra.fathom_site_id }}" defer></script>
{% endif %}
```

#### Comments (Giscus)
Configure Giscus in `config.toml` for GitHub Discussions-based comments:
```toml
[extra.giscus]
repo = "xballoy/xballoy.github.io"
repo_id = "<repo_id>"           # Get from giscus.app
category = "Announcements"
category_id = "<category_id>"   # Get from giscus.app
mapping = "pathname"
reactions_enabled = true
emit_metadata = false
theme = "preferred_color_scheme"
lang = "en"
```

Setup steps:
1. Enable GitHub Discussions on the repository
2. Install the Giscus app: https://github.com/apps/giscus
3. Get repo_id and category_id from https://giscus.app

### 8. Update GitHub Actions
Replace Jekyll build workflow with Zola:
- Use `shalzz/zola-deploy-action` or similar
- Update deployment configuration

### 9. Clean Up Old Jekyll Files
Remove after successful migration:
- `_config.yml`
- `_posts/`
- `_layouts/`
- `_includes/`
- `_sass/`
- `Gemfile`, `Gemfile.lock`
- `404.html`, `index.md`

## Files to Create/Modify

| Action | File |
|--------|------|
| Create | `config.toml` |
| Create | `content/_index.md` (homepage) |
| Create | `content/blog/_index.md` (blog section) |
| Create | 5 posts in `content/blog/` |
| Move | 6 images to `static/images/` |
| Create | `templates/injects/head.html` (Fathom analytics) |
| Update | `.github/workflows/` (deployment) |
| Delete | Jekyll files (after verification) |

## Verification Steps

1. **Install Zola locally**: `brew install zola` (macOS)
2. **Run dev server**: `zola serve`
3. **Verify each post renders correctly** at `/blog/<slug>/`
4. **Check image paths work** (should resolve from `/images/`)
5. **Verify RSS feed at `/atom.xml`**
6. **Test responsive design** (mobile/desktop)
7. **Verify Fathom analytics** loads in production build
8. **Verify Giscus comments** appear on posts after GitHub Discussions setup
9. **Test deployment to GitHub Pages** via updated workflow

## Decisions Made

- **Homepage**: Displays blog post list (redirects or renders from `/blog/`)
- **URL structure**: Posts at `/blog/<slug>/` (e.g., `/blog/my-global-day-of-code-retreat-2017/`)
- **Comments**: Migrate to Giscus (GitHub Discussions-based)
- **Future pages**: Root-level URLs available for new pages (e.g., `/about/`, `/projects/`)
