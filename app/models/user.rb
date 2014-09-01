require 'securerandom'

class User < ActiveRecord::Base
  has_many :card_purches

  # Validate user emails is valid
  validates_length_of :email, maximum: 120, :allow_blank => false
  validates_uniqueness_of :email, :allow_blank => false

  # Validate user emails is valid
  validates :email, :email => true, :allow_blank => true
  validates_length_of :email, maximum: 50, :allow_blank => true
  validates_uniqueness_of :email, :allow_blank => true

  # Used by the rails-admin gem - display name() intead of
  # the foreign key in associations.
  def name
    self.email
  end

  # Default Values
  # Post: http://stackoverflow.com/questions/1550688/how-do-i-create-a-default-value-for-attributes-in-rails-activerecords-model
  before_save :default_values
  # Set default values for first name, last_name and pin
  def default_values
    self.user_type_id = 1
  end

  # Get only necessary model attributes
  # Methods is used for remove unsed attributes when we need to response
  # user object
  def clear_unsed_attributes(user)
    access_attributes = ['id', 'first_name', 'last_name']
    clear_user = {}

    access_attributes.each do |attribute|
      clear_user[attribute] = user[attribute]
    end

    return clear_user
  end

  # SQL Queries
  #
  # Try to find user into databse with require if you user doesn't will
  # return boolean
  def self.check_user_exist_by_email(email)
    user = User.select("id").where(:email => email).first

    unless user.blank?
      # Into our dabatabase has information for this user
      return true
    else
      # User doesn't exist into our database
      return false
    end
  end
end
