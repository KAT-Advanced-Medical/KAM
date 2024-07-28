class ACE_Medical_Treatment_Actions {
    class CheckPulse;
    class BasicBandage;
    class ApplyHandWarmers: BasicBandage {
        displayName = CSTRING(Use_Handwarmer);
        displayNameProgress = CSTRING(Using);
        treatmentLocations = 0;
        allowedSelections[] = {"LeftArm", "RightArm", "LeftLeg", "RightLeg"};
        items[] = {"kat_handWarmer"};
        callbackSuccess = QFUNC(useHandWarmer);
    };
    class ApplyFluidWarmer: BasicBandage {
        displayName = CSTRING(Apply_Warmer);
        displayNameProgress = CSTRING(perform);
        category = "advanced";
        treatmentLocations = QGVAR(closedLocation);
        allowedSelections[] = {"LeftArm", "RightArm", "LeftLeg", "RightLeg", "Body"};
        allowSelfTreatment = 0;
        medicRequired = QUOTE(ace_medical_treatment_medicIV);
        treatmentTime = 10;
        items[] = {"kat_fluidWarmer"};
        condition = QUOTE(EFUNC(pharma,removeIV));        
        callbackSuccess = QFUNC(applyFluidWarmer);
    };
    class RemoveFluidWarmer: BasicBandage {
        displayName = CSTRING(Remove_Warmer);
        displayNameProgress = CSTRING(perform);
        category = "advanced";
        treatmentLocations = QGVAR(closedLocation);
        allowedSelections[] = {"LeftArm", "RightArm", "LeftLeg", "RightLeg", "Body"};
        allowSelfTreatment = 0;
        medicRequired = QUOTE(ace_medical_treatment_medicIV);
        treatmentTime = 10;
        items[] = {};
        condition = QUOTE(FUNC(removeWarmer));
        callbackSuccess = QFUNC(removeFluidWarmer);
    };
    class CheckTemperature: CheckPulse {
        displayName = CSTRING(Check_Temperature);
        displayNameProgress = CSTRING(Check_Temperature_Progress);
        category = "examine";
        allowedSelections[] = {"Head"};
        treatmentTime = 3;
        condition = "true";
        callbackSuccess = QFUNC(checkTemperature);
    };
};
