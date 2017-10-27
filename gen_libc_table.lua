
local serpent = require 'serpent'

local t = {}

if #arg == 0 then
  error('filename please')
end

-- file produced with something like
-- nm -D /usr/lib/libc.so | grep -v "_" | cut -d " " -f3 > filename.txt
-- on alpine col is contained inside the util-linux package

local lf = io.open(arg[1],'r')
for line in lf:lines() do
  local nonl = string.match(line,"([^\n]+)")
  local mpf = io.popen('man 3 ' .. nonl .. ' | col -b | cat')
  local mp = mpf:read('*all'); mpf:close()
  if mp ~= "" then -- make sure it's not empty
    t[nonl] = { description = mp }
  end
end
lf:close()

local f = io.open('libc_api.lua','w')
f:write('return ' .. serpent.block(t,{comment=false}))
f:close()
