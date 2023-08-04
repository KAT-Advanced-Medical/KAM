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

switch (_unit getVariable [QGVAR(cardiacArrestType), 0]) do {
    case 4: {
         round (random [150, 180, 200]);
    };
    case 3: {
        round (random [70, 100, 150]);
    };
    case 2: {
        round (random [70, 80, 100]);
    };
    default {
        0;
    };
};