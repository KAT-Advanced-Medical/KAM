#include "script_component.hpp"

["ace_cardiacArrest", LINKFUNC(handleCardiacArrest)] call CBA_fnc_addEventHandler;

GVAR(AEDX_MonitorTarget) = objNull;