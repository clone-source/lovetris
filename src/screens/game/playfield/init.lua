local conf = require("conf")
local Screen = require("engine.screen")
local Painter = require("screens.game.playfield.painter")

---@class Playfield: Screen
---@field painter Painter
local Playfield = setmetatable({}, { __index = Screen })
Playfield.__index = Playfield

---@param width number
---@param height number
function Playfield:new(width, height)
  local o = setmetatable(Screen:new(), Playfield)
  o.painter = Painter:new(width, height)
  return o
end

function Playfield:paint()
  self.painter:draw_background()
  self.painter:draw_guide()
end

return Playfield
