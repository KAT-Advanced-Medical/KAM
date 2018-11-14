/*
 * Author: Katalam
 * CBA Events function
 *
 * Arguments:
 * None
 *
 * Return Value:
 * None
 *
 * Example:
 * call kat_aceCirculation_fnc_events;
 *
 * Public: No
 */

["treatmentIVfalse", {_this call kat_aceCirculation_fnc_treatmentAdvanced_IV}] call CBA_fnc_addEventHandler;
["IVreset", {_this call kat_aceCirculation_fnc_removeEffect_IV}] call CBA_fnc_addEventHandler;
/*
private _checkTagAction = [
    "ACE_CheckDogtagSelf",
    format ["%1: %2", localize "STR_ACE_Dogtags_itemName", localize "STR_ACE_Dogtags_checkDogtag"],
    "\ace\addons\dogtags\data\dogtag_icon_ca.paa", //z
    {[_player, _target] call ace_dogtags_fnc_checkDogtag},
    {!isNil {_target getVariable ace_dogtags_dogtagData}}
] call ace_interact_menu_fnc_createAction;

["ACE_bodyBagObject", 0, ["ACE_MainActions"], _checkTagAction] call EFUNC(interact_menu,addActionToClass);
*/
