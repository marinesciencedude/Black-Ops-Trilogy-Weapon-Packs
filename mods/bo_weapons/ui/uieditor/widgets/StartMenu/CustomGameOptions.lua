DataSources.StartMenuGameOptions = ListHelper_SetupDataSource( "StartMenuGameOptions", function ( controller )
	local options = {}

	if CoD.isZombie then
		table.insert( options, {
			models = {
				displayText = "MENU_RESUMEGAME_CAPS",
				action = StartMenuGoBack_ListElement
			}
		} )

		if Engine.IsLobbyHost( Enum.LobbyType.LOBBY_TYPE_GAME ) then
			table.insert( options, {
				models = {
					displayText = "MENU_RESTART_LEVEL_CAPS",
					action = RestartGame
				}
			} )
		end

		--if Engine.IsLobbyHost( Enum.LobbyType.LOBBY_TYPE_GAME ) then
		--	table.insert( options, {
		--		models = {
		--			displayText = "PAUSE / UNPAUSE GAME",
		--			action = function ( self, element, controller, actionParam, menu )
		--				Engine.SendMenuResponse(controller, "PauseGame", "1")
		--			end
		--		}
		--	} )
		--end

		if Engine.IsLobbyHost( Enum.LobbyType.LOBBY_TYPE_GAME ) then
			table.insert( options, {
				models = {
					displayText = "MENU_END_GAME_CAPS",
					action = QuitGame_MP
				}
			} )
		else
			table.insert( options, {
				models = {
					displayText = "MENU_QUIT_GAME_CAPS",
					action = QuitGame_MP
				}
			} )
		end
	end

	return options
end, true )