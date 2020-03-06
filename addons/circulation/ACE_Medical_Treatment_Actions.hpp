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
        callbackSuccess = QUOTE([ARR_5('kat_Painkiller', _player, _patient, _selectionName, 'Painkillers')] call FUNC(removeItemfromMag));
        condition = QUOTE('kat_Painkiller' in (magazines _player) || 'kat_Painkiller' in (magazines _patient));
        litter[] = {};
    };
    class CheckDogtags: checkPulse {
        displayName = CSTRING(DogTag);
        displayNameProgress = CSTRING(DogTag_Action);
        treatmentTime = 2;
        allowedSelections[] = {"Head"};
        allowSelfTreatment = 1;
        callbackSuccess = "[_player, _patient] call ace_dogtags_fnc_checkDogtag";
        condition = "true";
    };
    class CheckBloodPressure: CheckPulse { // Remove the ability to check blood pressure at the head
        allowedSelections[] = {"LeftArm", "RightArm", "LeftLeg", "RightLeg"};
    };

    #include "Blood_Medical.hpp"

    class Defibrillator: CPR {
        items[] = {{"adv_aceCPR_AED", "kat_X_AED"}};
        treatmentTime = 10;
        callbackProgress = QUOTE(call FUNC(AED_sound));
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
        callbackSuccess = QUOTE([ARR_2(_player, _patient)] call FUNC(treatmentAdvanced_X));
        animationCaller = "AinvPknlMstpSnonWnonDnon_medic3";
    };
    class Remove_X_Defibrillator: X_Defibrillator {
        displayName = CSTRING(X_Action_Remove);
        items[] = {};
        condition = QUOTE(_patient getVariable [ARR_2(QQGVAR(X), true)]);
        treatmentTime = 5;
        callbackProgress = "";
        callbackSuccess = QUOTE([ARR_2(_player, _patient)] call FUNC(returnAED_X));
    };
};
