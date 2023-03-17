history = Pathname(ENV.fetch("XDG_CACHE_HOME") { Pathname(ENV["HOME"]).join(".cache") })
  .join("ruby/irb_history").to_path

if defined? Pry
  Pry.config.history_file = history
else
  IRB.conf[:SAVE_HISTORY] = history
end
