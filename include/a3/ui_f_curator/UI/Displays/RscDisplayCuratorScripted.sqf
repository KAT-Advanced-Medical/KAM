_mode = _this select 0;
_params = _this select 1;

switch _mode do {
	case "onLoad": {
		_params spawn (uinamespace getvariable "BIS_fnc_curatorInterfaceInit");
	};
	case "onUnload": {
		_params spawn (uinamespace getvariable "BIS_fnc_curatorInterfaceExit");
	};
};