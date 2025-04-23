class ACE_Medical_Treatment_Actions {
    class CheckPulse;
    class BasicBandage;
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