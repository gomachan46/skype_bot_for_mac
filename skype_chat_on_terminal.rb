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

def search_chat_ids_in_group()
    group_chat_id = ARGV[0]
    chat_ids = SkypeMac::Skype.send_(:command => 'GET CHAT %s RECENTCHATMESSAGES' % group_chat_id).sub(/^.*RECENTCHATMESSAGES/){}.split(/,/)
    @last_chat_id = chat_ids.last
    chat_ids
end

def search_new_chat_ids_in_group()
    group_chat_id = ARGV[0]
    chat_ids = SkypeMac::Skype.send_(:command => 'GET CHAT %s RECENTCHATMESSAGES' % group_chat_id).sub(/^.*#{@last_chat_id}/){}.split(/,/)
    chat_ids.shift
    @last_chat_id = chat_ids.last
    chat_ids
end

if ARGV[0].nil?
  search_chat_name()
  puts '上記の中からbotを潜入させたいchat_id(ex.#hoge/$fuga;xxxxxxx)を第一引数に指定してください'
  puts '引数的にエスケープすべきな文字はエスケープしてください'
  exit
end

while buf = Readline.readline("skype> ", true)
  if buf == "show"
    chat_ids = search_chat_ids_in_group()
    chat_ids.each{|chat_id| puts Skype.send_(:command => "get chatmessage #{chat_id} body")}
  elsif buf == "reload"
    new_chat_ids = search_new_chat_ids_in_group()
    new_chat_ids.each{|chat_id| puts Skype.send_(:command => "get chatmessage #{chat_id} body")}
  else
    puts Skype.send_(:command => "chatmessage #{ARGV[0]} #{buf}")
  end
end
