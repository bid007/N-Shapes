local soundTable=require("soundTable");

local Shapes = {};

function Shapes:new (o)    --constructor
  o = o or {}; 
  setmetatable(o, self);
  self.__index = self;  
  return o;
end

return Shape

