/*
 * Author: Katalam
 * Handle medical menu opened
 *
 * Arguments:
 * 0: Medical Menu display <DISPLAY>
 *
 * Return Value:
 * None
 *
 * Example:
 * [medical_menu] call ace_medical_menu_fnc_onMenuOpen
 *
 * Public: No
 */
#define MAX_DISTANCE 10

params ["_display"];

if (isNil "_display") exitWith {};

if (EGVAR(interact_menu,menuBackground)==1) then {[QGVAR(id), true] call EFUNC(common,blurScreen);};
if (EGVAR(interact_menu,menuBackground)==2) then {0 cutRsc[QEGVAR(interact_menu,menuBackground), "PLAIN", 1, false];};

if (isNil QGVAR(LatestDisplayOptionMenu)) then {
    GVAR(LatestDisplayOptionMenu) = "triage";
} else {
    if (GVAR(LatestDisplayOptionMenu) == "toggle") then {
        GVAR(LatestDisplayOptionMenu) = "triage";
        GVAR(INTERACTION_TARGET) = GVAR(INTERACTION_TARGET_PREVIOUS);
    };
};

private _target = GVAR(INTERACTION_TARGET);
if (isNil QGVAR(INTERACTION_TARGET_PREVIOUS)) then {
    GVAR(INTERACTION_TARGET_PREVIOUS) = _target;
};
[GVAR(LatestDisplayOptionMenu)] call FUNC(handleUI_DisplayOptions);

disableSerialization;

[_target, _display] call FUNC(updateUIInfo);

if (GVAR(MenuPFHID) != -1) exitWith {ERROR("PFID already running");};

kat_aceBreathing_MenuPFHID = [{

    (_this select 0) params ["_display"];
    if (isNull GVAR(INTERACTION_TARGET)) then {
        GVAR(INTERACTION_TARGET) = ACE_player;
    };
    [GVAR(INTERACTION_TARGET), _display] call FUNC(updateUIInfo);
    [GVAR(INTERACTION_TARGET)] call FUNC(updateIcons);
    [GVAR(LatestDisplayOptionMenu)] call FUNC(handleUI_DisplayOptions);

    //Check that it's valid to stay open:
    if !(([ACE_player, GVAR(INTERACTION_TARGET), ["isNotInside", "isNotSwimming"]] call EFUNC(common,canInteractWith)) && {[ACE_player, GVAR(INTERACTION_TARGET)] call FUNC(canOpenMenu)}) then {
        closeDialog 314412;
        //If we failed because of distance check, show UI message:
        if ((ACE_player distance GVAR(INTERACTION_TARGET)) > GVAR(maxRange)) then {
            [[ELSTRING(medical,DistanceToFar), [GVAR(INTERACTION_TARGET)] call EFUNC(common,getName)], 2] call EFUNC(common,displayTextStructured);
        };
    };

}, 0, [_display]] call CBA_fnc_addPerFrameHandler;

["ace_medicalMenuOpened", [ACE_player, _target]] call CBA_fnc_localEvent;
