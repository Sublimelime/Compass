--gets the distances between two entities
function getDistance(ent1, ent2)
   return math.sqrt(math.pow(math.abs(math.floor(ent2.position.x) - math.floor(ent1.position.x)), 2) + math.pow(math.abs(math.floor(ent2.position.y) - math.floor(ent1.position.y)), 2))
end

function searchArea(area, player, entity)
   local count = game.surfaces[1].count_entities_filtered{area=area,name=entity}
   if count > 0 then --found something
      local smallestDistIndex = 1
      local entities = game.surfaces[1].find_entities_filtered{area=area,name=entity}
      for index, entity in pairs(entities) do
         if getDistance(player, entity) < getDistance(player, entities[smallestDistIndex]) then
            smallestDistIndex = index
         end
      end
      if smallestDistIndex then
         return entities[smallestDistIndex]
      end
   else
      return nil
   end
end

--Finds the closest entity, and prints data like distance, and rough direction
function findEntityAndPrintData(player, entity)
   local closestEntity = nil
   local direction = ""
   local playerX = player.position.x
   local playerY = player.position.y

   -- Distance determiniations
   local area1 = {{playerX-30, playerY-30},{playerX+30,playerY + 30}}
   local area2 = {{playerX-100, playerY-100},{playerX+100,playerY + 100}}

   -- progressive checks, getting larger and larger
   closestEntity = searchArea(area1,player,entity) --search immediate area
   if not closestEntity then
      closestEntity = searchArea(area2,player,entity) -- Search a bigger area
      if not closestEntity then
         closestEntity = searchArea(nil,player,entity) --search entire surface
         if not closestEntity then
            player.print("Could not find an entity with that name.")
            return
         end
      end
   end

   local distance = getDistance(player, closestEntity)

   -- Direction determinations

   player.print("The closest " .. closestEntity.name .. " is " .. math.floor(distance) .. " tiles away, to the " ..direction .. ".")
end


-- Locates the entity based off of the provided name
function locate(data)
   local player = game.players[data.player_index]
   if (data.parameter and type(data.parameter) == "string") then --Check usage
      findEntityAndPrintData(player,data.parameter)
   else
      player.print("Please provide the internal name of the entity to locate, for example fast-inserter. Generally, this is close to the english name of the entity.")
   end
end

-- Locates the entity in the player's hand
function locateHotkey(data)
   local player = game.players[data.player_index]
   if not player.cursor_stack.valid_for_read then --Nothing in the player's hand
      player.print("You need an entity in your hand to locate.")
   else
      local entityToLocate = player.cursor_stack.prototype.place_result
      if not entityToLocate then --Item cannot be placed, so has no location
         player.print("This entity cannot be placed in the world, so cannot be located.")
         return
      end
      findEntityAndPrintData(player,entityToLocate.name)
   end
end


script.on_event("compass-find-entity", locateHotkey)

commands.add_command("locate",{"command-help.locate"},locate)
commands.add_command("l",{"command-help.locate"},locate)
commands.add_command("compass",{"command-help.locate"},locate)
