#include "..\script_component.hpp"
/*
 * Author: Cplhardcore
 * Gets Bleeding Rate of internal bleeding on a bodypart
 *
 * Arguments:
 * 0: Unit <OBJECT>
 * 1: Body part
 *
 * Return Value:
 * Amount of bleeding per second
 *
 *
 * Public: No
 */

params ["_unit", "_selectionN"];
private _wounds = GET_OPEN_WOUNDS(_unit);
private _bodyPart = ALL_BODY_PARTS select _selectionN;
private _partWounds = _wounds getOrDefault [_bodyPart, []];
private _partBleedAmount = 0;

{
    _x params ["_woundClassID", "_amountOf", "_bleeding"];
    _partBleedAmount = _partBleedAmount + (_bleeding * _amountOf);
} forEach _partWounds;

_partBleedAmount
