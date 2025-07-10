#include "..\script_component.hpp"
/*
 * Author: Cplhardcore
 * outputs current unit state to that units RPT for debug tracing
 *
 * Arguments:
 * 0: The module logic <OBJECT>
 *
 * Return Value:
 * None
 *
 * Example:
 * [LOGIC] call kat_zeus_fnc_toggleAIDeathModule;
 *
 * Public: Yes
 */

params ["_logic"];
if !(local _logic) exitWith {};

private _mouseOver = GETMVAR(bis_fnc_curatorObjectPlaced_mouseOver,[""]);

if ((_mouseOver select 0) != "OBJECT") then {
    [ACELSTRING(zeus,NothingSelected)] call FUNC(showMessage);
} else {
    private _unit = effectiveCommander (_mouseOver select 1);
    if !(_unit isKindOf "CAManBase") then {
        [ACELSTRING(zeus,OnlyInfantry)] call FUNC(showMessage);
    } else {
        diag_log str _unit;
private _pain = _unit getVariable [VAR_PAIN, 0];
private _bloodVol = _unit getVariable [VAR_BLOOD_VOL, DEFAULT_BLOOD_VOLUME];

private _tourniquet = _unit getVariable [VAR_TOURNIQUET, DEFAULT_TOURNIQUET_VALUES];

private _openWounds = _unit getVariable [VAR_OPEN_WOUNDS, []];
private _bandagedWounds = _unit getVariable [VAR_BANDAGED_WOUNDS, []];
private _stitchedWounds = _unit getVariable [VAR_STITCHED_WOUNDS, []];
private _wrappedWounds = _unit getVariable [VAR_WRAPPED_WOUNDS, []];
private _coagWounds = _unit getVariable [VAR_COAGED_WOUNDS, []];
private _isLimping = _unit getVariable [QACEGVAR(medical,isLimping), false];
private _fractures = _unit getVariable [VAR_FRACTURES, DEFAULT_FRACTURE_VALUES];

private _heartRate = _unit getVariable [VAR_HEART_RATE, DEFAULT_HEART_RATE];
private _bloodPress = _unit getVariable [VAR_BLOOD_PRESS, [80, 120]];
private _periphRes = _unit getVariable [VAR_PERIPH_RES, DEFAULT_PERIPH_RES];
private _spo2 = _unit getVariable [VAR_SPO2, DEFAULT_SPO2];
private _oxygenDemand = _unit getVariable [VAR_OXYGEN_DEMAND, 0];

private _ivBags = _unit getVariable [QACEGVAR(medical,ivBags), []];

private _bodypartDamage = _unit getVariable [VAR_BODYPART_DAMAGE, DEFAULT_BODYPART_DAMAGE_VALUES];
private _occludedMedications = _unit getVariable [QACEGVAR(medical,occludedMedications), []];
private _hemorrhage = _unit getVariable [VAR_HEMORRHAGE, 0];
private _inPain = _unit getVariable [VAR_IN_PAIN, false];
private _painSupp = _unit getVariable [VAR_PAIN_SUPP, 0];
private _medications = _unit getVariable [VAR_MEDICATIONS, []];
private _triageCard = _unit getVariable [QACEGVAR(medical,triageCard), []];
private _vasoconstriction = _unit getVariable [VAR_VASOCONSTRICTION, 1];


diag_log format [
    "[Vitals/Wounds] Pain: %1 | BloodVol: %2 | Tourniquet: %3 | OccludedMedications: %4 | OpenWounds: %5 | BandagedWounds: %6 | StitchedWounds: %7 | IsLimping: %8 | Fractures: %9 | HeartRate: %10 | BloodPress: %11 | PeriphRes: %12 | SpO2: %13 | OxygenDemand: %14 | IVBags: %15 | BodypartDamage: %16 | Hemorrhage: %17 | InPain: %18 | PainSupp: %19 | Medications: %20 | TriageCard: %21 | Vasoconstrictiion: %22 | WrappedWounds: %23 | CoagWounds: %24",
    _pain,
    _bloodVol,
    _tourniquet,
    _occludedMedications,
    _openWounds,
    _bandagedWounds,
    _stitchedWounds,
    _isLimping,
    _fractures,
    _heartRate,
    _bloodPress,
    _periphRes,
    _spo2,
    _oxygenDemand,
    _ivBags,
    _bodypartDamage,
    _hemorrhage,
    _inPain,
    _painSupp,
    _medications,
    _triageCard,
    _vasoconstriction,
    _wrappedWounds,
    _coagWounds
];


private _airwayItem = _unit getVariable [QEGVAR(airway,airway_item), ""];
private _airway = _unit getVariable [QEGVAR(airway,airway), false];
private _clearedTime = _unit getVariable [QEGVAR(airway,clearedTime), 0];
private _cricothyrotomy = _unit getVariable [QEGVAR(airway,cricothyrotomy), 0];
private _catastrophicAirway = _unit getVariable [QEGVAR(airway,catastrophicAirway), [false, false]];
private _obstruction = _unit getVariable [QEGVAR(airway,obstruction), [0, 0, 0]];
private _occlusion = _unit getVariable [QEGVAR(airway,occlusion), [0, 0, 0]];
private _occlusionMitigation = _unit getVariable [QEGVAR(airway,occlusionMitigation), [false, false, false]];
private _overstretch = _unit getVariable [QEGVAR(airway,overstretch), false];
private _recovery = _unit getVariable [QEGVAR(airway,recovery), false];
private _wasOccluded = _unit getVariable [QEGVAR(airway,wasOccluded), [0, 0, 0]];
private _hasPuked = _unit getVariable [QEGVAR(airway,hasPuked), false];
private _airwayStatus = _unit getVariable [QEGVAR(airway,airwayStatus), [0, 0, 0]];
private _isVisualized = _unit getVariable [QEGVAR(airway,isVisualized), false];
diag_log format [
    "[Airways] AirwayItem: %1 | Airway: %2 | ClearedTime: %3 | Cricothyrotomy: %4 | CatastrophicAirway: %5 | Obstruction: %6 | Occlusion: %7 | OcclusionMitigation: %8 | Overstretch: %9 | Recovery: %10 | WasOccluded: %11 | HasPuked: %12 | AirwayStatus: %13 | IsVisualized: %14",
    _airwayItem,
    _airway,
    _clearedTime,
    _cricothyrotomy,
    _catastrophicAirway,
    _obstruction,
    _occlusion,
    _occlusionMitigation,
    _overstretch,
    _recovery,
    _wasOccluded,
    _hasPuked,
    _airwayStatus,
    _isVisualized
];
private _airwayStatus = _unit getVariable [QEGVAR(breathing,airwayStatus), 100];
private _pneumothorax = _unit getVariable [QEGVAR(breathing,pneumothorax), [0, 0]];
private _pneumothoraxSurfaceArea = _unit getVariable [QEGVAR(breathing,pneumothoraxSurfaceArea), [0, 0]];
private _hemopneumothorax = _unit getVariable [QEGVAR(breathing,hemopneumothorax), [false, false]];
private _tensionpneumothorax = _unit getVariable [QEGVAR(breathing,tensionpneumothorax), [false, false]];
private _activeChestSeal = _unit getVariable [QEGVAR(breathing,activeChestSeal), [false, false]];
private _deepPenetratingInjury = _unit getVariable [QEGVAR(breathing,deepPenetratingInjury), [false, false]];
private _etco2Monitor = _unit getVariable [QEGVAR(breathing,etco2Monitor), []];
private _breathRate = _unit getVariable [QEGVAR(breathing,breathRate), 15];
private _nasalCannula = _unit getVariable [QEGVAR(breathing,nasalCannula), false];
private _lungSurfaceArea = _unit getVariable [QEGVAR(breathing,lungSurfaceArea), 400];
private _chestTube = _unit getVariable [QEGVAR(breathing,chestTube), [0, 0]];
private _attachedVent = _unit getVariable [QEGVAR(breathing,attachedVent), false];
private _attachedVentGUI = _unit getVariable [QEGVAR(breathing,attachedVentGUI), false];
private _paralysis = _unit getVariable [QEGVAR(breathing,paralysis), 0];
private _ventRate = _unit getVariable [QEGVAR(breathing,ventRate), 2];
private _trali = _unit getVariable [QEGVAR(breathing,TRALI), 0];

diag_log format [
    "[Respiratory] AirwayStatus: %1 | Pneumothorax: %2 | PneumothoraxSurfaceArea: %3 | Hemopneumothorax: %4 | TensionPneumothorax: %5 | ActiveChestSeal: %6 | DeepPenetratingInjury: %7 | ETCO2Monitor: %8 | BreathRate: %9 | NasalCannula: %10 | LungSurfaceArea: %11 | ChestTube: %12 | AttachedVent: %13 | AttachedVentGUI: %14 | Paralysis: %15 | VentRate: %16 | TRALI: %17",
    _airwayStatus,
    _pneumothorax,
    _pneumothoraxSurfaceArea,
    _hemopneumothorax,
    _tensionpneumothorax,
    _activeChestSeal,
    _deepPenetratingInjury,
    _etco2Monitor,
    _breathRate,
    _nasalCannula,
    _lungSurfaceArea,
    _chestTube,
    _attachedVent,
    _attachedVentGUI,
    _paralysis,
    _ventRate,
    _trali
];
private _cprCount = _unit getVariable [QEGVAR(circulation,cprCount), 2];
private _heartRestart = _unit getVariable [QEGVAR(circulation,heartRestart), false];
private _cardiacArrestType = _unit getVariable [QEGVAR(circulation,cardiacArrestType), 0];

private _bloodPressureChange = _unit getVariable [VAR_BLOODPRESSURE_CHANGE, 0];

private _bodyFluid = _unit getVariable [QEGVAR(circulation,bodyFluid), DEFAULT_BODY_FLUID];

private _isPerformingCPR = _unit getVariable [QEGVAR(circulation,isPerformingCPR), false];
private _oxygenationPeriod = _unit getVariable [QEGVAR(circulation,OxygenationPeriod), 0];

private _tourniquetTime = _unit getVariable [QEGVAR(circulation,tourniquetTime), [0,0,0,0,0,0,0,0,0,0,0,0]];
private _defaultHeartRate = _unit getVariable [QEGVAR(circulation,defaultHeartRate), 80];

private _bloodGas = _unit getVariable [QEGVAR(circulation,bloodGas), DEFAULT_BLOOD_GAS];
private _testedBloodGas = _unit getVariable [QEGVAR(circulation,testedBloodGas), [0,0,0,0,0,0,0,0,0,0,0,0]];

private _ABGmenuShow = _unit getVariable [QEGVAR(circulation,ABGmenuShow), false];

private _ht = _unit getVariable [QEGVAR(circulation,ht), []];
private _effusion = _unit getVariable [QEGVAR(circulation,effusion), 0];

private _attachedLucas = _unit getVariable [QEGVAR(circulation,attachedLucas), false];
private _attachedLucasState = _unit getVariable [QEGVAR(circulation,attachedLucasState), false];

diag_log format [
    "[Cardiac] CPRCount: %1 | HeartRestart: %2 | CardiacArrestType: %3 | BloodPressureChange: %4 | BodyFluid: %5 | IsPerformingCPR: %6 | OxygenationPeriod: %7 | TourniquetTime: %8 | DefaultHeartRate: %9 | BloodGas: %10 | TestedBloodGas: %11 | ABGmenuShow: %12 | HT: %13 | Effusion: %14 | AttachedLucas: %15 | AttachedLucasState: %16",
    _cprCount,
    _heartRestart,
    _cardiacArrestType,
    _bloodPressureChange,
    _bodyFluid,
    _isPerformingCPR,
    _oxygenationPeriod,
    _tourniquetTime,
    _defaultHeartRate,
    _bloodGas,
    _testedBloodGas,
    _ABGmenuShow,
    _ht,
    _effusion,
    _attachedLucas,
    _attachedLucasState
];
private _dustInjuryLight = _unit getVariable [QEGVAR(ophthalmology,dustInjuryLight), 0];
private _dustInjuryHeavy = _unit getVariable [QEGVAR(ophthalmology,dustInjuryHeavy), 0];
private _eyeInjuries = _unit getVariable [QEGVAR(ophthalmology,eyeInjuries), [1,1]];
private _eyeInjurySevere = _unit getVariable [QEGVAR(ophthalmology,eyeInjurySevere), false];

diag_log format [
    "[Ophthalmology] DustInjuryLight: %1 | DustInjuryHeavy: %2 | EyeInjuries: %3 | EyeInjurySevere: %4",
    _dustInjuryLight,
    _dustInjuryHeavy,
    _eyeInjuries,
    _eyeInjurySevere
];

private _alphaAction = _unit getVariable [QEGVAR(pharma,alphaAction), 1];

private _IV = _unit getVariable [QEGVAR(pharma,IV), [0,0,0,0,0,0,0,0,0,0,0,0]];
private _IVflow = _unit getVariable [QEGVAR(pharma,IVflow), [0,0,0,0,0,0,0,0,0,0,0,0]];
private _IVrate = _unit getVariable [QEGVAR(pharma,IVrate), [0,0,0,0,0,0,0,0,0,0,0,0]];

private _IVincomingFlowAmount = _unit getVariable [QEGVAR(pharma,IVincomingFlowAmount), [0,0,0,0,0,0,0,0,0,0,0,0]];
private _IVpfh = _unit getVariable [QEGVAR(pharma,IVpfh), [0,0,0,0,0,0,0,0,0,0,0,0]];
private _active = _unit getVariable [QEGVAR(pharma,active), false];
private _IVPharma_PFH = _unit getVariable [QEGVAR(pharma,IVPharma_PFH), 0];

private _IVmenuActive = _unit getVariable [QEGVAR(pharma,IVmenuActive), false];

private _externalPh = _unit getVariable [QEGVAR(pharma,externalPh), 0];
private _pH = _unit getVariable [QEGVAR(pharma,pH), 0];

private _opioidFactor = _unit getVariable [QEGVAR(pharma,opioidFactor), 0];
private _opioidDepression = _unit getVariable [QEGVAR(pharma,opioidDepression), 0];

private _kidneyFail = _unit getVariable [QEGVAR(pharma,kidneyFail), false];
private _kidneyArrest = _unit getVariable [QEGVAR(pharma,kidneyArrest), false];
private _kidneyPressure = _unit getVariable [QEGVAR(pharma,kidneyPressure), false];

private _respiratoryRate = _unit getVariable [QEGVAR(pharma,respiratoryRate), 1];
private _heartContractility = _unit getVariable [QEGVAR(pharma,heartContractility), 1];
private _nauseaMult = _unit getVariable [QEGVAR(pharma,nauseaMult), 1];

private _localAnesthesia = _unit getVariable [VAR_LOCAL_ANESTHESIA, DEFAULT_LOCAL_ANESTHESIA];
private _activeEtomidateLoadingDose = _unit getVariable [QEGVAR(pharma,activeEtomidateLoadingDose), false];
private _coagulationFactor = _unit getVariable [QEGVAR(pharma,coagulationFactor), 30];

diag_log format [
    "[IV/Pharma] AlphaAction: %1 | IV: %2 | IVflow: %3 | IVrate: %4 | IVincomingFlowAmount: %5 | IVpfh: %6 | Active: %7 | IVPharma_PFH: %8 | IVmenuActive: %9 | ExternalPh: %10 | pH: %11 | OpioidFactor: %12 | OpioidDepression: %13 | KidneyFail: %14 | KidneyArrest: %15 | KidneyPressure: %16 | RespiratoryRate: %17 | HeartContractility: %18 | NauseaMult: %19 | LocalAnesthesia: %20 | ActiveEtomidateLoadingDose: %21 | CoagulationFactor: %22",
    _alphaAction,
    _IV,
    _IVflow,
    _IVrate,
    _IVincomingFlowAmount,
    _IVpfh,
    _active,
    _IVPharma_PFH,
    _IVmenuActive,
    _externalPh,
    _pH,
    _opioidFactor,
    _opioidDepression,
    _kidneyFail,
    _kidneyArrest,
    _kidneyPressure,
    _respiratoryRate,
    _heartContractility,
    _nauseaMult,
    _localAnesthesia,
    _activeEtomidateLoadingDose,
    _coagulationFactor
];
private _fractures = _unit getVariable [QEGVAR(surgery,fractures), [0,0,0,0,0,0,0,0,0,0,0,0]];
private _lidocaine = _unit getVariable [QEGVAR(surgery,lidocaine), false];
private _etomidate = _unit getVariable [QEGVAR(surgery,etomidate), false];
private _sedated = _unit getVariable [QEGVAR(surgery,sedated), 0];
private _imaging = _unit getVariable [QEGVAR(surgery,imaging), false];
private _reboa = _unit getVariable [QEGVAR(surgery,reboa), false];
private _surgicalBlock = _unit getVariable [QEGVAR(surgery,surgicalBlock), [0,0,0,0,0,0,0,0,0,0,0,0]];

diag_log format [
    "[Ortho/Anesthesia] Fractures: %1 | Lidocaine: %2 | Etomidate: %3 | Sedated: %4 | Imaging: %5 | REBOA: %6 | SurgicalBlock: %7",
    _fractures,
    _lidocaine,
    _etomidate,
    _sedated,
    _imaging,
    _reboa,
    _surgicalBlock
];

private _respiratorydepth = _unit getVariable [QEGVAR(vitals,respiratoryDepth), DEFAULT_RESPIRATORY_DEPTH];
private _currentWeight = _unit getVariable [QEGVAR(vitals,currentWeight), 80];
diag_log format [
    "[Vitals] Respiratory Depth: %1 Current Weight: %2",
    _respiratorydepth,
    _currentWeight
];

deleteVehicle _logic;
    };
};
deleteVehicle _logic;
