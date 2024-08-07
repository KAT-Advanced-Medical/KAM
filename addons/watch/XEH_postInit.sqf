#include "script_component.hpp"

if (!hasInterface) exitWith {};

["KAT Watch", QGVAR(showGarmin), "Show Garmin", {
    // Conditions: canInteract
    if (!([ACE_player, objNull, ["isNotEscorting", "isNotInside"]] call ACEFUNC(common,canInteractWith)) || {!('KAT_Garmin' in assignedItems ACE_player)}) exitWith { false };

    if !(GETMVAR(GVAR(GarminActive),false)) then {
        [ACE_player] call FUNC(showAltimeter);
    } else {
        call FUNC(hideAltimeter);
    };

    true
}, { false }, [24, [false, false, false]], false] call CBA_fnc_addKeybind;
