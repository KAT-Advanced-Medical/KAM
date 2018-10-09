/*
 * Author: Katalam
 * Handling the deathtimer for airway injuries
 *
 * Arguments:
 * 0: Unit That Was Hit <OBJECT>
 *
 * Return Value:
 * None
 *
 * Example:
 * [bob, time, "O"] call kat_aceAirway_fnc_handleDie;
 *
 * Public: No
 */

params ["_unit", "_time", "_type"];

switch (_type) do {
    case "O": {
      [{(serverTime >= (_timeNew = serverTime + kat_aceAirway_deathTimer) && (true isEqualTo (_unit getVariable ["ace_medical_inReviveState", false]))}, {[_unit, true, false] call ace_medical_fnc_setDead;}, [], XX]  call CBA_fnc_waitUntilAndExecute; //Statement // Timeout Variable für ace medical revie Time
    };
    case "C": {

    };
    default {
      false;
    };
};
