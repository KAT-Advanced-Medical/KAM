#include "script_component.hpp"
/*
 * Author: Miss Heda
 * Unattaches a armband from a previously attached limb.
 *
 * Arguments:
 * 0: Player <OBJECT>
 * 1: Number
 *
 * Return Value:
 * None
 *
 * Example:
 * [player, 0] call kat_misc_fnc_slingArmband;
 *
 * Public: No
 */

params [
    "_unit",
    "_limbnumber"
];

switch (_limbnumber) do 
{
    case 0: { 
        private	_objectLA = _unit getVariable [QGVAR(whichArmabndisSlingedLA), ObjNull];

        switch (typeOf _objectLA) do
        {
            case "Kat_armbandRC": {
                [_unit, "kat_armband_red_cross"] call ACEFUNC(common,addToInventory);
                _unit setVariable [QGVAR(isLeftArmFree), true, true];
                deleteVehicle _objectLA;
            };

            case "Kat_armbandRCM": {
                [_unit, "kat_armband_medic"] call ACEFUNC(common,addToInventory);
                _unit setVariable [QGVAR(isLeftArmFree), true, true];
                deleteVehicle _objectLA;
            };

                case "Kat_armbandRCD": {
				[_unit, "kat_armband_doctor"] call ACEFUNC(common,addToInventory);
				_unit setVariable [QGVAR(isLeftArmFree), true, true];
				deleteVehicle _objectLA;
			};

			case "Kat_armbandKAT": {
				[_unit, "kat_armband_kat"] call ACEFUNC(common,addToInventory);
				_unit setVariable [QGVAR(isLeftArmFree), true, true];
				deleteVehicle _objectLA;
			};
		};
	};

	case 1: {
		private	_objectRA = _unit getVariable [QGVAR(whichArmabndisSlingedRA), ObjNull];

		switch (typeOf _objectRA) do
		{
			case "Kat_armbandRC": {
				[_unit, "kat_armband_red_cross"] call ACEFUNC(common,addToInventory);
				_unit setVariable [QGVAR(isRightArmFree), true, true];
				deleteVehicle _objectRA;
			};

			case "Kat_armbandRCM": {
				[_unit, "kat_armband_medic"] call ACEFUNC(common,addToInventory);
				_unit setVariable [QGVAR(isRightArmFree), true, true];
				deleteVehicle _objectRA;
			};

			case "Kat_armbandRCD": {
				[_unit, "kat_armband_doctor"] call ACEFUNC(common,addToInventory);
				_unit setVariable [QGVAR(isRightArmFree), true, true];
				deleteVehicle _objectRA;
			};

			case "Kat_armbandKAT": {
				[_unit, "kat_armband_kat"] call ACEFUNC(common,addToInventory);
				_unit setVariable [QGVAR(isRightArmFree), true, true];
				deleteVehicle _objectRA;
			};
		};
	};

	case 2: {
		private	_objectLL = _unit getVariable [QGVAR(whichArmabndisSlingedLL), ObjNull];

		switch (typeOf _objectLL) do
		{
			case "Kat_armbandRC": {
				[_unit, "kat_armband_red_cross"] call ACEFUNC(common,addToInventory);
				_unit setVariable [QGVAR(isLeftLegFree), true, true];
				deleteVehicle _objectLL;
			};

			case "Kat_armbandRCM": {
				[_unit, "kat_armband_medic"] call ACEFUNC(common,addToInventory);
				_unit setVariable [QGVAR(isLeftLegFree), true, true];
				deleteVehicle _objectLL;
			};

			case "Kat_armbandRCD": {
				[_unit, "kat_armband_doctor"] call ACEFUNC(common,addToInventory);
				_unit setVariable [QGVAR(isLeftLegFree), true, true];
				deleteVehicle _objectLL;
			};

			case "Kat_armbandKAT": {
				[_unit, "kat_armband_kat"] call ACEFUNC(common,addToInventory);
				_unit setVariable [QGVAR(isLeftLegFree), true, true];
				deleteVehicle _objectLL;
			};
		};
	};

	case 3: {
		private	_objectRL = _unit getVariable [QGVAR(whichArmabndisSlingedRL), ObjNull];

		switch (typeOf _objectRL) do
		{
			case "Kat_armbandRC": {
				[_unit, "kat_armband_red_cross"] call ACEFUNC(common,addToInventory);
				_unit setVariable [QGVAR(isRightLegFree), true, true];
				deleteVehicle _objectRL;
			};

			case "Kat_armbandRCM": {
				[_unit, "kat_armband_medic"] call ACEFUNC(common,addToInventory);
				_unit setVariable [QGVAR(isRightLegFree), true, true];
				deleteVehicle _objectRL;
			};

			case "Kat_armbandRCD": {
				[_unit, "kat_armband_doctor"] call ACEFUNC(common,addToInventory);
				_unit setVariable [QGVAR(isRightLegFree), true, true];
				deleteVehicle _objectRL;
			};

			case "Kat_armbandKAT": {
				[_unit, "kat_armband_kat"] call ACEFUNC(common,addToInventory);
				_unit setVariable [QGVAR(isRightLegFree), true, true];
				deleteVehicle _objectRL;
			};
		};
	};
};