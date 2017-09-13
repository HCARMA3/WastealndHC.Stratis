scriptName "fn_c_createTearTrigger";
/*--------------------------------------------------------------------
	-------------------- Armajunkies Wasteland -----------------------
	------------------------------------------------------------------

	- This Wasteland Version is a completely new code build. -
	- Please do not just copy and paste this code, there could be server dependencies -


	file: fn_c_createTearTrigger.sqf
	path: /E/Arma3Dev/Missions/particle_test.altis/fn_c_createTearTrigger.sqf
	================================
	Author: Hatchet Harry <orga@armajunkies.de>
	Modified by:
	Description: Creates a trigger locally on client, which is handling the teargas functions.
	Parameter(s):
	Returns:
--------------------------------------------------------------------*/
#define __filename "fn_c_createTearTrigger.sqf"
private ["_netID", "_shell", "_trigger"];

_netID = param [0, "", [""]];

//Send Create Trigger command to server
_shell = objectFromNetId _netID;
//Server Creates Trigger - Bedingung: Version 1.43 für False: MakeGlobal
_trigger = createTrigger ["EmptyDetector", position _shell, false];
_trigger setTriggerArea [10, 10, 0, false];
//Attach to Player, Nur der lokale Spieler ativiert den Trigger, erfordert Source Vehicle
_trigger triggerAttachVehicle [player];
//Setze Vehicle muss in Trigger sein
_trigger setTriggerActivation ["VEHICLE", "Present", true];

//Diese Abfrage ist wie folgt gestaltet: Ist Modulo true, wird der code ausgeführt. Ist Modulo falsch wird direkt abgebrochen. Gibt einen weichen Random Faktvor, um sich schnell zu verziehen und die Scripts nicht alle 0.5 sekunden auszuführen, Player in thislist -> Spieler in Trigger,
_trigger setTriggerStatements ["(round (time % 3) == 0) && player in thislist && (position player) select 2 <= 10 ", " [] spawn armajunkies_fnc_aj_c_teargasEffect; ", ""];

waitUntil {sleep 0.1; typeOf _shell == ""};
//Clients are deleting the Trigger
deleteVehicle _trigger;