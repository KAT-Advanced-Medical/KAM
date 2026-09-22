#include "script_component.hpp"

[QACEGVAR(medical_gui,updateBodyImage), LINKFUNC(gui_updateBodyImage)] call CBA_fnc_addEventHandler;
[QACEGVAR(medical_treatment,fullHealLocalMod), LINKFUNC(fullHealLocal)] call CBA_fnc_addEventHandler;
[QGVAR(checkBloodPressureLocal), LINKFUNC(checkBloodPressureLocal)] call CBA_fnc_addEventHandler;
[QGVAR(checkBloodPressureCuffLocal), LINKFUNC(checkBloodPressureCuffLocal)] call CBA_fnc_addEventHandler;
[QGVAR(checkPulseLocal), LINKFUNC(checkPulseLocal)] call CBA_fnc_addEventHandler;
[QGVAR(checkPulseStethLocal), LINKFUNC(checkPulseStethLocal)] call CBA_fnc_addEventHandler;
["ace_cardiacArrest", LINKFUNC(handleCardiacArrest)] call CBA_fnc_addEventHandler;

GVAR(AEDX_MonitorTarget) = objNull;

[QGVAR(setPreferredBloodType), {
    params ["_unit"];
    _unit setVariable [QGVAR(bloodTypePlayer), (profileNamespace getVariable [QGVAR(preferredBloodType), "O_N"]), true];
}] call CBA_fnc_addEventHandler;

["isNotPerformingCPR", {!((_this select 0) getVariable [QGVAR(isPerformingCPR), false])}] call ACEFUNC(common,addCanInteractWithCondition);

[QGVAR(handleNearToAED), {
    params ["_unit", "_patient"];

    if (ACEGVAR(medical_gui,target) isEqualTo _patient) then {
        [_unit, 0.3] call ACEFUNC(medical_status,adjustPainLevel);
    };
}] call CBA_fnc_addEventHandler;

[QGVAR(incorrectAEDUsage), {
    params ["_unit"];

    [QACEGVAR(medical,FatalVitals), _unit] call CBA_fnc_localEvent;
    _unit setVariable [QGVAR(cardiacArrestType), 1, true];
}] call CBA_fnc_addEventHandler;

[QGVAR(bloodPoisoning), {
    params ["_unit"];

    [QACEGVAR(medical,FatalVitals), _unit] call CBA_fnc_localEvent;
}] call CBA_fnc_addEventHandler;

[QGVAR(placeAED_initAction), LINKFUNC(placeAED_PickUpAction)] call CBA_fnc_addEventHandler;
[QEGVAR(misc,handleRespawn), LINKFUNC(handleRespawn)] call CBA_fnc_addEventHandler;

// Blood sample / result registries are server-authoritative; these run on the
// server only, the rest of the mod only ever raises them via CBA_fnc_serverEvent
[QGVAR(drawSample), LINKFUNC(serverDrawSample)] call CBA_fnc_addEventHandler;
[QGVAR(testSample), LINKFUNC(serverTestSample)] call CBA_fnc_addEventHandler;
[QGVAR(applyResult), LINKFUNC(serverApplyResult)] call CBA_fnc_addEventHandler;

// ...and these reply on the requesting medic's own machine
[QGVAR(sampleDrawnLocal), LINKFUNC(sampleDrawnLocal)] call CBA_fnc_addEventHandler;
[QGVAR(sampleTestedLocal), LINKFUNC(sampleTestedLocal)] call CBA_fnc_addEventHandler;
[QGVAR(resultAppliedLocal), LINKFUNC(resultAppliedLocal)] call CBA_fnc_addEventHandler;
