-- Copyright 2007-2022 Mitchell. See LICENSE.

local M = {}

--[[ This comment is for LuaDoc.
---
-- Handles file type detection for Textadept.
-- @field _G.events.LEXER_LOADED (string)
--   Emitted after loading a language lexer.
--   This is useful for overriding a language module's key bindings or other properties since
--   the module is not loaded when Textadept starts.
--   Arguments:
--
--   * _`name`_: The language lexer's name.
module('textadept.file_types')]]

-- Events.
events.LEXER_LOADED = 'lexer_loaded'

-- LuaFormatter off
---
-- Map of file extensions to their associated lexer names.
-- If the file type is not recognized by its first-line, each file extension is matched against
-- the file's extension.
-- @class table
-- @name extensions
M.extensions = {--[[Actionscript]]as='actionscript',asc='actionscript',--[[Ada]]adb='ada',ads='ada',--[[ANTLR]]g='antlr',g4='antlr',--[[APDL]]ans='apdl',inp='apdl',mac='apdl',--[[APL]]apl='apl',--[[Applescript]]applescript='applescript',--[[ASM]]asm='asm',ASM='asm',s='asm',S='asm',--[[ASP]]asa='asp',asp='asp',hta='asp',--[[AutoIt]]au3='autoit',a3x='autoit',--[[AWK]]awk='awk',--[[Batch]]bat='batch',cmd='batch',--[[BibTeX]]bib='bibtex',--[[Boo]]boo='boo',--[[C#]]cs='csharp',--[[C/C++]]c='ansi_c',cc='cpp',C='ansi_c',cpp='cpp',cxx='cpp',['c++']='cpp',h='cpp',hh='cpp',hpp='cpp',hxx='cpp',['h++']='cpp',--[[ChucK]]ck='chuck',--[[Clojure]]clj='clojure',cljs='clojure',cljc='clojure',edn='clojure',--[[CMake]]cmake='cmake',['cmake.in']='cmake',ctest='cmake',['ctest.in']='cmake',--[[CoffeeScript]]coffee='coffeescript',--[[Crystal]]cr='crystal',--[[CSS]]css='css',--[[CUDA]]cu='cuda',cuh='cuda',--[[D]]d='dmd',di='dmd',--[[Dart]]dart='dart',--[[Desktop]]desktop='desktop',--[[diff]]diff='diff',patch='diff',--[[Dockerfile]]Dockerfile='dockerfile',--[[dot]]dot='dot',--[[Eiffel]]e='eiffel',eif='eiffel',--[[Elixir]]ex='elixir',exs='elixir',--[[Elm]]elm='elm',--[[Erlang]]erl='erlang',hrl='erlang',--[[F#]]fs='fsharp',--[[Fantom]]fan='fantom',--[[Faust]]dsp='faust',--[[Fennel]]fnl='fennel',--[[Fish]]fish='fish',--[[Forth]]forth='forth',frt='forth',--[[Fortran]]f='fortran',['for']='fortran',ftn='fortran',fpp='fortran',f77='fortran',f90='fortran',f95='fortran',f03='fortran',f08='fortran',--[[fstab]]fstab='fstab',--[[Gap]]gd='gap',gi='gap',gap='gap',--[[Gettext]]po='gettext',pot='gettext',--[[Gherkin]]feature='gherkin',--[[Gleam]]gleam='gleam',--[[GLSL]]glslf='glsl',glslv='glsl',--[[GNUPlot]]dem='gnuplot',plt='gnuplot',--[[Go]]go='go',--[[Groovy]]groovy='groovy',gvy='groovy',--[[Gtkrc]]gtkrc='gtkrc',--[[Haskell]]hs='haskell',--[[HTML]]htm='html',html='html',shtm='html',shtml='html',xhtml='html',vue='html',--[[Icon]]icn='icon',--[[IDL]]idl='idl',odl='idl',--[[Inform]]ni='inform',--[[ini]]cfg='ini',cnf='ini',inf='ini',ini='ini',reg='ini',--[[Io]]io='io_lang',--[[Java]]bsh='java',java='java',--[[Javascript]]js='javascript',jsfl='javascript',--[[jq]]jq='jq',--[[JSON]]json='json',--[[JSP]]jsp='jsp',--[[Julia]]jl='julia',--[[LaTeX]]bbl='latex',dtx='latex',ins='latex',ltx='latex',tex='latex',sty='latex',--[[Ledger]]ledger='ledger',journal='ledger',--[[LESS]]less='less',--[[LilyPond]]lily='lilypond',ly='lilypond',--[[Lisp]]cl='lisp',el='lisp',lisp='lisp',lsp='lisp',--[[Literate Coffeescript]]litcoffee='litcoffee',--[[Logtalk]]lgt='logtalk',--[[Lua]]lua='lua',--[[Makefile]]GNUmakefile='makefile',iface='makefile',mak='makefile',makefile='makefile',Makefile='makefile',--[[Man]]['1']='man',['2']='man',['3']='man',['4']='man',['5']='man',['6']='man',['7']='man',['8']='man',['9']='man',['1x']='man',['2x']='man',['3x']='man',['4x']='man',['5x']='man',['6x']='man',['7x']='man',['8x']='man',['9x']='man',--[[Markdown]]md='markdown',--[[Meson]]['meson.build']='meson',--[[MoonScript]]moon='moonscript',--[[Myrddin]]myr='myrddin',--[[Nemerle]]n='nemerle',--[[Networkd]]link='networkd',network='networkd',netdev='networkd',--[[Nim]]nim='nim',--[[NSIS]]nsh='nsis',nsi='nsis',nsis='nsis',--[[Objective C]]m='objective_c',mm='objective_c',objc='objective_c',--[[OCaml]]caml='caml',ml='caml',mli='caml',mll='caml',mly='caml',--[[Pascal]]dpk='pascal',dpr='pascal',p='pascal',pas='pascal',--[[Perl]]al='perl',perl='perl',pl='perl',pm='perl',pod='perl',--[[PHP]]inc='php',php='php',php3='php',php4='php',phtml='php',--[[PICO-8]]p8='pico8',--[[Pike]]pike='pike',pmod='pike',--[[PKGBUILD]]PKGBUILD='pkgbuild',--[[Pony]]pony='pony',--[[Postscript]]eps='ps',ps='ps',--[[PowerShell]]ps1='powershell',--[[Prolog]]prolog='prolog',--[[Properties]]props='props',properties='props',--[[Protobuf]]proto='protobuf',--[[Pure]]pure='pure',--[[Python]]sc='python',py='python',pyw='python',--[[R]]R='rstats',Rout='rstats',Rhistory='rstats',Rt='rstats',['Rout.save']='rstats',['Rout.fail']='rstats',--[[Reason]]re='reason',--[[REBOL]]r='rebol',reb='rebol',--[[reST]]rst='rest',--[[Rexx]]orx='rexx',rex='rexx',--[[RHTML]]erb='rhtml',rhtml='rhtml',--[[RouterOS]]rsc='routeros',--[[Ruby]]Rakefile='ruby',rake='ruby',rb='ruby',rbw='ruby',--[[Rust]]rs='rust',--[[Sass CSS]]sass='sass',scss='sass',--[[Scala]]scala='scala',--[[Scheme]]sch='scheme',scm='scheme',--[[Shell]]bash='bash',bashrc='bash',bash_profile='bash',configure='bash',csh='bash',ksh='bash',mksh='bash',sh='bash',zsh='bash',--[[Smalltalk]]changes='smalltalk',st='smalltalk',sources='smalltalk',--[[SML]]sml='sml',fun='sml',sig='sml',--[[SNOBOL4]]sno='snobol4',SNO='snobol4',--[[Spin]]spin='spin',--[[SQL]]ddl='sql',sql='sql',--[[Systemd]]automount='systemd',device='systemd',mount='systemd',path='systemd',scope='systemd',service='systemd',slice='systemd',socket='systemd',swap='systemd',target='systemd',timer='systemd',--[[TaskPaper]]taskpaper='taskpaper',--[[Tcl]]tcl='tcl',tk='tcl',--[[Texinfo]]texi='texinfo',--[[TOML]]toml='toml',--[[Txt2tags]]t2t='txt2tags',--[[TypeScript]]ts='typescript',--[[Vala]]vala='vala',--[[vCard]]vcf='vcard',vcard='vcard',--[[Verilog]]v='verilog',ver='verilog',--[[VHDL]]vh='vhdl',vhd='vhdl',vhdl='vhdl',--[[Visual Basic]]bas='vb',cls='vb',ctl='vb',dob='vb',dsm='vb',dsr='vb',frm='vb',pag='vb',vb='vb',vba='vb',vbs='vb',--[[WSF]]wsf='wsf',--[[XML]]dtd='xml',svg='xml',xml='xml',xsd='xml',xsl='xml',xslt='xml',xul='xml',--[[Xs]]xs='xs',xsin='xs',xsrc='xs',--[[Xtend]]xtend='xtend',--[[YAML]]yaml='yaml',yml='yaml',--[[Zig]]zig='zig'}

---
-- Map of first-line patterns to their associated lexer names.
-- Each pattern is matched against the first line in the file.
-- @class table
-- @name patterns
M.patterns = {['^#!.+[/ ][gm]?awk']='awk',['^#!.+[/ ]lua']='lua',['^#!.+[/ ]octave']='matlab',['^#!.+[/ ]perl']='perl',['^#!.+[/ ]php']='php',['^#!.+[/ ]python']='python',['^#!.+[/ ]ruby']='ruby',['^#!.+[/ ]bash']='bash',['^#!.+/m?ksh']='bash',['^#!.+/sh']='bash',['^%s*class%s+%S+%s*<%s*ApplicationController']='rails',['^%s*class%s+%S+%s*<%s*ActionController::Base']='rails',['^%s*class%s+%S+%s*<%s*ActiveRecord::Base']='rails',['^%s*class%s+%S+%s*<%s*ActiveRecord::Migration']='rails',['^%s*<%?xml%s']='xml',['^#cloud%-config']='yaml'}
-- LuaFormatter on

local GETLEXER = _SCINTILLA.properties.lexer[1]
-- LuaDoc is in core/.buffer.luadoc.
local function get_lexer(buffer, current)
  local name = buffer:private_lexer_call(GETLEXER)
  return current and name:match('[^/]+$') or name:match('^[^/]+')
end

-- Attempts to detect the language based on a buffer's first line of text or that buffer's filename.
-- @param buffer The buffer to detect the language of.
-- @return lexer name or nil
local function detect_language(buffer)
  local line = buffer:get_line(1)
  -- Detect from first line.
  for patt, lexer_name in pairs(M.patterns) do if line:find(patt) then return lexer_name end end
  -- Detect from file extension.
  return buffer.filename and M.extensions[buffer.filename:match('[^/\\.]+$')]
end

local SETDIRECTPOINTER = _SCINTILLA.properties.doc_pointer[2]
local SETLEXER = _SCINTILLA.properties.i_lexer[2]
local GETERROR = _SCINTILLA.properties.status[1]
-- LuaDoc is in core/.buffer.luadoc.
local function set_lexer(buffer, name)
  assert_type(name, 'string/nil', 2)
  if not name then name = detect_language(buffer) or 'text' end
  buffer:private_lexer_call(SETDIRECTPOINTER, buffer.direct_pointer)
  buffer:private_lexer_call(SETLEXER, name)
  local errmsg = buffer:private_lexer_call(GETERROR)
  if #errmsg > 0 then
    buffer:private_lexer_call(SETLEXER, 'text')
    error(errmsg, 2)
  end
  buffer._lexer = name
  if package.searchpath(name, package.path) then _M[name] = require(name) end
  if buffer ~= ui.command_entry then events.emit(events.LEXER_LOADED, name) end
  local last_line = view.first_visible_line + view.lines_on_screen
  buffer:colorize(1, buffer:position_from_line(last_line + 1)) -- refresh
end

-- Gives new buffers lexer-specific functions.
events.connect(events.BUFFER_NEW,
  function() buffer.get_lexer, buffer.set_lexer = get_lexer, set_lexer end, 1)

-- Auto-detect lexer on file open or save as.
events.connect(events.FILE_OPENED, function() buffer:set_lexer() end)
events.connect(events.FILE_AFTER_SAVE,
  function(_, saved_as) if saved_as then buffer:set_lexer() end end)

-- Restores the buffer's lexer, primarily for the side-effect of emitting `events.LEXER_LOADED`.
local function restore_lexer() buffer:set_lexer(buffer._lexer) end
events.connect(events.BUFFER_AFTER_SWITCH, restore_lexer, 1)
events.connect(events.VIEW_AFTER_SWITCH, restore_lexer)
events.connect(events.VIEW_NEW, restore_lexer)
events.connect(events.RESET_AFTER, restore_lexer)

local LEXERS = _SCINTILLA.properties.lexer_language[1]
---
-- Prompts the user to select a lexer for the current buffer.
-- @see buffer.set_lexer
-- @name select_lexer
function M.select_lexer()
  local lexers = {}
  for name in buffer:private_lexer_call(LEXERS):gmatch('[^\n]+') do lexers[#lexers + 1] = name end
  local button, i = ui.dialogs.filteredlist{
    title = _L['Select Lexer'], columns = _L['Name'], items = lexers
  }
  if button == 1 and i then buffer:set_lexer(lexers[i]) end
end

return M
