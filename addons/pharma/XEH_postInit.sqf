#include "script_component.hpp"

<<<<<<< HEAD
[QGVAR(carbonateLocal), LINKFUNC(treatmentAdvanced_CarbonateLocal)] call CBA_fnc_addEventHandler;
[QGVAR(naloxoneLocal), LINKFUNC(treatmentAdvanced_NaloxoneLocal)] call CBA_fnc_addEventHandler;
[QGVAR(atropineLocal), LINKFUNC(treatmentAdvanced_AtropineLocal)] call CBA_fnc_addEventHandler;
[QGVAR(amiodaroneLocal), LINKFUNC(treatmentAdvanced_AmiodaroneLocal)] call CBA_fnc_addEventHandler;
[QGVAR(txaLocal), LINKFUNC(treatmentAdvanced_TXALocal)] call CBA_fnc_addEventHandler;
[QGVAR(reorientationLocal), LINKFUNC(treatmentAdvanced_ReorientationLocal)] call CBA_fnc_addEventHandler;
[QGVAR(medicationLocal), LINKFUNC(treatmentAdvanced_medicationLocal)] call CBA_fnc_addEventHandler;
=======
["treatmentCarbonate", {_this call FUNC(treatmentAdvanced_CarbonateLocal)}] call CBA_fnc_addEventHandler;
["treatmentNaloxone", {_this call FUNC(treatmentAdvanced_NaloxoneLocal)}] call CBA_fnc_addEventHandler;
["treatmentAtropine", {_this call FUNC(treatmentAdvanced_AtropineLocal)}] call CBA_fnc_addEventHandler;
["treatmentGeneric", {_this call FUNC(treatmentAdvanced_GenericLocal)}] call CBA_fnc_addEventHandler;
["treatmentTXA", {_this call FUNC(treatmentAdvanced_TXALocal)}] call CBA_fnc_addEventHandler;
["treatmentOndansetron", {_this call FUNC(treatmentAdvanced_OndansetronLocal)}] call CBA_fnc_addEventHandler;
["treatmentReorientation", {_this call FUNC(treatmentAdvanced_ReorientationLocal)}] call CBA_fnc_addEventHandler;
>>>>>>> parent of 3c83512 (More stuff)
