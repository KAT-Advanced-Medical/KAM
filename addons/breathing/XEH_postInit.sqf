#include "script_component.hpp"

[QGVAR(pulseoxLocal), LINKFUNC(treatmentAdvanced_pulseoximeterLocal)] call CBA_fnc_addEventHandler;
[QGVAR(chestSealLocal), LINKFUNC(treatmentAdvanced_chestSealLocal)] call CBA_fnc_addEventHandler;
[QGVAR(handleBreathing), LINKFUNC(handleBreathing)] call CBA_fnc_addEventHandler;
[QGVAR(hemopneumothoraxLocal), LINKFUNC(treatmentAdvanced_hemopneumothoraxLocal)] call CBA_fnc_addEventHandler;
[QGVAR(tensionpneumothoraxLocal), LINKFUNC(treatmentAdvanced_tensionpneumothoraxLocal)] call CBA_fnc_addEventHandler;
[QGVAR(cyanosisLocal), LINKFUNC(treatmentAdvanced_CyanosisLocal)] call CBA_fnc_addEventHandler;
[QGVAR(lowSpO2pp), LINKFUNC(lowSpO2pp)] call CBA_fnc_addEventHandler;

[QACEGVAR(medical,woundReceived),LINKFUNC(handlePulmoHit)] call CBA_fnc_addEventHandler;

["ace_unconscious", {
    params ["_unit", "_unconscious"];
    if (_unconscious) exitWith {};

    // Drop BVM if woken up with one on
    if(_unit call FUNC(hasBVM)) then {
        if (_patient getVariable [QGVAR(oxygenTankConnected), false]) then {
            _patient setVariable [QGVAR(oxygenTankConnected), false, true];
        };
        if (_patient getVariable [QGVAR(portableOxygenTankConnected), false]) then {
            _patient setVariable [QGVAR(portableOxygenTankConnected), false, true];
            _patient setVariable [QGVAR(oxygenTankProvider), nil, true];
        };

        private _weaponHolder = createVehicle ["Weapon_Empty", getPosATL _unit, [], 0, "CAN_COLLIDE"];
        if(_unit getVariable [QGVAR(pocketBVM), false]) then {
            _unit setVariable [QGVAR(pocketBVM), false, true];
            _weaponHolder addItemCargo ["kat_pocketBVM", 1];
        } else {
            _unit setVariable [QGVAR(BVM), false, true];
            _weaponHolder addItemCargo ["kat_BVM", 1];
        };
    };
}] call CBA_fnc_addEventHandler;

["kat_oxygenTank_300_Item", "kat_oxygenTank_300"] call ACEFUNC(common,registerItemReplacement);
["kat_oxygenTank_150_Item", "kat_oxygenTank_150"] call ACEFUNC(common,registerItemReplacement);