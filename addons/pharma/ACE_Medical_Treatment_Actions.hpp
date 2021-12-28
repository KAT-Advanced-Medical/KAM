class ACE_Medical_Treatment_Actions {
    class BasicBandage;
    class FieldDressing;
    class ApplyTourniquet;
    class RemoveTourniquet;
    class Morphine;
    class CheckPulse;
    class CPR;

    class BloodIV: BasicBandage {
        allowedSelections[] = {"Body", "LeftArm", "RightArm", "LeftLeg", "RightLeg"};
        medicRequired = QUOTE(ace_medical_medicIV);
        condition = QUOTE((_patient getVariable [ARR_2(QQGVAR(IVplaced), true)]) && FUNC(removeIV));
    };
    class Painkillers: Morphine {
        displayName = CSTRING(Inject_Box_Painkillers);
        displayNameProgress = CSTRING(Using);
        allowedSelections[] = {"Head"};
        items[] = {};
        callbackSuccess = QUOTE([ARR_5('kat_Painkiller', _medic, _patient, _bodyPart, 'Painkillers')] call FUNC(removeItemfromMag));
        condition = "[_medic, 'kat_Painkiller'] call ace_common_fnc_hasMagazine || [_patient, 'kat_Painkiller'] call ace_common_fnc_hasMagazine";
        litter[] = {};
        icon = QPATHTOF(ui\icon_painkillers_action.paa);
        animationPatient = "";
        animationPatientUnconscious = "AinjPpneMstpSnonWrflDnon_rolltoback";
        animationPatientUnconsciousExcludeOn[] = {"ainjppnemstpsnonwrfldnon"};
    };
    class Carbonate: Morphine {
        displayName = CSTRING(Take_Carbonate);
        displayNameProgress = CSTRING(Using);
        category = "medication";
        treatmentLocations = 0;
        allowedSelections[] = {"Head"};
        allowSelfTreatment = 0;
        medicRequired = 1;
        treatmentTime = 5;
        items[] = {};
        condition = "[_medic, 'kat_Carbonate'] call ace_common_fnc_hasMagazine || [_patient, 'kat_Carbonate'] call ace_common_fnc_hasMagazine";
        patientStateCondition = 0;
        callbackSuccess = QUOTE([ARR_3(_player, _patient, 'Carbonate')] call FUNC(treatmentAdvanced_Carbonate));
    };
    class Naloxone: Carbonate {
        displayName = CSTRING(Take_Naloxone);
        allowedSelections[] = {"Head"};
        allowSelfTreatment = 0;
        medicRequired = 1;
        treatmentTime = 5;
        items[] = {"kat_naloxone"};
        condition = QGVAR(naloxoneActive);
        patientStateCondition = 0;
        callbackSuccess = QUOTE([ARR_3(_player, _patient, 'Naloxone')] call FUNC(treatmentAdvanced_Naloxone));
    };
    class TXA: Carbonate {
        displayName = CSTRING(Take_TXA);
        allowedSelections[] = {"Body", "LeftArm", "RightArm", "LeftLeg", "RightLeg"};
        allowSelfTreatment = 0;
        medicRequired = 1;
        treatmentTime = QGVAR(PushTime);
        items[] = {"kat_TXA"};
        condition = QUOTE((_patient getVariable [ARR_2(QQGVAR(IVplaced), true)]) && GVAR(txaActive) && FUNC(removeIV));
        patientStateCondition = 0;
        callbackSuccess = QUOTE([ARR_2(_player, _patient)] call FUNC(treatmentAdvanced_TXA));
    };
    class Norepinephrine: Carbonate {
        displayName = CSTRING(Take_Norep);
        allowedSelections[] = {"Body", "LeftArm", "RightArm", "LeftLeg", "RightLeg"};
        allowSelfTreatment = 0;
        medicRequired = 1;
        treatmentTime = QGVAR(PushTime);
        items[] = {"kat_norepinephrine"};
        condition = QUOTE((_patient getVariable [ARR_2(QQGVAR(IVplaced), true)]) && FUNC(removeIV));
        patientStateCondition = 0;
        callbackSuccess = "ace_medical_treatment_fnc_medication";
    };
    class Phenylephrine: Carbonate {
        displayName = CSTRING(Take_Phenyl);
        allowedSelections[] = {"Body", "LeftArm", "RightArm", "LeftLeg", "RightLeg"};
        allowSelfTreatment = 0;
        medicRequired = 1;
        treatmentTime = QGVAR(PushTime);
        items[] = {"kat_phenylephrine"};
        condition = QUOTE((_patient getVariable [ARR_2(QQGVAR(IVplaced), true)]) && FUNC(removeIV));
        patientStateCondition = 0;
        callbackSuccess = "ace_medical_treatment_fnc_medication";
    };
    class Nitroglycerin: Carbonate {
        displayName = CSTRING(Take_Nitro);
        allowedSelections[] = {"Body", "LeftArm", "RightArm", "LeftLeg", "RightLeg"};
        allowSelfTreatment = 0;
        medicRequired = 1;
        treatmentTime = QGVAR(PushTime);
        items[] = {"kat_nitroglycerin"};
        condition = QUOTE((_patient getVariable [ARR_2(QQGVAR(IVplaced), true)]) && FUNC(removeIV));
        patientStateCondition = 0;
        callbackSuccess = "ace_medical_treatment_fnc_medication";
    };
    class Amiodarone: Carbonate {
        displayName = CSTRING(Take_Amiodarone);
        allowedSelections[] = {"LeftArm", "RightArm", "LeftLeg", "RightLeg"};
        allowSelfTreatment = 0;
        medicRequired = 1;
        treatmentTime = 5;
        items[] = {"kat_amiodarone"};
        condition = QUOTE((!([_patient] call ace_common_fnc_isAwake)) && (_patient getVariable [ARR_2(QQGVAR(IVplaced), true)]));
        patientStateCondition = 0;
        callbackSuccess = QUOTE([ARR_3(_player, _patient, 'Amiodarone')] call FUNC(treatmentAdvanced_Generic));
    };
    class Lidocaine: Carbonate {
        displayName = CSTRING(Take_Lidocaine);
        allowedSelections[] = {"LeftArm", "RightArm", "LeftLeg", "RightLeg"};
        allowSelfTreatment = 0;
        medicRequired = 1;
        treatmentTime = 5;
        items[] = {"kat_lidocaine"};
        condition = QUOTE((!([_patient] call ace_common_fnc_isAwake)) && (_patient getVariable [ARR_2(QQGVAR(IVplaced), true)]));
        patientStateCondition = 0;
        callbackSuccess = QUOTE([ARR_3(_player, _patient, 'Lidocaine')] call FUNC(treatmentAdvanced_Generic));
    };
    class Atropine: Carbonate {
        displayName = CSTRING(Take_Atropine);
        allowedSelections[] = {"LeftArm", "RightArm", "LeftLeg", "RightLeg"};
        allowSelfTreatment = 0;
        medicRequired = 1;
        treatmentTime = 5;
        items[] = {"kat_atropine"};
        condition = QUOTE(_patient getVariable [ARR_2(QQGVAR(IVplaced), true)]);
        patientStateCondition = 0;
        callbackSuccess = QUOTE([ARR_3(_player, _patient, 'Atropine')] call FUNC(treatmentAdvanced_Atropine));
    };
    class Reorientation: Carbonate {
        displayName = CSTRING(Take_Reorient);
        displayNameProgress = CSTRING(Reorienting);
        allowedSelections[] = {"Head"};
        allowSelfTreatment = 0;
        medicRequired = 1;
        treatmentTime = 1;
        items[] = {};
        condition = QUOTE(!([_patient] call ace_common_fnc_isAwake));
        patientStateCondition = 0;
        callbackSuccess = QUOTE([ARR_2(_player, _patient)] call FUNC(treatmentAdvanced_Reorientation));
        animationMedic = "AinvPknlMstpSnonWnonDnon_medicUp4";
        animationMedicProne = "AinvPknlMstpSnonWnonDnon_medicUp4";
    };
    class ApplyIV: ApplyTourniquet {
        displayName = CSTRING(Apply_IV_16);
        displayNameProgress = CSTRING(Applying_IV);
        medicRequired = QGVAR(IVmedic);
        category = "advanced";
        allowedSelections[] = {"LeftArm", "RightArm", "LeftLeg", "RightLeg"};
        items[] = {"kat_IV_16"};
        condition = QUOTE((!(_patient getVariable [ARR_2(QQGVAR(IVplaced), false)])) && FUNC(checkIV));
        treatmentTime = QGVAR(IVestablish);
        callbackSuccess = QUOTE([ARR_4(_player, _patient, _bodyPart, 'kat_IV_16')] call FUNC(applyIV));
        litter[] = {};
    };
    class ApplyIO: ApplyIV {
        displayName = CSTRING(Apply_IO_45);
        displayNameProgress = CSTRING(Applying_IV);
        medicRequired = QGVAR(IVmedic);
        category = "advanced";
        allowedSelections[] = {"Body"};
        items[] = {"kat_IO_FAST"};
        condition = QUOTE(!(_patient getVariable [ARR_2(QQGVAR(IVplaced), false)]));
        treatmentTime = QGVAR(IOestablish);
        callbackSuccess = QUOTE([ARR_4(_player, _patient, _bodyPart, 'kat_IO_FAST')] call FUNC(applyIV));
        litter[] = {};
    };
    class RemoveIV: ApplyTourniquet {
        displayName = CSTRING(Remove_IV);
        displayNameProgress = CSTRING(Removing_IV);
        allowedSelections[] = {"Body", "LeftArm", "RightArm", "LeftLeg", "RightLeg"};
        treatmentTime = 3;
        items[] = {};
        condition = QFUNC(removeIV);
        callbackSuccess = QFUNC(retrieveIV);
    };
};
