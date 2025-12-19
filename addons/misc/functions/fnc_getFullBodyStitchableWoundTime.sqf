#include "..\script_component.hpp"
/*
 * Author: kymckay
 * Returns a hashmap of the stitchable wounds that the given unit has on each body part.
 * A stitchable wound is a bandaged wound on a body part that does not have any bleeding wounds.
 *
 * Arguments:
 * 0: Unit <OBJECT>
 *
 * Return Value:
 * Stitchable Wounds <HASHMAP>
 *
 * Example:
 * [player] call kat_misc_fnc_getFullBodyStitchableWoundTime
 *
 * Public: No
 */

params ["_unit"];

// First determine which body parts have a bleeding wound
private _bleedingBodyParts = createHashMap;
{
    private _isBleeding = _y findIf {
        _x params ["_woundClassID", "_amountOf", "_bleedingRate"];
        private _classIndex = _woundClassID / 10;
        private _className = ACEGVAR(medical_damage,woundClassNames) select _classIndex;
        (_amountOf > 0 && {_bleedingRate > 0} && !(_className in ["InternalBleeding", "Evisceration", "Thermal_Burn"]));
    } != -1;

    if (_isBleeding) then {
        _bleedingBodyParts set [_x, true];
    };
} forEach GET_OPEN_WOUNDS(_unit);
private _totalAmount = 0;
// Any bandaged wound on a body part not bleeding is stitchable
private _unstitchableTypes = ["ETD", "Israeli_Bandage"];
private _stitchableWounds = createHashMap;
{
    if (!(_x in _bleedingBodyParts) && {_y isNotEqualTo []}) then {
        private _filteredWounds = _y select {
            _x params ["_woundClassID", "_amountOf", "_bleedingRate", "", "_type"];
            !(_type in _unstitchableTypes);
            _totalAmount = _totalAmount + (_amountOf max 1);
        };

        if (_filteredWounds isNotEqualTo []) then {
            _stitchableWounds set [_x, _filteredWounds];
        };
    };
} forEach GET_BANDAGED_WOUNDS(_unit);

{
    if (!(_x in _bleedingBodyParts) && {_y isNotEqualTo []}) then {
        private _filteredWounds = _y select {
            _x params ["_woundClassID", "_amountOf", "_bleedingRate", "", "_type"];
            !(_type in _unstitchableTypes);
            _totalAmount = _totalAmount + (_amountOf max 1);
        };

        if (_filteredWounds isNotEqualTo []) then {
            _stitchableWounds set [_x, _filteredWounds];
        };
    };
} forEach GET_COAGED_WOUNDS(_unit);

{
    if (!(_x in _bleedingBodyParts) && {_y isNotEqualTo []}) then {
        private _filteredWounds = _y select {
            _x params ["_woundClassID", "_amountOf", "_bleedingRate", "", "_type"];
            !(_type in _unstitchableTypes);
            _totalAmount = _totalAmount + (_amountOf max 1);
        };

        if (_filteredWounds isNotEqualTo []) then {
            _stitchableWounds set [_x, _filteredWounds];
        };
    };
} forEach GET_WRAPPED_WOUNDS(_unit);


_totalAmount