return {
    loaded = {},

    hasLoaded = function(self, file)
        for index, loaded in ipairs(self.loaded) do
            if loaded == file then
                return true
            end
        end
        return false
    end,

    parse = function(self, lines, indent)
        indent = indent or ''
        local output = {}
        for index, line in ipairs(lines) do
            local file = line:match('require[\'"]([^\'"]+)[\'"]')
            if file then
                if not self:hasLoaded(file) then
                    local path = file:gsub('%.', '/'):gsub('`/', '.') .. '.lua'
                    if File.exists(path) then
                        table.insert(self.loaded, file)
                        local contents = File.get_lines(path)
                        if path:match('^lib/autoload%.lua$') then
                            for i=1,13 do
                                table.remove(contents, 1)
                            end
                        end
                        contents = self:parse(contents, indent .. '    ')
                        contents = '(function()\n' .. contents:gsub('%%', '%%%%') .. '\nend)()'
                        file = file:gsub('%%', '%%%%')
                        for _, character in ipairs({'+', '-', '.', '?', '*', '[', ']', '(', ')', '$', '^'}) do
                            file = file:gsub('%' .. character, '%%' .. character)
                        end
                        line = line:gsub('require[\'"]' .. file .. '[\'"]', contents)
                    end
                else
                    line = ''
                end
            end
            if #line > 0 then
                line = indent .. line
            end
            output[#output+1] = line
        end
        return table.concat(output, '\n')
    end,

    bundle = function(self, entry, target, build)
        local build_file = build .. '/' .. target

        io.write('Bundling source code...\n')
        local parsed = self:parse( File.get_lines(entry) )
        local file = File.open(build_file .. '.lua', 'w')
        file:write(parsed)
        File.close(file)

        io.write('Done.\n')
        io.flush()
    end,

    compile = function(self, entry, target, build)
        local build_file = build .. '/' .. target

        io.write('Compiling source into binary...\n')
        os.execute('luac -o ' .. build_file .. '.luac ' .. build_file .. '.lua')

        io.write('Creating executable from binary...\n')
        local contents = File.get_contents(build_file .. '.luac')
        local file = File.open(build_file, 'wb')
        file:write('#!/usr/bin/env lua\n')
        file:write(contents)
        File.close(file)
        os.execute('chmod +x ' .. build_file)

        io.write('Done.\n')
        io.flush()
    end
}