class ACE_Medical_Treatment_Actions {
    class CheckPulse;
    class BasicBandage;
    class ApplyHandWarmers: BasicBandage {
        displayName = CSTRING(Use_Handwarmer);
        displayNameProgress = CSTRING(Using);
        condition = QUOTE(GVAR(hypothermiaActive));
        treatmentLocations = 0;
        treatmentTime = 5;
        allowedSelections[] = {"LeftArm","RightArm","Body","LeftLeg","RightLeg", "Chest", "UpperLeftArm", "UpperRightArm", "UpperLeftLeg", "UpperRightLeg"};
        items[] = {"kat_handWarmer"};
        callbackSuccess = QFUNC(useHandWarmer);
    };
    class ApplyFluidWarmer: BasicBandage {
        displayName = CSTRING(Apply_Warmer);
        displayNameProgress = CSTRING(perform);
        category = "advanced";
        allowedSelections[] = {"Chest", "LeftArm", "RightArm", "LeftLeg", "RightLeg"};
        medicRequired = QACEGVAR(medical_treatment,medicIV);
        treatmentTime = 10;
        items[] = {"kat_fluidWarmer"};
        condition = QUOTE(([ARR_3(_medic,_patient,_bodyPart)] call EFUNC(pharma,removeIV)) && !([ARR_2(_patient,_bodyPart)] call FUNC(removeWarmer)) && GVAR(hypothermiaActive));     
        callbackSuccess = QFUNC(applyFluidWarmer);
    };
    class RemoveFluidWarmer: BasicBandage {
        displayName = CSTRING(Remove_Warmer);
        displayNameProgress = CSTRING(perform);
        category = "advanced";
        allowedSelections[] = {"Body", "LeftArm", "RightArm", "LeftLeg", "RightLeg"};
        medicRequired = QACEGVAR(medical_treatment,medicIV);
        treatmentTime = 10;
        items[] = {};
        condition = QUOTE([ARR_2(_patient,_bodyPart)] call FUNC(removeWarmer) && GVAR(hypothermiaActive));
        callbackSuccess = QFUNC(removeFluidWarmer);
    };
    class CheckTemperature: CheckPulse {
        displayName = CSTRING(Check_Temperature);
        displayNameProgress = CSTRING(Check_Temperature_Progress);
        category = "examine";
        allowedSelections[] = {"Head","UpperLeftArm", "UpperRightArm", "UpperLeftLeg", "UpperRightLeg"};
        treatmentTime = 3;
        condition = QUOTE(GVAR(hypothermiaActive));
        callbackSuccess = QFUNC(checkTemperature);
    };
};
