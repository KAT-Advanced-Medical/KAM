/*
 * Author: Cplhardcore
 * Applies Overdose effects
 *
 * Arguments:
 * 0: Patient <OBJECT>
 * 1: Medication <String>
 * 
 * Return Value:
 * None
 *
 * Example:
 * [cursorTarget, "Morphine"] call kat_pharma_fnc_overdose;
 *
 * Public: No
 */
 params ["_patient", "_classname",];
 
 switch (_classname) do {
        case "Morphine": {
        };
        case "Epinephrine": {
        };
 };