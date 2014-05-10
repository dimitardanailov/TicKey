module CardPurchesHelper

  def generate_testing_data_create_purchase
    user = User.all.first

    unless user.blank?
      params[:user_id] = user[:id]
    end

    line = Line.all.first

    unless line.blank?
      params[:line_name] = line[:name]
    end

    card_type = TransportCardType.all.first

    unless card_type.blank?
      params[:card_type] = card_type[:name]
    end
  end
end
