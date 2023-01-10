deps:
	echo 'Installing bundler'
	gem install bundler
	echo 'Installing ruby gems'
	bundle install

start:
	@bundle exec jekyll serve --watch