## FAQ & Troubleshooting

### **My gas mask isn't protecting me from the mustard/sarin/VX cloud.**
That's intended. Level 2 agents go through the skin — you need a full CBRN suit, meaning a mask **and** a uniform that's on the *Available CBRN Suit Uniforms* whitelist. Check that your unit's uniform classname is in that setting.

### **I left the cloud but I'm still taking damage / coughing.**
Two possibilities. If it's mustard or VX, you're **contaminated** — the agent is still on you and re-poisons you every 40 seconds. Use a **Decontamination Kit**. If it's phosgene, the **delayed onset** has caught up with you — get on **oxygen** and give **Dexamethasone**.

### **I gave the casualty ATNAA but they went into cardiac arrest anyway.**
For sarin, the ATNAA has to be administered **before** the cardiac-arrest deadline (90 seconds by default). For VX, ATNAA alone isn't enough — the skin contamination re-applies the agent and starts a new chain, so you must **also** use a decon kit. Re-administer ATNAA and follow up with decon.

### **M8 paper says NEGATIVE but people are getting sick.**
M8 paper only detects nerve and blister agents. Chlorine and phosgene are choking agents and will always read NEGATIVE — that's realistic. Use the JCAD detector or smell hints for those.

### **I gave Atropine and the casualty didn't get better.**
Working as intended. Atropine **halts** lung injury from getting worse — it no longer cures it. Give **Dexamethasone** for the cure, and put them on oxygen in the meantime.

### **A mustard casualty isn't offered a chest seal or needle decompression.**
Also working as intended. Mustard causes diffuse **inhalation injury**, not a pneumothorax — there is no air in the pleural space and nothing to seal or decompress. Treat it with oxygen and Dexamethasone. See [Inhalation & Chemical Lung Injury](../Respiratory/03_inhalation_injury.md).

### **Nothing shows up in the medical menu.**
Check the *Show Poisoning* setting is enabled. If it's off, poisoning and intoxication are intentionally hidden from the menu. Lung injury is controlled separately by *Show lung injury in medical menu*, which is **off by default** — by design, so medics have to examine the casualty rather than reading it off a list.

### **AI mortars never fire sarin/VX/mustard.**
Correct — AI mortars are restricted to choking agents by design. Use the gas module, Zeus, or a player-crewed mortar to deploy the Level 2 agents.