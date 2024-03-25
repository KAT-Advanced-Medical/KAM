#include "script_component.hpp"

[QGVAR(fractureSelect), LINKFUNC(fractureSelectLocal)] call CBA_fnc_addEventHandler;
[QGVAR(closedReduction), LINKFUNC(closedReductionLocal)] call CBA_fnc_addEventHandler;
[QGVAR(openReduction), LINKFUNC(openReductionLocal)] call CBA_fnc_addEventHandler;
[QGVAR(incision), LINKFUNC(incisionLocal)] call CBA_fnc_addEventHandler;
[QGVAR(openReductionProgress), LINKFUNC(openReductionProgressLocal)] call CBA_fnc_addEventHandler;
[QGVAR(ultraAssessment), LINKFUNC(ultraAssessmentLocal)] call CBA_fnc_addEventHandler;
[QGVAR(reboaApply), LINKFUNC(reboaApplyLocal)] call CBA_fnc_addEventHandler;
[QGVAR(reboaDeepApply), LINKFUNC(reboaDeepApplyLocal)] call CBA_fnc_addEventHandler;
[QGVAR(reboaRemove), LINKFUNC(reboaRemoveLocal)] call CBA_fnc_addEventHandler;
[QGVAR(pericardialTap), LINKFUNC(pericardialTapLocal)] call CBA_fnc_addEventHandler;


