class CardPurch < ActiveRecord::Base

  validates_presence_of :user_id
  validates_presence_of :transport_card_type_id
  validates_presence_of :line_id

  def self.generate_expire_date
    expire_date = Time.now + 2.days

    return expire_date
  end
end
