#include "script_component.hpp"

["kat_stretcher", "Init", {
    params ["_vehicle"];

    [_vehicle] call ACEFUNC(dragging,initObject);
}] call CBA_fnc_addClassEventHandler;