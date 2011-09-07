# encoding: UTF-8
require File.expand_path("../test_helper.rb", __FILE__)

class Article < ActiveRecord::Base
  extend Spleen
  spleen(:dependent => :destroy)
end

describe Spleen::Base do
  it 'models dont use spleen by default' do
    assert !ActiveRecord::Base.respond_to?(:spleen)
    assert !Class.new(ActiveRecord::Base).respond_to?(:ratings)
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
