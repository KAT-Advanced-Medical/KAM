#include "..\script_component.hpp"
/*
 * Author: Cplhardcore
 * Checks for internal bleeding on a bodypart
 *
 * Arguments:
 * 0: Medic <OBJECT>
 * 1: Patient <OBJECT>
 * 2: Body Part <STRING>
 *
 * Return Value:
 * None
 *
 * Example:
 * [player, cursorObject, "LeftLeg"] call kat_hitpoints_checkJoints
 *
 * Public: No
 */

params ["_medic", "_patient", "_bodyPart"];

TRACE_1("checkLimb1",_bodyPart);
private _partIndex = ALL_BODY_PARTS find _bodyPart;
if (_partindex == 3) then {
    private _pelvicFracture = _patient getVariable [QGVAR(pelvicFracture), 0];
    private _typeLabel = switch (true) do {
        case (_pelvicFracture == -1): { LSTRING(stabilizedPelvicFracture_log) };
        case (_pelvicFracture == 0): { LSTRING(noPelvicFracture_log) };
        case (_pelvicFracture == 1): { LSTRING(pelvicFracture_log) };
        default {""};
    };
    if (_typeLabel != "") then {
        [_patient, "quick_view", _typeLabel] call EFUNC(circulation,removeLog);
        [_patient, "quick_view", _typeLabel, [[_medic] call ACEFUNC(common,getName)]] call ACEFUNC(medical_treatment,addToLog);
    };
} else {
private _jointArray = GET_JOINTS(_patient);
private _jointGroupIndex = switch (true) do {
case (_partIndex in [4, 5]): { 0 };
case (_partIndex in [6, 7]): { 1 };
case (_partIndex in [8, 9]): { 2 };
case (_partIndex in [10, 11]): { 3 };
default { -1 };
};
private _jointCheck = _patient getVariable [QGVAR(jointCheck), [false, false, false, false]];
_jointCheck set [_jointGroupIndex, true];
_patient setVariable [QGVAR(jointCheck), _jointCheck, true];
[{
    params ["_patient", "_jointGroupIndex"];
    private _jointCheck = _patient getVariable [QGVAR(jointCheck), [false, false, false, false]];
    _jointCheck set [_jointGroupIndex, false];
    _patient setVariable [QGVAR(jointCheck), _jointCheck, true];
}, [_patient, _jointGroupIndex], 300] call CBA_fnc_waitAndExecute;
private _limbJointStatus = _jointArray select _jointGroupIndex;
{
    _x params ["_level"];
    private _typeLabel = switch (true) do {
        case (_level == 1): { localize LSTRING(JointInjury_InflamedStrain) };
        case (_level == 2): { localize LSTRING(JointInjury_InflamedSprain) };
        case (_level == 3): { localize LSTRING(JointInjury_Dislocation) };
        case (_level == 4): { localize LSTRING(JointInjury_IcedStrain) };
        case (_level == 5): { localize LSTRING(JointInjury_IcedSprain) };
        case (_level == 6): { localize LSTRING(JointInjury_StabilizedDislocation) };
        case (_level == 7): { localize LSTRING(JointInjury_Strain) };
        case (_level == 8): { localize LSTRING(JointInjury_Sprain) };
        case (_level == 9): { localize LSTRING(JointInjury_ReducedDislocation) };
        case (_level == 10): { localize LSTRING(JointInjury_WrappedStrain) };
        case (_level == 11): { localize LSTRING(JointInjury_WrappedSprain) };
        default {""};
    };
    private _limbLabel = switch (true) do {
        case (_jointGroupIndex == 0): { localize ACELSTRING(medical_gui,LeftArm) };
        case (_jointGroupIndex == 1): { localize ACELSTRING(medical_gui,RightArm) };
        case (_jointGroupIndex == 2): { localize ACELSTRING(medical_gui,LeftLeg) };
        case (_jointGroupIndex == 3): { localize ACELSTRING(medical_gui,RightLeg) };
        default {};
    };
    private _joint = switch (true) do {
        case ((_jointGroupIndex in [0, 1]) && (_forEachIndex == 0)): { localize LSTRING(JointInjury_Shoulder) };
        case ((_jointGroupIndex in [0, 1]) && (_forEachIndex == 1)): { localize LSTRING(JointInjury_Elbow) };
        case ((_jointGroupIndex in [0, 1]) && (_forEachIndex == 2)): { localize LSTRING(JointInjury_Wrist) };
        case ((_jointGroupIndex in [2, 3]) && (_forEachIndex == 0)): { localize LSTRING(JointInjury_Hip) };
        case ((_jointGroupIndex in [2, 3]) && (_forEachIndex == 1)): { localize LSTRING(JointInjury_Knee) };
        case ((_jointGroupIndex in [2, 3]) && (_forEachIndex == 2)): { localize LSTRING(JointInjury_Ankle) };
        default {};
    };
    if ((_typeLabel != "") && (GVAR(JointChance) > 0)) then {
        [_patient, "quick_view", LSTRING(JointLog)] call EFUNC(circulation,removeLog);
        [_patient, "quick_view", LSTRING(JointLog), [[_medic] call ACEFUNC(common,getName), _typeLabel, _joint, _limbLabel]] call ACEFUNC(medical_treatment,addToLog);
    };
    } forEach _limbJointStatus;
};



