#include "function_macros.hpp";

params["_patient"];

private _pneumothorax = [_patient] call FUNC(kat_getPneumothorax);
private _hemopneumothorax = [_patient] call FUNC(kat_getHemopneumothorax);
private _tensionPneumothorax = [_patient] call FUNC(kat_getTensionPneumothorax);
private _airwayObstruction = [_patient] call FUNC(kat_getAirwayObstruction);
private _airWayOcclusion = [_patient] call FUNC(kat_getAirwayOcclusion);
private _spO2Low = ([_patient] call FUNC(kat_getAirwayStatus) < 85);

//display action if any are true
_spO2Low || _airwayObstruction || _airWayOcclusion || _pneumothorax || _hemopneumothorax || _tensionPneumothorax