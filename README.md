# Xavier Balloy Dev Blog

This website uses [Zola](https://www.getzola.org/) and
the [Linkita](https://www.getzola.org/themes/linkita/) theme.

## Writing a post

Add a file to the `content/blog/` directory. Posts can be:

- A single markdown file: `my-post.md`
- A folder with an `index.md` for posts with images: `my-post/index.md`

Posts use TOML front matter:

```toml
+++
title = "My awesome blog post"
description = "A brief description for SEO and previews."
date = 2024-01-15

[taxonomies]
tags = ["tag1", "tag2"]

[extra]
comment = true
+++

Post content starts here.

<!-- more -->

Content after this marker appears only on the full post page.
```

For more information see the [Zola documentation](https://www.getzola.org/documentation/content/overview/).

## Running locally

### Prerequisites

Install Zola following the [official instructions](https://www.getzola.org/documentation/getting-started/installation/).

On macOS:

```bash
brew install zola
```

### Serve the site

```bash
zola serve
```

Visit [http://127.0.0.1:1111/](http://127.0.0.1:1111/). Changes are automatically reloaded.

## Linting

Markdown linting uses Node.js and pnpm:

```bash
pnpm install
pnpm lint
```

## Deployment

The site is automatically deployed to GitHub Pages via GitHub Actions when changes are pushed to `main`.
