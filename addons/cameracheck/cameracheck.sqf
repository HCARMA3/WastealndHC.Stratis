// @file Name: cameraChecks.sqf
// @file Author:  wiking.at
 
if (!hasInterface) exitWith {};
 
private ["_fpOnFoot", "_forceFP", "_forceFPveh"];
_fpOnFoot = (difficultyOption "thirdPersonView" > 0 && ["A3W_firstPersonCamOnFoot"] call isConfigOn);
_fpNotDriver = (difficultyOption "thirdPersonView" > 0 && ["A3W_firstPersonCamNotDriver"] call isConfigOn);


// Init global Camrunning variable
Camrunning = false; 
 
while {true} do
{
	waitUntil
	{
		sleep 0.1;
		_forceFP = (_fpOnFoot && alive player && cameraOn == player);  //check if camera is on player
		_forceFPveh = (_fpNotDriver && alive player &&  cameraOn == (vehicle player) && (player != driver (vehicle player))); //Camera on player in vehicle, not driver
		((_forceFP && cameraView == "EXTERNAL") || (_forceFPveh && cameraView == "EXTERNAL") || cameraView == "GROUP")
	};
 
if (cameraView == "GROUP") then   //Disable Commander View
{
	cameraOn switchCamera "EXTERNAL";
};
 
if (_forceFP && cameraView == "EXTERNAL") then
{
	cameraOn switchCamera "INTERNAL";
	
		if !(Camrunning) then
			{
			[] execVM "addons\cameracheck\circling-cam.sqf";
			};
	
};

if (_forceFPveh && cameraView == "EXTERNAL") then
{
	cameraOn switchCamera "INTERNAL";
sleep 1;
};