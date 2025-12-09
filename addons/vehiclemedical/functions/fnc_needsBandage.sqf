#include "..\script_component.hpp"

params ["_patient"];
private _wounds = GET_OPEN_WOUNDS(_patient);
private _hasExternalBleeding = false;

{
    private _bodyPart = _x;
    private _woundList = _wounds get _bodyPart;

    {
        private _woundClassID = _x select 0;
        private _amountOf     = _x select 1;
        private _bleeding     = _x select 2;

        private _classIndex = _woundClassID / 10;
        private _className  = ACEGVAR(medical_damage,woundClassNames) select _classIndex;
        if (
            _amountOf > 0 
            && {_className != "InternalBleeding"} 
            && {_bleeding > 0}
        ) exitWith {
            _hasExternalBleeding = true;
        };
    } forEach _woundList;

    if (_hasExternalBleeding) exitWith {};
} forEach (keys _wounds);
_hasExternalBleeding