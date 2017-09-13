scriptName "fn_getPlayersAndSendTriggerCommand";
/*--------------------------------------------------------------------
	-------------------- Armajunkies Wasteland -----------------------
	------------------------------------------------------------------

	- This Wasteland Version is a completely new code build. -
	- Please do not just copy and paste this code, there could be server dependencies -


	file: fn_getPlayersAndSendTriggerCommand.sqf
	path: /E/Arma3Dev/Missions/particle_test.altis/fn_getPlayersAndSendTriggerCommand.sqf
	============================================
	Author: Hatchet Harry <orga@armajunkies.de>
	Modified by:
	Description: This file detects player, near the delivered teargas object and sends a publicvariable to the clients who need to create a clientlocal trigger.
	Parameter(s):
	Returns:
--------------------------------------------------------------------*/
#define __filename "fn_getPlayersAndSendTriggerCommand.sqf"

private ["_netID", "_entities", "_clientID"];
_netID = [_this, 0, "", [""]] call bis_fnc_param;
if(_netID != "" ) then {
	//Publicvariable überträgt nur die Netid
	_pos = position (objectFromNetId _netID);

	_entities = (_pos) nearEntities [["Man", "Air", "Car", "Motorcycle", "Tank"], 2000];
	{
		if(isPlayer _x) then {
			_clientID = owner _x;
			netIDToSend = _netID;
			_clientID publicVariableClient "netIDToSend";
		};
	} forEach _entities;
};
