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
	local index = nil
	if (type_obtained == "circle") then
		index = math.random(1,4)
		self.shape = display.newImage(game_sprites, index)
	elseif(type_obtained == "round_rect") then
		index = math.random(5,8)
		self.shape = display.newImage(game_sprites, index)
	elseif(type_obtained == "rect") then
		index = math.random(9,12)
		self.shape = display.newImage(game_sprites, index)
	elseif(type_obtained == "pentagon") then
		index = math.random(13,16)
		self.shape = display.newImage(game_sprites, index)
	elseif(type_obtained == "hexagon") then
		index = math.random(17,20)
		self.shape = display.newImage(game_sprites, index)
	elseif(type_obtained == "triangle") then
		index = math.random(21,24)
		self.shape = display.newImage(game_sprites, index)
	end
	local image_outline = graphics.newOutline(2, game_sprites, index)
	self.shape.pp = self --pointer to parent
	self.shape.tag = self.tag
	self.shape.anchorX = 0
	self.shape.anchorY = 0
	self.shape.width = self.shape.width/3
	self.shape.height = self.shape.height/3
	self.shape.x = self.xPos
	self.shape.y = self.yPos

	
	physics.addBody(self.shape, "dynamic", {outline = image_outline, density=1000})
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

return Shapes

