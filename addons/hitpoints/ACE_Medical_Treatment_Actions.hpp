class ACE_Medical_Treatment_Actions {
    class CheckPulse;
    class BasicBandage;
    class CPR;
    class Hemostat: BasicBandage {
        displayName = CSTRING(Hemostat);
        displayNameProgress = CSTRING(Hemostat_Progress);
        icon = QPATHTOF(ui\Hemostat.paa);
        items[] = {"kat_Hemostatic_Injector"};
        allowSelfTreatment = 1;
        allowedSelections[] = {"LeftArm", "RightArm", "LeftLeg", "RightLeg", "UpperLeftArm", "UpperRightArm", "UpperLeftLeg", "UpperRightLeg"};
        treatmentTime = 6;
    };
    class fourByfour_Gauze: BasicBandage {
        displayName = CSTRING(4X4_Gauze);
        displayNameProgress = CSTRING(4X4_Gauze_Progress);
        icon = QPATHTOF(ui\4X4_Gauze.paa);
        callbackSuccess = QACEFUNC(medical_treatment,bandage);
        items[] = {"kat_4X4_Gauze"};
    };
    class Compressed_Gauze: BasicBandage {
        displayName = CSTRING(Compressed_Gauze);
        displayNameProgress = CSTRING(Compressed_Gauze_Progress);
        icon = QPATHTOF(ui\Compressed_Gauze.paa);
        allowedSelections[] = {"LeftArm", "RightArm", "LeftLeg", "RightLeg", "UpperLeftArm", "UpperRightArm", "UpperLeftLeg", "UpperRightLeg"};
        items[] = {"kat_Compressed_Gauze"};
    };
    class Hemostatic_Gauze: BasicBandage {
        displayName = CSTRING(Hemostatic_Gauze);
        displayNameProgress = CSTRING(Hemostatic_Gauze_Progress);
        icon = QPATHTOF(ui\Hemostatic_Gauze.paa);
        callbackSuccess = QACEFUNC(medical_treatment,bandage);
        items[] = {"kat_Hemostatic_Gauze"};
    };
    class Adhesive_Bandage: BasicBandage {
        displayName = CSTRING(Adhesive_Bandage);
        displayNameProgress = CSTRING(Adhesive_Bandage_Progress);
        icon = QPATHTOF(ui\Adhesive_Bandage.paa);
        items[] = {"kat_Adhesive_Bandage"};
        callbackSuccess = QACEFUNC(medical_treatment,bandage);
        treatmentTime = 3;
    };
    class Burn_Dressing: BasicBandage {
        displayName = CSTRING(Burn_Dressing);
        displayNameProgress = CSTRING(Burn_Dressing_Progress);
        icon = QPATHTOF(ui\Burn_Dressing.paa);
        condition = QFUNC(canBurnBandage);
        callbackSuccess = QACEFUNC(medical_treatment,bandage);
        items[] = {"kat_Burn_Dressing"};
    };
    class Abdominal_Pad: BasicBandage {
        displayName = CSTRING(Abdominal_Pad);
        displayNameProgress = CSTRING(Abdominal_Pad_Progress);
        icon = QPATHTOF(ui\Abdominal_Pad.paa);
        items[] = {"kat_Abdominal_Pad"};
        allowedSelections[] = {"Body"};
        callbackSuccess = QACEFUNC(medical_treatment,bandage);
        treatmentTime = 6;
    };
    class ETD: BasicBandage {
        displayName = CSTRING(ETD);
        displayNameProgress = CSTRING(ETD_Progress);
        icon = QPATHTOF(ui\ETD.paa);
        callbackSuccess = QACEFUNC(medical_treatment,bandage);
        treatmentTime = 16;
        items[] = {"kat_ETD"};
    };
    class Elastic_Wrap: BasicBandage {
        displayName = CSTRING(Elastic_Wrap);
        displayNameProgress = CSTRING(Elastic_Wrap_Progress);
        icon = QPATHTOF(ui\Elastic_Wrap.paa);
        condition = QFUNC(canWrapWound);
        treatmentTime = QFUNC(getWrapTime);
        callbackSuccess = QFUNC(wrapWound);
        items[] = {"kat_Elastic_Wrap"};
    };
    class Elastic_Wrap_Splint: BasicBandage {
        displayName = CSTRING(Elastic_Wrap_Splint);
        displayNameProgress = CSTRING(Elastic_Wrap_Splint_Progress);
        icon = QPATHTOF(ui\Elastic_Wrap.paa);
        callbackSuccess = QFUNC(wrapSplint);
        condition = QFUNC(canWrapSplint);
        treatmentTime = 12;
        items[] = {"kat_Elastic_Wrap"};
    };
    class Roller_Gauze: BasicBandage {
        displayName = CSTRING(Roller_Gauze);
        displayNameProgress = CSTRING(Roller_Gauze_Progress);
        icon = QPATHTOF(ui\Roller_Gauze.paa);
        condition = QFUNC(canWrapWound);
        treatmentTime = QFUNC(getWrapTime);
        callbackSuccess = QFUNC(wrapWound);
        items[] = {"kat_Compressed_Gauze"};
    };
    class ApplyTourniquet: BasicBandage {
        allowedSelections[] = {"LeftArm", "RightArm", "LeftLeg", "RightLeg", "UpperLeftArm", "UpperRightArm", "UpperLeftLeg", "UpperRightLeg"};
    };
    class Splint: BasicBandage {
        allowedSelections[] = {"LeftArm", "RightArm", "LeftLeg", "RightLeg", "UpperLeftArm", "UpperRightArm", "UpperLeftLeg", "UpperRightLeg"};
    };

    // - Syringes -------------------------------------------------------------
    class FieldDressing;
    class Morphine: FieldDressing {
        allowedSelections[] = {"LeftArm", "RightArm", "LeftLeg", "RightLeg", "UpperLeftArm", "UpperRightArm", "UpperLeftLeg", "UpperRightLeg"};
    };
    // - Diagnose -------------------------------------------------------------
    class Diagnose: BasicBandage {
        allowedSelections[] = {"Head", "Chest"};
    };
    class CheckLimb: CheckPulse {
        displayName = CSTRING(Check_Limb);
        displayNameProgress = CSTRING(Check_Limb_Progress);
        category = "examine";
        condition = "true";
        allowedSelections[] = {"All"};
        allowSelfTreatment = 1;
        medicRequired = 0;
        treatmentTime = 2;
        callbackSuccess = QFUNC(checkLimb);
    };
    class ApplyPressure: CPR {
        displayName = CSTRING(ApplyPressure);
        displayNameProgress = "";
        icon = "";
        category = "bandage";
        treatmentTime = 0.01;
        allowSelfTreatment = 0;
        medicRequired = 0;
        treatmentLocations = TREATMENT_LOCATIONS_ALL;
        allowedSelections[] = {"All"};
        callbackStart = "";
        callbackProgress = "";
        callbackFailure = "";
        callbackSuccess = QFUNC(pressureStart);
        condition = QFUNC(canBandage);
        animationPatientUnconscious = "AinjPpneMstpSnonWrflDnon_rolltoback";
        animationPatientUnconsciousExcludeOn[] = {"ainjppnemstpsnonwrfldnon"};
    };
};