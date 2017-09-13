// @file Name: circling-cam.sqf
// @file Author:  wiking.at

Camrunning = true; // set to false to stop the camera
_radius = 2; // circle radius
_angle = 180; // starting angle
_altitude = ((getPosATL player) select 2)+1;
_dir = 0; //Direction of camera movement 0: anti-clockwise, 1: clockwise
_speed = 0.1; //lower is faster

_camTarget = (getPosATL player);
_camTarget set [2,((_camtarget select 2)+0.8)];

_coords = [player, _radius, _angle] call BIS_fnc_relPos;
_coords set [2, _altitude];
_camera = "camera" camCreate _coords;
_camera cameraEffect ["INTERNAL","BACK"];
_camera camPrepareFOV 1;
_camera camPrepareTarget _camTarget;
_camera camCommitPrepared 0;

while {Camrunning} do {
	_coords = [player, _radius, _angle] call BIS_fnc_relPos;
	_coords set [2, _altitude];

	_camera camPreparePos _coords;
	_camera camCommitPrepared _speed;

	waitUntil {sleep 0.1; camCommitted _camera || !(Camrunning)};

	_camera camPreparePos _coords;
	_camera camCommitPrepared 0;
	
	_angle = if (_dir == 0) then {_angle - 1} else {_angle + 1};
	sleep 0.1;
};

//Switch back to player if Camrunning evaluates to false
camDestroy _camera;
player cameraEffect ["terminate", "BACK"];