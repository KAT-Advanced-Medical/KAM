class ACE_Medical_Treatment_Actions {
    class BasicBandage;
    class Ultrasound: BasicBandage {
        displayName = CSTRING(UltraICP_Use);
        displayNameProgress = CSTRING(UltraICP_Action);
        category = "examine";
        treatmentLocations = QEGVAR(surgery,ultrasoundLocation);
        allowedSelections[] = {"Head"};
        allowSelfTreatment = 0;
        medicRequired = QEGVAR(surgery,ultrasoundAction_MedLevel);
        treatmentTime = QEGVAR(surgery,ultrasoundTime);
        items[] = {"kat_ultrasound"};
        consumeItem = 0;
        condition = QGVAR(enable);
        callbackSuccess = QFUNC(icpAssessment);
    };
};
