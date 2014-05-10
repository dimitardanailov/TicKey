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

  # Get count of active user purches by line id
  # Method will use group by user id. User who has biggest active purches will be 
  # placed into first place
  def self.get_count_of_user_active_purches_by_line_id(line_id)
    expire_date = Time.now

    card_purches = self
      .select("COUNT(user_id) as active_purches, user_id")
      .where("line_id = ? AND expire_date >= ?", line_id, expire_date)
      .group("user_id")
      .order("active_purches DESC")

    return card_purches
  end
end
