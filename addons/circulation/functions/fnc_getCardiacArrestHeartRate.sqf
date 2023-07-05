#include "script_component.hpp"
/*
 * Author: Blue
 * Generate heart rate for type of cardiac arrest
 *
 * Arguments:
 * 0: Unit <OBJECT>
 *
 * Return Value:
 * Heart rate <INT>
 *
 * Example:
 * [player] call kat_circulation_fnc_getCardiacArrestHeartRate;
 *
 * Public: No
 */

params ["_unit"];

/* type 
0 normal
1 asystole, no pulse, no shock
2 pulseless electrical activity, AEDX fake pulse, no shock
3 ventricular fibrillation, no pulse, shock
4 ventricular tachycardia, fast pulse, shock
*/

if(_unit getVariable [QGVAR(cardiacArrestType),0] isEqualTo 4) then {
    round (random [240, 280, 300]);
} else {
    round (random [70, 80, 100]);
};