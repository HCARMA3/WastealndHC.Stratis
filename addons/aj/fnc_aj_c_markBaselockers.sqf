scriptName "fnc_aj_c_markBaselockers";
// @file Name: fnc_aj_c_markBaselockers.sqf
// @file Author:  wiking.at
// @file Author: www.armajunkies.de

_baselockers = allMissionObjects "Land_device_assembled_F";
_MapMarkers = [];

["Current base and vehicle positions are shown on map for three minutes.", 5] call mf_notify_client;

{
	_objPos = getPosATL _x;
	_markertext = _x getvariable ["baseName","Base"]; //Return just "Base" if value can't be read
	_marker = "baselockerMapMarkers" + (str _forEachIndex);
	_marker = createMarkerLocal [_marker,_objPos];
	_marker setMarkerTypeLocal "waypoint";
	_marker setMarkerPosLocal _objPos;
	_marker setMarkerColorLocal "ColorOrange";
	_marker setMarkerTextLocal _markertext;
	_MapMarkers pushBack _marker;
	
}foreach _baselockers;


//continuously updated icons
setGroupIconsVisible [true, false];
_until = diag_tickTime + (3 * 60); // time in which player gets updated infos.

while {diag_ticktime < _until} do
{
	{
		if ( isplayer _x && (vehicle _x != _x) && (effectivecommander vehicle _x == _x)) then
		{
			private ["_groupIcon", "_iconColor"];

			switch (side _x) do
			{
				case BLUFOR:      { _groupIcon = "b_unknown"; _iconColor = [0, 0, 1, 1] };
				case OPFOR:       { _groupIcon = "o_unknown"; _iconColor = [1, 0, 0, 1] };
				case INDEPENDENT: { _groupIcon = "n_unknown"; _iconColor = [0, 1, 0, 1] };
				default           { _groupIcon = "c_unknown"; _iconColor = [1, 0, 0, 1] };
			};
			
			_className = typeOf vehicle _x;
			_displayNameVeh = getText (configFile >>  "CfgVehicles" >> _className >> "displayName");		
			clearGroupIcons group _x;
			group _x addGroupIcon [_groupIcon];
			group _x setGroupIconParams [_iconColor, format ["%1 (%2)", name _x, _displayNameVeh ], 1, true];
		};
	} forEach (allPlayers - entities "HeadlessClient_F"); 

	sleep 0.5;
};

{ clearGroupIcons group _x } forEach (allPlayers - entities "HeadlessClient_F");



/* This block would be used to only mark start positions
{
	if ( (vehicle _x != _x) && (driver vehicle _x == _x) ) then {

		_objPos = getPosATL _x;
		_className = typeOf vehicle _x;
		_displayNameVeh = getText (configFile >>  "CfgVehicles" >> _className >> "displayName");
	
		_markertext = format ["%1 (%2)",name player, _displaynameVeh];

		_marker = "vehicleMapMarkers" + (str _forEachIndex);
		_marker = createMarkerLocal [_marker,_objPos];
		_marker setMarkerTypeLocal "waypoint";
		_marker setMarkerPosLocal _objPos;
		_marker setMarkerColorLocal "ColorBlack";
		_marker setMarkerTextLocal _markertext;
		_MapMarkers pushBack _marker;
		
	};
} foreach _justplayers;
*/
	if (count _MapMarkers > 0) then {

		{
			deleteMarkerLocal _x;
		} forEach _MapMarkers;
		["The Satellite has left the area. Map info removed", 5] call mf_notify_client;
	};

//clear group icons again if first loop isn't catching all players
uisleep 20;
{ clearGroupIcons group _x } forEach (allPlayers - entities "HeadlessClient_F");