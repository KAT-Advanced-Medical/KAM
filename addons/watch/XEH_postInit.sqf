#include "script_component.hpp"

if (!hasInterface) exitWith {};

["KAT Watch", QGVAR(showKatmin), "Show Katmin", {
    // Conditions: canInteract
    if (!([ACE_player, objNull, ["isNotEscorting", "isNotInside"]] call ACEFUNC(common,canInteractWith)) || {!('KAT_Katmin' in assignedItems ACE_player)}) exitWith { false };

    if !(GETMVAR(GVAR(KatminActive),false)) then {
        [ACE_player] call FUNC(showKWatch);
    } else {
        call FUNC(hideKWatch);
    };

    true
}, { false }, [24, [false, false, false]], false] call CBA_fnc_addKeybind;

["KAT Cav Watch", QGVAR(showCavmin), "Show Cavmin", {
    // Conditions: canInteract
    if (!([ACE_player, objNull, ["isNotEscorting", "isNotInside"]] call ACEFUNC(common,canInteractWith)) || {!('KAT_Cavmin' in assignedItems ACE_player)}) exitWith { false };

    if !(GETMVAR(GVAR(CavminActive),false)) then {
        [ACE_player] call FUNC(showCWatch);
    } else {
        call FUNC(hideCWatch);
    };

    true
}, { false }, [24, [false, false, false]], false] call CBA_fnc_addKeybind;

["KAT STS Watch", QGVAR(showSTS), "Show STS", {
    // Conditions: canInteract
    if (!([ACE_player, objNull, ["isNotEscorting", "isNotInside"]] call ACEFUNC(common,canInteractWith)) || {!('KAT_STS' in assignedItems ACE_player)}) exitWith { false };

    if !(GETMVAR(GVAR(STSActive),false)) then {
        [ACE_player] call FUNC(showSWatch);
    } else {
        call FUNC(hideSWatch);
    };

    true
}, { false }, [24, [false, false, false]], false] call CBA_fnc_addKeybind;
