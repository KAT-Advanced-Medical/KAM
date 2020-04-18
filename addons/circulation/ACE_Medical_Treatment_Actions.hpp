class ACE_Medical_Treatment_Actions {
    class FieldDressing;
    class Morphine;
    class CheckPulse;
    class CPR;

    class Painkillers: Morphine {
        displayName = CSTRING(Inject_Box_Painkillers);
        displayNameProgress = CSTRING(Using);
        allowedSelections[] = {"Head"};
        items[] = {};
        callbackSuccess = QUOTE([ARR_5('kat_Painkiller', _medic, _patient, _bodyPart, 'Painkillers')] call FUNC(removeItemfromMag); [_patient] call FUNC(wrongBloodTreatment););
        condition = "[_medic, 'kat_Painkiller'] call ace_common_fnc_hasMagazine || [_patient, 'kat_Painkiller'] call ace_common_fnc_hasMagazine";
        litter[] = {};
        icon = QPATHTOF(ui\icon_painkillers_action.paa);
    };
    class CheckDogtags: checkPulse {
        displayName = CSTRING(DogTag);
        displayNameProgress = CSTRING(DogTag_Action);
        treatmentTime = 2;
        allowedSelections[] = {"Head"};
        allowSelfTreatment = 1;
        callbackSuccess = "[_medic, _patient] call ace_dogtags_fnc_checkDogtag";
        condition = "true";
    };
    class CheckBloodPressure: CheckPulse { // Remove the ability to check blood pressure at the head
        allowedSelections[] = {"LeftArm", "RightArm", "LeftLeg", "RightLeg"};
    };

    #include "Blood_Medical.hpp"

    class Defibrillator: CPR {
        items[] = {};
        treatmentTime = 10;
        callbackProgress = QUOTE(call FUNC(AED_sound));
        condition = QUOTE((_patient getVariable [ARR_2(QQGVAR(X), false)]) || [ARR_2(_medic, 'adv_aceCPR_AED')] call ace_common_fnc_hasItem || [ARR_2(_medic, 'kat_X_AED')] call ace_common_fnc_hasItem);
        medicRequired = 1;
        icon = QPATHTOF(ui\X_Series-Device_W.paa);
    };
    class X_Defibrillator: CPR {
        displayName = CSTRING(X_Action_Use);
        displayNameProgress = CSTRING(X_Action_Progress);
        items[] = {"kat_X_AED"};
        condition = QUOTE(!(_patient getVariable [ARR_2(QQGVAR(X), false)]));
        treatmentTime = 5;
        consumeItem = 1;
        medicRequired = 1;
        callbackProgress = "";
        callbackStart = "";
        callbackFailure = "";
        callbackSuccess = QFUNC(treatmentAdvanced_X);
        animationCaller = "AinvPknlMstpSnonWnonDnon_medic3";
        icon = QPATHTOF(ui\X_Series-Device_W.paa);
    };
    class Remove_X_Defibrillator: X_Defibrillator {
        displayName = CSTRING(X_Action_Remove);
        items[] = {};
        condition = QUOTE(_patient getVariable [ARR_2(QQGVAR(X), true)]);
        treatmentTime = 5;
        callbackProgress = "";
        callbackSuccess = QUOTE([ARR_2(_medic, _patient)] call FUNC(returnAED_X));
        icon = QPATHTOF(ui\X_Series-Device_W.paa);
    };
};
