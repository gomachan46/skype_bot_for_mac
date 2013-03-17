#! /usr/bin/ruby

require "rubygems"
require "rb-skypemac"
require "readline"

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
ARGV[1] ||= 'www'

chat_id = search_last_chat_id_in_group()
while true
  latest_chat_id = search_last_chat_id_in_group()
  puts "chatmessage #{ARGV[0]} #{ARGV[1]} unless chat_id == latest_chat_id"
  puts Skype.send_(:command => "chatmessage #{ARGV[0]} #{ARGV[1]}") unless chat_id == latest_chat_id
  chat_id = search_last_chat_id_in_group()
  sleep(rand(100))
end
