#include "script_component.hpp"
/*
* Author: DiGii
*
* Arguments:
* 0: player <Object>
*
* Return Value:
* NONE
*
* Example:
* [] call kat_chemical_fnc_init;
*
* Public: No
*/
params["_unit"];

[] spawn {
    waitUntil {
        !isnil "kat_chemical_avail_gasmask" && time > 1
    };
    private _items = missionnamespace getVariable ["kat_chemical_avail_gasmask", """G_AirPurifyingRespirator_01_F"""];
    private _item_arr = [_items, "CfgGlasses"] call FUNC(getlist);
    KAT_AVAIL_GASMASK = _item_arr;
    publicVariable "KAT_AVAIL_GASMASK";
    
    waitUntil {
        !isnil "kat_medical_affectAI"
    };
    private _affectAI = missionnamespace getVariable [QGVAR(affectAI), false];
    kat_AFFECT_AI = _affectAI;
    publicVariable "kat_AFFECT_AI";
};

if (hasinterface) then {
    [] call FUNC(coughing);
    [] spawn FUNC(handleGasMaskDur);
    [] spawn FUNC(chemDetector);
    [_unit] spawn FUNC(breathing);
    kat_lastpoisend = 0;
    _unit setVariable[QGVAR(timeleft), missionnamespace getVariable [QGVAR(infecttime), 60], true];
    _unit setVariable [QGVAR(enteredPoisen), false, true];
    _unit setVariable [QGVAR(gasmask_durability), 10, true];
    _unit setVariable [QGVAR(gasmask_durability_reset), false, true];
    
    [{
        private _playertime = _unit getVariable[QGVAR(timeleft), 60];
        private _maxtime = missionnamespace getVariable [QGVAR(infecttime), 60];
        if (!(_unit getVariable[QGVAR(enteredPoisen), false])) then {
            if (_playertime < missionnamespace getVariable [QGVAR(infecttime), 60]) then {
                _playertime = _playertime + 1;
                if (_playertime >= _maxtime) then {
                    _playertime = _maxtime;
                };
                _unit setVariable[QGVAR(timeleft), _playertime, true];
            };
        };
    }, 2, []]call CBA_fnc_addPerFrameHandler;
    
    [{
        "KAT_CHEM_DETECtor" cutRsc ["RscWeaponChemicalDetector", "PLAin", 1, false];
        private _ui = uiNamespace getVariable "RscWeaponChemicalDetector";
        private _obj = _ui displayCtrl 101;
        if (!(_unit getVariable[QGVAR(enteredPoisen), false])) then {
            _obj ctrlAnimatemodel ["Threat_Level_Source", 0, true];
        };
    }, 2, []]call CBA_fnc_addPerFrameHandler;
};