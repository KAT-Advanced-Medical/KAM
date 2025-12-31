#include "..\script_component.hpp"
/*
 * Author: BaerMitUmlaut, ulteq
 * Main looping function that updates fatigue values.
 *
 * Arguments:
 * None
 *
 * Return Value:
 * None
 *
 * Example:
 * [] call ace_advanced_fatigue_fnc_mainLoop
 *
 * Public: No
 */

// Dead people don't breathe, will also handle null (map intros)
if (!alive ACE_player) exitWith {
    [LINKFUNC(mainLoop), [], 1] call CBA_fnc_waitAndExecute;

    private _staminaBarContainer = uiNamespace getVariable [QACEGVAR(advanced_fatigue,staminaBarContainer), controlNull];
    _staminaBarContainer ctrlSetFade 1;
    _staminaBarContainer ctrlCommit 1;
};

private _velocity = velocity ACE_player;
private _normal = surfaceNormal (getPosWorld ACE_player);
private _movementVector = vectorNormalized _velocity;
private _fwdAngle = asin (_movementVector select 2);
private _sideAngle = if ((getPosATL ACE_player) select 2 > 0.01) then {
    0 // ignore terrain normal if not touching it
} else {
    private _sideVector = vectorNormalized (_movementVector vectorCrossProduct _normal);
    asin (_sideVector select 2);
};
if (ACEGVAR(advanced_fatigue,isSwimming)) then { // ignore when floating
    _fwdAngle = 0;
    _sideAngle = 0;
};

private _bodyMass = ACE_player getVariable [QEGVAR(vitals,currentWeight), 80];
private _currentWork = ((0.5617 * _bodyMass + 42.57) * BIOMECH_EFFICIENCY);
private _currentSpeed = (vectorMagnitude _velocity) min 6;
private _caffeineCount = ([ACE_player, "Caffeine", false] call ACEFUNC(medical_status,getMedicationCount)) select 1;
private _pervatinCount = ([ACE_player, "Pervatin", false] call ACEFUNC(medical_status,getMedicationCount)) select 1;
// fix #4481. Diving to the ground is recorded as PRONE stance with running speed velocity. Cap maximum speed to fix.
if (ACEGVAR(advanced_fatigue,isProne)) then {
    _currentSpeed = _currentSpeed min 1.5;
};

private _terrainGradient = abs _fwdAngle;
private _terrainFactor = 1;
private _gearMass = 0 max (((ACE_player getVariable [QACEGVAR(movement,totalLoad), loadAbs ACE_player]) / 22.046 - UNDERWEAR_WEIGHT) * ACEGVAR(advanced_fatigue,loadFactor));

if (isNull objectParent ACE_player && {_currentSpeed > 0.1} && {isTouchingGround ACE_player || {underwater ACE_player}}) then {
    if (!ACEGVAR(advanced_fatigue,isSwimming)) then {
        // If the unit is going downhill, it's much less demanding
        if (_fwdAngle < 0) then {
            _terrainGradient = 0.15 * _terrainGradient;
        };

        // Used to simulate the unevenness/roughness of the terrain
        if (_sideAngle != 0) then {
            private _sideGradient = abs (_sideAngle / 45) min 1;

            _terrainFactor = 1 + _sideGradient ^ 4;
        };
    };

    // Add a scaling factor of 0.1 to reduce excessive stamina consumption on default settings (see #10361)
    _currentWork = [_gearMass, _terrainGradient * ACEGVAR(advanced_fatigue,terrainGradientFactor) * 0.1, _terrainFactor, _currentSpeed] call FUNC(getMetabolicCosts);
    _currentWork = _currentWork max ((0.5617 * _bodyMass + 42.57) * BIOMECH_EFFICIENCY);
};

