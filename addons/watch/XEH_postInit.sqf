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
