# encoding: UTF-8
class Rating < ActiveRecord::Base
  RATEABLE_TYPES = %w{}
  RATETOR_TYPES = %w{User}
  belongs_to :rateable, :polymorphic => true
  belongs_to :ratetor, :polymorphic => true

  validates_presence_of :rateable, :ratetor
  validates_inclusion_of :rateable_type, :in => RATEABLE_TYPES
  validates_inclusion_of :ratetor_type, :in => RATETOR_TYPES
  validates_uniqueness_of :ratetor_id, :scope => [:rateable_id, :rateable_type],
    :message => proc {I18n.t('rateable.already_rated')}
end
