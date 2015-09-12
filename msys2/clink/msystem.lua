-- Chocolatey MSYS2
--
-- Copyright (C) 2015 Stefan Zimmermann <zimmermann.code@gmail.com>
--
-- Licensed under the Apache License, Version 2.0


-- dummy parser for termination of arg list (no more choices)
local _ = clink.arg.new_parser({})


clink.arg.register_parser("msystem", clink.arg.new_parser({
    "msys" .. _,
    "mingw32" .. _,
    "mingw64" .. _,
    "/d" .. _,
    "/?" .. _,
}))
