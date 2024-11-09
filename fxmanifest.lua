fx_version('cerulean')
games({ 'gta5' })
lua54 'yes'

shared_scripts {
    '@ox_lib/init.lua',
    'config.lua'
}

server_scripts({
    '@oxmysql/lib/MySQL.lua',
    "@vrp/lib/utils.lua",
    'server.lua'
});

client_scripts({
    'client.lua'
});
