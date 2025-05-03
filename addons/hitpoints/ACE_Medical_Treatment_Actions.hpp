class ACE_Medical_Treatment_Actions {
    class CheckPulse;
    class BasicBandage;
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
        displayName = CSTRING(4X4_Gauze_Display);
        displayNameProgress = CSTRING(4X4_Gauze_Progress);
        icon = QPATHTOF(ui\4X4_Gauze.paa);
        items[] = {"kat_4X4_Gauze"};
    };
    class Compressed_Gauze: BasicBandage {
        displayName = CSTRING(Compressed_Gauze_Display);
        displayNameProgress = CSTRING(Compressed_Gauze_Progress);
        icon = QPATHTOF(ui\Compressed_Gauze.paa);
        condition = QFUNC(canPackWound);
        treatmentTime = QFUNC(getPackTime);
        items[] = {"kat_Compressed_Gauze"};
    };
    class Abdominal_Pad: BasicBandage {
        displayName = CSTRING(Abdominal_Pad_Display);
        displayNameProgress = CSTRING(Abdominal_Pad_Progress);
        icon = QPATHTOF(ui\Abdominal_Pad.paa);
        items[] = {"kat_Abdominal_Pad"};
        allowedSelections[] = {"Body"};
    };
    class ETD: BasicBandage {
        displayName = CSTRING(ETD_Display);
        displayNameProgress = CSTRING(ETD_Progress);
        icon = QPATHTOF(ui\ETD.paa);
        items[] = {"kat_ETD"};
    };
    class Elastic_Wrap: BasicBandage {
        displayName = CSTRING(Elastic_Wrap_Display);
        displayNameProgress = CSTRING(Elastic_Wrap_Progress);
        icon = QPATHTOF(ui\Elastic_Wrap.paa);
        condition = QFUNC(canWrapWound);
        treatmentTime = QFUNC(getWrapTime);
        callbackProgress = QFUNC(wrapWoundProgress);
        items[] = {"kat_Elastic_Wrap"};
    };
    class Elastic_Wrap_Splint: BasicBandage {
        displayName = CSTRING(Elastic_Wrap_Display);
        displayNameProgress = CSTRING(Elastic_Wrap_Progress);
        icon = QPATHTOF(ui\Elastic_Wrap.paa);
        condition = QFUNC(canWrapSplint);
        callbackSuccess = QFUNC(wrapSplint);
        treatmentTime = 12;
        items[] = {"kat_Elastic_Wrap"};
    };
    class Roller_Gauze: BasicBandage {
        displayName = CSTRING(Roller_Gauze_Display);
        displayNameProgress = CSTRING(Roller_Gauze_Progress);
        icon = QPATHTOF(ui\Roller_Gauze.paa);
        condition = QFUNC(canWrapWound);
        treatmentTime = QFUNC(getWrapTime);
        callbackProgress = QFUNC(wrapWoundProgress);
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
};