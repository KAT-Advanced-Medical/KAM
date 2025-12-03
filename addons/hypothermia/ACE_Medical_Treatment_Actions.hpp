class ACE_Medical_Treatment_Actions {
    class CheckPulse;
    class BasicBandage;
    class ApplyHandWarmers: BasicBandage {
        displayName = CSTRING(Use_Handwarmer);
        displayNameProgress = CSTRING(Using);
        condition = QUOTE(GVAR(hypothermiaActive));
        treatmentLocations = 0;
        treatmentTime = 5;
        allowedSelections[] = {"LeftArm", "RightArm", "LeftLeg","RightLeg", "Body"};
        items[] = {"kat_handWarmer"};
        callbackSuccess = QFUNC(useHandWarmer);
    };
    class ApplyFluidWarmer: BasicBandage {
        displayName = CSTRING(Apply_Warmer);
        displayNameProgress = CSTRING(perform);
        category = "advanced";
        allowedSelections[] = {"Chest", "LeftArm", "RightArm", "UpperLeftLeg", "UpperRightLeg", "UpperLeftArm", "UpperRightArm", "LeftLeg", "RightLeg", "Neck"};
        medicRequired = QACEGVAR(medical_treatment,medicIV);
        treatmentTime = 10;
        items[] = {"kat_fluidWarmer"};
        condition = QUOTE(([ARR_3(_medic,_patient,_bodyPart)] call EFUNC(pharma,removeIVCheck)) && !([ARR_2(_patient,_bodyPart)] call FUNC(removeWarmer)) && GVAR(hypothermiaActive));     
        callbackSuccess = QFUNC(applyFluidWarmer);
    };
    class RemoveFluidWarmer: BasicBandage {
        displayName = CSTRING(Remove_Warmer);
        displayNameProgress = CSTRING(perform);
        category = "advanced";
        allowedSelections[] = {"Chest", "LeftArm", "RightArm", "UpperLeftLeg", "UpperRightLeg", "UpperLeftArm", "UpperRightArm", "LeftLeg", "RightLeg", "Neck"};
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
    class CheckTemperatureThermo: CheckPulse {
        displayName = CSTRING(Check_TemperatureThermo);
        displayNameProgress = CSTRING(Check_TemperatureThermo_Progress);
        category = "examine";
        allowedSelections[] = {"UpperLeftArm", "UpperRightArm", "UpperLeftLeg", "UpperRightLeg"};
        treatmentTime = 10;
        items[] = {"kat_thermometer"};
        condition = QUOTE(GVAR(hypothermiaActive));
        callbackSuccess = QFUNC(checkTemperatureThermo);
    };
    class ApplySpaceBlanket: BasicBandage {
        displayName = CSTRING(Apply_SpaceBlanket);
        displayNameProgress = CSTRING(perform);
        category = "advanced";
        allowedSelections[] = {"All"};
        medicRequired = 0;
        treatmentTime = 10;
        items[] = {"kat_spaceBlanket"};
        condition = QUOTE(!([ARR_2(_patient,_bodyPart)] call FUNC(removeBlanket)) && GVAR(hypothermiaActive)); 
        callbackSuccess = QFUNC(applySpaceBlanket);
    };
    class RemoveSpaceBlanket: BasicBandage {
        displayName = CSTRING(Remove_SpaceBlanket);
        displayNameProgress = CSTRING(perform);
        category = "advanced";
        allowedSelections[] = {"All"};
        medicRequired = 0;
        treatmentTime = 4;
        items[] = {};
        condition = QUOTE([ARR_2(_patient,_bodyPart)] call FUNC(removeBlanket) && GVAR(hypothermiaActive));
        callbackSuccess = QFUNC(removeSpaceBlanket);
    };
};
