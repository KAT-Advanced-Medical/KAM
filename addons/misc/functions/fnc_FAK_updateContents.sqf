#include "script_component.hpp"
/*
 * Author: Blue
 * Update contents of FAKs
 *
 * Arguments:
 * None
 *
 * Return Value:
 * None
 *
 * Example:
 * [] call kat_misc_fnc_FAK_updateContents;
 *
 * Public: No
 */

// IFAK
missionNameSpace setVariable [QGVAR(IFAKContents),
[(missionNamespace getVariable [QGVAR(IFAKFirstSlotItem), []]),
(missionNamespace getVariable [QGVAR(IFAKSecondSlotItem), []]),
(missionNamespace getVariable [QGVAR(IFAKThirdSlotItem), []]),
(missionNamespace getVariable [QGVAR(IFAKFourthSlotItem), []])]];

// AFAK
missionNameSpace setVariable [QGVAR(AFAKContents),
[(missionNamespace getVariable [QGVAR(AFAKFirstSlotItem), []]),
(missionNamespace getVariable [QGVAR(AFAKSecondSlotItem), []]),
(missionNamespace getVariable [QGVAR(AFAKThirdSlotItem), []]),
(missionNamespace getVariable [QGVAR(AFAKFourthSlotItem), []]),
(missionNamespace getVariable [QGVAR(AFAKFifthSlotItem), []]),
(missionNamespace getVariable [QGVAR(AFAKSixthSlotItem), []])]];

// MFAK
missionNameSpace setVariable [QGVAR(MFAKContents),
[(missionNamespace getVariable [QGVAR(MFAKFirstSlotItem), []]),
(missionNamespace getVariable [QGVAR(MFAKSecondSlotItem), []]),
(missionNamespace getVariable [QGVAR(MFAKThirdSlotItem), []]),
(missionNamespace getVariable [QGVAR(MFAKFourthSlotItem), []]),
(missionNamespace getVariable [QGVAR(MFAKFifthSlotItem), []]),
(missionNamespace getVariable [QGVAR(MFAKSixthSlotItem), []]),
(missionNamespace getVariable [QGVAR(MFAKSeventhSlotItem), []]),
(missionNamespace getVariable [QGVAR(MFAKEighthSlotItem), []])]];