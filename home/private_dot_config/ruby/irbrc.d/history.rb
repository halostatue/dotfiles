require "digest/md5"

pwd_base = Pathname.pwd.basename.to_s.sub(/^\./, "")
pwd_digest = Digest::MD5.hexdigest(Dir.pwd)

history = Pathname(ENV.fetch("XDG_CACHE_HOME") { Pathname(ENV["HOME"]).join(".cache") })
  .join("ruby", "irb_history.#{pwd_base}.#{pwd_digest}").to_path

if defined? Pry
  Pry.config.history_file = history
else
  IRB.conf[:HISTORY_FILE] = history
end
