scriptName "fn_aj_s_refreshZeus";
// @file Name: fn_aj_s_refreshZeus.sqf
// @file Author:  wiking.at
// @file Author: www.armajunkies.de

if (isServer) then {
    // Refresh map objects if zeus ui is opened
	
	private "_zeusUID";
	_zeusUID = _this;	
	_zeusUID = missionnamespace  getvariable[_zeusUID,0];
	
		{	
		//Don't add Stores to Zeuscurator as they would get invisible for the zeus player afterwards
		if !(_x isKindof "C_man_1_1_F") then   //Stores in A3W are using this class
			{
			_zeusUID addCuratorEditableObjects [[_x],true];
			}
		else
			{
				if !((vehiclevarname _x find "Store") == 3) then  //Editor Name has to contain Store on this position
					{
					_zeusUID addCuratorEditableObjects [[_x],true];
					};			
			};		
		} 
		foreach (allMissionObjects "All");

	
};