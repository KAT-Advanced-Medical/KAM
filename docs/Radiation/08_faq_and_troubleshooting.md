## FAQ & Troubleshooting

### **My geiger is screaming but I'm not taking any damage. Is it broken?**
No — that's working as intended, and it might be your gear doing its job. The geiger reads the **dose rate** (the field around you), which your shielding does *not* change. What your shielding reduces is the **accumulated dose** — the Gy total you actually soak up. Watch that number: if it's barely climbing while the rate is high, your suit/vehicle is protecting you. (And if you're in a pure-gamma field with only a mask on, the rate being scary while the dose climbs fast is *also* correct — a mask doesn't stop gamma.)

### **I left the radiation hours ago but my dose is still going up.**
You breathed it in. That's **internal contamination** — radioactive material inside you that keeps converting to dose long after you've left. A geiger and a decon kit can't help with it because it isn't on your surface. Use **Prussian Blue** to chelate it out, or wait for your body to slowly clear it.

### **I deconned the casualty but their dose didn't drop.**
Decon only removes **surface** contamination — it stops them reading hot and cross-contaminating others, but it does nothing to dose already absorbed, and nothing to internal contamination. If their dose is still climbing, it's internal (use Prussian Blue). If it's just high but stable, that's the permanent record of what they absorbed — there's no scrubbing that off, only treating the sickness.

### **A pure gamma source gave me almost no burns. Shouldn't radiation burn me?**
Not gamma. Skin/radiation burns come from **beta** and from **handling a source point-blank**. Gamma and neutron drive whole-body dose, not skin dose, so a gamma zone makes you *sick* without covering you in burns. Stand in a beta field — or pick up a `kat_radSource` — to see burns.

### **I walked into a hot zone and died almost instantly. Is that normal?**
Only if the source is enormous. Source strength is in **Gy/h**, and a very high value (say several hundred) will push you past the 6 Gy lethal threshold in well under a minute. If you want a survivable hazard, lower the source strength, raise the dose thresholds, or both — see [Zeus & mission makers](07_zeus_and_MissionMakers.md).

### **One of the sickness effects does nothing — no fever / no blood-pressure drop / bleeding still clots.**
That effect's host subsystem is probably disabled. The physiology layers ride on other KAT systems: fever needs **Hypothermia**, acidosis needs **Breathing**, hypotension needs **Circulation**, won't-clot bleeding needs **Pharmacy Coagulation**, and anemia regen needs **Vitals Fluid Shift**. They're all on by default — check none got switched off. (Radiation skips a disabled layer cleanly; it won't error.)

### **My AI test casualty ignores all the physiology.**
Turn **Simple Medical OFF** in KAT Vitals. Simple medical bypasses the detailed vitals loop that the radiation effects hook into. Players always get the full sim; AI only do when simple medical is off.

### **The casualty recovered from severe radiation sickness on their own. Bug?**
Intended. Below the lethal tier, sickness heals slowly once the casualty is out of radiation (and clear of internal contamination). **Filgrastim** speeds it up. Only the **lethal tier** never self-recovers. Note the *accumulated dose* on the dosimeter stays put — that's the exposure record; it's the sickness that fades, not the history.

### **A medic treating a contaminated casualty started getting dosed.**
That's cross-contamination, and it's intended. A surface-contaminated casualty emits a weak field of their own. **Decon them** to shut it off — until you do, anyone working on them is standing next to a small source. Survey first, decon, then treat.

### **The dosimeter clicks won't stop even in clean air.**
You're contaminated — *you* are the source the geiger is reading. Survey yourself and use the decon kit. (If you've turned the dosimeter sound off and it still seems to click, that's the placeholder chime samples — dedicated click audio is planned.)

### **Is radiation a separate addon I need to enable?**
No. Radiation is part of the **Chemical** addon — same PBO, same CBA settings category (under the "10. Radiation" subcategory). If you have KAT's chemical addon, you have radiation.
