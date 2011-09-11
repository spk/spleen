# encoding: UTF-8
require File.expand_path('../test_helper', __FILE__)

class Article < ActiveRecord::Base
  extend Spleen
  spleen(:dependent => :destroy)
end

class User < ActiveRecord::Base
end

# XXX find a better way to do that test
class Rating < ActiveRecord::Base
  RATEABLE_TYPES = %w{Article}
  RATETOR_TYPES = %w{User}
  belongs_to :rateable, :polymorphic => true
  belongs_to :ratetor, :polymorphic => true

  validates_presence_of :rateable, :ratetor
  validates_inclusion_of :rateable_type, :in => RATEABLE_TYPES
  validates_inclusion_of :ratetor_type, :in => RATETOR_TYPES
  validates_uniqueness_of :ratetor_id, :scope => [:rateable_id, :rateable_type],
    :message => proc {I18n.t('rateable.already_rated')}
end

describe Spleen::Base do
  it 'can rate a rateable type' do
    a = Article.new
    u = User.create(:name => 'spk')
    a.rate(1, u).must_equal true
    a.ratings.size.must_equal 1
    a.average_rate.must_equal 1.0
    a.sum_rate.must_equal 1.0
    a.count_rate.must_equal 1.0

    # can rate one time
    a.rate(2, u).must_equal false

    # errors
    a.errors.messages[:base].size.must_equal 1
    # TODO: test i18n message
  end
end
