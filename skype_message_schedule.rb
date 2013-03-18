#! /usr/bin/ruby

require "rubygems"
require "rb-skypemac"
require "readline"
require 'shellwords'

include SkypeMac

def search_chat_name()
  chats = SkypeMac::Skype.send_(:command => 'SEARCH RECENTCHATS')
  chats=chats.sub("CHATS ","").split(/,/)
  for chat_id in chats
    puts SkypeMac::Skype.send_(:command => 'GET CHAT %s FRIENDLYNAME' % chat_id)
  end
end

def search_last_chat_id_in_group()
    group_chat_id = ARGV[0]
    SkypeMac::Skype.send_(:command => 'GET CHAT %s RECENTCHATMESSAGES' % group_chat_id).split(/,/).last
end

if ARGV[0].nil?
  search_chat_name() if ARGV[0].nil?
  puts '上記の中からbotを潜入させたいchat_id(ex.#hoge/$fuga;xxxxxxx)を第一引数に指定してください'
  exit
end
time_limit = ARGV[1].to_i
time_limit = 3 if (time_limit<=0)

puts "chatmessage #{ARGV[0]} #{time_limit}分間だけ待ってやろう"
puts Skype.send_(:command => "chatmessage #{ARGV[0]} #{time_limit}分間だけ待ってやろう")
sleep(time_limit*60)
puts Skype.send_(:command => "chatmessage #{ARGV[0]} さあ答えを聞こうじゃないか")
