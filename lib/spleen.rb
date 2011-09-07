# encoding: UTF-8
require 'rails'

module Spleen
  def self.extended(model_class)
    model_class.instance_eval do
      extend Base
    end

    model_class.class_eval do
      ##
      # @param [Float] value
      # @param [ActiveRecord::Base] ratetor
      # @return [Boolean] TrueClass is rate saved else FalseClass
      #
      def rate(value, ratetor)
        r = Rating.new(
          :ratetor => ratetor,
          :rateable_type => ratetor.class.to_s,
          :rate => value,
          :rateable => self,
          :rateable_type => self.class.to_s,
          :rateable_id => self.id
        )
        if r.valid?
          r.save
        else
          r.errors.full_messages.each do |e|
            self.errors.add(:base, e)
          end
          false
        end
      end

      ##
      # Helper method that returns the average rating
      #
      def average_rate
        Rating.calculate(:average, :rate,
                         :conditions => {
          :rateable_type => self.class.to_s,
          :rateable_id => self.id
        }).to_f
      end
      ##
      # Helper method that returns the sum rate
      #
      def sum_rate
        Rating.calculate(:sum, :rate,
                         :conditions => {
          :rateable_type => self.class.to_s,
          :rateable_id => self.id
        }).to_i
      end
      ##
      # Helper method that returns the count rate
      #
      def count_rate
        Rating.calculate(:count, :rate,
                         :conditions => {
          :rateable_type => self.class.to_s,
          :rateable_id => self.id
        }).to_i
      end
    end
  end

  module Base
    def spleen(opts={})
      options = {:as => :rateable}
      options.merge!(opts)
      has_many :ratings, options
    end
  end
end
