class ACE_Medical_Treatment_Actions {
    class BasicBandage;
    class ApplyHandWarmers: BasicBandage {
        displayName = CSTRING(Use_Handwarmer);
        displayNameProgress = CSTRING(Using);
        treatmentLocations = 0;
        allowedSelections[] = {"Body"};
        items[] = {"kat_handWarmer"};
        callbackSuccess = QFUNC(useHandWarmer);
    };
    class ApplyFluidWarmer: BasicBandage {
        displayName = CSTRING(fracture_closed);
        displayNameProgress = CSTRING(perform);
        category = "advanced";
        treatmentLocations = QGVAR(closedLocation);
        allowedSelections[] = {"LeftArm", "RightArm", "LeftLeg", "RightLeg", "Body"};
        allowSelfTreatment = 0;
        medicRequired = QUOTE(ace_medical_treatment_medicIV);
        treatmentTime = QGVAR(closedTime);
        items[] = {"kat_fluidWarmer"};
        condition = QUOTE(EFUNC(pharma,removeIV));        
        callbackSuccess = QFUNC(applyFluidWarmer);
    };
    class RemoveFluidWarmer: BasicBandage {
        displayName = CSTRING(fracture_closed);
        displayNameProgress = CSTRING(perform);
        category = "advanced";
        treatmentLocations = QGVAR(closedLocation);
        allowedSelections[] = {"LeftArm", "RightArm", "LeftLeg", "RightLeg", "Body"};
        allowSelfTreatment = 0;
        medicRequired = QUOTE(ace_medical_treatment_medicIV);
        treatmentTime = QGVAR(closedTime);
        items[] = {};
        condition = QUOTE(FUNC(removeWarmer));
        callbackSuccess = QFUNC(removeFluidWarmer);
    };
};
