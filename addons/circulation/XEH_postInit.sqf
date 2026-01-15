#include "script_component.hpp"

[QACEGVAR(medical_gui,updateBodyImage), LINKFUNC(gui_updateBodyImage)] call CBA_fnc_addEventHandler;
[QACEGVAR(medical_treatment,fullHealLocalMod), LINKFUNC(fullHealLocal)] call CBA_fnc_addEventHandler;
[QGVAR(checkBloodPressureLocal), LINKFUNC(checkBloodPressureLocal)] call CBA_fnc_addEventHandler;
[QGVAR(checkBloodPressureCuffLocal), LINKFUNC(checkBloodPressureCuffLocal)] call CBA_fnc_addEventHandler;
[QGVAR(checkPulseLocal), LINKFUNC(checkPulseLocal)] call CBA_fnc_addEventHandler;
[QGVAR(checkPulseStethLocal), LINKFUNC(checkPulseStethLocal)] call CBA_fnc_addEventHandler;
[QGVAR(checkNeckLocal), LINKFUNC(checkNeckLocal)] call CBA_fnc_addEventHandler;
[QGVAR(checkCapRefillLocal), LINKFUNC(checkCapRefillLocal)] call CBA_fnc_addEventHandler;
["ace_cardiacArrest", LINKFUNC(handleCardiacArrest)] call CBA_fnc_addEventHandler;

GVAR(AEDX_MonitorTarget) = objNull;

[QGVAR(setPreferredBloodType), {
    params ["_unit"];
    _unit setVariable [QGVAR(bloodTypePlayer), (profileNamespace getVariable [QGVAR(preferredBloodType), "O_N"]), true];
}] call CBA_fnc_addEventHandler;

["isNotPerformingCPR", {!((_this select 0) getVariable [QGVAR(isPerformingCPR), false])}] call ACEFUNC(common,addCanInteractWithCondition);

["isNotPerformingBVM", {!((_this select 0) getVariable [QEGVAR(breathing,isPerformingBVM), false])}] call ACEFUNC(common,addCanInteractWithCondition);

[QGVAR(handleNearToAED), {
    params ["_unit", "_patient"];

    if (ACEGVAR(medical_gui,target) isEqualTo _patient) then {
        [_unit, 0.3] call ACEFUNC(medical_status,adjustPainLevel);
    };
}] call CBA_fnc_addEventHandler;

[QGVAR(AEDused), {
    params ["_unit"];
    _unit setVariable [QGVAR(AEDEffectiveness), 0.5, true];
    [{
    params ["_args", "_idPFH"];
    _args params ["_unit"];
    private _AEDeffectivness = _unit getVariable [QGVAR(AEDEffectiveness), 1];
    _unit setVariable [QGVAR(AEDEffectiveness), (_AEDeffectivness + 0.01), true];
    if ((_AEDeffectivness == 1) || !(alive _unit)) exitWith {
        [_idPFH] call CBA_fnc_removePerFrameHandler;
    };
    }, 1, [_unit]] call CBA_fnc_addPerFrameHandler;
}] call CBA_fnc_addEventHandler;

[QGVAR(AEDused), {
    params ["_unit"];
    _unit setVariable [QGVAR(heartRestart), true, true];
    [{
        params ["_unit"];
        _unit setVariable [QGVAR(heartRestart), false, true];
    }, [_unit], 5] call CBA_fnc_waitAndExecute;
}] call CBA_fnc_addEventHandler;

[QACEGVAR(medical,CPRSucceeded), {
    params ["_unit"];
    _unit setVariable [QGVAR(refractoryCA), false, true];
}] call CBA_fnc_addEventHandler;

[QGVAR(incorrectAEDUsage), {
    params ["_unit"];

    [QACEGVAR(medical,FatalVitals), _unit] call CBA_fnc_localEvent;
    _unit setVariable [QGVAR(cardiacArrestType), 1, true];
}] call CBA_fnc_addEventHandler;

[QGVAR(placeAED_initAction), LINKFUNC(placeAED_PickUpAction)] call CBA_fnc_addEventHandler;
[QEGVAR(misc,handleRespawn), LINKFUNC(handleRespawn)] call CBA_fnc_addEventHandler;
[QACEGVAR(medical_gui,updateInjuryListPart), LINKFUNC(gui_updateInjuryListPart)] call CBA_fnc_addEventHandler;