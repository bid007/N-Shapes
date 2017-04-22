local soundTable=require("soundTable");
local physics = require("physics")

local Shapes = {tag="shapes", xPos = 0, yPos = 0, type="circle"};

function Shapes:new (o)    --constructor
  o = o or {}; 
  setmetatable(o, self);
  self.__index = self;  
  return o;
end

function Shapes:spawn()
	local type_obtained = self.type
	if (type_obtained == "circle") then
		self.shape = display.newImage(game_sprites, math(1,4))
	elseif(type_obtained == "round_rect") then
		self.shape = display.newImage(game_sprites, math(5,8))
	elseif(type_obtained == "rect") then
		self.shape = display.newImage(game_sprites, math(9,12))
	elseif(type_obtained == "pentagon") then
		self.shape = display.newImage(game_sprites, math(13,16))
	elseif(type_obtained == "hexagon") then
		self.shape = display.newImage(game_sprites, math(17,20))
	elseif(type_obtained == "triangle") then
		self.shape = display.newImage(game_sprites, math(21, 24))
	end
	self.shape.pp = self --pointer to parent
	self.shape.tag = self.tag
	physics.addBody(self.shape, "kinematic")
end

function Shapes:move()
	transition.to(self.shape, {time = 2000, x = self.xPos, y = display.contentHeight * 1.2})
end

function Shapes:handle_collision_with_other()
	local function collision(event)
		if(event.phase == "began") then
			if(self ~= nil and self.shape ~= nil and event.other ~= nil ) then
				print("do stuffs on collision with player.")
			end
		end
	end
	self.shape:addEventListener("collision", collision)
end

return Shape

