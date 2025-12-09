#include "..\script_component.hpp"

params["_patient"];

private _dead = GVAR(Unstable_TrackDead) && !alive _patient;
private _bleeding = GVAR(Unstable_TrackBleeding) && [_patient] call FUNC(needsBandage);
private _sleepy = GVAR(Unstable_TrackUnconscious) && IS_UNCONSCIOUS(_patient);
private _cardiacArrest = GVAR(Unstable_TrackCardiacArrest) && (_patient getVariable [QEGVAR(circulation,cardiacArrestType), 0] != 0);
private _spO2Low = (GET_KAT_SPO2(_patient) < 90);

//display action if any are true
_bleeding || _sleepy || _cardiacArrest || _dead || _spO2Low