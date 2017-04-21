local soundTable=require("soundTable");

local Car = {};

function Car:new (o)    --constructor
  o = o or {}; 
  setmetatable(o, self);
  self.__index = self;  
  return o;
end

return Car

