#include "..\script_component.hpp"
/*
 * Author: YetheSamartaka
 * Throws a warning and add line to RPT log if incompatible addons(Listed by us - developers) that
 * could negatively affect correct functionality of KAT are used. Warning disappears after 60 seconds.
 *
 * Arguments:
 * None
 *
 * Return Value:
 * None
 *
 * Example:
 * call kat_misc_fnc_incompatibilityWarning
 *
 * Public: No
 */

private _foundIncompatibleAddons = [];

//Checks if incompatible addons are loaded
{ if (isClass(configFile >> "CfgPatches" >> _x)) then {
    _foundIncompatibleAddons append [_x];
    //Incompatible addons
    //Here is the Wiki page with current list: https://github.com/Tomcat-SG/KAM/wiki/Incompatible-addons
}; } forEach ["KATMEDICALSTATIC","kat_evac","KATMEDICALsteth","adv_aceCPR","aceP_main"];

if ((count _foundIncompatibleAddons) > 0) then {
    diag_log format [LLSTRING(incompatibilityWarning_Desc), _foundIncompatibleAddons];
    private _text = format [LLSTRING(incompatibilityWarning_Desc), _foundIncompatibleAddons];
    if (hasInterface) then {
        _text = composeText [lineBreak, parseText format ["<t align='center'>%1</t>", _text]];
        private _rscLayer = "ACE_RscErrorHint" call BIS_fnc_rscLayer;
        _rscLayer cutRsc ["ACE_RscErrorHint", "PLAIN", 0, true];
        disableSerialization;
        private _ctrlHint = uiNamespace getVariable "ACE_ctrlErrorHint";
        _ctrlHint ctrlSetStructuredText _text;

        //Removes Warning message after 60 seconds
        [{params ["_rscLayer"];
            _rscLayer cutFadeOut 0.2;
        }, [_rscLayer], 60] call CBA_fnc_waitAndExecute;
    };
};
