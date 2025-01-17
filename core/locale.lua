-- Copyright 2007-2022 Mitchell. See LICENSE.

local M = {}

--[[ This comment is for LuaDoc.
---
-- Map of all messages used by Textadept to their localized form.
-- If the table does not contain the localized version of a given message, it returns a string
-- that starts with "No Localization:" via a metamethod.
-- Note: the terminal version ignores any "_" mnemonics the GUI version would use.
module('_L')]]

local f = io.open(_USERHOME .. '/locale.conf', 'rb')
if not f then
  local lang = (os.getenv('LANG') or ''):match('^[^_.@]+') -- TODO: LC_MESSAGES?
  if lang then f = io.open(string.format('%s/core/locales/locale.%s.conf', _HOME, lang)) end
end
if not f then f = io.open(_HOME .. '/core/locale.conf', 'rb') end
assert(f, '"core/locale.conf" not found')
for line in f:lines() do
  -- Any line that starts with a non-word character except '[' is considered a comment.
  if not line:find('^%s*[%w_%[]') then goto continue end
  local id, str = line:match('^(.-)%s*=%s*(.-)\r?$')
  if id and str and assert(not M[id], 'duplicate locale key "%s"', id) then
    M[id] = not CURSES and str or str:gsub('_', '')
  end
  ::continue::
end
f:close()

return setmetatable(M, {__index = function(_, k) return 'No Localization:' .. k end})
