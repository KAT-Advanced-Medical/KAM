["Attachable_Stretcher", ["CONTAINER","CLOTHES"], ["Attach Stretcher"], [], "", [{true},{params ["_unit", "_container", "_item", "_slot", "_params"];_unit == vehicle _unit}], {
    params ["_unit", "_container", "_item", "_slot", "_params"];
    [_unit,_item] call Rev_fnc_stretcher_attach;
},true] call CBA_fnc_addItemContextMenuOption;
