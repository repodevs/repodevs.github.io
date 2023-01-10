# me.repodevs.com

This is my official page based on [Jekyll-Uno](https://github.com/joshgerdes/jekyll-uno) pages

---

### Install and Test

1. Download or clone repo `git clone git@github.com:repodevs/repodevs.github.io.git`
2. Enter the folder: `cd repodevs.github.io/`
3. If you don't have bundler installed: `gem install bundler`
3. Install Ruby gems: `bundle install`
4. Start Jekyll server: `bundle exec jekyll serve --watch`

Access via: [http://localhost:4000/repodevs.github.io/](http://localhost:4000/repodevs.github.io/)

If you would like to run without using the `github-pages` gem, update your Gemfile to the following:

```
source 'https://rubygems.org'
gem 'jekyll-paginate'
gem 'jekyll-watch'
gem 'kramdown'
gem 'kramdown-parser-gfm'
```

---

### Copyright and license

It is under [the MIT license](/LICENSE).