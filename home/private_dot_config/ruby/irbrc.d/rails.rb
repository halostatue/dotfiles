def rails?
  defined?(::Rails) && Rails.env
end

if rails? && defined?(ActiveRecord)
  def change_log(stream)
    require "logger"
    ActiveRecord::Base.logger = Logger.new(stream)
    ActiveRecord::Base.clear_active_connections!
    nil
  end

  def show_log
    change_log($stdout)
  end

  def hide_log
    change_log(nil)
  end

  def log_off
    puts "== Logging to log file."
    ActiveRecord::Base.logger.level = 1 # warn (?)
    nil
  end

  def log_on
    puts "== Logging to console."
    ActiveRecord::Base.logger.level = 0 # debug (?)
    nil
  end

  class Class
    def core_ext
      instance_methods.map { |m|
        [m, instance_method(m).source_location]
      }.select { |m|
        m[1] && m[1][0] =~ /activesupport/
      }.map { |m|
        m[0]
      }.sort
    end
  end
end
