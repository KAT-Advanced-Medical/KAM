#include "..\script_component.hpp"
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
missionNamespace setVariable [QGVAR(IFAKContents),
[(missionNamespace getVariable [QGVAR(IFAKFirstSlotItem), []]),
(missionNamespace getVariable [QGVAR(IFAKSecondSlotItem), []]),
(missionNamespace getVariable [QGVAR(IFAKThirdSlotItem), []]),
(missionNamespace getVariable [QGVAR(IFAKFourthSlotItem), []])]];

// AFAK
missionNamespace setVariable [QGVAR(AFAKContents),
[(missionNamespace getVariable [QGVAR(AFAKFirstSlotItem), []]),
(missionNamespace getVariable [QGVAR(AFAKSecondSlotItem), []]),
(missionNamespace getVariable [QGVAR(AFAKThirdSlotItem), []]),
(missionNamespace getVariable [QGVAR(AFAKFourthSlotItem), []]),
(missionNamespace getVariable [QGVAR(AFAKFifthSlotItem), []]),
(missionNamespace getVariable [QGVAR(AFAKSixthSlotItem), []])]];

// MFAK
missionNamespace setVariable [QGVAR(MFAKContents),
[(missionNamespace getVariable [QGVAR(MFAKFirstSlotItem), []]),
(missionNamespace getVariable [QGVAR(MFAKSecondSlotItem), []]),
(missionNamespace getVariable [QGVAR(MFAKThirdSlotItem), []]),
(missionNamespace getVariable [QGVAR(MFAKFourthSlotItem), []]),
(missionNamespace getVariable [QGVAR(MFAKFifthSlotItem), []]),
(missionNamespace getVariable [QGVAR(MFAKSixthSlotItem), []]),
(missionNamespace getVariable [QGVAR(MFAKSeventhSlotItem), []]),
(missionNamespace getVariable [QGVAR(MFAKEighthSlotItem), []])]];

// MEDPACK
missionNamespace setVariable [QGVAR(MEDPACKContents),
[(missionNamespace getVariable [QGVAR(MEDPACKFirstSlotItem), []]),
(missionNamespace getVariable [QGVAR(MEDPACKSecondSlotItem), []]),
(missionNamespace getVariable [QGVAR(MEDPACKThirdSlotItem), []]),
(missionNamespace getVariable [QGVAR(MEDPACKFourthSlotItem), []]),
(missionNamespace getVariable [QGVAR(MEDPACKFifthSlotItem), []]),
(missionNamespace getVariable [QGVAR(MEDPACKSixthSlotItem), []]),
(missionNamespace getVariable [QGVAR(MEDPACKSeventhSlotItem), []]),
(missionNamespace getVariable [QGVAR(MEDPACKEighthSlotItem), []])]];

// Get Slot Names (didn't wanna create a new file for this)
missionNamespace setVariable [QGVAR(FAKSlotNames),
[(LLSTRING(FAK_Slot_1_Hint)),
(LLSTRING(FAK_Slot_2_Hint)),
(LLSTRING(FAK_Slot_3_Hint)),
(LLSTRING(FAK_Slot_4_Hint)),
(LLSTRING(FAK_Slot_5_Hint)),
(LLSTRING(FAK_Slot_6_Hint)),
(LLSTRING(FAK_Slot_7_Hint)),
(LLSTRING(FAK_Slot_8_Hint))]];

missionNamespace setVariable [QGVAR(MEDPACKSlotNames),
[(LLSTRING(MEDPACK_Slot_1_Hint)),
(LLSTRING(MEDPACK_Slot_2_Hint)),
(LLSTRING(MEDPACK_Slot_3_Hint)),
(LLSTRING(MEDPACK_Slot_4_Hint)),
(LLSTRING(MEDPACK_Slot_5_Hint)),
(LLSTRING(MEDPACK_Slot_6_Hint)),
(LLSTRING(MEDPACK_Slot_7_Hint)),
(LLSTRING(MEDPACK_Slot_8_Hint))]];

