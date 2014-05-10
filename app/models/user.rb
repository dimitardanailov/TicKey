require 'securerandom'

class User < ActiveRecord::Base
  has_many :card_purches

  # Validate user emails is valid
  validates :email, :email => true, :allow_blank => false
  validates_length_of :email, maximum: 120, :allow_blank => false
  validates_uniqueness_of :email, :allow_blank => false
end
