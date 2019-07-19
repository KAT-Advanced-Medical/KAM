#include "script_component.hpp"
/*
 * Author: Katalam
 * Removes a pulseoximeter for a patient and adds Item to the caller
 *
 * Arguments:
 * 0: Medic <OBJECT>
 * 1: Patient <OBJECT>
 * 2: Body part <STRING>
 * 3: Treatment class name <STRING>
 *
 * Return Value:
 * None
 *
 * Example:
 * [player, cursorTarget, "leftarm", "RemovePulseoximeter"] call KAM_breathing_fnc_treatmentAdvanced_removePulseoximeter;
 *
 * Public: No
 */

params ["_caller", "_target", "_selectionName"];

private _index = ["head", "body", "leftarm", "rightarm", "leftleg", "rightleg"] find toLower _selectionName;

private _pulseOxi = _target getVariable [QGVAR(pulseoximeter), [0,0,0,0,0,0]];
_pulseOxi set [_index, 1];
_target setVariable [QGVAR(pulseoximeter), _pulseOxi, true];

if (_caller canAdd "KAM_pulseoximeter") then {
    _caller addItem "KAM_pulseoximeter";
} else {
    if (_target canAdd "KAM_pulseoximeter") then {
        _target addItem "KAM_pulseoximeter";
    } else {
        private _groundHolder = createVehicle ["WeaponHolderSimulated", _target, [], 0.5, "CAN_COLLIDE"];
        _groundHolder addItemCargoGlobal ["KAM_pulseoximeter", 1];
    };
};