// Oxygen calculation
private _oxygen = (GET_KAT_SPO2(ACE_player) / 100);
// Calculate muscle damage increase
ACEGVAR(advanced_fatigue,muscleDamage) = ACEGVAR(advanced_fatigue,muscleDamage) + (_currentWork / ACEGVAR(advanced_fatigue,peakPower)) ^ 3.2 * MUSCLE_TEAR_RATE;

// Calculate muscle damage recovery
ACEGVAR(advanced_fatigue,muscleDamage) = 0 max (ACEGVAR(advanced_fatigue,muscleDamage) - MUSCLE_RECOVERY * ACEGVAR(advanced_fatigue,recoveryFactor)) min 1;
private _muscleIntegrity = 1 - ACEGVAR(advanced_fatigue,muscleDamage);
private _muscleFactor = sqrt _muscleIntegrity;

// Calculate available power
private _stimulantLoad = (_caffeineCount) + (_pervatinCount * 1.5);
private _stimulantMult = linearConversion [0, 3, _stimulantLoad, 1, 0.5, true];
private _ae1PathwayPowerFatigued = ACEGVAR(advanced_fatigue,ae1PathwayPower) * sqrt (ACEGVAR(advanced_fatigue,ae1Reserve) / AE1_MAXRESERVE) * _oxygen * _muscleFactor;
private _ae2PathwayPowerFatigued = ACEGVAR(advanced_fatigue,ae2PathwayPower) * sqrt (ACEGVAR(advanced_fatigue,ae2Reserve) / AE2_MAXRESERVE) * _oxygen * _muscleFactor;
_ae1PathwayPowerFatigued = _ae1PathwayPowerFatigued / _stimulantMult;
_ae2PathwayPowerFatigued = _ae2PathwayPowerFatigued / _stimulantMult;
private _aePathwayPowerFatigued  = _ae1PathwayPowerFatigued + _ae2PathwayPowerFatigued;
// private _anPathwayPowerFatigued  = ACEGVAR(advanced_fatigue,anPathwayPower) * sqrt (ACEGVAR(advanced_fatigue,anReserve) / AN_MAXRESERVE) * _oxygen * _muscleIntegrity; // not used

// Calculate how much power is consumed from each reserve
private _ae1Power = _currentWork min _ae1PathwayPowerFatigued;
private _ae2Power = (_currentWork - _ae1Power) min _ae2PathwayPowerFatigued;
private _anPowerRaw = 0 max (_currentWork - _ae1Power - _ae2Power);
private _anPower = _anPowerRaw * _stimulantMult;

// Remove ATP from reserves for current work
ACEGVAR(advanced_fatigue,ae1Reserve) = 0 max (ACEGVAR(advanced_fatigue,ae1Reserve) - _ae1Power / ACEGVAR(advanced_fatigue,aeWattsPerATP));
ACEGVAR(advanced_fatigue,ae2Reserve) = 0 max (ACEGVAR(advanced_fatigue,ae2Reserve) - _ae2Power / ACEGVAR(advanced_fatigue,aeWattsPerATP));
ACEGVAR(advanced_fatigue,anReserve)  = 0 max (ACEGVAR(advanced_fatigue,anReserve)  -  _anPower / ACEGVAR(advanced_fatigue,anWattsPerATP));

// Acidosis accumulation
ACEGVAR(advanced_fatigue,anFatigue)  = ACEGVAR(advanced_fatigue,anFatigue) + _anPower * ACEGVAR(advanced_fatigue,maxPowerFatigueRatio) * 1.1 * _stimulantMult;

// Aerobic ATP reserve recovery
ACEGVAR(advanced_fatigue,ae1Reserve) = (ACEGVAR(advanced_fatigue,ae1Reserve) + _oxygen * ACEGVAR(advanced_fatigue,recoveryFactor) * AE1_ATP_RECOVERY * (ACEGVAR(advanced_fatigue,ae1PathwayPower) - _ae1Power) / ACEGVAR(advanced_fatigue,ae1PathwayPower)) min AE1_MAXRESERVE;
ACEGVAR(advanced_fatigue,ae2Reserve) = (ACEGVAR(advanced_fatigue,ae2Reserve) + _oxygen * ACEGVAR(advanced_fatigue,recoveryFactor) * AE2_ATP_RECOVERY * (ACEGVAR(advanced_fatigue,ae2PathwayPower) - _ae2Power) / ACEGVAR(advanced_fatigue,ae2PathwayPower)) min AE2_MAXRESERVE;

