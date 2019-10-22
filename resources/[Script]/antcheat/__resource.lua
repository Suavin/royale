-- Manifest
resource_manifest_version '44febabe-d386-4d18-afbe-5e627f4af937'

description 'AntCheater'

dependency "vrp"

-- General
client_scripts {
  'anticheater-client.lua',
}

server_scripts {
  '@vrp/lib/utils.lua',
  'anticheater-server.lua',
}