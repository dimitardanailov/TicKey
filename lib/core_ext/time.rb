class Time

  # Method will gnerate two dates from param
  # - iso 8601 date format
  # - rfc 822 date format
  def self.generate_mime_formated_dates(date)
    dates = Hash.new
    iso_8601_date = nil
    rfc_822_date = nil

    unless date.blank?
      iso_8601_date = date.generate_iso_8601_date
      rfc_822_date = date.generate_iso_rfc822_date
    end

    dates[:iso_8601] = iso_8601_date
    dates[:rfc822] = rfc_822_date

    return dates
  end

  # UTC ISO 8601 format
  # Articles:
  # http://stackoverflow.com/questions/4046289/convert-datetime-string-to-utc-in-rails/22913188#22913188
  # http://www.elabs.se/blog/36-working-with-time-zones-in-ruby-on-rails
  # http://devblog.avdi.org/2009/10/25/iso8601-dates-in-ruby/
  def generate_iso_8601_date
    date = self.to_formatted_s(:response_format)
    iso8601_date = Time.parse(date).utc.iso8601

    return iso8601_date
  end
        
  # RFC 822 time zones
  # http://nathanhoad.net/easy-rfc-822-datetimes-for-rss-in-rails
  def generate_iso_rfc822_date
    date = self.to_formatted_s(:response_format)
    rfc822 = Time.parse(date).utc.rfc2822

    return rfc822
  end
end
