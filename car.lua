local soundTable=require("soundTable")
local physics = require("physics")

local Car = {xPos = 0, yPos = 0, imgFile = "car.png", tag = "car"}

function Car:new (o)    --constructor
  o = o or {}
  setmetatable(o, self)
  self.__index = self 
  return o
end

function Car:spawn()
	self.shape = display.newImage(self.imgFile, self.xPos, self.yPos)
	self.shape:scale( 0.1, 0.1 )
	self.shape.tag = self.tag
	self.shape.pp = self
end

return Car

