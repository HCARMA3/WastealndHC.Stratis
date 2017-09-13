//	@file Version:
//	@file Name:
//	@file Author: Cael817, modded by Wiking[AJ]
//	@file Created:

private ["_price", "_playerMoney"];


_baseradius = ["A3W_AJBaseRadius", 60] call getPublicVar;
#define RELOCK_PRICE_RELATIONSHIP 10

_maxLifetime = ["A3W_objectLifetime", 120] call getPublicVar;
_objects = nearestObjects [position player, ["thingX", "Building", "ReammoBox_F"], _baseradius];
_ownedObjects = {typeName _x == "OBJECT" && {!(isNil {_x getVariable "ownerUID"})} && {_x getVariable "objectLocked"}} count _objects;
//_ownedObjects = {typeName _x == "OBJECT" && {_x getVariable ["ownerUID",""] == getPlayerUID player}} count _objects; // Use this if you want only owned objects to be relocked.

_price = 100;
{
_objClass = typeOf _x;


	{
		if (_objClass == _x select 1) exitWith
		{
			_price = _price + ((ceil (((_x select 2) / RELOCK_PRICE_RELATIONSHIP) / 5)) * 5);
		};
	} forEach (call allGenStoreVanillaItems);
} forEach _objects;


_playerMoney = player getVariable "cmoney";


if (isNil "reLockedObjectMapMarkers") then {
	// This is the global we use to keep track of map markers
	reLockedObjectMapMarkers = [];
};

if (count reLockedObjectMapMarkers > 0) then {
	{
		deleteMarkerLocal _x;
	} forEach reLockedObjectMapMarkers;
	reLockedObjectMapMarkers = [];
	["Map cleared of previous markers", 5] call mf_notify_client;
};

if (!isNil "_price") then 
{
	// Add total sell value to confirm message
	_confirmMsg = format ["Renew lifteime of %1 baseparts/objects will cost you $%2<br/>Range is %3 meters, all renewed objects will be marked on map<br/>If not renewed objects expire after %4 hours.", _ownedObjects, _price, _baseradius, _maxLifetime];

	// Display confirm message
	if ([parseText _confirmMsg, "Confirm", "OK", true] call BIS_fnc_guiMessage) then
	{	
		// Ensure the player has enough money

		if (_price > _playerMoney) exitWith
		{
			hint format ["You need $%1 to renew %2 objects",  _price, _ownedObjects];
			playSound "FD_CP_Not_Clear_F";
		};
		
		player setVariable["cmoney",(player getVariable "cmoney")-_price,true];
		
		reLockedObjectMapMarkers = [];
		{
		//if(_x getVariable "ownerUID" == getplayerUID player) then 
		if !(isNil {_x getVariable "ownerUID"}) then // Changed so also non owned objects are relocked
		{
		private ["_name","_objPos","_name","_marker"];
		_x setVariable ["baseSaving_hoursAlive", nil, true]; //this is only for local persistance mode - extb isn't using it
		_x setVariable ["baseSaving_spawningTime", nil, true];
		_x setVariable ["objectLocked",true,true];
		pvar_manualObjectSave = netId _x;
		publicVariableServer "pvar_manualObjectSave";   //this resets the lock timer for extdb persistance
		//trackObject = _x;
		//publicVariableServer "trackObject";
		//_x setVariable ["ownerUID", getPlayerUID player, true]; //possibly set new owner?
		//_x setVariable ["ownerN", name player, true]; // set this here if not set in R3F?
		_name = gettext(configFile >> "CfgVehicles" >> (typeOf _x) >> "displayName");
		_objPos = getPosATL _x;
		_marker = "reLockedObjectMapMarkers" + (str _forEachIndex);
		_marker = createMarkerLocal [_marker, _objPos];
		_marker setMarkerTypeLocal "waypoint";
		_marker setMarkerPosLocal _objPos;
		_marker setMarkerTextLocal _name;
		_marker setMarkerColorLocal "ColorBlue";
		_marker setMarkerTextLocal _name;
	reLockedObjectMapMarkers pushBack _marker;
	};
} forEach _objects;


if (count reLockedObjectMapMarkers > 0) then {

	["Added Markers for the renewed objects, they will be removed in 30 seconds", 5] call mf_notify_client;
	
	}else{
	//["No owned objects found within the set radius", 5] call mf_notify_client;
	[format ["No owned objects found within %1m",_baseradius], 5] call mf_notify_client;	
};
	
sleep 30;

if (count reLockedObjectMapMarkers > 0) then
{
	{
		deleteMarkerLocal _x;
	} forEach reLockedObjectMapMarkers;
	reLockedObjectMapMarkers = [];
	["Map cleared", 5] call mf_notify_client;
};

};
};