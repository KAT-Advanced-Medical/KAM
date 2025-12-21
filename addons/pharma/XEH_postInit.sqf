#include "script_component.hpp"

[QGVAR(carbonateLocal), LINKFUNC(treatmentAdvanced_CarbonateLocal)] call CBA_fnc_addEventHandler;
[QGVAR(naloxoneLocal), LINKFUNC(treatmentAdvanced_NaloxoneLocal)] call CBA_fnc_addEventHandler;
[QGVAR(alteplaseLocal), LINKFUNC(treatmentAdvanced_AlteplaseLocal)] call CBA_fnc_addEventHandler;
[QGVAR(atropineLocal), LINKFUNC(treatmentAdvanced_AtropineLocal)] call CBA_fnc_addEventHandler;
[QGVAR(adenosineLocal), LINKFUNC(treatmentAdvanced_AdenosineLocal)] call CBA_fnc_addEventHandler;
[QGVAR(amiodaroneLocal), LINKFUNC(treatmentAdvanced_AmiodaroneLocal)] call CBA_fnc_addEventHandler;
[QGVAR(txaLocal), LINKFUNC(treatmentAdvanced_TXALocal)] call CBA_fnc_addEventHandler;
[QGVAR(txaautoLocal), LINKFUNC(treatmentAdvanced_TXAAutoLocal)] call CBA_fnc_addEventHandler;
[QGVAR(reorientationLocal), LINKFUNC(treatmentAdvanced_ReorientationLocal)] call CBA_fnc_addEventHandler;
[QGVAR(medicationLocal), LINKFUNC(medicationLocal)] call CBA_fnc_addEventHandler;
[QGVAR(eacaLocal), LINKFUNC(treatmentAdvanced_EACALocal)] call CBA_fnc_addEventHandler;
[QGVAR(etomidateLocal), LINKFUNC(treatmentAdvanced_EtomidateLocal)] call CBA_fnc_addEventHandler;
[QGVAR(dialysisLocal), LINKFUNC(treatmentAdvanced_DialysisLocal)] call CBA_fnc_addEventHandler;
[QGVAR(flumazenilLocal), LINKFUNC(treatmentAdvanced_FlumazenilLocal)] call CBA_fnc_addEventHandler;
[QGVAR(lorazepamLocal), LINKFUNC(treatmentAdvanced_LorazepamLocal)] call CBA_fnc_addEventHandler;
[QGVAR(flushLocal), LINKFUNC(treatmentAdvanced_FlushLocal)] call CBA_fnc_addEventHandler;
[QGVAR(pervitinLocal), LINKFUNC(treatmentAdvanced_PervitinLocal)] call CBA_fnc_addEventHandler;
[QGVAR(pervitinPP), LINKFUNC(pervitinPP)] call CBA_fnc_addEventHandler;
[QGVAR(ketamineLocal), LINKFUNC(treatmentAdvanced_KetamineLocal)] call CBA_fnc_addEventHandler;
[QGVAR(morphineLocal), LINKFUNC(treatmentAdvanced_MorphineLocal)] call CBA_fnc_addEventHandler;
[QGVAR(nalbuphineLocal), LINKFUNC(treatmentAdvanced_NalbuphineLocal)] call CBA_fnc_addEventHandler;
[QGVAR(fentanylLocal), LINKFUNC(treatmentAdvanced_FentanylLocal)] call CBA_fnc_addEventHandler;
[QGVAR(caffeineLocal), LINKFUNC(treatmentAdvanced_CaffeineLocal)] call CBA_fnc_addEventHandler;
[QGVAR(lidocaineLocal), LINKFUNC(treatmentAdvanced_LidocaineLocal)] call CBA_fnc_addEventHandler;
[QGVAR(succinylcholineLocal), LINKFUNC(treatmentAdvanced_SuccinylcholineLocal)] call CBA_fnc_addEventHandler;
[QGVAR(rocuroniumLocal), LINKFUNC(treatmentAdvanced_RocuroniumLocal)] call CBA_fnc_addEventHandler;
[QGVAR(sugammadexLocal), LINKFUNC(treatmentAdvanced_SugammadexLocal)] call CBA_fnc_addEventHandler;

[QGVAR(fentanylPatchLocal), LINKFUNC(treatmentAdvanced_FentanylPatchLocal)] call CBA_fnc_addEventHandler;
[QGVAR(removeFentanylPatchLocal), LINKFUNC(treatmentAdvanced_RemoveFentanylPatchLocal)] call CBA_fnc_addEventHandler;

