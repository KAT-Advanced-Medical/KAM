#include "..\script_component.hpp"
/*
 * Author: apo_tle
 * Called when a unit is hit. Handles receiving TBIs and setting up dedicated PFHs to increase ICP.
 *
 * Arguments:
 * 0: Unit That Was Hit <OBJECT>
 * 1: Damage done to each body part <ARRAY>
 *  0: Damage <NUMBER>
 *  1: Bodypart <STRING>
 * 2: Shooter <OBJECT>
 * 3: Ammo classname or damage type <STRING>
 *
 * Return Value:
 * None
 *
 * Example:
 * [cursorTarget, [1, "Head"], objNull, "BulletBase"] call kat_brain_fnc_concussion
 *
 * Public: No
 */
params ["_unit"];

private _pfh = [{
    params ["_args","_pfhID"];
    _args params ["_unit"];
    if (!alive _unit) exitWith {
        [_pfhID] call CBA_fnc_removePerFrameHandler;
        _unit setVariable [QGVAR(concussionPFH), nil];
    };
    private _edema    = _unit getVariable [QGVAR(edema),0];
    private _oldEdema    = _unit getVariable [QGVAR(edema),0];
    private _bleeding = _unit getVariable [QGVAR(bleeding),0];
    private _ICP      = _unit getVariable [QGVAR(ICP),15];
    private _necrosis = _unit getVariable [QGVAR(necrosis),0];
    private _reversibleDamage = _unit getVariable [QGVAR(reversibleDamage),0];
    private _concussion = _unit getVariable [QGVAR(concussion),0];
    if (_edema < 0.7) then {
        _edema = (_edema + 0.01) min _concussion; // slow swelling
    };
    private _targetICP = 15 + (_edema * 10) + (_bleeding * 20);
    _ICP = _ICP + ((_targetICP - _ICP) * 0.025);
    if (_ICP > 35) then {
        _necrosis = _necrosis + ((_ICP - 25) * 0.002) min 1;
    };
    if (_ICP > 20) then {
        _concussion = (_concussion + 0.01) min 1;
        _reversibleDamage = _reversibleDamage + ((_ICP - 20) * 0.02) min 1;
    };
    if (_edema > 0 && {_ICP < 20}) then {
        _edema = (_edema - 0.005) max 0;
    };
    if (_edema > _oldEdema) then {
        _unit setVariable [QGVAR(isSwelling), true, true];
    } else {
        _unit setVariable [QGVAR(isSwelling), false, true];
    };
    _concussion = (_concussion - 0.002) max 0;
    _unit setVariable [QGVAR(edema), _edema, true];
    _unit setVariable [QGVAR(ICP), _ICP, true];
    _unit setVariable [QGVAR(necrosis), _necrosis, true];
    _unit setVariable [QGVAR(concussion), _concussion, true];
    private _earRinging = linearConversion [0, 1, _concussion, 0, 20, true];
    GVAR(concussionRinging) = _earRinging;
    _unit setVariable [QGVAR(reversibleDamage),_reversibleDamage,true];
    if ((_edema == 0) && (_concussion == 0) && (_ICP <= 20) && (_reversibleDamage == 0)) then {
        _unit setVariable [QGVAR(concussionPFH), nil];
        [_pfhID] call CBA_fnc_removePerFrameHandler;
    };
 }, 5, [_unit]] call CBA_fnc_addPerFrameHandler;
 _unit setVariable [QGVAR(concussionPFH), _pfh];
