local soundTable=require("soundTable")
local physics = require("physics")

local Car = {xPos = 0, yPos = 0, imgFile = "car48.png", tag = "car"}

function Car:new (o)    --constructor
  o = o or {}
  setmetatable(o, self)
  self.__index = self 
  return o
end

function Car:spawn()
	print("Not Implemented")
end

function Car:handleCustomTap()
	print("Not Implemented")
end

return Car