[QGVAR(adenosineOverdoseLocal), LINKFUNC(treatmentAdvanced_AdenosineOverdoseLocal)] call CBA_fnc_addEventHandler;
[QGVAR(alteplaseOverdoseLocal), LINKFUNC(treatmentAdvanced_AlteplaseOverdoseLocal)] call CBA_fnc_addEventHandler;
[QGVAR(amiodaroneOverdoseLocal), LINKFUNC(treatmentAdvanced_AmiodaroneOverdoseLocal)] call CBA_fnc_addEventHandler;
[QGVAR(atropineOverdoseLocal), LINKFUNC(treatmentAdvanced_AtropineOverdoseLocal)] call CBA_fnc_addEventHandler;
[QGVAR(caffeineOverdoseLocal), LINKFUNC(treatmentAdvanced_CaffeineOverdoseLocal)] call CBA_fnc_addEventHandler;
[QGVAR(carbonateOverdoseLocal), LINKFUNC(treatmentAdvanced_CarbonateOverdoseLocal)] call CBA_fnc_addEventHandler;
[QGVAR(cwmpOverdoseLocal), LINKFUNC(treatmentAdvanced_CWMPOverdoseLocal)] call CBA_fnc_addEventHandler;
[QGVAR(doxapramOverdoseLocal), LINKFUNC(treatmentAdvanced_DoxapramOverdoseLocal)] call CBA_fnc_addEventHandler;
[QGVAR(diazepamOverdoseLocal), LINKFUNC(treatmentAdvanced_DiazepamOverdoseLocal)] call CBA_fnc_addEventHandler;
[QGVAR(metoprololOverdoseLocal), LINKFUNC(treatmentAdvanced_MetoprololOverdoseLocal)] call CBA_fnc_addEventHandler;
[QGVAR(eacaOverdoseLocal), LINKFUNC(treatmentAdvanced_EACAOverdoseLocal)] call CBA_fnc_addEventHandler;
[QGVAR(epinephrineOverdoseLocal), LINKFUNC(treatmentAdvanced_EpinephrineOverdoseLocal)] call CBA_fnc_addEventHandler;
[QGVAR(etomidateOverdoseLocal), LINKFUNC(treatmentAdvanced_EtomidateOverdoseLocal)] call CBA_fnc_addEventHandler;
[QGVAR(fentanylOverdoseLocal), LINKFUNC(treatmentAdvanced_FentanylOverdoseLocal)] call CBA_fnc_addEventHandler;
[QGVAR(flumazenilOverdoseLocal), LINKFUNC(treatmentAdvanced_FlumazenilOverdoseLocal)] call CBA_fnc_addEventHandler;
[QGVAR(ketamineOverdoseLocal), LINKFUNC(treatmentAdvanced_KetamineOverdoseLocal)] call CBA_fnc_addEventHandler;
[QGVAR(lidocaineOverdoseLocal), LINKFUNC(treatmentAdvanced_LidocaineOverdoseLocal)] call CBA_fnc_addEventHandler;
[QGVAR(lorazepamOverdoseLocal), LINKFUNC(treatmentAdvanced_LorazepamOverdoseLocal)] call CBA_fnc_addEventHandler;
[QGVAR(morphineOverdoseLocal), LINKFUNC(treatmentAdvanced_MorphineOverdoseLocal)] call CBA_fnc_addEventHandler;
[QGVAR(naloxoneOverdoseLocal), LINKFUNC(treatmentAdvanced_NaloxoneOverdoseLocal)] call CBA_fnc_addEventHandler;
[QGVAR(nalbuphineOverdoseLocal), LINKFUNC(treatmentAdvanced_NalbuphineOverdoseLocal)] call CBA_fnc_addEventHandler;
[QGVAR(nitroglycerinOverdoseLocal), LINKFUNC(treatmentAdvanced_NitroglycerinOverdoseLocal)] call CBA_fnc_addEventHandler;
[QGVAR(norepinephrineOverdoseLocal), LINKFUNC(treatmentAdvanced_NorepinephrineOverdoseLocal)] call CBA_fnc_addEventHandler;
[QGVAR(penthroxOverdoseLocal), LINKFUNC(treatmentAdvanced_PenthroxOverdoseLocal)] call CBA_fnc_addEventHandler;
[QGVAR(phenylephrineOverdoseLocal), LINKFUNC(treatmentAdvanced_PhenylephrineOverdoseLocal)] call CBA_fnc_addEventHandler;
[QGVAR(pervitinOverdoseLocal), LINKFUNC(treatmentAdvanced_PervitinOverdoseLocal)] call CBA_fnc_addEventHandler;
[QGVAR(txaOverdoseLocal), LINKFUNC(treatmentAdvanced_TXAOverdoseLocal)] call CBA_fnc_addEventHandler;
[QGVAR(bicarbonateOverdoseLocal), LINKFUNC(treatmentAdvanced_bicarbonateOverdoseLocal)] call CBA_fnc_addEventHandler;
[QGVAR(calciumChlorideOverdoseLocal), LINKFUNC(treatmentAdvanced_CalciumChlorideOverdoseLocal)] call CBA_fnc_addEventHandler;
[QGVAR(calciumGluconateOverdoseLocal), LINKFUNC(treatmentAdvanced_CalciumGluconateOverdoseLocal)] call CBA_fnc_addEventHandler;

[QGVAR(applyPressureBag), LINKFUNC(treatmentAdvanced_applyPressureBagLocal)] call CBA_fnc_addEventHandler;
[QGVAR(removePressureBag), LINKFUNC(treatmentAdvanced_removePressureBagLocal)] call CBA_fnc_addEventHandler;

[QEGVAR(misc,handleRespawn), LINKFUNC(handleRespawn)] call CBA_fnc_addEventHandler;

[QACEGVAR(medical_gui,updateInjuryListPart), LINKFUNC(gui_updateInjuryListPart)] call CBA_fnc_addEventHandler;
[QACEGVAR(medical_gui,updateBodyImage), LINKFUNC(gui_updateBodyImage)] call CBA_fnc_addEventHandler;
[QACEGVAR(medical_treatment,fullHealLocalMod), LINKFUNC(fullHealLocal)] call CBA_fnc_addEventHandler;

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

[QACEGVAR(medical_status,initialized), LINKFUNC(coagRegen)] call CBA_fnc_addEventHandler;
[QACEGVAR(medical_status,initialized), LINKFUNC(clotWound)] call CBA_fnc_addEventHandler;
