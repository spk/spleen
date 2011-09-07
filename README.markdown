# Ratings for Rails 3

    gem 'spleen'

    bundle exec rails generate spleen:install

Usage:

    # edit app/models/article.rb:
      extend Spleen
      spleen(:dependent => :destroy)

    # add Article to RATEABLE_TYPES on app/models/rating.rb:
      RATEABLE_TYPES = %w{Article}

    a = Article.create(:title => 'test')
    a.rate(1, User.last)
    a.ratings # => [#<Rating id: 1, ...]
    a.average_rate # => 1.0
    a.sum_rate # => 1
    a.count_rate # => 1

# TODO

* tests
* documentation

# LICENSE

The MIT License

Copyright (c) 2011 Laurent Arnoud <laurent@spkdev.net>
