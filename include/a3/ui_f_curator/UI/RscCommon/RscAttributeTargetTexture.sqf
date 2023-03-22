// Includes
#include "\A3\UI_F_Curator\ui\defineResinclDesign.inc"

// Parameters
private ["_action", "_parameters", "_object"];
_action 	= _this param [0, "", [""]];
_parameters 	= _this param [1, [], [[]]];
_object		= _this param [2, objNull, [objNull]];

// IDC's
private ["_idcPreview", "_idcTextureList"];
_idcPreview 	= IDC_RSCATTRIBUTETARGETTEXTURE_PREVIEW;
_idcTextureList	= IDC_RSCATTRIBUTETARGETTEXTURE_TEXTURELIST;

// Sub-functions
switch _action do {
	case "onLoad": {
		// Parameters
		private ["_display"];
		_display = _parameters param [0, displayNull, [displayNull]];
		
		// The preview and texture list box
		private ["_ctrlPreview", "_ctrlTextureList"];
		_ctrlPreview		= _display displayCtrl _idcPreview;
		_ctrlTextureList	= _display displayCtrl _idcTextureList;
		
		// Add event handler to the list box, to detect when user changes the selected item
		_ctrlTextureList ctrlAddEventHandler ["lbSelChanged", { with uinamespace do { ["onTextureChanged", [_this select 0]] call RscAttributeTargetTexture; }; }];
		
		// The textures
		private "_textures";
		_textures = getArray (configFile >> "CfgVehicles" >> typeOf _object >> "textures");
		
		// Fill the list box with textures
		{
			_ctrlTextureList lbAdd (_x select 0);
			_ctrlTextureList lbSetData [_forEachIndex, _x select 1];
		} forEach _textures;
		
		// Select the first item in the list or the last user selected one
		_ctrlTextureList lbSetCurSel (_object getVariable ["RscAttributeTargetTexture_textureIndex", 0]);
	};
	
	case "onTextureChanged": {
		// The List box
		private "_ctrlTextureList";
		_ctrlTextureList = _parameters param [0, controlNull, [controlNull]];
		
		// The display
		private "_display";
		_display = ctrlParent _ctrlTextureList;
		
		// The preview image
		private "_ctrlPreview";
		_ctrlPreview = _display displayCtrl _idcPreview;
		
		// The new image to display
		private "_image";
		_image = _ctrlTextureList lbData (lbCurSel _ctrlTextureList);
		
		// Set the preview image to the newly selected item in the list box
		_ctrlPreview ctrlSetText _image;
	};
	
	case "confirmed": {
		// The display
		private "_display";
		_display = _parameters param [0, displayNull, [displayNull]];
		
		// The List box
		private "_ctrlTextureList";
		_ctrlTextureList = _display displayCtrl _idcTextureList;
		
		// The new image to display
		private "_image";
		_image = _ctrlTextureList lbData (lbCurSel _ctrlTextureList);
		
		// Set the texture on the object
		_object setObjectTextureGlobal [0, _image];
		
		// Store
		_object setVariable ["RscAttributeTargetTexture_textureIndex", lbCurSel _ctrlTextureList, true];
	};
	
	case "onUnload": {
		
	};
	
	case default {
		// Error
		["Invalid action (%1)", _action] call BIS_fnc_error;
	};
};
