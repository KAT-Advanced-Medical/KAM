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
        items[] = {"kat_4X4_Gauze"};
    };
    class Compressed_Gauze: BasicBandage {
        displayName = CSTRING(Compressed_Gauze);
        displayNameProgress = CSTRING(Compressed_Gauze_Progress);
        icon = QPATHTOF(ui\Compressed_Gauze.paa);
        allowedSelections[] = {"Body", "LeftArm", "RightArm", "LeftLeg", "RightLeg", "UpperLeftArm", "UpperRightArm", "UpperLeftLeg", "UpperRightLeg"};
        items[] = {"kat_Compressed_Gauze"};
    };
    class Hemostatic_Gauze: BasicBandage {
        displayName = CSTRING(Hemostatic_Gauze);
        displayNameProgress = CSTRING(Hemostatic_Gauze_Progress);
        icon = QPATHTOF(ui\Hemostatic_Gauze.paa);
        items[] = {"kat_Hemostatic_Gauze"};
    };
    class Adhesive_Bandage: BasicBandage {
        displayName = CSTRING(Adhesive_Bandage);
        displayNameProgress = CSTRING(Adhesive_Bandage_Progress);
        icon = QPATHTOF(ui\Adhesive_Bandage.paa);
        items[] = {"kat_Adhesive_Bandage"};
        treatmentTime = 3;
    };
    class Burn_Dressing: BasicBandage {
        displayName = CSTRING(Burn_Dressing);
        displayNameProgress = CSTRING(Burn_Dressing_Progress);
        icon = QPATHTOF(ui\Burn_Dressing.paa);
        condition = QFUNC(canBurnBandage);
        callbackSuccess = QFUNC(burnDressing);
        items[] = {"kat_Burn_Dressing"};
    };
    class Abdominal_Pad: BasicBandage {
        displayName = CSTRING(Abdominal_Pad);
        displayNameProgress = CSTRING(Abdominal_Pad_Progress);
        icon = QPATHTOF(ui\Abdominal_Pad.paa);
        items[] = {"kat_Abdominal_Pad"};
        allowedSelections[] = {"Body"};
        callbackSuccess = QFUNC(ABDPad);
        treatmentTime = 8;
    };
    class ETD: BasicBandage {
        displayName = CSTRING(ETD);
        displayNameProgress = CSTRING(ETD_Progress);
        icon = QPATHTOF(ui\ETD.paa);
        callbackSuccess = QACEFUNC(medical_treatment,bandage);
        items[] = {"kat_ETD"};
    };
    class Israeli_Bandage: BasicBandage {
        displayName = CSTRING(Israeli_Bandage);
        displayNameProgress = CSTRING(Israeli_Bandage_Progress);
        icon = QPATHTOF(ui\Israeli_Bandage.paa);
        callbackSuccess = QACEFUNC(medical_treatment,bandage);
        items[] = {"kat_Israeli_Bandage"};
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
    class Ice_Pack: BasicBandage {
        displayName = CSTRING(Ice_Pack);
        displayNameProgress = CSTRING(Ice_Pack_Progress);
        icon = QPATHTOF(ui\Ice_Pack.paa);
        condition = QFUNC(canIceJoint);
        category = "surgery";
        medicRequired = 0;
        treatmentTime = QGVAR(iceTime);
        callbackSuccess = QFUNC(IceJoint);
        items[] = {"kat_Ice_Pack"};
    };
    class Elastic_Wrap_Joint: BasicBandage {
        displayName = CSTRING(Elastic_Wrap_Joint);
        displayNameProgress = CSTRING(Elastic_Wrap_Joint_Progress);
        icon = QPATHTOF(ui\Elastic_Wrap.paa);
        category = "surgery";
        callbackSuccess = QFUNC(wrapJoint);
        condition = QFUNC(canWrapJoint);
        medicRequired = QGVAR(JointCareLevel);
        treatmentTime = QGVAR(wrapTime);
        items[] = {"kat_Elastic_Wrap"};
    };
    class Stabilize_Joint: BasicBandage {
        displayName = CSTRING(Stabilize_Joint);
        displayNameProgress = CSTRING(Stabilize_Joint_Progress);
        icon = QPATHTOF(ui\Elastic_Wrap.paa);
        category = "surgery";
        callbackSuccess = QFUNC(stabilizeJoint);
        condition = QFUNC(canStabilizeJoint);
        medicRequired = QGVAR(JointCareLevel);
        treatmentTime = QGVAR(stabilizeTime);
        items[] = {"kat_Elastic_Wrap"};
    };
    class Reduce_Joint: BasicBandage {
        displayName = CSTRING(Reduce_Joint);
        displayNameProgress = CSTRING(Reduce_Joint_Progress);
        icon = QPATHTOF(ui\Elastic_Wrap.paa);
        category = "surgery";
        callbackSuccess = QFUNC(reduceJoint);
        condition = QFUNC(canReduceJoint);
        allowSelfTreatment = 0;
        medicRequired = QGVAR(JointCareLevel);
        treatmentTime = QGVAR(reduceTime);
        items[] = {};
    };
    class Bind_Pelvis: BasicBandage {
        displayName = CSTRING(Bind_Pelvis);
        displayNameProgress = CSTRING(Bind_Pelvis_Progress);
        icon = QPATHTOF(ui\Pelvic_Binder.paa);
        category = "surgery";
        callbackSuccess = QFUNC(bindPelvis);
        condition = QFUNC(canBindPelvis);
        allowSelfTreatment = 0;
        medicRequired = QGVAR(JointCareLevel);
        treatmentTime = QGVAR(bindTime);
        items[] = {"kat_Pelvic_Binder"};
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
        treatmentTime = 5;
        items[] = {};
        callbackSuccess = QFUNC(checkLimb);
    };
    class CheckJoints: CheckPulse {
        displayName = CSTRING(Check_Joints);
        displayNameProgress = CSTRING(Check_Joints_Progress);
        category = "examine";
        condition = "true";
        allowedSelections[] = {"LeftArm", "RightArm", "LeftLeg", "RightLeg", "UpperLeftArm", "UpperRightArm", "UpperLeftLeg", "UpperRightLeg", "Body"};
        allowSelfTreatment = 1;
        medicRequired = 0;
        treatmentTime = 8;
        items[] = {};
        callbackSuccess = QFUNC(checkJoints);
    };
    class ApplyPressure: CPR {
        displayName = CSTRING(ApplyPressure);
        displayNameProgress = "";
        icon = "";
        category = "bandage";
        treatmentTime = 0.01;
        allowSelfTreatment = 1;
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
    class RemoveETD: BasicBandage {
        displayName = CSTRING(Remove_ETD);
        displayNameProgress = CSTRING(Removing_ETD);
        items[] = {};
        treatmentTime = QGVAR(removalTimeETD);
        condition = QUOTE([ARR_3(_patient,_bodyPart,'ETD')] call FUNC(hasRemovableBandage));
        callbackSuccess = QUOTE([ARR_3(_patient,_bodyPart,'ETD')] call FUNC(removeBandage));
    };
    class RemoveIsraeli: BasicBandage {
        displayName = CSTRING(Remove_Israeli);
        displayNameProgress = CSTRING(Removing_Israeli);
        items[] = {};
        treatmentTime = QGVAR(removalTimeIsraeli);
        condition = QUOTE([ARR_3(_patient,_bodyPart,'Israeli_Bandage')] call FUNC(hasRemovableBandage));
        callbackSuccess = QUOTE([ARR_3(_patient,_bodyPart,'Israeli_Bandage')] call FUNC(removeBandage));
    };
    class ApplyTourniquet: BasicBandage {
        allowedSelections[] = {"LeftArm", "RightArm", "LeftLeg", "RightLeg", "UpperLeftArm", "UpperRightArm", "UpperLeftLeg", "UpperRightLeg"};
        condition = "false";
    };
    class ApplyHastyTourniquet: ApplyTourniquet {
        displayName = CSTRING(Apply_HastyTourniquet);
        displayNameProgress = CSTRING(Applying_HastyTourniquet);
        treatmentTime = QGVAR(treatmentTimeHastyTourniquet);
        treatmentTimeTrained = QGVAR(treatmentTimeTrainedHastyTourniquet);
        condition = QUOTE(!([ARR_2(_patient,_bodyPart)] call ACEFUNC(medical_treatment,hasTourniquetAppliedTo)) && ([ARR_2(_patient,_bodyPart)] call EFUNC(surgery,hasAdditionalTourniquetAppliedTo)));
        callbackSuccess = QUOTE([ARR_8(_medic, _patient, _bodyPart, _classname, _itemUser, _usedItem, _createLitter, 1)] call FUNC(tourniquet));
    };
    class ApplyDelibrateTourniquet: ApplyTourniquet {
        displayName = CSTRING(Apply_DelibrateTourniquet);
        displayNameProgress = CSTRING(Applying_DelibrateTourniquet);
        treatmentTime = QGVAR(treatmentTimeTrainedDelibrateTourniquet);
        treatmentTimeTrained = QGVAR(treatmentTimeTrainedDelibrateTourniquet);
        condition = QUOTE(!([ARR_2(_patient,_bodyPart)] call ACEFUNC(medical_treatment,hasTourniquetAppliedTo)) && ([ARR_2(_patient,_bodyPart)] call EFUNC(surgery,hasAdditionalTourniquetAppliedTo)));
        callbackSuccess = QUOTE([ARR_8(_medic, _patient, _bodyPart, _classname, _itemUser, _usedItem, _createLitter, 2)] call FUNC(tourniquet));
        allowedUnderwater = 0;
    };
};