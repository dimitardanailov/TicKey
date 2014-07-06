# Add extensions methods to Rails DateTime Class
# Posts: 
# + http://www.doctormonk.com/2008/06/extending-core-classes-in-ruby-on-rails.html
# + http://stackoverflow.com/questions/5654517/in-ruby-on-rails-to-extend-the-string-class-where-should-the-code-be-put-in
class DateTime
  
  @@db_format = "%Y-%m-%d %H:%M"

  # Try to parse string to date and return date with format %Y
  # Post: http://apidock.com/ruby/DateTime/strftime
  def self.string_format_and_convert(date_string)
    begin
      date_time = DateTime.parse(date_string)
    rescue => ex
      # Display error into server console
      puts YAML::dump(ex)
      date_time = DateTime.now
    end

    date_time.convert_datetime_to_db_date_time(date_time)

    return date_time
  end

  # Try to convert string to date.
  # Method can parse date with this format: 
  # %m/%e/%Y 
  # %m/%d/%Y
  # If you date_string is invalid will return DateTime.now
  def self.strptime_date_time(date_string)
    date_time = DateTime.now
    unless date_string.blank?
      date_string = date_string.strip

      # Check month into date string has leading zero. If you not begin with 
      # leading zero, script will added.
      pattern_month_has_no_leading_zero = /^\d\//
      if date_string.match(pattern_month_has_no_leading_zero)
        date_string = "0" + date_string
      end

      # DateTime Format Examples:
      # - 02/6/2013 - %m/%e/%Y
      # - 02/06/2013 - %m/%d/%Y
      formats = ["%m/%e/%Y", "%m/%d/%Y"]
      formats.each do |date_format|
        # Try to cast string to DateTime
        if DateTime.strptime(date_string, date_format)
          date_time = DateTime.strptime(date_string, date_format)
          break
        end
      end
    end

    return date_time
  end

  def convert_datetime_to_db_date_time
    date_format = "%Y-%m-%d %H:%M"
    self.try(:strftime, date_format)
  end

  # Try to parse format to set format.
  # If you date is invalid or format is invalid, method will return nil
  def self.try_to_parse(format = nil)
    date_format = set_date_format(format)
    
    begin
      date_time = self.parse(date_format)
      return date_time
    rescue => ex
      puts YAML::dump(ex)
      return nil
    end
  end

  # If you format is equal will use default database format
  def set_date_format(format) 
    unless format.nil?
      return format
    else
      return @@db_format
    end
  end
end

