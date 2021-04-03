#!/usr/bin/env ruby

# <xbar.title>Brew Services</xbar.title>
# <xbar.version>v1.0</xbar.version>
# <xbar.author>Adam Lindberg</xbar.author>
# <xbar.author.github>eproxus</xbar.author.github>
# <xbar.desc>Shows and manages Homebrew services.</xbar.desc>
# <xbar.image>http://i.imgur.com/hVfhHYP.jpg</xbar.image>
# <xbar.dependencies>ruby, brew, brew-services</xbar.dependencies>

# xbar Homebrew services plugin
# by Adam Lindbeng (@eproxus)

#--- User parameters ----------------------------------------------------------

BAR_COLORS = true

#--- Script internals ---------------------------------------------------------

require 'pathname'

BREW_LINK = "http://brew.sh/"
BREW_SERVICES_LINK = "https://github.com/Homebrew/homebrew-services"

SCRIPT_PATH = Pathname($0).realpath

brew = %w(~/.brew/bin /opt/homebrew/bin /usr/local/bin).map { |path| Pathname(path).join('brew') }.find(&:executable?)

if brew
  BREW = brew
  services = brew.dirname.dirname
  services = services.join('Homebrew') if brew.to_path =~ %r{^/usr/local}
  services = services.join('Library/Taps/Homebrew/homebrew-services/cmd/services.rb')
  BREW_SERVICES = services if services.exist?
end

if BAR_COLORS
  DARK_MODE = %x(defaults read -g AppleInterfaceStyle 2> /dev/null).strip
  RESET_COLOR = DARK_MODE == 'Dark' ? "\e[37m" : "\e[30m"
else
  RESET_COLOR = "\e[37m"
end

unless BREW
  puts [
    "Homebrew not installed | color=red",
    "---",
    "Install Homebrew... | href=#{BREW_LINK}",
    REFRESH,
  ].join("\n")
  exit
end

unless BREW_SERVICES
  puts [
    "Homebrew Services not installed | color=red",
    "---",
    "Install Homebrew Services... | href=#{BREW_SERVICES_LINK}",
    REFRESH,
  ].join("\n")
  exit
end

def service(command, name)
  "shell=\"#{BREW}\"" \
    + " param1=services param2=#{command} param3=\"#{name}\"" \
    + " terminal=false refresh=true"
end

def menu(name, status, user)
  if status == "started"
    [
      "#{name} | color=green",
      "--Restart | #{service("restart", name)}",
      "--Stop | #{service("stop", name)}",
      "-----",
      "--State: #{status}",
      "--User: #{user}",
    ]
  else
    [
      name,
      "--Start | #{service("start", name)}",
      "-----",
      "--State: #{status}",
    ]
  end
end

def plural(count)
  count <= 1 ? "#{count} Service" : "#{count} Services"
end

output = %x(#{BREW} services list).split("\n")[1..-1]

services = output && output.reduce({started: 0, menus: []}) do |acc, service|
  name, status, user, _plist = service.split
  acc[:started] += 1 if status == "started"
  acc[:menus] += menu(name, status, user)
  acc
end

total = (output || []).length
started = services[:started]
menus = services[:menus].join("\n")

all =
  if total > 1
    <<~ALL_MENU
    ---
    All
    --Start #{plural(total - started)} | #{service("start", "--all")}
    --Stop #{plural(started)} | #{service("stop", "--all")}
    --Restart #{plural(total)} | #{service("restart", "--all")}
    ALL_MENU
  end

puts <<-MENU
#{started}/#{total}
---
#{menus}
#{all}---
Refresh | refresh=true
MENU
