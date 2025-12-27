#define DEBUG_MODE_FULL
#include "..\script_component.hpp"
/*
 * Author: Glowbal, mharis001, Cplhardcore
 * Local callback for administering an IV bag to a patient.
 *
 * Arguments:
 * 0: Patient <OBJECT>
 * 1: Body Part <STRING>
 * 2: Treatment <STRING>
 * 3: Medic <OBJECT>
 * 4: Item User <OBJECT>
 * 5: Used item <STRING>
 *
 * Return Value:
 * None
 *
 * Example:
 * [player, "RightArm", "BloodIV", player, player, "ACE_BloodIV"] call ace_medical_treatment_fnc_ivBagLocal
 *
 * Public: No
 */

params ["_patient", "_bodyPart", "_treatment", "_medic", "_itemUser", "_item"];

// Exit if patient has max blood volume
private _bloodVolume = GET_BLOOD_VOLUME_LITERS(_patient);
if (_bloodVolume >= 7.5) exitWith {
    // Return the bag if patient is topped up on blood
    if (_medic call ACEFUNC(common,isPlayer) || {missionNamespace getVariable [QACEGVAR(medical_ai,requireItems), 0] > 0}) then {
        [_itemUser, _item] call ACEFUNC(common,addToInventory);
    };
};

private _partIndex = ALL_BODY_PARTS find toLowerANSI _bodyPart;

// Get attributes for the used IV
private _defaultConfig = configFile >> QUOTE(ACE_ADDON(Medical_Treatment)) >> "IV";
private _ivConfig = _defaultConfig >> _treatment;

private _volume    = GET_NUMBER(_ivConfig >> "volume",getNumber (_defaultConfig >> "volume"));
private _type      = GET_STRING(_ivConfig >> "type",getText (_defaultConfig >> "type"));
private _rateCoef  = GET_NUMBER(_ivConfig >> "rateCoef",getNumber (_defaultConfig >> "rateCoef"));
private _platelets = GET_NUMBER(_ivConfig >> "platelets",getNumber (_defaultConfig >> "platelets"));
private _ph = GET_NUMBER(_ivConfig >> "ph",getNumber (_defaultConfig >> "ph"));
private _ca = GET_NUMBER(_ivConfig >> "ca",getNumber (_defaultConfig >> "ca"));
private _uuid = (str CBA_missionTime + str random 1e6); // bag UID

// Add IV bag to patient's ivBags array
TRACE_6("IVBAGLOCAL",_volume,_type,_partIndex,_treatment,_rateCoef,_item);
TRACE_4("IVBAGLOCAL1",_ca,_ph,_platelets,_uuid);
private _ivBags = _patient getVariable [QACEGVAR(medical,ivBags), []];
_ivBags pushBack [_volume, _type, _partIndex, _treatment, _rateCoef, _item, _platelets, _ph, _ca, _uuid];
TRACE_1("IVBAGLOCAL2",_ivBags);
_patient setVariable [QACEGVAR(medical,ivBags), _ivBags, true];