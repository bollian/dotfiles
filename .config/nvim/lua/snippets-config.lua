local manager = require 'snippets'

local guard = [[#ifndef ${1:UNIT_NAME}_H_
#define $1_H_



#endif // $1_H_]]

local U = require 'snippets.utils'
local snippets = {
  _global = {
    mpl2 = U.force_comment [[This Source Code Form is subject to the terms of the Mozilla Public
License, v. 2.0. If a copy of the MPL was not distributed with this
file, You can obtain one at https://mozilla.org/MPL/2.0/.]],
    copyright = U.force_comment [[Copyright (C) Ian Boll ${=os.date("%Y")}]]
  },
  c = {
    guard = guard
  },
  cpp = {
    guard = guard
  }
}

manager.use_suggested_mappings()
manager.snippets = snippets
