#!/usr/bin/env lua
require'lib.autoload'

CLI.options = {
    build = {
        description = 'Change build directory path.',
        alias = 'b',
        default = './build'
    },
    entry = {
        description = 'Change path for entry file.',
        alias = 'e',
        default = './src/init.lua'
    },
    output = {
        description = 'Set name for compiled executable.',
        alias = 'o',
        default = 'stanley'
    },
}

CLI.help = {
    'Creating executable from Lua source.',
    '\nUsage: %EXEC% [options] command',
    '\nAvailable commands:',
    CLI.printCommands,
    '\nOptional arguments:',
    CLI.printOptions,
}

CLI.commands = {
    help = { 'Show this message.', function()
        CLI:printHelp()
    end},

    clean = { 'Delete build directory.', function()
        io.write('Deleting build directory...\n')
        os.execute('rm -rf ' .. CLI:getOption('build'))
        io.write('Done.\n')
        io.flush()
    end},

    build = { 'Compile source into binary.', function()
        assert(File.exists(CLI:getOption('entry')), 'Specified entry file does not exist! ' .. CLI:getOption('entry'))
        assert(File.exists(CLI:getOption('build')), 'Build directory does not exist! ' .. CLI:getOption('build'))
        lexe:compile(CLI:getOption('entry'), CLI:getOption('output'), CLI:getOption('build'))
    end},
}

CLI:init()
if CLI:getOption('version') then
    CLI:printVersion()
    os.exit()
end
if #CLI.args > 0 then
    local Command = CLI.args[1]
    table.remove(CLI.args, 1)
    CLI:issueCommand(Command)
else
    CLI:issueCommand('help')
end
