DiscordWebhookSystemInfos = 'https://discordapp.com/api/webhooks/629169538365128734/2nagidLTbxnGw3hCh9xFjpwYDGUFOlJ_iyXpMrooyS_XGzDlKn10q5Ocz5T_WIUrcLSS'
DiscordWebhookKillinglogs = 'https://discordapp.com/api/webhooks/629169669009571870/flv2p3edvH_DioF9gIIK1VCdLnQTWU5R3LXXQ_y5ee36mamVDoxp1RMXgxhSBJyJ2Hee'
DiscordWebhookChat = 'https://discordapp.com/api/webhooks/629169756133654529/yHKogtJhDtt6W32CUxxySiLV1SW72zD6T6yC1c89PsFl9A6ccrQuT41CbfEaBzr57W_k'

SystemAvatar = 'https://wiki.fivem.net/w/images/d/db/FiveM-Wiki.png'

UserAvatar = 'https://i.imgur.com/8RYxNkm.png'

SystemName = 'Royale Academy'


--[[ Special Commands formatting
		 *YOUR_TEXT*			--> Make Text Italics in Discord
		**YOUR_TEXT**			--> Make Text Bold in Discord
	   ***YOUR_TEXT***			--> Make Text Italics & Bold in Discord
		__YOUR_TEXT__			--> Underline Text in Discord
	   __*YOUR_TEXT*__			--> Underline Text and make it Italics in Discord
	  __**YOUR_TEXT**__			--> Underline Text and make it Bold in Discord
	 __***YOUR_TEXT***__		--> Underline Text and make it Italics & Bold in Discord
		~~YOUR_TEXT~~			--> Strikethrough Text in Discord
]]
-- Use 'USERNAME_NEEDED_HERE' without the quotes if you need a Users Name in a special command
-- Use 'USERID_NEEDED_HERE' without the quotes if you need a Users ID in a special command


-- These special commands will be printed differently in discord, depending on what you set it to
SpecialCommands = {
				   {'/ooc', '**[OOC]:**'},
				   {'/911', '**[911]: (CALLER ID: [ USERNAME_NEEDED_HERE | USERID_NEEDED_HERE ])**'},
				  }

						
-- These blacklisted commands will not be printed in discord
BlacklistedCommands = {
					   '/AnyCommand',
					   '/AnyCommand2',
					  }

-- These Commands will use their own webhook
OwnWebhookCommands = {
					  {'/AnotherCommand', 'WEBHOOK_LINK_HERE'},
					  {'/AnotherCommand2', 'WEBHOOK_LINK_HERE'},
					 }

-- These Commands will be sent as TTS messages
TTSCommands = {
			   '/Whatever',
			   '/Whatever2',
			  }

