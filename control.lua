
-- Locates the entity based off of the provided name
function locate(data)


end

-- Locates the entity in the player's hand
function locateHotkey(data)


end

script.on_event("compass-find-entity", locateHotkey)

commands.add_command("locate","command-help.locate",locate)
commands.add_command("l","command-help.locate",locate)
commands.add_command("compass","command-help.locate",locate)
