class CardPurch < ActiveRecord::Base

  belongs_to :user
  belongs_to :line
  belongs_to :transport_card_type

  validates_presence_of :user_id
  validates_presence_of :transport_card_type_id
  validates_presence_of :line_id

  # Generate expirte date for each user ticket
  # Every tickety will be valid only two days
  def self.generate_expire_date
    expire_date = Time.now + 2.days

    return expire_date
  end

  # Get only active tickets for user
  def self.get_active_card_purches_by_user_id(user_id)
    expire_date = Time.now

    card_purches = self
      .select("id, line_id, expire_date")
      .where("user_id = ? AND expire_date >= ?", user_id, expire_date)
      .order("expire_date ASC")

    return card_purches
  end
end
