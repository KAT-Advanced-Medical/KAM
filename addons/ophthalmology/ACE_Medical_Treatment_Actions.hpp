class ACE_Medical_Treatment_Actions {
    class EyeWash {
        displayName = CSTRING(eyewash_display);
        displayNameProgress = CSTRING(eyewash_action);
        category = "bandage";
        treatmentLocations = 0;
        allowedSelections[] = {"Head"};
        allowSelfTreatment = 1;
        medicRequired = QGVAR(eyewash_medic_required);
        treatmentTime = QGVAR(eyewash_treatment_time);
        items[] = {
            "ACE_salineIV",
            "ACE_salineIV_500",
            "ACE_salineIV_250",
            "KAT_salineIV100",
            "kat_RingersLactateIV",
            "kat_RingersLactateIV_500",
            "kat_RingersLactateIV_250",
        };
        condition = QGETGVAR(enable,true);
        callbackSuccess = QFUNC(treatmentAdvanced_eyewash);
        callbackFailure = "";
        callbackProgress = "";
        consumeItem = 1;
        animationPatient = "";
        animationPatientUnconscious = "AinjPpneMstpSnonWrflDnon_rolltoback";
        animationPatientUnconsciousExcludeOn[] = {"ainjppnemstpsnonwrfldnon"};
        animationMedic = "AinvPknlMstpSlayWrflDnon_medicOther";
        animationMedicProne = "AinvPpneMstpSlayW[wpn]Dnon_medicOther";
        animationMedicSelf = "AinvPknlMstpSlayW[wpn]Dnon_medic";
        animationMedicSelfProne = "AinvPpneMstpSlayW[wpn]Dnon_medic";
        litter[] = {};
    };

    class EyeWashWater: EyeWash {
        displayName = CSTRING(eyewash_display_water);
        items[] = {
            "ACE_Canteen",
            "ACE_Canteen_Half",
            "ACE_WaterBottle",
            "ACE_WaterBottle_Half"
        };
    };

    class EyeWasher: EyeWash {
        displayName = CSTRING(eyewasher_display_item);
        items[] = {"KAT_Eyewasher"};
    };

    class EyeShield: EyeWash {
        displayName = CSTRING(eyeshield_display);
        displayNameProgress = CSTRING(eyeshield_action);
        medicRequired = QGVAR(eyeshield_medic_required);
        treatmentTime = QGVAR(eyeshield_treatment_time);
        items[] = {
            "kat_eyecovers"
        };
        condition = QFUNC(eyeShieldCondition);
        callbackSuccess = QFUNC(treatmentAdvanced_eyeShield);
    };
    class RemoveEyeShield: EyeWash {
        displayName = CSTRING(eyeshieldremove_action);
        displayNameProgress = CSTRING(eyeshieldremove_progress);
        medicRequired = 0;
        treatmentTime = QGVAR(eyeshield_treatment_time);
        items[] = {};
        condition = QFUNC(eyeShieldRemoveCondition);
        callbackSuccess = QFUNC(treatmentAdvanced_eyeShieldRemove);
    };
};
