-- This is a full comment line that should be removed
local M = {}

-- Another comment line
local function test() -- inline comment here
    print("hello world") -- another inline comment
    return true
end

-- Multiple comment lines
-- All of these should be removed
-- When using KillComments
M.value = 42 -- inline comment on assignment

-- Final comment block
return M