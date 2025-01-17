-- Copyright 2007-2022 Mitchell. See LICENSE.

local M = {}

--[[ This comment is for LuaDoc.
---
-- The ansi_c module.
-- It provides utilities for editing C code.
-- @field autocomplete_snippets (boolean)
--   Whether or not to include snippets in autocompletion lists.
--   The default value is `true`.
module('_M.ansi_c')]]

-- Autocompletion and documentation.

---
-- List of ctags files to use for autocompletion in addition to the current project's top-level
-- *tags* file or the current directory's *tags* file.
-- @class table
-- @name tags
M.tags = {
  _HOME .. '/modules/ansi_c/tags', _HOME .. '/modules/ansi_c/lua_tags',
  _USERHOME .. '/modules/ansi_c/tags'
}

M.autocomplete_snippets = true

-- LuaFormatter off
local XPM = textadept.editing.XPM_IMAGES
local xpms = setmetatable({c=XPM.CLASS,d=XPM.SLOT,e=XPM.VARIABLE,f=XPM.METHOD,g=XPM.TYPEDEF,m=XPM.VARIABLE,s=XPM.STRUCT,t=XPM.TYPEDEF,v=XPM.VARIABLE},{__index=function()return 0 end})
-- LuaFormatter on

textadept.editing.autocompleters.ansi_c = function()
  -- Retrieve the symbol behind the caret.
  local line, pos = buffer:get_cur_line()
  local symbol, op, part = line:sub(1, pos - 1):match('([%w_]-)([%.%->]*)([%w_]*)$')
  if symbol == '' and part == '' then return nil end -- nothing to complete
  if op ~= '' and op ~= '.' and op ~= '->' then return nil end
  -- Attempt to identify the symbol type.
  if symbol ~= '' then
    local decl = '([%w_]+)[%s%*&]+' .. symbol:gsub('%p', '%%%0') .. '[^%w_]'
    for i = buffer:line_from_position(buffer.current_pos) - 1, 1, -1 do
      local class = buffer:get_line(i):match(decl)
      if class then
        symbol = class
        break
      end
    end
  end
  -- Search through ctags for completions for that symbol.
  local tags_files = {}
  for i = 1, #M.tags do tags_files[#tags_files + 1] = M.tags[i] end
  tags_files[#tags_files + 1] = (io.get_project_root(buffer.filename) or lfs.currentdir()) ..
    '/tags'
  local name_patt = '^' .. part
  local sep = string.char(buffer.auto_c_type_separator)
  ::rescan::
  local list = {}
  for _, filename in ipairs(tags_files) do
    if not lfs.attributes(filename) then goto continue end
    for tag_line in io.lines(filename) do
      local name = tag_line:match('^%S+')
      if (name:find(name_patt) and not name:find('^!') and not list[name]) or
        (name == symbol and op == '') then
        local fields = tag_line:match(';"\t(.*)$')
        local type = fields:match('class:(%S+)') or fields:match('enum:(%S+)') or
          fields:match('struct:(%S+)') or ''
        if type == symbol then
          list[#list + 1] = name .. sep .. xpms[fields:sub(1, 1)]
          list[name] = true
        elseif name == symbol and fields:match('typeref:') then
          -- For typeref, change the lookup symbol to the referenced name and rescan tags files.
          symbol = fields:match('[^:]+$')
          goto rescan
        end
      end
    end
    ::continue::
  end
  if symbol == '' and M.autocomplete_snippets then
    local _, snippets = textadept.editing.autocompleters.snippet()
    for i = 1, #snippets do list[#list + 1] = snippets[i] end
  end
  return #part, list
end

for _, tags in ipairs(M.tags) do
  table.insert(textadept.editing.api_files.ansi_c, (tags:gsub('tags$', 'api')))
end

-- Snippets.

local snip = snippets.ansi_c

snip.func = '%1(int) %2(name)(%3(args)) {\n\t%0\n\treturn %4(0);\n}'
snip.vfunc = 'void %1(name)(%2(args)) {\n\t%0\n}'
snip['if'] = 'if (%1) {\n\t%0\n}'
snip.eif = 'else if (%1) {\n\t%0\n}'
snip['else'] = 'else {\n\t%0\n}'
snip['for'] = 'for (%1; %2; %3) {\n\t%0\n}'
snip['fori'] = 'for (%1(int) %2(i) = %3(0); %2 %4(<) %5(count); %2%6(++)) {\n\t%0\n}'
snip['while'] = 'while (%1) {\n\t%0\n}'
snip['do'] = 'do {\n\t%0\n} while (%1);'
snip.sw = 'switch (%1) {\n\tcase %2:\n\t\t%0\n\t\tbreak;\n}'
snip.case = 'case %1:\n\t%0\n\tbreak;'

snip.st = 'struct %1(name) {\n\t%0\n};'
snip.td = 'typedef %1(int) %2(name_t);'
snip.tds = 'typedef struct %1(name) {\n\t%0\n} %1%2(_t);'

snip.def = '#define %1(name) %2(value)'
snip.inc = '#include "%1"'
snip.Inc = '#include <%1>'
snip.pif = '#if %1\n%0\n#endif'

snip.main = 'int main(int argc, const char **argv) {\n\t%0\n\treturn 0;\n}'
snip.printf = 'printf("%1(%s)\\n", %2);'

return M
