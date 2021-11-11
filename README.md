# Xavier Balloy Dev Blog

This website uses [Jekyll](https://jekyllrb.com) and
the [minima](https://github.com/jekyll/minima) theme.

## Writing a post

Add a file to the `_posts` directory with the following format

```
YEAR-MONTH-DAY-title.md
```

Where `YEAR` is a four-digit number, `MONTH` and `DAY` are both two-digit
numbers.

All blog post files must begin
with [front matter](https://jekyllrb.com/docs/front-matter/). For example, the
minimal example is:

```
---
layout: post
title:  "My awesome blog post"
---

# Post title

Post content
```

For more information see "[Post](https://jekyllrb.com/docs/posts/)" in the
Jekyll documentation.

## Running locally

### Prerequisites

```bash
# ruby-install: install any Ruby version
# chruby: changes the current Ruby
$ brew install ruby-install chruby

# Install the current version of Ruby
$ ruby-install ruby

# Install bundler
$ gem install bundler
```

### Serve the site

1. Run `bundle install` to install the dependencies.
2. Then you can serve the website with `bundle exec jekyll serve` and visit it
   at [http://127.0.0.1:4000/](http://127.0.0.1:4000/).

To see your modifications you just need to refresh the page. However, if you
modify the `_config.yml` file you will need to stop the process and serve the
website again.

## Configuration

### Enabling analytics (via Fathom)

To activate [Fathom Analytics](https://usefathom.com/ref/2LQGOG) (using this is
a affiliate link you will get $10 discount on your first invoice) add the
following lines in `_config.yml`:

```yml
fathom_analytics:
  site_id: ABCDEFG
  # If you have a custom domain uncomment the following line
  # custom_domain: https://llama.yoursite.com/script.js
```
