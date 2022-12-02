#include "script_component.hpp"

[QGVAR(selectFracture), LINKFUNC(fractureSelectLocal)] call CBA_fnc_addEventHandler;
[QGVAR(closedReduction), LINKFUNC(closedFractureLocal)] call CBA_fnc_addEventHandler;
[QGVAR(openReduction), LINKFUNC(openReductionLocal)] call CBA_fnc_addEventHandler;
[QGVAR(incision), LINKFUNC(openFractureIncisionLocal)] call CBA_fnc_addEventHandler;
["treatmentOpenFractureProgress", {_this call FUNC(openFractureProgressLocal)}] call CBA_fnc_addEventHandler;
[QGVAR(debridement), LINKFUNC(debridementLocal)] call CBA_fnc_addEventHandler;
[QGVAR(NPWT), LINKFUNC(npwtTreatmentLocal)] call CBA_fnc_addEventHandler;