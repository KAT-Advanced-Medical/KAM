params["_search"];
// I'm assuming that I'll never have booleans loaded from stringtable.xml
private _result = uiNamespace getVariable[_search, false]; 
if(_result isEqualType false) exitWith // so as long as I don't actually load booleans I'll be ok
{
	_result = localize _search;// if I say it enough, does it become true?
	uiNamespace setVariable[_search, _result]; // Apologies to anyone who has to fix an issue caused by this assumption :)
	_result 
};
_result;