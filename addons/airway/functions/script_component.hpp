#include "\x\kat\addons\airway\script_component.hpp"

// Override the macros used by ACE
#define VAR_BLOOD_PRESS       "ACE_medical_bloodPressure"
#define VAR_BLOOD_VOL         "ACE_medical_bloodVolume"
#define VAR_WOUND_BLEEDING    "ACE_medical_woundBleeding"
#define VAR_CRDC_ARRST        "ACE_medical_inCardiacArrest"
#define VAR_HEART_RATE        "ACE_medical_heartRate"
#define VAR_PAIN              "ACE_medical_pain"
#define VAR_PAIN_SUPP         "ACE_medical_painSuppress"
#define VAR_PERIPH_RES        "ACE_medical_peripheralResistance"
#define VAR_UNCON             "ACE_isUnconscious"
#define VAR_OPEN_WOUNDS       "ACE_medical_openWounds"
#define VAR_BANDAGED_WOUNDS   "ACE_medical_bandagedWounds"
#define VAR_STITCHED_WOUNDS   "ACE_medical_stitchedWounds"
// These variables track gradual adjustments (from medication, etc.)
#define VAR_MEDICATIONS       "ACE_medical_medications"
// These variables track the current state of status values above
#define VAR_HEMORRHAGE        "ACE_medical_hemorrhage"
#define VAR_IN_PAIN           "ACE_medical_inPain"
#define VAR_TOURNIQUET        "ACE_medical_tourniquets"
#define VAR_FRACTURES         "ACE_medical_fractures"
