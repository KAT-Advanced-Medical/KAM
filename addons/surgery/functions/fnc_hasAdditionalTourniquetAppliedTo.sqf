#include "..\script_component.hpp"
/*
 * Author: Glowbal
 * Modified: Mazinski
 * Checks if the unit has a tourniquet applied on the specified body part.
 *
 * Arguments:
 * 0: Unit <OBJECT>
 * 1: Body Part <STRING>
 *
 * Return Value:
 * Has Tourniquet Been Applied <BOOL>
 *
 * Example:
 * [player, "leftleg"] call kat_surgery_fnc_hasAdditionalTourniquetAppliedTo
 *
 * Public: No
 */

params ["_unit", "_bodyPart"];

private _index = ALL_BODY_PARTS find toLower _bodyPart;

_index >= 0 && {GET_SURGICAL_TOURNIQUETS(_unit) select _index == 0}