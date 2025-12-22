local function main()
    local part = arg[2]
    local puzzleInput = {}

    for line in io.lines() do
        table.insert(puzzleInput, line)
    end

    local module = require(part)
    local solver = module[part]

    if solver then
        print(solver(puzzleInput))
    else
        print("Unknown part: " .. (part or "nil"))
    end
end

main()