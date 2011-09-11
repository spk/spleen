# encoding: UTF-8
require File.expand_path('../test_helper', __FILE__)
require File.expand_path('../../lib/generators/spleen/templates/model', __FILE__)

class Article < ActiveRecord::Base
  extend Spleen
  spleen(:dependent => :destroy)
end

class User < ActiveRecord::Base
end

describe Spleen::Base do
  it 'models dont use spleen by default' do
    assert !ActiveRecord::Base.respond_to?(:spleen)
    assert !Class.new(ActiveRecord::Base).respond_to?(:ratings)
  end

  it 'default rating we can rate anything' do
    a = Article.new
    u = User.create(:name => 'spk')
    a.rate(1, u).must_equal false
    a.errors.messages[:base].size.must_equal 1
    I18n.with_locale(I18n.default_locale) do
      error_message = I18n.t('errors.format',
                             :attribute => 'rateable_type'.humanize,
                             :message => I18n.t('errors.messages.inclusion'))
      a.errors.messages[:base].first.must_equal error_message
    end
  end

  it 'have ratings methods' do
    assert Article.respond_to?(:spleen)
    a = Article.new
    assert a.respond_to?(:ratings)
    assert a.respond_to?(:rate)
    assert a.respond_to?(:average_rate)
    assert a.respond_to?(:sum_rate)
    assert a.respond_to?(:count_rate)
  end
end
