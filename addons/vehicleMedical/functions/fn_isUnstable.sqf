#include "..\script_component.hpp";

params["_patient"];

private _dead = GVAR(Unstable_TrackDead) && !alive _patient;
private _bleeding = GVAR(Unstable_TrackBleeding) && [_patient] call FUNC(isBleeding);
private _sleepy = GVAR(Unstable_TrackUnconscious) && [_patient] call FUNC(isUnconscious);
private _cardiac = GVAR(Unstable_TrackCardiacArrest) && [_patient] call FUNC(isCardiacArrest);
private _legFractures = GVAR(Unstable_TrackLegFractures) && [_patient] call FUNC(hasLegFractures);
private _pneumothorax = [_patient] call FUNC(kat_getPneumothorax);
private _hemopneumothorax = [_patient] call FUNC(kat_getHemopneumothorax);
private _tensionPneumothorax = [_patient] call FUNC(kat_getTensionPneumothorax);
private _airwayObstruction = [_patient] call FUNC(kat_getAirwayObstruction);
private _airWayOcclusion = [_patient] call FUNC(kat_getAirwayOcclusion);
private _spO2Low = ([_patient] call FUNC(kat_getAirwayStatus) < 85);

//display action if any are true
_spO2Low || _airwayObstruction || _airWayOcclusion || _pneumothorax || _hemopneumothorax || _tensionPneumothorax

//display action if any are true
_bleeding || _sleepy || _cardiac || _legFractures || _dead || _kat_unstable