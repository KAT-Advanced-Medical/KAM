#include "script_component.hpp"

["treatmentIVfalse", {_this call FUNC(treatmentAdvanced_IV)}] call CBA_fnc_addEventHandler;
["IVreset", {_this call FUNC(removeEffect_IV)}] call CBA_fnc_addEventHandler;
["treatmentCarbonate", {_this call FUNC(treatmentAdvanced_CarbonateLocal)}] call CBA_fnc_addEventHandler;
["treatmentNaloxone", {_this call FUNC(treatmentAdvanced_NaloxoneLocal)}] call CBA_fnc_addEventHandler;
["treatmentAtropine", {_this call FUNC(treatmentAdvanced_AtropineLocal)}] call CBA_fnc_addEventHandler;
["treatmentGeneric", {_this call FUNC(treatmentAdvanced_GenericLocal)}] call CBA_fnc_addEventHandler;
["treatmentTXA", {_this call FUNC(treatmentAdvanced_TXALocal)}] call CBA_fnc_addEventHandler;
["treatmentOndansetron", {_this call FUNC(treatmentAdvanced_OndansetronLocal)}] call CBA_fnc_addEventHandler;
["treatmentReorientation", {_this call FUNC(treatmentAdvanced_ReorientationLocal)}] call CBA_fnc_addEventHandler;