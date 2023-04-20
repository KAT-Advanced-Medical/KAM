class ACE_Medical_Treatment_Actions {
    class SalineIV;
    class BasicBandage;
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
};
