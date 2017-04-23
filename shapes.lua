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
	if (type_obtained == "Circle") then
		index = math.random(1,4)
		self.shape = display.newImage(game_sprites, index)
		self.shape.name = "Circle"

	elseif(type_obtained == "round_rect") then
		index = math.random(5,8)
		self.shape = display.newImage(game_sprites, index)
		self.shape.name = "round_rect"

	elseif(type_obtained == "Rectangle") then
		index = math.random(9,12)
		self.shape = display.newImage(game_sprites, index)
		self.shape.name = "Rectangle"

	elseif(type_obtained == "Pentagon") then
		index = math.random(13,16)
		self.shape = display.newImage(game_sprites, index)
		self.shape.name = "Pentagon"

	elseif(type_obtained == "Hexagon") then
		index = math.random(17,20)
		self.shape = display.newImage(game_sprites, index)
		self.shape.name = "Hexagon"

	elseif(type_obtained == "Triangle") then
		index = math.random(21,24)
		self.shape = display.newImage(game_sprites, index)
		self.shape.name = "Triangle"
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

	
	physics.addBody(self.shape, "dynamic", {outline = image_outline, bounce = 0})
end

function Shapes:move()
	transition.to(self.shape, {time = 2000, x = self.xPos, y = display.contentHeight * 1.2})
end

function Shapes:handle_collision_with_other(to_avoid_shape)
	local function collision(event)
		if(event.phase == "began") then
			if(self ~= nil and self.shape ~= nil and event.other ~= nil ) then

				print(to_avoid_shape)
				print(event.target.name)

				if(event.other.tag == 'bottom_rect' and event.target.name ~= to_avoid_shape) then
					print("The game ends")
					if(sound_on) then
						audio.play(soundTable["explosionSound"], {channel = 2})
					end
					Runtime:dispatchEvent( {name="end"} )
					return
				end

				if(event.other.tag == 'car' and event.target.name ~= to_avoid_shape) then
					if(sound_on) then
						audio.play(soundTable["pickupSound"], {channel = 3})
					end
					Runtime:dispatchEvent({name="update_score"})
				end

				event.target:removeSelf()
				event.target = nil
			end
		end
	end
	self.shape:addEventListener("collision", collision)
end

return Shapes

