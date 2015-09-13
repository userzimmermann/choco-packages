-- Chocolatey MSYS2
--
-- Copyright (C) 2015 Stefan Zimmermann <zimmermann.code@gmail.com>
--
-- Licensed under the Apache License, Version 2.0


new_parser = clink.arg.new_parser

-- dummy parser for termination of arg list (no more choices)
local _ = new_parser({})

-- create an override parser doing default filesystem matching
function new_default_parser()
    return new_parser({function() end})
end

local default = new_default_parser({function() end})


-- auto-completion of package names
local packages_parser = new_parser()
-- the actual packages table to be used in pacman argument parser
local packages = (function()
    local p = io.popen("pacman.exe -Ssq 2>&1")
    local names = {}
    for name in p:lines() do
        -- let package args recursively expect another package as next arg
        table.insert(names, name .. packages_parser)
    end
    if p:close() then
       return names
    end
    return {}
end)()
packages_parser:set_arguments(packages)


-- get available subflags from from pacman <flag> --help
local function subflags(flag)
    local p = io.popen("pacman.exe " .. flag .. " --help 2>&1")
    local subflags = {}
    for line in p:lines() do
        --^   -x, --long   description...
        local short, long = line:match("^%s*(%-[^%s])%s*,%s*(%-%-[^%s]+)")
        if short then
            subflags[#subflags + 1] = short
            subflags[#subflags + 1] = long
        else
            --^   --long   description...
            local long = line:match("^%s*(%-%-[^%s]+)")
            if long then
                subflags[#subflags + 1] = long
            end
        end
    end
    if p:close() then
        return subflags
    end
    return {}
end


clink.arg.register_parser("pacman",
  -- also set packages as base arguments
  -- to enable package completion after combined short flags
  -- which are not explicitly defined (like -Syu)
  new_parser(packages):set_flags({
      -- flags without further args
      "-h" .. _, "--help" .. _,
      "-V" .. _, "--version" .. _,
  }):add_flags((function()
      local flags = {}
      -- flags followed by optional subflags and package names
      for _, flag in next, {
          "-D", "--database",
          "-F", "--files",
          "-Q", "--query",
          "-R", "--remove",
          "-S", "--sync",
          "-T", "--deptest",
      } do
          table.insert(flags, flag ..
            new_parser(packages):set_flags(subflags(flag)))
      end
      -- flags followed by optional subflags and file paths
      local subflags = subflags("-U")
      for _, flag in next, {"-U", "--upgrade"} do
          table.insert(flags, flag ..
            new_default_parser():set_flags(subflags))
      end
      return flags
  end)())
)
