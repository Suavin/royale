Config = {}

Config.RestrictedChannels = 12 -- channels that are encrypted (EMS, Fire and police can be included there) if we give eg 10, channels from 1 - 10 will be encrypted
Config.enableCmd = false --  /radio command should be active or not (if not you have to carry the item "radio") true / false

Config.messages = {

  ['not_on_radio'] = 'No momento, você não está em nenhum rádio',
  ['on_radio'] = 'Você está atualmente no rádio: <b>',
  ['joined_to_radio'] = 'Você entrou no rádio: <b>',
  ['you_on_radio'] = 'Você já está no rádio: <b>'

}
