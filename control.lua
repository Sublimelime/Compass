--Finds the closest entity, and prints data like distance, and rough direction
function findEntityAndPrintData(player, entity)
   local distance = 0
   local direction = ""


   player.print("The closest " .. entity .. " is " .. distance .. " tiles away, to the " ..direction .. ".")

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
