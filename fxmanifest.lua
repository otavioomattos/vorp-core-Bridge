fx_version 'cerulean'
game 'rdr3'
rdr3_warning 'I acknowledge that this is a prerelease build of RedM, and I am aware my resources *will* become incompatible once RedM ships.'

description 'RSG VorpCore Wrapper'
author 'DrD'
version '0.0.1'

server_script {
    '@oxmysql/lib/MySQL.lua',
    'server.lua'
}

client_script 'client.lua'

lua54 'yes'