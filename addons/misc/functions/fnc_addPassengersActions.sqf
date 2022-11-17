#include "script_component.hpp"
/*
 * Author: esteldunedain Edit by Katalam
 * Create one action per passenger.
 *
 * Arguments:
 * 0: Vehicle <OBJECT>
 * 1: Player <OBJECT>
 * 3: Parameters <ARRAY>
 *
 * Return Value:
 * Children actions <ARRAY>
 *
 * Example:
 * [target, player, [params]] call ace_interaction_fnc_addPassengersActions
 *
 * Public: No
 */

params ["_vehicle", "_player"];

private _actions = [];

{
    private _unit = _x;

    if (_unit != _player && {getText (configFile >> "CfgVehicles" >> typeOf _unit >> "simulation") != "UAVPilot"}) then {
        private _icon = [
            "",
            "A3\ui_f\data\IGUI\RscIngameUI\RscUnitInfo\role_driver_ca.paa",
            "A3\ui_f\data\IGUI\RscIngameUI\RscUnitInfo\role_gunner_ca.paa",
            "A3\ui_f\data\IGUI\RscIngameUI\RscUnitInfo\role_commander_ca.paa"
        ] select (([driver _vehicle, gunner _vehicle, commander _vehicle] find _unit) + 1);

        private _triage = _unit getVariable [QACEGVAR(medical,triageLevel), 0];
        if (_triage > 1 && _triage < 4) then {
            _icon = ["\z\ace\addons\medical\UI\icons\medical_crossYellow.paa", "\z\ace\addons\medical\UI\icons\medical_crossRed"] select (_triage - 2);
        };

        if (_unit getVariable [QACEGVAR(captives,isHandcuffed), false]) then {
            _icon = "\z\ace\addons\captives\UI\handcuff_ca.paa";
        };

        _actions pushBack [
            [
                format ["%1", _unit],
                [_unit, true] call ACEFUNC(common,getName),
                _icon,
                {
                    //statement (Run on hover) - reset the cache so we will insert actions immedietly when hovering over new unit
                    [vehicle _target, "ace_interact_menu_ATCache_ACE_SelfActions"] call ACEFUNC(common,eraseCache);
                },
                {true},
                {
                    if (ACEGVAR(interact_menu,selectedTarget) isEqualTo _target) then {
                        _this call ACEFUNC(interaction,addPassengerActions);
                    } else {
                        [] //not selected, don't waste time on actions
                    };
                },
                [_unit],
                {[0, 0, 0]},
                2,
                [false,false,false,true,false] //add run on hover (4th bit true)
                ] call ACEFUNC(interact_menu,createAction),
                [],
                _unit
            ];
    };
    false
} count crew _vehicle;

_actions
