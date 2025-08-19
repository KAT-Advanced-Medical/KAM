#include "function_macros.hpp";

params["_patient"];

private _dead = GVAR(Unstable_TrackDead) && !alive _patient;
private _bleeding = GVAR(Unstable_TrackBleeding) && [_patient] call FUNC(isBleeding);
private _sleepy = GVAR(Unstable_TrackUnconscious) && [_patient] call FUNC(isUnconscious);
private _cardiac = GVAR(Unstable_TrackCardiacArrest) && [_patient] call FUNC(isCardiacArrest);
private _legFractures = GVAR(Unstable_TrackLegFractures) && [_patient] call FUNC(hasLegFractures);
private _kat_unstable = GVAR(EnableSupportKAT) && [_patient] call FUNC(kat_isUnstable);

//display action if any are true
_bleeding || _sleepy || _cardiac || _legFractures || _dead || _kat_unstable