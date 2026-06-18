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

// Lung damage: chemical pneumonitis from inhaled mustard. High chance value
// pushes toward tension hemopneumothorax (the lethal variant).
_unit setVariable [QEGVAR(breathing,pneumothorax), 1, true];
_unit setVariable [QEGVAR(breathing,deepPenetratingInjury), true, true];
_unit setVariable [QEGVAR(breathing,activeChestSeal), false, true];

// Start deteriorating after delay
[_unit] call EFUNC(breathing,handlePneumothoraxDeterioration);

if (EGVAR(breathing,advPtxEnable)) then {
    [_unit, 30, true] call EFUNC(breathing,inflictAdvancedPneumothorax);
};

// Pain spike — pushes past unconscious threshold quickly.
private _currentPain = _unit getVariable [VAR_PAIN, 0];
_unit setVariable [VAR_PAIN, (_currentPain + 0.3) min 1, true];

// Bandageable chemical burn wound on a random major body part. ChemicalBurn
// (defined in ACE_Medical_Injuries.hpp) inherits ThermalBurn but bleeds,
// Apply 6 wounds ad once
for "_i" from 1 to 6 do {
    private _bodyPart = selectRandom ["Body", "LeftArm", "RightArm", "LeftLeg", "RightLeg", "Head"];
    private _dmg = 0.1 + random 0.8;
    [_unit, _dmg, _bodyPart, "KAT_chemicalBurn", _unit] call ACEFUNC(medical,addDamageToUnit);

    // Cough sound (audible signal, helps medics locate)
    [QEGVAR(breathing,playCough), [_unit], _unit] call CBA_fnc_targetEvent;
};
