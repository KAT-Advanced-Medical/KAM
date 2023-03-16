#include "script_component.hpp"

[QGVAR(carbonateLocal), LINKFUNC(treatmentAdvanced_CarbonateLocal)] call CBA_fnc_addEventHandler;
[QGVAR(naloxoneLocal), LINKFUNC(treatmentAdvanced_NaloxoneLocal)] call CBA_fnc_addEventHandler;
[QGVAR(atropineLocal), LINKFUNC(treatmentAdvanced_AtropineLocal)] call CBA_fnc_addEventHandler;
[QGVAR(amiodaroneLocal), LINKFUNC(treatmentAdvanced_AmiodaroneLocal)] call CBA_fnc_addEventHandler;
[QGVAR(txaLocal), LINKFUNC(treatmentAdvanced_TXALocal)] call CBA_fnc_addEventHandler;
[QGVAR(reorientationLocal), LINKFUNC(treatmentAdvanced_ReorientationLocal)] call CBA_fnc_addEventHandler;
[QGVAR(medicationLocal), LINKFUNC(treatmentAdvanced_medicationLocal)] call CBA_fnc_addEventHandler;
[QGVAR(eacaLocal), LINKFUNC(treatmentAdvanced_EACALocal)] call CBA_fnc_addEventHandler;
[QGVAR(dialysisLocal), LINKFUNC(treatmentAdvanced_DialysisLocal)] call CBA_fnc_addEventHandler;
[QGVAR(flumazenilLocal), LINKFUNC(treatmentAdvanced_FlumazenilLocal)] call CBA_fnc_addEventHandler;
[QGVAR(lorazepamLocal), LINKFUNC(treatmentAdvanced_LorazepamLocal)] call CBA_fnc_addEventHandler;
[QGVAR(fluidLocal), LINKFUNC(fluidLocal)] call CBA_fnc_addEventHandler;
[QGVAR(flushLocal), LINKFUNC(treatmentAdvanced_FlushLocal)] call CBA_fnc_addEventHandler;
[QGVAR(pervitinLocal), LINKFUNC(treatmentAdvanced_PervitinLocal)] call CBA_fnc_addEventHandler;
[QGVAR(pervitinPP), LINKFUNC(pervitinPP)] call CBA_fnc_addEventHandler;
[QGVAR(ketaminePP), LINKFUNC(ketaminePP)] call CBA_fnc_addEventHandler;
[QGVAR(fentanylPP), LINKFUNC(fentanylPP)] call CBA_fnc_addEventHandler;
[QGVAR(caffeineLocal), LINKFUNC(treatmentAdvanced_CaffeineLocal)] call CBA_fnc_addEventHandler;


["kat_PainkillerItem", "kat_Painkiller"] call ACEFUNC(common,registerItemReplacement);
["kat_CarbonateItem", "kat_Carbonate"] call ACEFUNC(common,registerItemReplacement);
["kat_PervitinItem", "kat_Pervitin"] call ACEFUNC(common,registerItemReplacement);
["kat_CaffeineItem", "kat_Caffeine"] call ACEFUNC(common,registerItemReplacement);

["ace_treatmentSucceded", {
    params ["_medic", "_patient", "_bodyPart", "_classname"];
    if (!local _patient) exitWith {["ace_treatmentSucceded", _this, _patient] call CBA_fnc_targetEvent};
    if (_classname == "Epinephrine") then {

        if (ACE_Player != _patient) exitWith {};
        if (ACEGVAR(advanced_fatigue,enabled)) then {
            params ["_patient"];
            if !(alive _patient) exitWith {};
            ACEGVAR(advanced_fatigue,anReserve) = ACEGVAR(advanced_fatigue,anReserve) + 300;
            ["EDF", 0.5] call ACEFUNC(advanced_fatigue,addDutyFactor);

            [{
                params ["_patient"];
                ["EDF"] call ACEFUNC(advanced_fatigue,removeDutyFactor);
            },
            [_patient],
            120] call CBA_fnc_waitAndExecute;
        
        } else {
            
            params ["_patient"];

            if !(alive _patient) exitWith {};
            _patient setAnimSpeedCoef 1.2;
            _patient setStamina 180;
            
            [{
                params ["_patient"];
                _patient setAnimSpeedCoef 1;
            },
            [_patient],
            120] call CBA_fnc_waitAndExecute;
        };
    };
}] call CBA_fnc_addEventHandler;