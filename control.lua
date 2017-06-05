
-- Locates the entity based off of the provided name
function locate(data)


end

-- Locates the entity in the player's hand
function locateHotkey(data)


end

script.on_event("compass-find-entity", locateHotkey)

commands.add_command("locate","locate-help",locate)
commands.add_command("l","locate-help",locate)
commands.add_command("compass","locate-help",locate)
