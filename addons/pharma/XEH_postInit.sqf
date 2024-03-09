#include "script_component.hpp"

[QGVAR(carbonateLocal), LINKFUNC(treatmentAdvanced_CarbonateLocal)] call CBA_fnc_addEventHandler;
[QGVAR(naloxoneLocal), LINKFUNC(treatmentAdvanced_NaloxoneLocal)] call CBA_fnc_addEventHandler;
[QGVAR(atropineLocal), LINKFUNC(treatmentAdvanced_AtropineLocal)] call CBA_fnc_addEventHandler;
[QGVAR(amiodaroneLocal), LINKFUNC(treatmentAdvanced_AmiodaroneLocal)] call CBA_fnc_addEventHandler;
[QGVAR(txaLocal), LINKFUNC(treatmentAdvanced_TXALocal)] call CBA_fnc_addEventHandler;
[QGVAR(reorientationLocal), LINKFUNC(treatmentAdvanced_ReorientationLocal)] call CBA_fnc_addEventHandler;
[QGVAR(medicationLocal), LINKFUNC(medicationLocal)] call CBA_fnc_addEventHandler;
[QGVAR(eacaLocal), LINKFUNC(treatmentAdvanced_EACALocal)] call CBA_fnc_addEventHandler;
[QGVAR(dialysisLocal), LINKFUNC(treatmentAdvanced_DialysisLocal)] call CBA_fnc_addEventHandler;
[QGVAR(flumazenilLocal), LINKFUNC(treatmentAdvanced_FlumazenilLocal)] call CBA_fnc_addEventHandler;
[QGVAR(lorazepamLocal), LINKFUNC(treatmentAdvanced_LorazepamLocal)] call CBA_fnc_addEventHandler;
[QGVAR(fluidLocal), LINKFUNC(fluidLocal)] call CBA_fnc_addEventHandler;
[QGVAR(flushLocal), LINKFUNC(treatmentAdvanced_FlushLocal)] call CBA_fnc_addEventHandler;
[QGVAR(pervitinLocal), LINKFUNC(treatmentAdvanced_PervitinLocal)] call CBA_fnc_addEventHandler;
[QGVAR(pervitinPP), LINKFUNC(pervitinPP)] call CBA_fnc_addEventHandler;
[QGVAR(ketamineLocal), LINKFUNC(treatmentAdvanced_KetamineLocal)] call CBA_fnc_addEventHandler;
[QGVAR(fentanylLocal), LINKFUNC(treatmentAdvanced_FentanylLocal)] call CBA_fnc_addEventHandler;
[QGVAR(caffeineLocal), LINKFUNC(treatmentAdvanced_CaffeineLocal)] call CBA_fnc_addEventHandler;


["kat_PainkillerItem", "kat_Painkiller"] call ACEFUNC(common,registerItemReplacement);
["kat_PenthroxItem", "kat_Penthrox"] call ACEFUNC(common,registerItemReplacement);
["kat_CarbonateItem", "kat_Carbonate"] call ACEFUNC(common,registerItemReplacement);
["kat_PervitinItem", "kat_Pervitin"] call ACEFUNC(common,registerItemReplacement);
["kat_CaffeineItem", "kat_Caffeine"] call ACEFUNC(common,registerItemReplacement);

["ace_treatmentSucceded", {
    params ["_medic", "_patient", "_bodyPart", "_classname"];
    if (!(GVAR(staminaMedication)) || ACE_Player != _patient || !(alive _patient)) exitWith {};
    
    if (_classname == "Epinephrine") then {
        if (ACEGVAR(advanced_fatigue,enabled)) then {
            ACEGVAR(advanced_fatigue,anReserve) = ACEGVAR(advanced_fatigue,anReserve) + 300;
            ["kat_EDF", 0.5] call ACEFUNC(advanced_fatigue,addDutyFactor);

            [{
                params ["_patient"];
                ["kat_EDF"] call ACEFUNC(advanced_fatigue,removeDutyFactor);
            }, [_patient], 120] call CBA_fnc_waitAndExecute;
        
        } else {
            _defaultAnimSpeed = getAnimSpeedCoef _patient;
            _patient setAnimSpeedCoef (_defaultAnimSpeed * 1.25);
            _patient setStamina 180;
            
            [{
                params ["_patient", "_defaultAnimSpeed"];
                _patient setAnimSpeedCoef _defaultAnimSpeed;
            },[_patient, _defaultAnimSpeed], 120] call CBA_fnc_waitAndExecute;
        };
    };
}] call CBA_fnc_addEventHandler;