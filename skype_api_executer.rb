#! /usr/bin/env ruby

require "rubygems"
require "rb-skypemac"
require "readline"

include SkypeMac

while buf = Readline.readline("skype> ", true)
  if buf == "help"
    system("open https://developer.skype.com/Docs/ApiDoc/src#Reference")
  else
    p Skype.send_(:command => buf)
  end
end
