#include "..\script_component.hpp"
/*
 * Author: DiGii
 * Applies one tick of mustard damage to a unit. Inflicts chemical pulmonary
 * injury (hemopneumothorax), a pain spike strong enough to drive the unit
 * unconscious, and a bleeding ChemicalBurn wound on a random body part. Death
 * routes through the medical system (low SpO2 / shock / cardiac arrest from
 * compounded bleeding + lung damage) for a slow-death feel.
 *
 * Called once when the burn deadline fires, then again every
 * contaminationTickInterval seconds via the contamination tick PFH while
 * chemicalContamination remains "mustard". Decon kit clears that variable
 * and the progression stops on the next tick.
 *
 * Arguments:
 * 0: Unit <OBJECT>
 *
 * Return Value:
 * None
 *
 * Public: No
 */

params ["_unit"];
if (!alive _unit) exitWith {};

if (LUNG_MODEL_ACTIVE) then {
    private _gasData = GVAR(gasRegistry) getOrDefault ["mustard", createHashMap];
    private _cap = _gasData getOrDefault ["lungInjuryCap", 0.6];
    [QEGVAR(breathing,setLungInjury), [_unit, _cap, "mustard", _gasData getOrDefault ["lungProgression", 0], _gasData getOrDefault ["lungProgressiveMin", LUNG_INJURY_PROGRESSIVE_MIN]]] call CBA_fnc_localEvent;
} else {
    // Legacy behaviour, retained so turning the lung model off restores the old presentation.
    _unit setVariable [QEGVAR(breathing,pneumothorax), 1, true];
    _unit setVariable [QEGVAR(breathing,deepPenetratingInjury), true, true];
    _unit setVariable [QEGVAR(breathing,activeChestSeal), false, true];

    [_unit, 0] call EFUNC(breathing,handlePneumothoraxDeterioration);

    if (EGVAR(breathing,advPtxEnable)) then {
        _unit setVariable [QEGVAR(breathing,hemopneumothorax), true, true];
        _unit setVariable [QEGVAR(breathing,pneumothorax), 4, true];

        if (EGVAR(circulation,enable)) then {
            [_unit] call EFUNC(circulation,updateInternalBleeding);
        };
    };
};

// Pain spike — pushes past unconscious threshold quickly. Blistering hurts regardless of how
// the lung injury is modelled, so this is not conditional on the pneumothorax settings.
[_unit, 0.7] call ACEFUNC(medical_status,adjustPainLevel);

private _currentPain = _unit getVariable [VAR_PAIN, 0];
_unit setVariable [VAR_PAIN, (_currentPain + 0.3) min 1, true];

// Bandageable chemical burn wound on a random major body part. ChemicalBurn
// (defined in ACE_Medical_Injuries.hpp) inherits ThermalBurn but bleeds,
// Apply 6 wounds ad once
for "_i" from 1 to 6 do {
    private _bodyPart = selectRandom ["Body", "LeftArm", "RightArm", "LeftLeg", "RightLeg", "Head"];
    private _dmg = 0.1 + random 0.8;
    [_unit, _dmg, _bodyPart, "KAT_chemicalBurn", _unit] call ACEFUNC(medical,addDamageToUnit);
};

private _soundTargets = allPlayers inAreaArray [ASLToAGL getPosASL _unit, 15, 15, 0, false, 15];

if (_soundTargets isNotEqualTo []) then {
    [QEGVAR(breathing,playCough), [_unit], _soundTargets] call CBA_fnc_targetEvent;
};
