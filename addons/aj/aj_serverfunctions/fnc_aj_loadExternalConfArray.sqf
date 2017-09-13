/*

    _                          _             _    _                _
   / \   _ __ _ __ ___   __ _ (_)_   _ _ __ | | _(_) ___  ___   __| | ___
  / _ \ | '__| '_ ` _ \ / _` || | | | | '_ \| |/ / |/ _ \/ __| / _` |/ _ \
 / ___ \| |  | | | | | | (_| || | |_| | | | |   <| |  __/\__ \| (_| |  __/
/_/   \_\_|  |_| |_| |_|\__,_|/ |\__,_|_| |_|_|\_\_|\___||___(_)__,_|\___|
                            |__/
Name: fnc_aj_loadExternalConfArray.sqf
Description:
	Läd ein externes Array und macht es zur serverseitigen globalen Variable

	Parameter(s):
		0: genereller Config Pfad
	Returns:
Test Execution:
["_friendlyName","name1",[1764.95,5611.56],[20,20],45] execVM "functions\fnc_aj_createMarker.sqf"
*/

private ["_aj_Config"];

_aj_Config = false;

aj_externalConfigFolder = "\AJFiles";

if (loadFile (aj_externalConfigFolder + "\AJ_Config.sqf") != "") then
{
	call compileFinal preprocessFileLineNumbers (aj_externalConfigFolder + "\AJ_Config.sqf");
	_aj_Config = true;
};

if(!_aj_Config) then {
	diag_log format ["ERROR: AJ Konfigurationsdatei wurde nicht gefunden. Pfad: ",(aj_externalConfigFolder + "\AJ_Config.sqf")];
}
else {
	diag_log format ["INFO: AJ Konfigurationsdatei wurde geladen. Pfad: ",(aj_externalConfigFolder + "\AJ_Config.sqf")];
};
_aj_Config;