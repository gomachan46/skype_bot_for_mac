skype_bot_for_mac
=================

正直他の環境で動くかまだわかりません。  
ruby1.8.7、mac(mountain lion)でのみ動作確認  
rb-skypemac依存  

現状

指定したチャットにbotを送り、誰かが書き込んだら指定した言葉を書き込みます。  
* ruby skype_chat_on_terminal.rb chat_id
* ruby skype_message_schedule.rb chat_id time_limit
* ruby skype_quick_response.rb chat_id sentence

引数を入力しなかった場合、最近会話をしたグループおよび個人チャットの一覧を表示します。  
表示された情報を基に引数を与えて再度実行してください。
chat_idはエスケープしてください。

理想

* もっと楽にchat_idを指定できるようにする
* 会話の流れをわかった発言を自動的にするようにする
