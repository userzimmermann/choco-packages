-- Chocolatey MSYS2
--
-- Copyright (C) 2015 Stefan Zimmermann <zimmermann.code@gmail.com>
--
-- Licensed under the Apache License, Version 2.0


parser = clink.arg.new_parser

-- dummy parser for terminating arg list (no more choices)
local _ = parser({})

-- fall back to clink's default filesystem matching
local default = parser({function() end})


local systems = {
    "msys" .. _,
    "mingw32" .. _,
    "mingw64" .. _,
}

-- specifiers for msystem /i
local installers = {
    -- supports an optional clink settings dir
    "clink" .. default,
}

clink.arg.register_parser("msystem",
  parser({systems}):set_flags({
      "/?" .. _,
      "/d" .. _,
      "/i" .. parser(installers),
  })
)
