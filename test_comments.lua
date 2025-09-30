-- This is a comment at the top
local M = {}

-- Another comment here
-- Multiple comment lines
-- All together
function M.test()
    print("hello") -- inline comment
    -- Comment inside function
    return true
end

-- Final comment block
-- With multiple lines
-- To test folding
return M