class ACE_Medical_Treatment_Actions {
    class FieldDressing;
    class SalineIV;
    class BasicBandage;
    class SurgicalKit;
    class SalineIV_Stand: SalineIV {
        displayName = CSTRING(Display_IVStand);
        medicRequired = 0;
        condition = QUOTE([ARR_2(_medic, 1000)] call FUNC(conditionIV));
        items[] = {};
        callbackSuccess = QUOTE([ARR_5(_medic, _patient, _bodyPart, 'SalineIV', 'ACE_salineIV')] call FUNC(treatmentIV));
        consumeItem = 0;
    };
    class SalineIV_Stand_500: SalineIV_Stand {
        displayName = CSTRING(Display_IVStand_500);
        condition = QUOTE([ARR_2(_medic, 500)] call FUNC(conditionIV));
        callbackSuccess = QUOTE([ARR_5(_medic, _patient, _bodyPart, 'SalineIV_500', 'ACE_salineIV_500')] call FUNC(treatmentIV));
    };
    class SalineIV_Stand_250: SalineIV_Stand {
        displayName = CSTRING(Display_IVStand_250);
        condition = QUOTE([ARR_2(_medic, 250)] call FUNC(conditionIV));
        callbackSuccess = QUOTE([ARR_5(_medic, _patient, _bodyPart, 'SalineIV_250', 'ACE_salineIV_250')] call FUNC(treatmentIV));
    };
    class RemoveTourniquet: BasicBandage {
        treatmentTime = QGVAR(treatmentTimeDetachTourniquet);
    };
    class ApplyNeckTourniquet: BasicBandage {
        displayName = ACECSTRING(medical_treatment,Apply_Tourniquet);
        displayNameProgress = ACECSTRING(medical_treatment,Applying_Tourniquet);
        icon = QPATHTOF(ui\tourniquet.paa);
        allowedSelections[] = {"Head"};
        items[] = {"ACE_tourniquet"};
        treatmentTime = QACEGVAR(medical_treatment,treatmentTimeTourniquet);
        condition = QUOTE(!([ARR_2(_patient,_bodyPart)] call ACEFUNC(medical_treatment,hasTourniquetAppliedTo)) && GVAR(neckTourniquet));
        callbackSuccess = QFUNC(headTourniquet);
        litter[] = {};
    };
    class FullBodySurgicalKit: SurgicalKit {
        displayName = CSTRING(Use_SurgicalKitFullBody);
        treatmentTime = QFUNC(getFullBodyStitchTime);
        condition = QFUNC(fullBodyCanStitch);
        callbackStart = QFUNC(surgicalKitStart);
        callbackProgress = QFUNC(fullBodySurgicalKitProgress);
    };
    // class FullBodySurgicalKit: FieldDressing {
    //     displayName = CSTRING(Use_SurgicalKitFullBody);
    //     displayNameProgress = CSTRING(Stitching);
    //     icon = QPATHTOEF(medical_gui,ui\surgical_kit.paa);
    //     category = "advanced";
    //     items[] = {"ACE_surgicalKit"};
    //     treatmentLocations = QGVAR(locationSurgicalKit);
    //     allowSelfTreatment = QGVAR(allowSelfStitch);
    //     medicRequired = QGVAR(medicSurgicalKit);
    //     treatmentTime = QFUNC(getFullBodyStitchTime);
    //     condition = QFUNC(fullBodyCanStitch);
    //     callbackSuccess = "";
    //     callbackStart = QFUNC(surgicalKitStart);
    //     callbackProgress = QFUNC(fullBodySurgicalKitProgress);
    //     consumeItem = QGVAR(consumeSurgicalKit); // setting can be 0,1,2 - only 1 will consume items[]
    //     animationMedic = "AinvPknlMstpSnonWnonDnon_medic1";
    //     litter[] = {{"ACE_MedicalLitter_gloves"}};
    // };
};