private _aeSurplus = _ae1PathwayPowerFatigued + _ae2PathwayPowerFatigued - _ae1Power - _ae2Power;

// Anaerobic ATP reserve recovery
ACEGVAR(advanced_fatigue,anReserve) = 0 max (ACEGVAR(advanced_fatigue,anReserve) + _aeSurplus / ACEGVAR(advanced_fatigue,VO2MaxPower) * AN_ATP_RECOVERY * ACEGVAR(advanced_fatigue,recoveryFactor) * (ACEGVAR(advanced_fatigue,anFatigue) max linearConversion [AN_MAXRESERVE, 0, ACEGVAR(advanced_fatigue,anReserve), 0, 0.75, true]) ^ 2) min AN_MAXRESERVE; // max linearConversion ensures that if ACEGVAR(advanced_fatigue,anFatigue) is very low, it will still regenerate reserves
// Acidosis recovery
ACEGVAR(advanced_fatigue,anFatigue) = 0 max (ACEGVAR(advanced_fatigue,anFatigue) - _aeSurplus * ACEGVAR(advanced_fatigue,maxPowerFatigueRatio) * ACEGVAR(advanced_fatigue,recoveryFactor) * ACEGVAR(advanced_fatigue,anFatigue) ^ 2) min 1;

// Calculate a pseudo-perceived fatigue, which is used for effects
ACEGVAR(advanced_fatigue,aeReservePercentage) = (ACEGVAR(advanced_fatigue,ae1Reserve) / AE1_MAXRESERVE + ACEGVAR(advanced_fatigue,ae2Reserve) / AE2_MAXRESERVE) / 2;
ACEGVAR(advanced_fatigue,anReservePercentage) = ACEGVAR(advanced_fatigue,anReserve) / AN_MAXRESERVE;
private _perceivedFatigue = 1 - (ACEGVAR(advanced_fatigue,anReservePercentage) min ACEGVAR(advanced_fatigue,aeReservePercentage));

#ifdef DEBUG_MODE_FULL
systemChat format ["---- muscleDamage: %1 ----", ACEGVAR(advanced_fatigue,muscleDamage) toFixed 8];
systemChat format ["---- ae2: %1 - an: %2 ----", (ACEGVAR(advanced_fatigue,ae2Reserve) / AE2_MAXRESERVE) toFixed 2, (ACEGVAR(advanced_fatigue,anReserve) / AN_MAXRESERVE) toFixed 2];
systemChat format ["---- anFatigue: %1 - perceivedFatigue: %2 ----", ACEGVAR(advanced_fatigue,anFatigue) toFixed 2, _perceivedFatigue toFixed 2];
systemChat format ["---- velocity %1 - respiratoryRate: %2 ----", (vectorMagnitude _velocity) toFixed 2, ACEGVAR(advanced_fatigue,respiratoryRate) toFixed 2];
// systemChat format ["---- aePower: %1 ----", _aePathwayPowerFatigued toFixed 1];
#endif

[ACE_player, _perceivedFatigue, ACEGVAR(advanced_fatigue,anReserve) == 0, _fwdAngle, _sideAngle] call ACEFUNC(advanced_fatigue,handleEffects);

if (ACEGVAR(advanced_fatigue,enableStaminaBarRealized)) then {
    [ACEGVAR(advanced_fatigue,anReserve) / AN_MAXRESERVE] call ACEFUNC(advanced_fatigue,handleStaminaBar);
};

[LINKFUNC(mainLoop), [], 1] call CBA_fnc_waitAndExecute;