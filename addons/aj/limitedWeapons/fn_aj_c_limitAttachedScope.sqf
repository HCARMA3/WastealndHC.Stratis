scriptName "fn_aj_c_limitAttachedScope";
/*--------------------------------------------------------------------
	file: limitAttachedScope.sqf
	============================
	Author: Hatchet Harry <info@armajunkies.de>
	Modified by: wiking.at
	Description: Checks if a limited scope is being used and detaches it.
	Parameter(s):
	Returns:
--------------------------------------------------------------------*/
#define __filename "fn_aj_c_limitAttachedScope.sqf"

_limitedScopeWeaponsArray = [
"LMG_Zafir_F",
"LMG_Zafir_pointer_F",
"LMG_Zafir_ARCO_F",
"LMG_Mk200_F",
"LMG_Mk200_LP_BI_F",
"LMG_Mk200_BI_F",
"LMG_Mk200_MRCO_F",
"LMG_Mk200_pointer_F",
"MMG_01_hex_F",         //Navid
"MMG_01_tan_F",         //Navid
"MMG_01_hex_ARCO_LP_F", //Navid
"MMG_02_camo_F",        //SPMG
"MMG_02_black_F",       //SPMG
"MMG_02_sand_F",        //SPMG
"MMG_02_sand_RCO_LP_F", //SPMG
"MMG_02_black_RCO_BI_F",//SPMG
"arifle_MX_SW_F",
"arifle_MX_SW_pointer_F",
"arifle_MX_SW_Hamr_pointer_F",
"arifle_MX_SW_Black_F",
"arifle_MX_SW_Black_Hamr_pointer_F",
"arifle_MX_SW_khk_F",
"arifle_SPAR_02_blk_F",
"arifle_SPAR_02_khk_F",
"arifle_SPAR_02_snd_F",
"LMG_03_F",
"arifle_CTARS_blk_F",
"arifle_CTARS_ghex_F",
"arifle_CTARS_hex_F"
];

_disallowedScopes = [
	"optic_KHS_tan", //Kahilia
	"optic_KHS_old", //Kahilia
	"optic_KHS_hex", //Kahilia
	"optic_KHS_blk", //Kahilia
	"optic_AMS_snd", //AMS
	"optic_AMS_khk", //AMS
	"optic_AMS", //AMS
	"optic_SOS", //SOS
	"optic_SOS_khk_F",
	"optic_LRPS", //LPRS
	"optic_LRPS_ghex_F",
	"optic_LRPS_tna_F",
	"optic_DMS", //DMS
	"optic_DMS_ghex_F",
	"optic_Nightstalker"
];

if(primaryWeapon player in _limitedScopeWeaponsArray) then {
	{
		if(_x in primaryWeaponItems player) then {
			player removePrimaryWeaponItem _x;
			if ([player, _x] call fn_fitsInventory) then
				{
					[player, _x] call fn_forceAddItem;
				}
		};
	} forEach _disallowedScopes;
};

