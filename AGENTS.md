# Guidance for coding agents

This is a personal website built with [Zola](https://www.getzola.org/) using the
theme [Linkita](https://www.getzola.org/themes/linkita/). The theme is installed
as a git submodule in `themes/linkita/`.

## Content structure

All content lives under `content/`. Zola derives the site structure from the
directory layout.

```
content/
├── _index.md              # Site root metadata (sort_by, paginate_by, profile)
└── blog/
    ├── _index.md          # Archive section metadata
    ├── my-post.md         # Post without images (single file)
    └── my-post/           # Post with images (folder)
        ├── index.md
        └── image.png
```

`_index.md` files define section metadata and are not pages themselves. The blog
section uses `template = "archive.html"` and `transparent = true`.

## Writing a post

Posts use TOML front matter:

```toml
+++
title = "Post title"
description = "Short description for SEO and previews."
date = 2024-01-15

[taxonomies]
tags = ["tag1", "tag2"]

[extra]
comment = true
# Optional fields:
# mermaid = true
# first_published_site = "Original site name"
# first_published_link = "https://..."
+++

Summary text visible on the index page.

<!-- more -->

Full content below the fold.
```

### Front matter fields

| Field                          | Required | Description                           |
|--------------------------------|----------|---------------------------------------|
| `title`                        | yes      | Post title                            |
| `description`                  | yes      | Short description for SEO             |
| `date`                         | yes      | Publication date (`YYYY-MM-DD`)       |
| `[taxonomies] tags`            | yes      | List of tags                          |
| `[extra] comment`              | yes      | Enable comments (`true`/`false`)      |
| `[extra] mermaid`              | no       | Enable Mermaid diagrams               |
| `[extra] first_published_site` | no       | Name of the original publication site |
| `[extra] first_published_link` | no       | URL of the original publication       |

### Posts with images

Use a folder with `index.md` instead of a single file. All non-Markdown files in
the folder are co-located and copied alongside the generated page. Reference
images with the `{{ img() }}` shortcode.

### Mermaid diagrams

When `mermaid = true` is set in front matter, use `{% mermaid() %}...{% end %}`
blocks in the post body.
