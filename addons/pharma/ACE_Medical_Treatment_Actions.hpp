class ACE_Medical_Treatment_Actions {
     class BasicBandage {
        removeFromInteractions = "false";
    };
    class FieldDressing;
    class ApplyTourniquet;
    class RemoveTourniquet;
    class Morphine;
    class CheckPulse;
    class CPR;

    class BloodIV: BasicBandage {
        allowedSelections[] = {"Chest", "LeftArm", "RightArm", "UpperLeftLeg", "UpperRightLeg", "UpperLeftArm", "UpperRightArm", "LeftLeg", "RightLeg", "Neck"};
        medicRequired = QUOTE(ace_medical_treatment_medicIV);
        condition = QUOTE(!(GVAR(RequireInsIV)) || FUNC(removeIVCheck));
        callbackSuccess = "[_medic, _patient, _bodyPart, _className, _itemUser, _usedItem] call ace_medical_treatment_fnc_ivBag;";
    };
    class BloodIV_500: BloodIV {
        callbackSuccess = "[_medic, _patient, _bodyPart, _className, _itemUser, _usedItem] call ace_medical_treatment_fnc_ivBag;";
    };
    class BloodIV_250: BloodIV {
        callbackSuccess = "[_medic, _patient, _bodyPart, _className, _itemUser, _usedItem] call ace_medical_treatment_fnc_ivBag;";
    };
    class SalineIV: BloodIV {
        callbackSuccess = "[_medic, _patient, _bodyPart, _className, _itemUser, _usedItem] call ace_medical_treatment_fnc_ivBag;";
    };
    class SalineIV_500: SalineIV {
        callbackSuccess = "[_medic, _patient, _bodyPart, _className, _itemUser, _usedItem] call ace_medical_treatment_fnc_ivBag;";
    };
    class SalineIV_250: SalineIV {
        callbackSuccess = "[_medic, _patient, _bodyPart, _className, _itemUser, _usedItem] call ace_medical_treatment_fnc_ivBag;";
    };
    class PlasmaIV: BloodIV {
        callbackSuccess = "[_medic, _patient, _bodyPart, _className, _itemUser, _usedItem] call ace_medical_treatment_fnc_ivBag;";
    };
    class PlasmaIV_500: PlasmaIV {
        callbackSuccess = "[_medic, _patient, _bodyPart, _className, _itemUser, _usedItem] call ace_medical_treatment_fnc_ivBag;";
    };
    class PlasmaIV_250: PlasmaIV {
        callbackSuccess = "[_medic, _patient, _bodyPart, _className, _itemUser, _usedItem] call ace_medical_treatment_fnc_ivBag;";
    };
    class PackedRBCIV_500: BloodIV {
        displayName = CSTRING(Actions_Packed_RBC_500);
        items[] = {"kat_PackedRBCIV_500"};
        displayNameProgress = CSTRING(Transfusing_Packed_RBC);
        callbackSuccess = "[_medic, _patient, _bodyPart, _className, _itemUser, _usedItem] call ace_medical_treatment_fnc_ivBag;";
    };
    class PackedRBCIV_250: BloodIV {
        displayName = CSTRING(Actions_Packed_RBC_250);
        items[] = {"kat_PackedRBCIV_250"};
        displayNameProgress = CSTRING(Transfusing_Packed_RBC);
        callbackSuccess = "[_medic, _patient, _bodyPart, _className, _itemUser, _usedItem] call ace_medical_treatment_fnc_ivBag;";
    };
    class RingersLactateIV: SalineIV {
        displayName = CSTRING(Actions_Ringers_Lactate);
        items[] = {"kat_RingersLactateIV"};
        displayNameProgress = CSTRING(Transfusing_Ringers_Lactate);
        callbackSuccess = "[_medic, _patient, _bodyPart, _className, _itemUser, _usedItem] call ace_medical_treatment_fnc_ivBag;";
    };
    class RingersLactateIV_500: SalineIV {
        displayName = CSTRING(Actions_Ringers_Lactate_500);
        items[] = {"kat_RingersLactateIV_500"};
        displayNameProgress = CSTRING(Transfusing_Ringers_Lactate);
        callbackSuccess = "[_medic, _patient, _bodyPart, _className, _itemUser, _usedItem] call ace_medical_treatment_fnc_ivBag;";
    };
    class RingersLactateIV_250: SalineIV {
        displayName = CSTRING(Actions_Ringers_Lactate_250);
        items[] = {"kat_RingersLactateIV_250"};
        displayNameProgress = CSTRING(Transfusing_Ringers_Lactate);
        callbackSuccess = "[_medic, _patient, _bodyPart, _className, _itemUser, _usedItem] call ace_medical_treatment_fnc_ivBag;";
    };
    class Epinephrine: Morphine {
        callbackSuccess = QFUNC(medication);
    };
    class CWMP: Morphine {
        displayName = CSTRING(Give_CWMP);
        displayNameProgress = CSTRING(Using);
        allowedSelections[] = {"Head"};
        medicRequired = QGVAR(medLvl_CWMP);
        treatmentTime = QGVAR(treatmentTime_CWMP);
        items[] = {"kat_Painkiller"};
        condition = QUOTE(!(_patient getVariable [ARR_2(QQEGVAR(airway,recovery),false)]));
        callbackSuccess = QFUNC(treatmentAdvanced_CWMP);
        icon = QPATHTOF(ui\icon_painkillers_action.paa);
        animationPatient = "";
        animationPatientUnconscious = "AinjPpneMstpSnonWrflDnon_rolltoback";
        animationPatientUnconsciousExcludeOn[] = {"ainjppnemstpsnonwrfldnon","kat_recoveryposition"};
        sounds[] = {{QPATHTO_R(sounds\take_CWMP.ogg),5,1,15}};
        litter[] = {};
    };
    class Carbonate: Morphine {
        displayName = CSTRING(Take_Carbonate);
        displayNameProgress = CSTRING(Using);
        category = "medication";
        treatmentLocations = 0;
        allowedSelections[] = {"Head"};
        allowSelfTreatment = 1;
        medicRequired = QGVAR(medLvl_Carbonate);
        treatmentTime = QGVAR(treatmentTime_Carbonate);
        items[] = {"kat_Carbonate"};
        callbackSuccess = QFUNC(treatmentAdvanced_Carbonate);
        animationPatient = "";
        animationPatientUnconscious = "AinjPpneMstpSnonWrflDnon_rolltoback";
        animationPatientUnconsciousExcludeOn[] = {"ainjppnemstpsnonwrfldnon","kat_recoveryposition"};
        sounds[] = {{QPATHTO_R(sounds\use_carbonate.ogg),5,1,15}};
        litter[] = {};
    };
    class Pervitin: Morphine {
        displayName = CSTRING(Take_Pervitin);
        displayNameProgress = CSTRING(Using);
        allowedSelections[] = {"Head"};
        allowSelfTreatment = 1;
        medicRequired = QGVAR(medLvl_Pervitin);
        treatmentTime = QGVAR(treatmentTime_Pervitin);
        items[] = {"kat_Pervitin"};
        condition = QUOTE(!(_patient getVariable [ARR_2(QQEGVAR(airway,recovery),false)]));
        callbackSuccess = QFUNC(treatmentAdvanced_Pervitin);
        animationPatient = "";
        animationPatientUnconscious = "AinjPpneMstpSnonWrflDnon_rolltoback";
        animationPatientUnconsciousExcludeOn[] = {"ainjppnemstpsnonwrfldnon","kat_recoveryposition"};
        sounds[] = {{QPATHTO_R(sounds\take_painkillers.ogg),5,1,15}};
        litter[] = {};
    };
    class Caffeine: Morphine {
        displayName = CSTRING(Take_Caffeine);
        displayNameProgress = CSTRING(Using);
        allowedSelections[] = {"Head"};
        allowSelfTreatment = 1;
        medicRequired = QGVAR(medLvl_Caffeine);
        treatmentTime = QGVAR(treatmentTime_Caffeine);
        items[] = {"kat_Caffeine"};
        condition = QUOTE(!(_patient getVariable [ARR_2(QQEGVAR(airway,recovery),false)]));
        callbackSuccess = QFUNC(treatmentAdvanced_Caffeine);
        animationPatient = "";
        animationPatientUnconscious = "AinjPpneMstpSnonWrflDnon_rolltoback";
        animationPatientUnconsciousExcludeOn[] = {"ainjppnemstpsnonwrfldnon","kat_recoveryposition"};
        sounds[] = {{QPATHTO_R(sounds\take_painkillers.ogg),5,1,15}};
        litter[] = {};
    };
    class Penthrox: Morphine {
        displayName = CSTRING(Use_Penthrox);
        displayNameProgress = CSTRING(Using);
        allowedSelections[] = {"Head"};
        allowSelfTreatment = 1;
        medicRequired = QGVAR(medLvl_Penthrox);
        treatmentTime = QGVAR(treatmentTime_Penthrox);
        items[] = {"kat_Penthrox"};
        callbackSuccess = QFUNC(treatmentAdvanced_Penthrox);
        condition = QUOTE([_patient] call ACEFUNC(common,isAwake));
        animationPatient = "";
        animationPatientProne = "";
        animationMedic = "";
        animationMedicProne = "";
        animationMedicSelf = "";
        animationMedicSelfProne = "";
        sounds[] = {{QPATHTO_R(sounds\use_penthrox.ogg),2,1,7}};
        litter[] = {};
    };
    class Naloxone: Carbonate {
        displayName = CSTRING(Take_Naloxone);
        allowedSelections[] = {"Head"};
        allowSelfTreatment = 1;
        medicRequired = QGVAR(medLvl_Naloxone);
        treatmentTime = QGVAR(treatmentTime_Naloxone);
        items[] = {"kat_naloxone"};
        callbackSuccess = QFUNC(treatmentAdvanced_Naloxone);
        sounds[] = {};
    };
    /*class EACA: Carbonate {
        displayName = CSTRING(Take_EACA);
        allowedSelections[] =  {"Neck", "Chest", "Body", "LeftArm", "RightArm", "UpperLeftArm", "UpperRightArm", "UpperLeftLeg", "UpperRightLeg", "LeftLeg", "RightLeg"};
        allowSelfTreatment = 1;
        medicRequired = QGVAR(medLvl_EACA);
        treatmentTime = QGVAR(treatmentTime_EACA);
        items[] = {"kat_EACA"};
        condition = QUOTE(FUNC(AMSCheck));
        callbackSuccess = QFUNC(medication);
        sounds[] = {};
    };
    class TXA: EACA {
        displayName = CSTRING(Take_TXA);
        allowSelfTreatment = 1;
        medicRequired = QGVAR(medLvl_TXA);
        treatmentTime = QGVAR(treatmentTime_TXA);
        items[] = {"kat_TXA"};
        callbackSuccess = QFUNC(medication);
        sounds[] = {};
    };*/
    class TXAAuto: Morphine {
        displayName = CSTRING(Take_TXAAuto);
        displayNameProgress = CSTRING(Using);
        allowSelfTreatment = 1;
        medicRequired = QGVAR(medLvl_TXAAuto);
        items[] = {"kat_TXAAuto"};
        condition = "";
        treatmentTime = QGVAR(treatmentTime_TXAAuto);
        callbackSuccess = QFUNC(medication);
        sounds[] = {};
    };
    class SalineFlush: Carbonate {
        displayName = CSTRING(Saline_Flush);
        allowedSelections[] = {"Neck", "Chest", "LeftArm", "RightArm", "UpperLeftLeg", "UpperRightLeg", "UpperLeftArm", "UpperRightArm", "LeftLeg", "RightLeg", "Neck"};
        allowSelfTreatment = 1;
        medicRequired = QGVAR(medLvl_SalineFlush);
        treatmentTime = QGVAR(treatmentTime_SalineFlush);
        items[] = {};
        condition = QUOTE((_patient getVariable [ARR_2(QQGVAR(IVplaced),true)]) && FUNC(salineCheck));
        callbackSuccess = QFUNC(treatmentAdvanced_Flush);
        sounds[] = {};
    };
    class SyringeSalineFlush: Carbonate {
        displayName = CSTRING(Saline_Flush);    
        allowedSelections[] = {"Neck", "Chest", "LeftArm", "RightArm", "UpperLeftArm", "UpperRightArm", "UpperLeftLeg", "UpperRightLeg", "LeftLeg", "RightLeg"};
        allowSelfTreatment = 1;
        medicRequired = QGVAR(medLvl_SalineFlush);
        treatmentTime = QGVAR(treatmentTime_SalineFlush);
        items[] = {"kat_syringe_salineIV_5ml_30"};
        condition = QUOTE(_patient getVariable [ARR_2(QQGVAR(IVplaced),true)]);
        callbackSuccess = QFUNC(treatmentAdvanced_Flush);
        sounds[] = {};
    };
    class Inspect: Carbonate {
        displayName = CSTRING(Inspect_Catheter);
        category = "examine";
        allowedSelections[] = {"Neck", "Chest", "LeftArm", "RightArm", "UpperLeftArm", "UpperRightArm", "UpperLeftLeg", "UpperRightLeg", "LeftLeg", "RightLeg"};
        allowSelfTreatment = 1;
        medicRequired = 1;
        treatmentTime = 2;
        items[] = {};
        condition = QFUNC(removeIV);
        callbackSuccess = QFUNC(inspectCatheter);
        animationMedic = "";
        animationMedicProne = "";
        sounds[] = {};
    };
    class ManualPressureBag: BasicBandage {
        displayName = CSTRING(ManualPressure_displayName);
        displayNameProgress = CSTRING(ManualPressure_progress);
        allowedSelections[] = {"Neck", "Chest", "LeftArm", "RightArm", "UpperLeftArm", "UpperRightArm", "UpperLeftLeg", "UpperRightLeg", "LeftLeg", "RightLeg"};
        category = "advanced";
        treatmentTime = 1;
        medicRequired = 0;
        items[] = {};
        icon = "";
        condition = QUOTE(([ARR_3(_player,_patient,_bodyPart)] call FUNC(hasIVbag)));
        callbackSuccess = QFUNC(treatmentAdvanced_ManualBagPressure);
    };
    class ApplyPressureBag: BasicBandage {
        displayName = CSTRING(Apply_PressureBag);
        displayNameProgress = CSTRING(Applying_PressureBag);
        category = "advanced";
        allowedSelections[] = {"Chest", "LeftArm", "RightArm", "UpperLeftLeg", "UpperRightLeg", "UpperLeftArm", "UpperRightArm", "LeftLeg", "RightLeg", "Neck"};
        medicRequired = QACEGVAR(medical_treatment,medicIV);
        treatmentTime = 6;
        items[] = {"kat_pressureBag"};
        condition = QUOTE(([ARR_3(_player,_patient,_bodyPart)] call FUNC(removeIV)) && !([ARR_2(_patient,_bodyPart)] call FUNC(removePressure)));  
        callbackSuccess = QFUNC(treatmentAdvanced_applyPressureBag);
    };
    class RemovePressureBag: BasicBandage {
        displayName = CSTRING(Remove_PressureBag);
        displayNameProgress = CSTRING(Removing_PressureBag);
        category = "advanced";
        allowedSelections[] = {"Chest", "LeftArm", "RightArm", "UpperLeftLeg", "UpperRightLeg", "UpperLeftArm", "UpperRightArm", "LeftLeg", "RightLeg", "Neck"};
        medicRequired = QACEGVAR(medical_treatment,medicIV);
        treatmentTime = 6;
        items[] = {};
        condition = QUOTE([ARR_2(_patient,_bodyPart)] call FUNC(removePressure));
        callbackSuccess = QFUNC(treatmentAdvanced_RemovePressureBag);
    };
    /*class Norepinephrine: EACA {
        displayName = CSTRING(Take_Norep);
        allowSelfTreatment = 1;
        medicRequired = QGVAR(medLvl_Norepinephrine);
        treatmentTime = QGVAR(treatmentTime_Norepinephrine);
        items[] = {"kat_norepinephrine"};
        callbackSuccess = QFUNC(medication);
        sounds[] = {};
    };
    class Phenylephrine: EACA {
        displayName = CSTRING(Take_Phenyl);
        displayNameProgress = CSTRING(Using);
        allowSelfTreatment = 1;
        medicRequired = QGVAR(medLvl_Phenylephrine);
        treatmentTime = QGVAR(treatmentTime_Phenylephrine);
        items[] = {"kat_phenylephrine"};
        callbackSuccess = QFUNC(medication);
        sounds[] = {};
    };*/
    class PhenylephrineAuto: Morphine {
        displayName = CSTRING(Take_Phenyl_Auto);
        displayNameProgress = CSTRING(Using);
        allowedSelections[] = {"LeftArm", "RightArm", "UpperLeftArm", "UpperRightArm", "UpperLeftLeg", "UpperRightLeg", "LeftLeg", "RightLeg"};
        allowSelfTreatment = 1;
        items[] = {"kat_phenylephrineAuto"};
        condition = "";
        medicRequired = QGVAR(medLvl_PhenylephrineAuto);
        treatmentTime = QGVAR(treatmentTime_PhenylephrineAuto);
        callbackSuccess = QFUNC(medication);
        sounds[] = {};
    };
    /*class Nitroglycerin: EACA {
        displayName = CSTRING(Take_Nitro);
        allowSelfTreatment = 1;
        medicRequired = QGVAR(medLvl_Nitroglicerin);
        treatmentTime = QGVAR(treatmentTime_Nitroglycerin);
        items[] = {"kat_nitroglycerin"};
        callbackSuccess = QFUNC(medication);
        sounds[] = {};
    };
    class Amiodarone: EACA {
        displayName = CSTRING(Take_Amiodarone);
        allowSelfTreatment = 1;
        medicRequired = QGVAR(medLvl_Amiodarone);
        treatmentTime = QGVAR(treatmentTime_Amiodarone);
        items[] = {"kat_amiodarone"};
        callbackSuccess = QFUNC(medication);
        sounds[] = {};
    };
    class Lidocaine: EACA {
        displayName = CSTRING(Take_Lidocaine);
        allowSelfTreatment = 1;
        medicRequired = QGVAR(medLvl_Lidocain);
        treatmentTime = QGVAR(treatmentTime_Lidocaine);
        items[] = {"kat_lidocaine"};
        callbackSuccess = QFUNC(medication);
        sounds[] = {};
    };*/
    class Atropine: Morphine {
        displayName = CSTRING(Take_Atropine);
        displayNameProgress = CSTRING(Using);
        allowedSelections[] = {"LeftArm", "RightArm", "UpperLeftArm", "UpperRightArm", "UpperLeftLeg", "UpperRightLeg", "LeftLeg", "RightLeg"};
        allowSelfTreatment = 1;
        medicRequired = QGVAR(medLvl_Atropine);
        treatmentTime = QGVAR(treatmentTime_Atropine);
        condition = "";
        items[] = {"kat_atropine"};
        callbackSuccess = QFUNC(medication);
        sounds[] = {};
    };
    /*class AtropineIV: EACA {
        displayName = CSTRING(Take_AtropineIV);
        allowSelfTreatment = 1;
        medicRequired = QGVAR(medLvl_AtropineIV);
        treatmentTime = QGVAR(treatmentTime_AtropineIV);
        items[] = {"kat_atropineIV"};
        callbackSuccess = QFUNC(medication);
        sounds[] = {};
    };
    class Ketamine: EACA {
        displayName = CSTRING(Take_Ketamine);
        allowSelfTreatment = 1;
        medicRequired = QGVAR(medLvl_Ketamine);
        treatmentTime = QGVAR(treatmentTime_Ketamine);
        items[] = {"kat_ketamine"};
        callbackSuccess = QFUNC(medication);
        sounds[] = {};
    };
    class Fentanyl: EACA {
        displayName = CSTRING(Take_Fentanyl);
        allowSelfTreatment = 1;
        medicRequired = QGVAR(medLvl_Fentanyl);
        treatmentTime = QGVAR(treatmentTime_Fentanyl);
        items[] = {"kat_fentanyl"};
        callbackSuccess = QFUNC(medication);
        sounds[] = {};
    };
    class Nalbuphine: EACA {
        displayName = CSTRING(Take_Nalbuphine);
        allowSelfTreatment = 1;
        medicRequired = QGVAR(medLvl_Nalbuphine);
        treatmentTime = QGVAR(treatmentTime_Nalbuphine);
        items[] = {"kat_nalbuphine"};
        callbackSuccess = QFUNC(medication);
        sounds[] = {};
    };
    class MorphineIV: EACA {
        displayName = CSTRING(Take_MorphineIV);
        allowSelfTreatment = 1;
        medicRequired = QGVAR(medLvl_MorphineIV);
        treatmentTime = QGVAR(treatmentTime_MorphineIV);
        items[] = {"kat_morphineIV"};
        callbackSuccess = QFUNC(medication);
        sounds[] = {};
    };
    class AdenosineIV: EACA {
        displayName = CSTRING(Take_AdenosineIV);
        allowSelfTreatment = 1;
        medicRequired = QGVAR(medLvl_AdenosineIV);
        treatmentTime = QGVAR(treatmentTime_AdenosineIV);
        items[] = {"kat_adenosineIV"};
        callbackSuccess = QFUNC(medication);
        sounds[] = {};
    };*/
    class Reorientation: Carbonate {
        displayName = CSTRING(Take_Reorient);
        displayNameProgress = CSTRING(Reorienting);
        allowedSelections[] = {"Head"};
        allowSelfTreatment = 0;
        medicRequired = QGVAR(medLvl_Reorientation);
        treatmentTime = QGVAR(treatmentTime_Reorientation);
        items[] = {};
        condition = QUOTE(!([_patient] call ace_common_fnc_isAwake) && GVAR(Reorientation_Enable));
        litter[] = {};
        callbackSuccess = QFUNC(treatmentAdvanced_Reorientation);
        animationMedic = "AinvPknlMstpSnonWnonDnon_medicUp4";
        animationMedicProne = "AinvPknlMstpSnonWnonDnon_medicUp4";
        sounds[] = {};
    };
    class ApplyIV: ApplyTourniquet {
        displayName = CSTRING(Apply_IV_16);
        displayNameProgress = CSTRING(Applying_IV);
        medicRequired = QGVAR(medLvl_ApplyIV);
        category = "advanced";
        allowedSelections[] = {"LeftArm", "RightArm", "UpperLeftLeg", "UpperRightLeg"};
        items[] = {"kat_IV_16"};
        condition = QUOTE(!([ARR_3(_player,_patient,_bodyPart)] call FUNC(removeIV)));
        treatmentTime = QGVAR(treatmentTime_ApplyIV);
        callbackSuccess = QUOTE([ARR_4(_player,_patient,_bodyPart,'kat_IV_16')] call FUNC(applyIV));
        litter[] = {};
        sounds[] = {};
    };
    class Apply14IV: ApplyIV {
        displayName = CSTRING(Apply_IV_14);
        displayNameProgress = CSTRING(Applying_IV);
        medicRequired = QGVAR(medLvl_Apply14IV);
        category = "advanced";
        allowedSelections[] = {"LeftArm", "RightArm", "UpperLeftLeg", "UpperRightLeg"};
        items[] = {"kat_IV_14"};
        condition = QUOTE(!([ARR_3(_player,_patient,_bodyPart)] call FUNC(removeIV)));
        treatmentTime = QGVAR(treatmentTime_ApplyIV);
        callbackSuccess = QUOTE([ARR_4(_player,_patient,_bodyPart,'kat_IV_14')] call FUNC(applyIV));
        litter[] = {};
        sounds[] = {};
    };
    class Apply20IV: ApplyIV {
        displayName = CSTRING(Apply_IV_20);
        displayNameProgress = CSTRING(Applying_IV);
        medicRequired = QGVAR(medLvl_Apply20IV);
        category = "advanced";
        allowedSelections[] = {"LeftArm", "RightArm", "UpperLeftLeg", "UpperRightLeg"};
        items[] = {"kat_IV_20"};
        condition = QUOTE(!([ARR_3(_player,_patient,_bodyPart)] call FUNC(removeIV)));
        treatmentTime = QGVAR(treatmentTime_ApplyIV);
        callbackSuccess = QUOTE([ARR_4(_player,_patient,_bodyPart,'kat_IV_20')] call FUNC(applyIV));
        litter[] = {};
        sounds[] = {};
    };
    class ApplyIO: ApplyIV {
        displayName = CSTRING(Apply_IO_45);
        displayNameProgress = CSTRING(Applying_IV);
        medicRequired = QGVAR(medLvl_ApplyIO);
        category = "advanced";
        allowedSelections[] = {"Chest"};
        items[] = {"kat_IO_FAST"};
        condition = QUOTE(!([ARR_3(_player,_patient,_bodyPart)] call FUNC(removeIV)));
        treatmentTime = QGVAR(treatmentTime_ApplyIO);
        callbackSuccess = QUOTE([ARR_2(_medic,_patient)] call EFUNC(airway,handleRecoveryPosition); [ARR_4(_player,_patient,_bodyPart,'kat_IO_FAST')] call FUNC(applyIV););
        litter[] = {};
        sounds[] = {};
    };
    class ApplyEZIO: ApplyIV {
        displayName = CSTRING(Apply_EZ_IO);
        displayNameProgress = CSTRING(Applying_IV);
        medicRequired = QGVAR(medLvl_ApplyEZIO);
        allowSelfTreatment = 0;
        category = "advanced";
        items[] = {"kat_EZ_IO"};
        allowedSelections[] = {"UpperLeftArm", "UpperRightArm", "LeftLeg", "RightLeg"};
        condition = QUOTE(!([ARR_3(_player,_patient,_bodyPart)] call FUNC(removeIV)));
        treatmentTime = QGVAR(treatmentTime_ApplyEZIO);
        callbackSuccess = QUOTE([ARR_4(_player,_patient,_bodyPart,'kat_EZ_IO')] call FUNC(applyIV));
        sounds[] = {};
    };
    class ApplyEJV: ApplyIV {
        displayName = CSTRING(Apply_EJV);
        displayNameProgress = CSTRING(Applying_EJV);
        medicRequired = QGVAR(medLvl_ApplyEJV);
        allowSelfTreatment = 0;
        category = "advanced";
        allowedSelections[] = {"Neck"};
        items[] = {"kat_EJV"};
        condition = QUOTE(!([ARR_3(_player,_patient,_bodyPart)] call FUNC(removeIV)));
        treatmentTime = QGVAR(treatmentTime_ApplyEJV);
        callbackSuccess = QUOTE([ARR_4(_player,_patient,_bodyPart,'kat_EJV')] call FUNC(applyIV));
        sounds[] = {};
    };
    class RemoveIV: ApplyTourniquet {
        displayName = CSTRING(Remove_IV);
        displayNameProgress = CSTRING(Removing_IV);
        category = "advanced";
        allowedSelections[] = {"Chest", "Neck", "LeftArm", "RightArm", "UpperLeftLeg", "UpperRightLeg", "UpperLeftArm", "UpperRightArm", "LeftLeg", "RightLeg"};
        treatmentTime = QGVAR(treatmentTime_ApplyIV);
        items[] = {};
        condition = QFUNC(removeIVCheck);
        callbackSuccess = QFUNC(retrieveIV);
        sounds[] = {};
    };
    /*class Etomidate: EACA {
        displayName = CSTRING(Etomidate_Use);
        category = "surgery";
        treatmentLocations = 0;
        allowSelfTreatment = 0;
        medicRequired = QGVAR(medLvl_Etomidate);
        treatmentTime = QGVAR(treatmentTime_Etomidate);
        items[] = {"kat_etomidate"};
        callbackSuccess = QFUNC(medication);
        sounds[] = {};
    };
    class Lorazepam: EACA {
        displayName = CSTRING(Lorazepam_Use);
        category = "surgery";
        treatmentLocations = 0;
        allowSelfTreatment = 0;
        medicRequired = QGVAR(medLvl_Lorazepam);
        treatmentTime = QGVAR(treatmentTime_Lorazepam);
        items[] = {"kat_lorazepam"};
        callbackSuccess = QFUNC(medication);
        sounds[] = {};
    };
    class Flumazenil: EACA {
        displayName = CSTRING(Flumazenil_Use);
        category = "surgery";
        treatmentLocations = 0;
        allowSelfTreatment = 0;
        medicRequired = QGVAR(medLvl_Flumezenil);
        treatmentTime = QGVAR(treatmentTime_Flumazenil);
        items[] = {"kat_flumazenil"};
        callbackSuccess = QFUNC(medication);
        sounds[] = {};
    };
    class EpinephrineIV: EACA {
        displayName = CSTRING(Take_Epi);
        displayNameProgress = CSTRING(Using);
        allowSelfTreatment = 1;
        medicRequired = QGVAR(medLvl_EpinephrineIV);
        treatmentTime = QGVAR(treatmentTime_EpinephrineIV);
        items[] = {"kat_epinephrineIV"};
        callbackSuccess = QFUNC(medication);
        sounds[] = {};
    };*/
    class Dialysis: BasicBandage {
        displayName = CSTRING(Dialysis_DisplayName);
        displayNameProgress = CSTRING(Dialysis_DisplayNameProgress);
        icon = QPATHTOEF(circulation,ui\icon_aedx.paa);
        category = "surgery";
        consumeItem = 0;
        items[] = {};
        medicRequired = 1;
        condition = QFUNC(vehicleCheckDialysis);
        treatmentTime = 15;
        callbackProgress = "";
        callbackStart = "";
        callbackFailure = "";
        callbackSuccess = QUOTE([ARR_2(_medic,_patient)] call FUNC(treatmentAdvanced_Dialysis));
        litter[] = {};
    };
    class CheckCoag: CheckPulse {
        displayName = CSTRING(CheckCoag_DisplayName);
        displayNameProgress = CSTRING(CheckCoag_DisplayNameProgress);
        allowedSelections[] = {"LeftArm", "RightArm", "UpperLeftLeg", "UpperRightLeg"};
        treatmentLocations = QGVAR(CheckCoag_Location);
        medicRequired = QGVAR(CheckCoag_MedLevel);
        treatmentTime = QGVAR(CheckCoag_TreatmentTime);
        category = "examine";
        consumeItem = 0;
        items[] = {"kat_coag_sense"};
        condition = QFUNC(removeIVCheck);
        callbackProgress = "";
        callbackStart = "";
        callbackFailure = "";
        callbackSuccess = QFUNC(treatmentAdvanced_CheckCoag);
        litter[] = {};
    };
    class syringe_EACA_5ml_10: Carbonate {
        displayName = KATPUSHCSTRING(eaca,5ml,10);
        displayNameProgress = KATPUSHINGCSTRING(eaca,5ml,10);
        allowedSelections[] = {"Neck", "Chest", "LeftArm", "RightArm", "UpperLeftArm", "UpperRightArm", "UpperLeftLeg", "UpperRightLeg", "LeftLeg", "RightLeg"};
        allowSelfTreatment = 1;
        medicRequired = QGVAR(medLvl_EACA);
        treatmentTime = QGVAR(treatmentTime_IV);
        items[] = {"kat_syringe_eaca_5ml_10"};
        condition = QUOTE(FUNC(ivCondition));
        callbackSuccess = QFUNC(medication);
        removeFromInteractions = "true";
        sounds[] = {};
    };
    class syringe_EACA_5ml_20: syringe_EACA_5ml_10 {
        displayName = KATPUSHCSTRING(eaca,5ml,20);
        displayNameProgress = KATPUSHINGCSTRING(eaca,5ml,20);
        items[] = {"kat_syringe_eaca_5ml_20"};
    };
    class syringe_TXA_10ml_10: Carbonate {
        displayName = KATPUSHCSTRING(txa,10ml,10);
        displayNameProgress = KATPUSHINGCSTRING(txa,10ml,10);
        allowedSelections[] = {"LeftArm", "RightArm", "UpperLeftArm", "UpperRightArm", "UpperLeftLeg", "UpperRightLeg", "LeftLeg", "RightLeg"};
        allowSelfTreatment = 1;
        medicRequired = QGVAR(medLvl_TXAIM);
        treatmentTime = QGVAR(treatmentTime_IM);
        items[] = {"kat_syringe_txa_10ml_10"};
        callbackSuccess = QFUNC(medication);
        removeFromInteractions = "true";
        sounds[] = {};
    };
    class syringe_TXA_10ml_20: syringe_TXA_10ml_10 {
        displayName = KATPUSHCSTRING(txa,10ml,20);
        displayNameProgress = KATPUSHINGCSTRING(txa,10ml,20);
        items[] = {"kat_syringe_txa_10ml_20"};
    };
    class syringe_TXA_5ml_10: syringe_EACA_5ml_10 {
        displayName = KATPUSHCSTRING(txa,5ml,10);
        displayNameProgress = KATPUSHINGCSTRING(txa,5ml,10);
        medicRequired = QGVAR(medLvl_TXA);
        items[] = {"kat_syringe_txa_5ml_10"};
    };
    class syringe_TXA_5ml_20: syringe_TXA_5ml_10 {
        displayName = KATPUSHCSTRING(txa,5ml,20);
        displayNameProgress = KATPUSHINGCSTRING(txa,5ml,20);
        items[] = {"kat_syringe_txa_5ml_20"};
    };
    class syringe_AdenosineIV_5ml_10: syringe_EACA_5ml_10 {
        medicRequired = QGVAR(medLvl_adenosineIV);
        items[] = {"kat_syringe_adenosineIV_5ml_10"};
        displayName = KATPUSHCSTRING(adenosineIV,5ml,10);
        displayNameProgress = KATPUSHINGCSTRING(adenosineIV,5ml,10);
    };
    class syringe_AdenosineIV_5ml_20: syringe_AdenosineIV_5ml_10 {
        items[] = {"kat_syringe_adenosineIV_5ml_20"};
        displayName = KATPUSHCSTRING(adenosineIV,5ml,20);
        displayNameProgress = KATPUSHINGCSTRING(adenosineIV,5ml,20);
    };
    class syringe_AdenosineIV_5ml_30: syringe_AdenosineIV_5ml_10 {
        items[] = {"kat_syringe_adenosineIV_5ml_30"};
        displayName = KATPUSHCSTRING(adenosineIV,5ml,30);
        displayNameProgress = KATPUSHINGCSTRING(adenosineIV,5ml,30);
    };
    class syringe_Alteplase_5ml_30: syringe_EACA_5ml_10 {
        medicRequired = QGVAR(medLvl_alteplase);
        items[] = {"kat_syringe_alteplase_5ml_30"};
        displayName = KATPUSHCSTRING(alteplase,5ml,30);
        displayNameProgress = KATPUSHINGCSTRING(alteplase,5ml,30);
    };
    class syringe_Amiodarone_5ml_10: syringe_EACA_5ml_10 {
        medicRequired = QGVAR(medLvl_amiodarone);
        items[] = {"kat_syringe_amiodarone_5ml_10"};
        displayName = KATPUSHCSTRING(amiodarone,5ml,10);
        displayNameProgress = KATPUSHINGCSTRING(amiodarone,5ml,10);
    };
    class syringe_Amiodarone_5ml_20: syringe_Amiodarone_5ml_10 {
        items[] = {"kat_syringe_amiodarone_5ml_20"};
        displayName = KATPUSHCSTRING(amiodarone,5ml,20);
        displayNameProgress = KATPUSHINGCSTRING(amiodarone,5ml,20);
    };
    class syringe_Amiodarone_5ml_30: syringe_Amiodarone_5ml_10 {
        items[] = {"kat_syringe_amiodarone_5ml_30"};
        displayName = KATPUSHCSTRING(amiodarone,5ml,30);
        displayNameProgress = KATPUSHINGCSTRING(amiodarone,5ml,30);
    };
    class syringe_AtropineIV_5ml_10: syringe_EACA_5ml_10 {
        medicRequired = QGVAR(medLvl_AtropineIV);
        items[] = {"kat_syringe_atropineIV_5ml_10"};
        displayName = KATPUSHCSTRING(atropineIV,5ml,10);
        displayNameProgress = KATPUSHINGCSTRING(atropineIV,5ml,10);
    };
    class syringe_AtropineIV_5ml_30: syringe_AtropineIV_5ml_10 {
        items[] = {"kat_syringe_atropineIV_5ml_30"};
        displayName = KATPUSHCSTRING(atropineIV,5ml,30);
        displayNameProgress = KATPUSHINGCSTRING(atropineIV,5ml,30);
    };
    class syringe_Doxapram_5ml_10: syringe_EACA_5ml_10 {
        medicRequired = QGVAR(medLvl_doxapram);
        items[] = {"kat_syringe_doxapram_5ml_10"};
        displayName = KATPUSHCSTRING(doxapram,5ml,10);
        displayNameProgress = KATPUSHINGCSTRING(doxapram,5ml,10);
    };
    class syringe_Doxapram_5ml_20: syringe_Doxapram_5ml_10 {
        items[] = {"kat_syringe_doxapram_5ml_20"};
        displayName = KATPUSHCSTRING(doxapram,5ml,20);
        displayNameProgress = KATPUSHINGCSTRING(doxapram,5ml,20);
    };
    class syringe_Doxapram_5ml_30: syringe_Doxapram_5ml_10 {
        items[] = {"kat_syringe_doxapram_5ml_30"};
        displayName = KATPUSHCSTRING(doxapram,5ml,30);
        displayNameProgress = KATPUSHINGCSTRING(doxapram,5ml,30);
    };
    class syringe_EpinephrineIV_5ml_10: syringe_EACA_5ml_10 {
        medicRequired = QGVAR(medLvl_EpinephrineIV);
        items[] = {"kat_syringe_epinephrineIV_5ml_10"};
        displayName = KATPUSHCSTRING(epinephrineIV,5ml,10);
        displayNameProgress = KATPUSHINGCSTRING(epinephrineIV,5ml,10);
    };
    class syringe_EpinephrineIV_5ml_20: syringe_EpinephrineIV_5ml_10 {
        items[] = {"kat_syringe_epinephrineIV_5ml_20"};
        displayName = KATPUSHCSTRING(epinephrineIV,5ml,20);
        displayNameProgress = KATPUSHINGCSTRING(epinephrineIV,5ml,20);
    };
    class syringe_Etomidate_5ml_10: syringe_EACA_5ml_10 {
        category = "surgery";
        medicRequired = QGVAR(medLvl_etomidate);
        items[] = {"kat_syringe_etomidate_5ml_10"};
        displayName = KATPUSHCSTRING(etomidate,5ml,10);
        displayNameProgress = KATPUSHINGCSTRING(etomidate,5ml,10);
    };
    class syringe_Etomidate_5ml_14: syringe_Etomidate_5ml_10 {
        items[] = {"kat_syringe_etomidate_5ml_14"};
        displayName = KATPUSHCSTRING(etomidate,5ml,14);
        displayNameProgress = KATPUSHINGCSTRING(etomidate,5ml,14);
    };
    class syringe_Etomidate_5ml_16: syringe_Etomidate_5ml_10 {
        items[] = {"kat_syringe_etomidate_5ml_16"};
        displayName = KATPUSHCSTRING(etomidate,5ml,16);
        displayNameProgress = KATPUSHINGCSTRING(etomidate,5ml,16);
    };
    class syringe_Etomidate_5ml_18: syringe_Etomidate_5ml_10 {
        items[] = {"kat_syringe_etomidate_5ml_18"};
        displayName = KATPUSHCSTRING(etomidate,5ml,18);
        displayNameProgress = KATPUSHINGCSTRING(etomidate,5ml,18);
    };
    class syringe_Etomidate_5ml_20: syringe_Etomidate_5ml_10 {
        items[] = {"kat_syringe_etomidate_5ml_20"};
        displayName = KATPUSHCSTRING(etomidate,5ml,20);
        displayNameProgress = KATPUSHINGCSTRING(etomidate,5ml,20);
    };
    class syringe_Etomidate_5ml_22: syringe_Etomidate_5ml_10 {
        items[] = {"kat_syringe_etomidate_5ml_22"};
        displayName = KATPUSHCSTRING(etomidate,5ml,22);
        displayNameProgress = KATPUSHINGCSTRING(etomidate,5ml,22);
    };
    class syringe_Etomidate_5ml_24: syringe_Etomidate_5ml_10 {
        items[] = {"kat_syringe_etomidate_5ml_24"};
        displayName = KATPUSHCSTRING(etomidate,5ml,24);
        displayNameProgress = KATPUSHINGCSTRING(etomidate,5ml,24);
    };
    class syringe_Etomidate_5ml_26: syringe_Etomidate_5ml_10 {
        items[] = {"kat_syringe_etomidate_5ml_26"};
        displayName = KATPUSHCSTRING(etomidate,5ml,26);
        displayNameProgress = KATPUSHINGCSTRING(etomidate,5ml,26);
    };
    class syringe_Etomidate_5ml_28: syringe_Etomidate_5ml_10 {
        items[] = {"kat_syringe_etomidate_5ml_28"};
        displayName = KATPUSHCSTRING(etomidate,5ml,28);
        displayNameProgress = KATPUSHINGCSTRING(etomidate,5ml,28);
    };
    class syringe_Etomidate_5ml_30: syringe_Etomidate_5ml_10 {
        items[] = {"kat_syringe_etomidate_5ml_30"};
        displayName = KATPUSHCSTRING(etomidate,5ml,30);
        displayNameProgress = KATPUSHINGCSTRING(etomidate,5ml,30);
    };
    class syringe_Fentanyl_5ml_10: syringe_EACA_5ml_10 {
        medicRequired = QGVAR(medLvl_fentanyl);
        items[] = {"kat_syringe_fentanyl_5ml_10"};
        displayName = KATPUSHCSTRING(fentanyl,5ml,10);
        displayNameProgress = KATPUSHINGCSTRING(fentanyl,5ml,10);
    };
    class syringe_Fentanyl_5ml_12: syringe_Fentanyl_5ml_10 {
        items[] = {"kat_syringe_fentanyl_5ml_12"};
        displayName = KATPUSHCSTRING(fentanyl,5ml,12);
        displayNameProgress = KATPUSHINGCSTRING(fentanyl,5ml,12);
    };
    class syringe_Fentanyl_5ml_14: syringe_Fentanyl_5ml_10 {
        items[] = {"kat_syringe_fentanyl_5ml_14"};
        displayName = KATPUSHCSTRING(fentanyl,5ml,14);
        displayNameProgress = KATPUSHINGCSTRING(fentanyl,5ml,14);
    };
    class syringe_Fentanyl_5ml_16: syringe_Fentanyl_5ml_10 {
        items[] = {"kat_syringe_fentanyl_5ml_16"};
        displayName = KATPUSHCSTRING(fentanyl,5ml,16);
        displayNameProgress = KATPUSHINGCSTRING(fentanyl,5ml,16);
    };
    class syringe_Fentanyl_5ml_18: syringe_Fentanyl_5ml_10 {
        items[] = {"kat_syringe_fentanyl_5ml_18"};
        displayName = KATPUSHCSTRING(fentanyl,5ml,18);
        displayNameProgress = KATPUSHINGCSTRING(fentanyl,5ml,18);
    };
    class syringe_Fentanyl_5ml_20: syringe_Fentanyl_5ml_10 {
        items[] = {"kat_syringe_fentanyl_5ml_20"};
        displayName = KATPUSHCSTRING(fentanyl,5ml,20);
        displayNameProgress = KATPUSHINGCSTRING(fentanyl,5ml,20);
    };
    class syringe_Fentanyl_5ml_22: syringe_Fentanyl_5ml_10 {
        items[] = {"kat_syringe_fentanyl_5ml_22"};
        displayName = KATPUSHCSTRING(fentanyl,5ml,22);
        displayNameProgress = KATPUSHINGCSTRING(fentanyl,5ml,22);
    };
    class syringe_Fentanyl_5ml_24: syringe_Fentanyl_5ml_10 {
        items[] = {"kat_syringe_fentanyl_5ml_24"};
        displayName = KATPUSHCSTRING(fentanyl,5ml,24);
        displayNameProgress = KATPUSHINGCSTRING(fentanyl,5ml,24);
    };
    class syringe_Fentanyl_5ml_26: syringe_Fentanyl_5ml_10 {
        items[] = {"kat_syringe_fentanyl_5ml_26"};
        displayName = KATPUSHCSTRING(fentanyl,5ml,26);
        displayNameProgress = KATPUSHINGCSTRING(fentanyl,5ml,26);
    };
    class syringe_Fentanyl_5ml_28: syringe_Fentanyl_5ml_10 {
        items[] = {"kat_syringe_fentanyl_5ml_28"};
        displayName = KATPUSHCSTRING(fentanyl,5ml,28);
        displayNameProgress = KATPUSHINGCSTRING(fentanyl,5ml,28);
    };
    class syringe_Fentanyl_5ml_30: syringe_Fentanyl_5ml_10 {
        items[] = {"kat_syringe_fentanyl_5ml_30"};
        displayName = KATPUSHCSTRING(fentanyl,5ml,30);
        displayNameProgress = KATPUSHINGCSTRING(fentanyl,5ml,30);
    };
    class syringe_Fentanyl_10ml_10: syringe_TXA_10ml_10 {
        medicRequired = QGVAR(medLvl_fentanylIM);
        items[] = {"kat_syringe_fentanyl_10ml_10"};
        displayName = KATPUSHCSTRING(fentanyl,10ml,10);
        displayNameProgress = KATPUSHINGCSTRING(fentanyl,10ml,10);
    };
    class syringe_Fentanyl_10ml_12: syringe_Fentanyl_10ml_10 {
        items[] = {"kat_syringe_fentanyl_10ml_12"};
        displayName = KATPUSHCSTRING(fentanyl,10ml,12);
        displayNameProgress = KATPUSHINGCSTRING(fentanyl,10ml,12);
    };
    class syringe_Fentanyl_10ml_14: syringe_Fentanyl_10ml_10 {
        items[] = {"kat_syringe_fentanyl_10ml_14"};
        displayName = KATPUSHCSTRING(fentanyl,10ml,14);
        displayNameProgress = KATPUSHINGCSTRING(fentanyl,10ml,14);
    };
    class syringe_Fentanyl_10ml_16: syringe_Fentanyl_10ml_10 {
        items[] = {"kat_syringe_fentanyl_10ml_16"};
        displayName = KATPUSHCSTRING(fentanyl,10ml,16);
        displayNameProgress = KATPUSHINGCSTRING(fentanyl,10ml,16);
    };
    class syringe_Fentanyl_10ml_18: syringe_Fentanyl_10ml_10 {
        items[] = {"kat_syringe_fentanyl_10ml_18"};
        displayName = KATPUSHCSTRING(fentanyl,10ml,18);
        displayNameProgress = KATPUSHINGCSTRING(fentanyl,10ml,18);
    };
    class syringe_Fentanyl_10ml_20: syringe_Fentanyl_10ml_10 {
        items[] = {"kat_syringe_fentanyl_10ml_20"};
        displayName = KATPUSHCSTRING(fentanyl,10ml,20);
        displayNameProgress = KATPUSHINGCSTRING(fentanyl,10ml,20);
    };
    class syringe_Fentanyl_10ml_22: syringe_Fentanyl_10ml_10 {
        items[] = {"kat_syringe_fentanyl_10ml_22"};
        displayName = KATPUSHCSTRING(fentanyl,10ml,22);
        displayNameProgress = KATPUSHINGCSTRING(fentanyl,10ml,22);
    };
    class syringe_Fentanyl_10ml_24: syringe_Fentanyl_10ml_10 {
        items[] = {"kat_syringe_fentanyl_10ml_24"};
        displayName = KATPUSHCSTRING(fentanyl,10ml,24);
        displayNameProgress = KATPUSHINGCSTRING(fentanyl,10ml,24);
    };
    class syringe_Fentanyl_10ml_26: syringe_Fentanyl_10ml_10 {
        items[] = {"kat_syringe_fentanyl_10ml_26"};
        displayName = KATPUSHCSTRING(fentanyl,10ml,26);
        displayNameProgress = KATPUSHINGCSTRING(fentanyl,10ml,26);
    };
    class syringe_Fentanyl_10ml_28: syringe_Fentanyl_10ml_10 {
        items[] = {"kat_syringe_fentanyl_10ml_28"};
        displayName = KATPUSHCSTRING(fentanyl,10ml,28);
        displayNameProgress = KATPUSHINGCSTRING(fentanyl,10ml,28);
    };
    class syringe_Fentanyl_10ml_30: syringe_Fentanyl_10ml_10 {
        items[] = {"kat_syringe_fentanyl_10ml_30"};
        displayName = KATPUSHCSTRING(fentanyl,10ml,30);
        displayNameProgress = KATPUSHINGCSTRING(fentanyl,10ml,30);
    };
     class syringe_Flumazenil_5ml_10: syringe_EACA_5ml_10 {
        category = "surgery";
        medicRequired = QGVAR(medLvl_flumazenil);
        items[] = {"kat_syringe_flumazenil_5ml_10"};
        displayName = KATPUSHCSTRING(flumazenil,5ml,10);
        displayNameProgress = KATPUSHINGCSTRING(flumazenil,5ml,10);
    };
    class syringe_Flumazenil_5ml_20: syringe_Flumazenil_5ml_10 {
        items[] = {"kat_syringe_flumazenil_5ml_20"};
        displayName = KATPUSHCSTRING(flumazenil,5ml,20);
        displayNameProgress = KATPUSHINGCSTRING(flumazenil,5ml,20);
    };
    class syringe_Flumazenil_5ml_30: syringe_Flumazenil_5ml_10 {
        items[] = {"kat_syringe_flumazenil_5ml_30"};
        displayName = KATPUSHCSTRING(flumazenil,5ml,30);
        displayNameProgress = KATPUSHINGCSTRING(flumazenil,5ml,30);
    };
    class syringe_Ketamine_5ml_10: syringe_EACA_5ml_10 {
        medicRequired = QGVAR(medLvl_ketamine);
        items[] = {"kat_syringe_ketamine_5ml_10"};
        displayName = KATPUSHCSTRING(ketamine,5ml,16);
        displayNameProgress = KATPUSHINGCSTRING(ketamine,5ml,16);
    };
    class syringe_Ketamine_5ml_12: syringe_Ketamine_5ml_10 {
        items[] = {"kat_syringe_ketamine_5ml_12"};
        displayName = KATPUSHCSTRING(ketamine,5ml,12);
        displayNameProgress = KATPUSHINGCSTRING(ketamine,5ml,12);
    };
    class syringe_Ketamine_5ml_14: syringe_Ketamine_5ml_10 {
        items[] = {"kat_syringe_ketamine_5ml_14"};
        displayName = KATPUSHCSTRING(ketamine,5ml,14);
        displayNameProgress = KATPUSHINGCSTRING(ketamine,5ml,14);
    };
    class syringe_Ketamine_5ml_16: syringe_Ketamine_5ml_10 {
        items[] = {"kat_syringe_ketamine_5ml_16"};
        displayName = KATPUSHCSTRING(ketamine,5ml,16);
        displayNameProgress = KATPUSHINGCSTRING(ketamine,5ml,16);
    };
    class syringe_Ketamine_5ml_18: syringe_Ketamine_5ml_10 {
        items[] = {"kat_syringe_ketamine_5ml_18"};
        displayName = KATPUSHCSTRING(ketamine,5ml,18);
        displayNameProgress = KATPUSHINGCSTRING(ketamine,5ml,18);
    };
    class syringe_Ketamine_5ml_20: syringe_Ketamine_5ml_10 {
        items[] = {"kat_syringe_ketamine_5ml_20"};
        displayName = KATPUSHCSTRING(ketamine,5ml,20);
        displayNameProgress = KATPUSHINGCSTRING(ketamine,5ml,20);
    };
    class syringe_Ketamine_5ml_22: syringe_Ketamine_5ml_10 {
        items[] = {"kat_syringe_ketamine_5ml_22"};
        displayName = KATPUSHCSTRING(ketamine,5ml,22);
        displayNameProgress = KATPUSHINGCSTRING(ketamine,5ml,22);
    };
    class syringe_Ketamine_5ml_24: syringe_Ketamine_5ml_10 {
        items[] = {"kat_syringe_ketamine_5ml_24"};
        displayName = KATPUSHCSTRING(ketamine,5ml,24);
        displayNameProgress = KATPUSHINGCSTRING(ketamine,5ml,24);
    };
    class syringe_Ketamine_5ml_26: syringe_Ketamine_5ml_10 {
        items[] = {"kat_syringe_ketamine_5ml_26"};
        displayName = KATPUSHCSTRING(ketamine,5ml,26);
        displayNameProgress = KATPUSHINGCSTRING(ketamine,5ml,26);
    };
    class syringe_Ketamine_5ml_28: syringe_Ketamine_5ml_10 {
        items[] = {"kat_syringe_ketamine_5ml_28"};
        displayName = KATPUSHCSTRING(ketamine,5ml,28);
        displayNameProgress = KATPUSHINGCSTRING(ketamine,5ml,28);
    };
    class syringe_Ketamine_5ml_30: syringe_Ketamine_5ml_10 {
        items[] = {"kat_syringe_ketamine_5ml_30"};
        displayName = KATPUSHCSTRING(ketamine,5ml,30);
        displayNameProgress = KATPUSHINGCSTRING(ketamine,5ml,30);
    };
    class syringe_Ketamine_10ml_10: syringe_TXA_10ml_10 {
        medicRequired = QGVAR(medLvl_ketamineIM);
        items[] = {"kat_syringe_ketamine_10ml_10"};
        displayName = KATPUSHCSTRING(ketamine,10ml,10);
        displayNameProgress = KATPUSHINGCSTRING(ketamine,10ml,10);
    };
    class syringe_Ketamine_10ml_12: syringe_Ketamine_10ml_10 {
        items[] = {"kat_syringe_ketamine_10ml_12"};
        displayName = KATPUSHCSTRING(ketamine,10ml,12);
        displayNameProgress = KATPUSHINGCSTRING(ketamine,10ml,12);
    };
    class syringe_Ketamine_10ml_14: syringe_Ketamine_10ml_10 {
        items[] = {"kat_syringe_ketamine_10ml_14"};
        displayName = KATPUSHCSTRING(ketamine,10ml,14);
        displayNameProgress = KATPUSHINGCSTRING(ketamine,10ml,14);
    };
    class syringe_Ketamine_10ml_16: syringe_Ketamine_10ml_10 {
        items[] = {"kat_syringe_ketamine_10ml_16"};
        displayName = KATPUSHCSTRING(ketamine,10ml,16);
        displayNameProgress = KATPUSHINGCSTRING(ketamine,10ml,16);
    };
    class syringe_Ketamine_10ml_18: syringe_Ketamine_10ml_10 {
        items[] = {"kat_syringe_ketamine_10ml_18"};
        displayName = KATPUSHCSTRING(ketamine,10ml,18);
        displayNameProgress = KATPUSHINGCSTRING(ketamine,10ml,18);
    };
    class syringe_Ketamine_10ml_20: syringe_Ketamine_10ml_10 {
        items[] = {"kat_syringe_ketamine_10ml_20"};
        displayName = KATPUSHCSTRING(ketamine,10ml,20);
        displayNameProgress = KATPUSHINGCSTRING(ketamine,10ml,20);
    };
    class syringe_Ketamine_10ml_22: syringe_Ketamine_10ml_10 {
        items[] = {"kat_syringe_ketamine_10ml_22"};
        displayName = KATPUSHCSTRING(ketamine,10ml,22);
        displayNameProgress = KATPUSHINGCSTRING(ketamine,10ml,22);
    };
    class syringe_Ketamine_10ml_24: syringe_Ketamine_10ml_10 {
        items[] = {"kat_syringe_ketamine_10ml_24"};
        displayName = KATPUSHCSTRING(ketamine,10ml,24);
        displayNameProgress = KATPUSHINGCSTRING(ketamine,10ml,24);
    };
    class syringe_Ketamine_10ml_26: syringe_Ketamine_10ml_10 {
        items[] = {"kat_syringe_ketamine_10ml_26"};
        displayName = KATPUSHCSTRING(ketamine,10ml,26);
        displayNameProgress = KATPUSHINGCSTRING(ketamine,10ml,26);
    };
    class syringe_Ketamine_10ml_28: syringe_Ketamine_10ml_10 {
        items[] = {"kat_syringe_ketamine_10ml_28"};
        displayName = KATPUSHCSTRING(ketamine,10ml,28);
        displayNameProgress = KATPUSHINGCSTRING(ketamine,10ml,28);
    };
    class syringe_Ketamine_10ml_30: syringe_Ketamine_10ml_10 {
        items[] = {"kat_syringe_ketamine_10ml_30"};
        displayName = KATPUSHCSTRING(ketamine,10ml,30);
        displayNameProgress = KATPUSHINGCSTRING(ketamine,10ml,30);
    };
    class syringe_Lidocaine_5ml_10: syringe_EACA_5ml_10 {
        medicRequired = QGVAR(medLvl_lidocaine);
        items[] = {"kat_syringe_lidocaine_5ml_10"};
        displayName = KATPUSHCSTRING(lidocaine,5ml,10);
        displayNameProgress = KATPUSHINGCSTRING(lidocaine,5ml,10);
    };
    class syringe_Lidocaine_5ml_12: syringe_Lidocaine_5ml_10 {
        items[] = {"kat_syringe_lidocaine_5ml_12"};
        displayName = KATPUSHCSTRING(lidocaine,5ml,12);
        displayNameProgress = KATPUSHINGCSTRING(lidocaine,5ml,12);
    };
    class syringe_Lidocaine_5ml_20: syringe_Lidocaine_5ml_10 {
        items[] = {"kat_syringe_lidocaine_5ml_20"};
        displayName = KATPUSHCSTRING(lidocaine,5ml,20);
        displayNameProgress = KATPUSHINGCSTRING(lidocaine,5ml,20);
    };
    class syringe_Lidocaine_5ml_30: syringe_Lidocaine_5ml_10 {
        items[] = {"kat_syringe_lidocaine_5ml_30"};
        displayName = KATPUSHCSTRING(lidocaine,5ml,30);
        displayNameProgress = KATPUSHINGCSTRING(lidocaine,5ml,30);
    };
    class syringe_Lidocaine_10ml_10: syringe_TXA_10ml_10 {
        allowedSelections[] = {"Chest", "Body", "LeftArm", "RightArm", "UpperLeftArm", "UpperRightArm", "UpperLeftLeg", "UpperRightLeg", "LeftLeg", "RightLeg"};
        medicRequired = QGVAR(medLvl_lidocaineIM);
        items[] = {"kat_syringe_lidocaine_10ml_10"};
        displayName = KATPUSHCSTRING(lidocaine,10ml,10);
        displayNameProgress = KATPUSHINGCSTRING(lidocaine,10ml,10);
    };
     class syringe_Lorazepam_5ml_10: syringe_EACA_5ml_10 {
        category = "surgery";
        medicRequired = QGVAR(medLvl_lorazepam);
        items[] = {"kat_syringe_lorazepam_5ml_10"};
        displayName = KATPUSHCSTRING(lorazepam,5ml,10);
        displayNameProgress = KATPUSHINGCSTRING(lorazepam,5ml,10);
    };
    class syringe_Lorazepam_5ml_12: syringe_Lorazepam_5ml_10 {
        items[] = {"kat_syringe_lorazepam_5ml_12"};
        displayName = KATPUSHCSTRING(lorazepam,5ml,12);
        displayNameProgress = KATPUSHINGCSTRING(lorazepam,5ml,12);
    };
    class syringe_Lorazepam_5ml_14: syringe_Lorazepam_5ml_10 {
        items[] = {"kat_syringe_lorazepam_5ml_14"};
        displayName = KATPUSHCSTRING(lorazepam,5ml,14);
        displayNameProgress = KATPUSHINGCSTRING(lorazepam,5ml,14);
    };
    class syringe_Lorazepam_5ml_16: syringe_Lorazepam_5ml_10 {
        items[] = {"kat_syringe_lorazepam_5ml_16"};
        displayName = KATPUSHCSTRING(lorazepam,5ml,16);
        displayNameProgress = KATPUSHINGCSTRING(lorazepam,5ml,16);
    };
    class syringe_Lorazepam_5ml_18: syringe_Lorazepam_5ml_10 {
        items[] = {"kat_syringe_lorazepam_5ml_18"};
        displayName = KATPUSHCSTRING(lorazepam,5ml,18);
        displayNameProgress = KATPUSHINGCSTRING(lorazepam,5ml,18);
    };
    class syringe_Lorazepam_5ml_20: syringe_Lorazepam_5ml_10 {
        items[] = {"kat_syringe_lorazepam_5ml_20"};
        displayName = KATPUSHCSTRING(lorazepam,5ml,20);
        displayNameProgress = KATPUSHINGCSTRING(lorazepam,5ml,20);
    };
    class syringe_Lorazepam_5ml_22: syringe_Lorazepam_5ml_10 {
        items[] = {"kat_syringe_lorazepam_5ml_22"};
        displayName = KATPUSHCSTRING(lorazepam,5ml,22);
        displayNameProgress = KATPUSHINGCSTRING(lorazepam,5ml,22);
    };
    class syringe_Lorazepam_5ml_24: syringe_Lorazepam_5ml_10 {
        items[] = {"kat_syringe_lorazepam_5ml_24"};
        displayName = KATPUSHCSTRING(lorazepam,5ml,24);
        displayNameProgress = KATPUSHINGCSTRING(lorazepam,5ml,24);
    };
    class syringe_Lorazepam_5ml_26: syringe_Lorazepam_5ml_10 {
        items[] = {"kat_syringe_lorazepam_5ml_26"};
        displayName = KATPUSHCSTRING(lorazepam,5ml,26);
        displayNameProgress = KATPUSHINGCSTRING(lorazepam,5ml,26);
    };
    class syringe_Lorazepam_5ml_28: syringe_Lorazepam_5ml_10 {
        items[] = {"kat_syringe_lorazepam_5ml_28"};
        displayName = KATPUSHCSTRING(lorazepam,5ml,28);
        displayNameProgress = KATPUSHINGCSTRING(lorazepam,5ml,28);
    };
    class syringe_Lorazepam_5ml_30: syringe_Lorazepam_5ml_10 {
        items[] = {"kat_syringe_lorazepam_5ml_30"};
        displayName = KATPUSHCSTRING(lorazepam,5ml,30);
        displayNameProgress = KATPUSHINGCSTRING(lorazepam,5ml,30);
    };
    
    class syringe_MorphineIV_5ml_10: syringe_EACA_5ml_10 {
        medicRequired = QGVAR(medLvl_morphineIV);
        items[] = {"kat_syringe_morphineIV_5ml_10"};
        displayName = KATPUSHCSTRING(morphineIV,5ml,10);
        displayNameProgress = KATPUSHINGCSTRING(morphineIV,5ml,10);
    };
    class syringe_MorphineIV_5ml_16: syringe_MorphineIV_5ml_10 {
        items[] = {"kat_syringe_morphineIV_5ml_16"};
        displayName = KATPUSHCSTRING(morphineIV,5ml,16);
        displayNameProgress = KATPUSHINGCSTRING(morphineIV,5ml,16);
    };
    class syringe_MorphineIV_5ml_20: syringe_MorphineIV_5ml_10 {
        items[] = {"kat_syringe_morphineIV_5ml_20"};
        displayName = KATPUSHCSTRING(morphineIV,5ml,20);
        displayNameProgress = KATPUSHINGCSTRING(morphineIV,5ml,20);
    };
    class syringe_MorphineIV_5ml_26: syringe_MorphineIV_5ml_10 {
        items[] = {"kat_syringe_morphineIV_5ml_26"};
        displayName = KATPUSHCSTRING(morphineIV,5ml,26);
        displayNameProgress = KATPUSHINGCSTRING(morphineIV,5ml,26);
    };
    class syringe_MorphineIV_5ml_30: syringe_MorphineIV_5ml_10 {
        items[] = {"kat_syringe_morphineIV_5ml_30"};
        displayName = KATPUSHCSTRING(morphineIV,5ml,30);
        displayNameProgress = KATPUSHINGCSTRING(morphineIV,5ml,30);
    };
    class syringe_MorphineIV_10ml_10: syringe_TXA_10ml_10 {
        medicRequired = QGVAR(medLvl_morphineIM);
        items[] = {"kat_syringe_morphineIV_10ml_10"};
        displayName = KATPUSHCSTRING(morphineIV,10ml,10);
        displayNameProgress = KATPUSHINGCSTRING(morphineIV,10ml,10);
    };
    class syringe_MorphineIV_10ml_16: syringe_MorphineIV_10ml_10 {
        items[] = {"kat_syringe_morphineIV_10ml_16"};
        displayName = KATPUSHCSTRING(morphineIV,10ml,16);
        displayNameProgress = KATPUSHINGCSTRING(morphineIV,10ml,16);
    };
    class syringe_MorphineIV_10ml_20: syringe_MorphineIV_10ml_10 {
        items[] = {"kat_syringe_morphineIV_10ml_20"};
        displayName = KATPUSHCSTRING(morphineIV,10ml,20);
        displayNameProgress = KATPUSHINGCSTRING(morphineIV,10ml,20);
    };
    class syringe_MorphineIV_10ml_26: syringe_MorphineIV_10ml_10 {
        items[] = {"kat_syringe_morphineIV_10ml_26"};
        displayName = KATPUSHCSTRING(morphineIV,10ml,26);
        displayNameProgress = KATPUSHINGCSTRING(morphineIV,10ml,26);
    };
    class syringe_MorphineIV_10ml_30: syringe_MorphineIV_10ml_10 {
        items[] = {"kat_syringe_morphineIV_10ml_30"};
        displayName = KATPUSHCSTRING(morphineIV,10ml,30);
        displayNameProgress = KATPUSHINGCSTRING(morphineIV,10ml,30);
    };
    class syringe_Nalbuphine_5ml_10: syringe_EACA_5ml_10 {
        medicRequired = QGVAR(medLvl_nalbuphine);
        items[] = {"kat_syringe_nalbuphine_5ml_10"};
        displayName = KATPUSHCSTRING(nalbuphine,5ml,10);
        displayNameProgress = KATPUSHINGCSTRING(nalbuphine,5ml,10);
    };
    class syringe_Nalbuphine_5ml_12: syringe_Nalbuphine_5ml_10 {
        items[] = {"kat_syringe_nalbuphine_5ml_12"};
        displayName = KATPUSHCSTRING(nalbuphine,5ml,12);
        displayNameProgress = KATPUSHINGCSTRING(nalbuphine,5ml,12);
    };
    class syringe_Nalbuphine_5ml_14: syringe_Nalbuphine_5ml_10 {
        items[] = {"kat_syringe_nalbuphine_5ml_14"};
        displayName = KATPUSHCSTRING(nalbuphine,5ml,14);
        displayNameProgress = KATPUSHINGCSTRING(nalbuphine,5ml,14);
    };
    class syringe_Nalbuphine_5ml_16: syringe_Nalbuphine_5ml_10 {
        items[] = {"kat_syringe_nalbuphine_5ml_16"};
        displayName = KATPUSHCSTRING(nalbuphine,5ml,16);
        displayNameProgress = KATPUSHINGCSTRING(nalbuphine,5ml,16);
    };
    class syringe_Nalbuphine_5ml_18: syringe_Nalbuphine_5ml_10 {
        items[] = {"kat_syringe_nalbuphine_5ml_18"};
        displayName = KATPUSHCSTRING(nalbuphine,5ml,18);
        displayNameProgress = KATPUSHINGCSTRING(nalbuphine,5ml,18);
    };
    class syringe_Nalbuphine_5ml_20: syringe_Nalbuphine_5ml_10 {
        items[] = {"kat_syringe_nalbuphine_5ml_20"};
        displayName = KATPUSHCSTRING(nalbuphine,5ml,20);
        displayNameProgress = KATPUSHINGCSTRING(nalbuphine,5ml,20);
    };
    class syringe_Nalbuphine_5ml_22: syringe_Nalbuphine_5ml_10 {
        items[] = {"kat_syringe_nalbuphine_5ml_22"};
        displayName = KATPUSHCSTRING(nalbuphine,5ml,22);
        displayNameProgress = KATPUSHINGCSTRING(nalbuphine,5ml,22);
    };
    class syringe_Nalbuphine_5ml_24: syringe_Nalbuphine_5ml_10 {
        items[] = {"kat_syringe_nalbuphine_5ml_24"};
        displayName = KATPUSHCSTRING(nalbuphine,5ml,24);
        displayNameProgress = KATPUSHINGCSTRING(nalbuphine,5ml,24);
    };
    class syringe_Nalbuphine_5ml_26: syringe_Nalbuphine_5ml_10 {
        items[] = {"kat_syringe_nalbuphine_5ml_26"};
        displayName = KATPUSHCSTRING(nalbuphine,5ml,26);
        displayNameProgress = KATPUSHINGCSTRING(nalbuphine,5ml,26);
    };
    class syringe_Nalbuphine_5ml_28: syringe_Nalbuphine_5ml_10 {
        items[] = {"kat_syringe_nalbuphine_5ml_28"};
        displayName = KATPUSHCSTRING(nalbuphine,5ml,28);
        displayNameProgress = KATPUSHINGCSTRING(nalbuphine,5ml,28);
    };
    class syringe_Nalbuphine_5ml_30: syringe_Nalbuphine_5ml_10 {
        items[] = {"kat_syringe_nalbuphine_5ml_30"};
        displayName = KATPUSHCSTRING(nalbuphine,5ml,30);
        displayNameProgress = KATPUSHINGCSTRING(nalbuphine,5ml,30);
    };
    class syringe_Nalbuphine_10ml_10: syringe_TXA_10ml_10 {
        medicRequired = QGVAR(medLvl_nalbuphineIM);
        items[] = {"kat_syringe_nalbuphine_10ml_10"};
        displayName = KATPUSHCSTRING(nalbuphine,10ml,10);
        displayNameProgress = KATPUSHINGCSTRING(nalbuphine,10ml,10);
    };
    class syringe_Nalbuphine_10ml_12: syringe_Nalbuphine_10ml_10 {
        items[] = {"kat_syringe_nalbuphine_10ml_12"};
        displayName = KATPUSHCSTRING(nalbuphine,10ml,12);
        displayNameProgress = KATPUSHINGCSTRING(nalbuphine,10ml,12);
    };
    class syringe_Nalbuphine_10ml_14: syringe_Nalbuphine_10ml_10 {
        items[] = {"kat_syringe_nalbuphine_10ml_14"};
        displayName = KATPUSHCSTRING(nalbuphine,10ml,14);
        displayNameProgress = KATPUSHINGCSTRING(nalbuphine,10ml,14);
    };
    class syringe_Nalbuphine_10ml_16: syringe_Nalbuphine_10ml_10 {
        items[] = {"kat_syringe_nalbuphine_10ml_16"};
        displayName = KATPUSHCSTRING(nalbuphine,10ml,16);
        displayNameProgress = KATPUSHINGCSTRING(nalbuphine,10ml,16);
    };
    class syringe_Nalbuphine_10ml_18: syringe_Nalbuphine_10ml_10 {
        items[] = {"kat_syringe_nalbuphine_10ml_18"};
        displayName = KATPUSHCSTRING(nalbuphine,10ml,18);
        displayNameProgress = KATPUSHINGCSTRING(nalbuphine,10ml,18);
    };
    class syringe_Nalbuphine_10ml_20: syringe_Nalbuphine_10ml_10 {
        items[] = {"kat_syringe_nalbuphine_10ml_20"};
        displayName = KATPUSHCSTRING(nalbuphine,10ml,20);
        displayNameProgress = KATPUSHINGCSTRING(nalbuphine,10ml,20);
    };
    class syringe_Nalbuphine_10ml_22: syringe_Nalbuphine_10ml_10 {
        items[] = {"kat_syringe_nalbuphine_10ml_22"};
        displayName = KATPUSHCSTRING(nalbuphine,10ml,22);
        displayNameProgress = KATPUSHINGCSTRING(nalbuphine,10ml,22);
    };
    class syringe_Nalbuphine_10ml_24: syringe_Nalbuphine_10ml_10 {
        items[] = {"kat_syringe_nalbuphine_10ml_24"};
        displayName = KATPUSHCSTRING(nalbuphine,10ml,24);
        displayNameProgress = KATPUSHINGCSTRING(nalbuphine,10ml,24);
    };
    class syringe_Nalbuphine_10ml_26: syringe_Nalbuphine_10ml_10 {
        items[] = {"kat_syringe_nalbuphine_10ml_26"};
        displayName = KATPUSHCSTRING(nalbuphine,10ml,26);
        displayNameProgress = KATPUSHINGCSTRING(nalbuphine,10ml,26);
    };
    class syringe_Nalbuphine_10ml_28: syringe_Nalbuphine_10ml_10 {
        items[] = {"kat_syringe_nalbuphine_10ml_28"};
        displayName = KATPUSHCSTRING(nalbuphine,10ml,28);
        displayNameProgress = KATPUSHINGCSTRING(nalbuphine,10ml,28);
    };
    class syringe_Nalbuphine_10ml_30: syringe_Nalbuphine_10ml_10 {
        items[] = {"kat_syringe_nalbuphine_10ml_30"};
        displayName = KATPUSHCSTRING(nalbuphine,10ml,30);
        displayNameProgress = KATPUSHINGCSTRING(nalbuphine,10ml,30);
    };
    class syringe_Ondansetron_5ml_10: syringe_EACA_5ml_10 {
        medicRequired = QGVAR(medLvl_ondansetron);
        items[] = {"kat_syringe_ondansetron_5ml_10"};
        displayName = KATPUSHCSTRING(ondansetron,5ml,10);
        displayNameProgress = KATPUSHINGCSTRING(ondansetron,5ml,10);
    };
    class syringe_Ondansetron_5ml_16: syringe_Ondansetron_5ml_10 {
        items[] = {"kat_syringe_ondansetron_5ml_16"};
        displayName = KATPUSHCSTRING(ondansetron,5ml,16);
        displayNameProgress = KATPUSHINGCSTRING(ondansetron,5ml,16);
    };
    class syringe_Ondansetron_5ml_20: syringe_Ondansetron_5ml_10 {
        items[] = {"kat_syringe_ondansetron_5ml_20"};
        displayName = KATPUSHCSTRING(ondansetron,5ml,20);
        displayNameProgress = KATPUSHINGCSTRING(ondansetron,5ml,20);
    };
    class syringe_Ondansetron_5ml_26: syringe_Ondansetron_5ml_10 {
        items[] = {"kat_syringe_ondansetron_5ml_26"};
        displayName = KATPUSHCSTRING(ondansetron,5ml,26);
        displayNameProgress = KATPUSHINGCSTRING(ondansetron,5ml,26);
    };
    class syringe_Ondansetron_5ml_30: syringe_Ondansetron_5ml_10 {
        items[] = {"kat_syringe_ondansetron_5ml_30"};
        displayName = KATPUSHCSTRING(ondansetron,5ml,30);
        displayNameProgress = KATPUSHINGCSTRING(ondansetron,5ml,30);
    };
    class syringe_Phenylephrine_5ml_10: syringe_EACA_5ml_10 {
        displayName = KATPUSHCSTRING(phenylephrine,5ml,10);
        displayNameProgress = KATPUSHINGCSTRING(phenylephrine,5ml,10);
        medicRequired = QGVAR(medLvl_phenylephrine);
        items[] = {"kat_syringe_phenylephrine_5ml_10"};
    };
    class syringe_Phenylephrine_5ml_20: syringe_Phenylephrine_5ml_10 {
        displayName = KATPUSHCSTRING(phenylephrine,5ml,20);
        displayNameProgress = KATPUSHINGCSTRING(phenylephrine,5ml,20);
        items[] = {"kat_syringe_phenylephrine_5ml_20"};
    };
    class syringe_Phenylephrine_5ml_30: syringe_Phenylephrine_5ml_10 {
        displayName = KATPUSHCSTRING(phenylephrine,5ml,30);
        displayNameProgress = KATPUSHINGCSTRING(phenylephrine,5ml,30);
        items[] = {"kat_syringe_phenylephrine_5ml_30"};
    };
    class syringe_Rocuronium_5ml_10: syringe_EACA_5ml_10 {
        medicRequired = QGVAR(medLvl_rocuronium);
        items[] = {"kat_syringe_rocuronium_5ml_10"};
        displayName = KATPUSHCSTRING(rocuronium,5ml,10);
        displayNameProgress = KATPUSHINGCSTRING(rocuronium,5ml,10);
    };
    class syringe_Rocuronium_5ml_12: syringe_Rocuronium_5ml_10 {
        items[] = {"kat_syringe_rocuronium_5ml_12"};
        displayName = KATPUSHCSTRING(rocuronium,5ml,12);
        displayNameProgress = KATPUSHINGCSTRING(rocuronium,5ml,12);
    };
    class syringe_Rocuronium_5ml_14: syringe_Rocuronium_5ml_10 {
        items[] = {"kat_syringe_rocuronium_5ml_14"};
        displayName = KATPUSHCSTRING(rocuronium,5ml,14);
        displayNameProgress = KATPUSHINGCSTRING(rocuronium,5ml,14);
    };
    class syringe_Rocuronium_5ml_16: syringe_Rocuronium_5ml_10 {
        items[] = {"kat_syringe_rocuronium_5ml_16"};
        displayName = KATPUSHCSTRING(rocuronium,5ml,16);
        displayNameProgress = KATPUSHINGCSTRING(rocuronium,5ml,16);
    };
    class syringe_Rocuronium_5ml_18: syringe_Rocuronium_5ml_10 {
        items[] = {"kat_syringe_rocuronium_5ml_18"};
        displayName = KATPUSHCSTRING(rocuronium,5ml,18);
        displayNameProgress = KATPUSHINGCSTRING(rocuronium,5ml,18);
    };
    class syringe_Rocuronium_5ml_20: syringe_Rocuronium_5ml_10 {
        items[] = {"kat_syringe_rocuronium_5ml_20"};
        displayName = KATPUSHCSTRING(rocuronium,5ml,20);
        displayNameProgress = KATPUSHINGCSTRING(rocuronium,5ml,20);
    };
    class syringe_Rocuronium_5ml_22: syringe_Rocuronium_5ml_10 {
        items[] = {"kat_syringe_rocuronium_5ml_22"};
        displayName = KATPUSHCSTRING(rocuronium,5ml,22);
        displayNameProgress = KATPUSHINGCSTRING(rocuronium,5ml,22);
    };
    class syringe_Rocuronium_5ml_24: syringe_Rocuronium_5ml_10 {
        items[] = {"kat_syringe_rocuronium_5ml_24"};
        displayName = KATPUSHCSTRING(rocuronium,5ml,24);
        displayNameProgress = KATPUSHINGCSTRING(rocuronium,5ml,24);
    };
    class syringe_Rocuronium_5ml_26: syringe_Rocuronium_5ml_10 {
        items[] = {"kat_syringe_rocuronium_5ml_26"};
        displayName = KATPUSHCSTRING(rocuronium,5ml,26);
        displayNameProgress = KATPUSHINGCSTRING(rocuronium,5ml,26);
    };
    class syringe_Rocuronium_5ml_28: syringe_Rocuronium_5ml_10 {
        items[] = {"kat_syringe_rocuronium_5ml_28"};
        displayName = KATPUSHCSTRING(rocuronium,5ml,28);
        displayNameProgress = KATPUSHINGCSTRING(rocuronium,5ml,28);
    };
    class syringe_Rocuronium_5ml_30: syringe_Rocuronium_5ml_10 {
        items[] = {"kat_syringe_rocuronium_5ml_30"};
        displayName = KATPUSHCSTRING(rocuronium,5ml,30);
        displayNameProgress = KATPUSHINGCSTRING(rocuronium,5ml,30);
    };
    class syringe_Succinylcholine_5ml_10: syringe_EACA_5ml_10 {
        medicRequired = QGVAR(medLvl_succinylcholine);
        items[] = {"kat_syringe_succinylcholine_5ml_10"};
        displayName = KATPUSHCSTRING(succinylcholine,5ml,10);
        displayNameProgress = KATPUSHINGCSTRING(succinylcholine,5ml,10);
    };
    class syringe_Succinylcholine_5ml_12: syringe_Succinylcholine_5ml_10 {
        items[] = {"kat_syringe_succinylcholine_5ml_12"};
        displayName = KATPUSHCSTRING(succinylcholine,5ml,12);
        displayNameProgress = KATPUSHINGCSTRING(succinylcholine,5ml,12);
    };
    class syringe_Succinylcholine_5ml_14: syringe_Succinylcholine_5ml_10 {
        items[] = {"kat_syringe_succinylcholine_5ml_14"};
        displayName = KATPUSHCSTRING(succinylcholine,5ml,14);
        displayNameProgress = KATPUSHINGCSTRING(succinylcholine,5ml,14);
    };
    class syringe_Succinylcholine_5ml_16: syringe_Succinylcholine_5ml_10 {
        items[] = {"kat_syringe_succinylcholine_5ml_16"};
        displayName = KATPUSHCSTRING(succinylcholine,5ml,16);
        displayNameProgress = KATPUSHINGCSTRING(succinylcholine,5ml,16);
    };
    class syringe_Succinylcholine_5ml_18: syringe_Succinylcholine_5ml_10 {
        items[] = {"kat_syringe_succinylcholine_5ml_18"};
        displayName = KATPUSHCSTRING(succinylcholine,5ml,18);
        displayNameProgress = KATPUSHINGCSTRING(succinylcholine,5ml,18);
    };
    class syringe_Succinylcholine_5ml_20: syringe_Succinylcholine_5ml_10 {
        items[] = {"kat_syringe_succinylcholine_5ml_20"};
        displayName = KATPUSHCSTRING(succinylcholine,5ml,20);
        displayNameProgress = KATPUSHINGCSTRING(succinylcholine,5ml,20);
    };
    class syringe_Succinylcholine_5ml_22: syringe_Succinylcholine_5ml_10 {
        items[] = {"kat_syringe_succinylcholine_5ml_22"};
        displayName = KATPUSHCSTRING(succinylcholine,5ml,22);
        displayNameProgress = KATPUSHINGCSTRING(succinylcholine,5ml,22);
    };
    class syringe_Succinylcholine_5ml_24: syringe_Succinylcholine_5ml_10 {
        items[] = {"kat_syringe_succinylcholine_5ml_24"};
        displayName = KATPUSHCSTRING(succinylcholine,5ml,24);
        displayNameProgress = KATPUSHINGCSTRING(succinylcholine,5ml,24);
    };
    class syringe_Succinylcholine_5ml_26: syringe_Succinylcholine_5ml_10 {
        items[] = {"kat_syringe_succinylcholine_5ml_26"};
        displayName = KATPUSHCSTRING(succinylcholine,5ml,26);
        displayNameProgress = KATPUSHINGCSTRING(succinylcholine,5ml,26);
    };
    class syringe_Succinylcholine_5ml_28: syringe_Succinylcholine_5ml_10 {
        items[] = {"kat_syringe_succinylcholine_5ml_28"};
        displayName = KATPUSHCSTRING(succinylcholine,5ml,28);
        displayNameProgress = KATPUSHINGCSTRING(succinylcholine,5ml,28);
    };
    class syringe_Succinylcholine_5ml_30: syringe_Succinylcholine_5ml_10 {
        items[] = {"kat_syringe_succinylcholine_5ml_30"};
        displayName = KATPUSHCSTRING(succinylcholine,5ml,30);
        displayNameProgress = KATPUSHINGCSTRING(succinylcholine,5ml,30);
    };
    class syringe_Sugammadex_5ml_20: syringe_EACA_5ml_10 {
        medicRequired = QGVAR(medLvl_rocuronium);
        items[] = {"kat_syringe_sugammadex_5ml_20"};
        displayName = KATPUSHCSTRING(sugammadex,5ml,20);
        displayNameProgress = KATPUSHINGCSTRING(sugammadex,5ml,20);
    };
    class CheckVein: CheckPulse {
        displayName = CSTRING(CheckVein_DisplayName);
        displayNameProgress = CSTRING(CheckVein_DisplayNameProgress);
        allowedSelections[] = {"LeftArm", "RightArm", "UpperLeftLeg", "UpperRightLeg"};
        treatmentLocations = 0;
        medicRequired = QGVAR(CheckVein_MedLevel);
        treatmentTime = QGVAR(CheckVein_TreatmentTime);
        category = "examine";
        consumeItem = 0;
        condition = "";
        callbackProgress = "";
        callbackStart = "";
        callbackFailure = "";
        callbackSuccess = QFUNC(treatmentAdvanced_CheckVein);
        litter[] = {};
    };
    class RemoveSaline: RemoveIV {
        displayName = CSTRING(RemoveSaline);
        displayNameProgress = CSTRING(RemovingSalineIV_Progress);
        treatmentTime = QACEGVAR(medical_treatment,treatmentTimeIV);
        consumeItem = 0;
        condition = QUOTE([ARR_4(_player,_patient,_bodyPart,'Saline')] call FUNC(ivBagCheck));
        callbackSuccess = QUOTE([ARR_4(_player,_patient,_bodyPart,'Saline')] call FUNC(removeIVBag));
    };
    class RemovePlasma: RemoveIV {
        displayName = CSTRING(RemovePlasma);
        displayNameProgress = CSTRING(RemovingPlasmaIV_Progress);
        treatmentTime = QACEGVAR(medical_treatment,treatmentTimeIV);
        consumeItem = 0;
        condition = QUOTE([ARR_4(_player,_patient,_bodyPart,'Plasma')] call FUNC(ivBagCheck));
        callbackSuccess = QUOTE([ARR_4(_player,_patient,_bodyPart,'Plasma')] call FUNC(removeIVBag));
    };
    class RemoveBlood: RemoveIV {
        displayName = CSTRING(RemoveBlood);
        displayNameProgress = CSTRING(RemovingBloodIV_Progress);
        treatmentTime = QACEGVAR(medical_treatment,treatmentTimeIV);
        consumeItem = 0;
        condition = QUOTE([ARR_4(_player,_patient,_bodyPart,'Blood')] call FUNC(ivBagCheck));
        callbackSuccess = QUOTE([ARR_4(_player,_patient,_bodyPart,'Blood')] call FUNC(removeIVBag));
    };
    class RemovePackedRBC: RemoveIV {
        displayName = CSTRING(RemovePackedRBC);
        displayNameProgress = CSTRING(RemovingPackedRBCIV_Progress);
        treatmentTime = QACEGVAR(medical_treatment,treatmentTimeIV);
        consumeItem = 0;
        condition = QUOTE([ARR_4(_player,_patient,_bodyPart,'PackedRBC')] call FUNC(ivBagCheck));
        callbackSuccess = QUOTE([ARR_4(_player,_patient,_bodyPart,'PackedRBC')] call FUNC(removeIVBag));
    };
    class RemoveRingersLactate: RemoveIV {
        displayName = CSTRING(RemoveRingersLactate);
        displayNameProgress = CSTRING(RemovingRingersLactateIV_Progress);
        treatmentTime = QACEGVAR(medical_treatment,treatmentTimeIV);
        consumeItem = 0;
        condition = QUOTE([ARR_4(_player,_patient,_bodyPart,'Ringers Lactate')] call FUNC(ivBagCheck));
        callbackSuccess = QUOTE([ARR_4(_player,_patient,_bodyPart,'Ringers Lactate')] call FUNC(removeIVBag));
    };
    class ApplyFentPatch: Morphine {
        displayName = CSTRING(Apply_FentPatch);
        displayNameProgress = CSTRING(Applying_FentPatch);
        medicRequired = QGVAR(medLvl_ApplyFentPatch);
        treatmentTime = QGVAR(treatmentTime_ApplyFentPatch);
        allowSelfTreatment = 1;
        category = "medication";
        allowedSelections[] = {"Chest", "Neck", "LeftArm", "RightArm", "UpperLeftLeg", "UpperRightLeg", "UpperLeftArm", "UpperRightArm", "LeftLeg", "RightLeg"};
        items[] = {"kat_fentPatch"};
        condition = QUOTE(!([ARR_3(_player,_patient,_bodyPart)] call FUNC(treatmentAdvanced_FentanylPatchCheck)));
        callbackSuccess = QFUNC(treatmentAdvanced_FentanylPatch);
        sounds[] = {};
    };
    class RemoveFentPatch: ApplyFentPatch {
        displayName = CSTRING(Remove_FentPatch);
        displayNameProgress = CSTRING(Removing_FentPatch);
        category = "medication";
        allowedSelections[] = {"Chest", "Neck", "LeftArm", "RightArm", "UpperLeftLeg", "UpperRightLeg", "UpperLeftArm", "UpperRightArm", "LeftLeg", "RightLeg"};
        treatmentTime = QGVAR(treatmentTime_ApplyFentPatch);
        medicRequired = 0;
        items[] = {};
        condition = QUOTE(([ARR_3(_player,_patient,_bodyPart)] call FUNC(treatmentAdvanced_FentanylPatchRemoveCheck)));
        callbackSuccess = QFUNC(treatmentAdvanced_RemoveFentanylPatch);
        sounds[] = {};
    };
};
