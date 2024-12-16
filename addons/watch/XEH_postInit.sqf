#include "script_component.hpp"

if (!hasInterface) exitWith {};

[QGVAR(closeWatchTimer), LINKFUNC(closeWatchTimer)] call CBA_fnc_addEventHandler;
[QEGVAR(misc,handleRespawn), LINKFUNC(handleRespawn)] call CBA_fnc_addEventHandler;

[QGVAR(playWatchTone), {
    params ["_unit", "_tone"];
    _unit say3D [_tone, 5];
}] call CBA_fnc_addEventHandler;

["KAT Watch", QGVAR(showKatmin), CSTRING(ShowKATWatch_Setting), {
    // Conditions: canInteract
    if (!([ACE_player, objNull, ["isNotEscorting", "isNotInside"]] call ACEFUNC(common,canInteractWith))) exitWith { false };

    private _return = false;

    switch true do{
        case (('KAT_Katmin' in assignedItems ACE_player)): {
            _return = true;

            if !(GETMVAR(GVAR(KatminActive),false)) then {
                [ACE_player] call FUNC(showKWatch);
            } else {
                call FUNC(hideKWatch);
            };        
        };
        case (('KAT_Cavmin' in assignedItems ACE_player)): {
            _return = true;

            if !(GETMVAR(GVAR(CavminActive),false)) then {
                [ACE_player] call FUNC(showCWatch);
            } else {
                call FUNC(hideCWatch);
            };      
        };
        case (('KAT_STS' in assignedItems ACE_player)): {
            _return = true;

            if !(GETMVAR(GVAR(STSActive),false)) then {
                [ACE_player] call FUNC(showSWatch);
            } else {
                call FUNC(hideSWatch);
            };   
        };
        case (('KAT_Ranger' in assignedItems ACE_player)): {
            _return = true;

            if !(GETMVAR(GVAR(RangerActive),false)) then {
                [ACE_player] call FUNC(showRWatch);
            } else {
                call FUNC(hideRWatch);
            };      
        };
    };

    _return
}, { false }, [24, [false, false, false]], false] call CBA_fnc_addKeybind;

["KAT Watch", QGVAR(increaseTimer), CSTRING(AddTimer_Setting), {
    if (!([ACE_player, objNull, ["isNotEscorting", "isNotInside"]] call ACEFUNC(common,canInteractWith)) || {!('KAT_Ranger' in assignedItems ACE_player)}) exitWith { false };

    if !(GETMVAR(GVAR(RangerActive),false)) exitWith { false };

    private _timerLength = ACE_player getVariable [QGVAR(rangerTimer), 0];

    if (_timerLength < 999) then {
        ACE_player setVariable [QGVAR(rangerTimer), ((_timerLength + 15) min 999), false];
    };

    true
}, { false }, [38, [false, false, true]], false] call CBA_fnc_addKeybind;

["KAT Watch", QGVAR(decreaseTimer), CSTRING(SubtractTimer_Setting), {
    if (!([ACE_player, objNull, ["isNotEscorting", "isNotInside"]] call ACEFUNC(common,canInteractWith)) || {!('KAT_Ranger' in assignedItems ACE_player)}) exitWith { false };

    if !(GETMVAR(GVAR(RangerActive),false)) exitWith { false };

    private _timerLength = ACE_player getVariable [QGVAR(rangerTimer), 0];

    if (_timerLength > 0) then {
        ACE_player setVariable [QGVAR(rangerTimer), ((_timerLength - 15) max 0), false];
    };

    true
}, { false }, [36, [false, false, true]], false] call CBA_fnc_addKeybind;

["KAT Watch", QGVAR(startTimer), CSTRING(StartStopTimer_Setting), {
    if (!([ACE_player, objNull, ["isNotEscorting", "isNotInside"]] call ACEFUNC(common,canInteractWith)) || {!('KAT_Ranger' in assignedItems ACE_player)}) exitWith { false };

    private _timerLength = ACE_player getVariable [QGVAR(rangerTimer), 0];
    private _timerActive = ACE_player getVariable [QGVAR(rangerStart), false];

    if (_timerLength > 0) then {
        if (_timerActive) then {
            ACE_player setVariable [QGVAR(rangerStart), false, false];
        } else {
            if !(GETMVAR(GVAR(RangerActive),false)) then {
                [QGVAR(closeWatchTimer), [ACE_player], ACE_player] call CBA_fnc_targetEvent;
            };

            ACE_player setVariable [QGVAR(rangerStart), true, false];
        };
    };

    true
}, { false }, [37, [false, false, true]], false] call CBA_fnc_addKeybind;