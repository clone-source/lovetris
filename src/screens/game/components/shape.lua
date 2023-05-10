local conf = require("conf")
local Square = require("screens.game.components.square")

---@class Shape
---@field row number
---@field column number
---@field width number
---@field height number
---@field color Color
---@field grid number[][]
---@field squares Square[]
local Shape = {}
Shape.__index = Shape

---@param row number
---@param column number
---@param grid number[][]
---@param color Color
function Shape:new(row, column, grid, color)
  local o = { row = row, column = column, grid = grid, color = color, width = 0, height = 0 }

  o.squares = Shape.squaresFromGrid(self, grid, color)
  if #o.squares > 0 then
    self.computeSize(o)
  end

  setmetatable(o, self)

  return o
end

function Shape:draw()
  for _, square in ipairs(self.squares) do
    square:draw()
  end
end

---@param grid number[][]
---@param color Color
---@return Square[]
function Shape:squaresFromGrid(grid, color)
  local squares = {}
  for _, cell in ipairs(grid) do
    table.insert(squares, Square:new(cell[1], cell[2], color))
  end
  return squares
end

function Shape:computeSquaresAbsolutePositions()
  for _, square in ipairs(self.squares) do
  end
end

function Shape:computeSize()
  local minRow = conf.PUZZLE_HEIGHT
  local maxRow = 0
  local minColumn = conf.PUZZLE_WIDTH
  local maxColumn = 0

  for _, square in ipairs(self.squares) do
    if square.row > maxRow then
      maxRow = square.row
    end
    if square.column > maxColumn then
      maxColumn = square.column
    end
    if square.row < minRow then
      minRow = square.row
    end
    if square.column < minColumn then
      minColumn = square.column
    end
  end

  self.height = maxRow - minRow + 1
  self.width = maxColumn - minRow + 1
end

return Shape
