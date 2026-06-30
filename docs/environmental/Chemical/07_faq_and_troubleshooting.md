## FAQ & Troubleshooting

### **My gas mask isn't protecting me from the mustard/sarin/VX cloud.**
That's intended. Level 2 agents go through the skin — you need a full CBRN suit, meaning a mask **and** a uniform that's on the *Available CBRN Suit Uniforms* whitelist. Check that your unit's uniform classname is in that setting.

### **I left the cloud but I'm still taking damage / coughing.**
Two possibilities. If it's mustard or VX, you're **contaminated** — the agent is still on you and re-poisons you every 40 seconds. Use a **Decontamination Kit**. If it's phosgene, the **delayed onset** has caught up with you (2–6 minutes after exposure) — use **Atropine**.

### **I gave the casualty ATNAA but they went into cardiac arrest anyway.**
For sarin, the ATNAA has to be administered **before** the cardiac-arrest deadline (90 seconds by default). For VX, ATNAA alone isn't enough — the skin contamination re-applies the agent and starts a new chain, so you must **also** use a decon kit. Re-administer ATNAA and follow up with decon.

### **M8 paper says NEGATIVE but people are getting sick.**
M8 paper only detects nerve and blister agents. Chlorine and phosgene are choking agents and will always read NEGATIVE — that's realistic. Use the JCAD detector or smell hints for those.

### **Nothing shows up in the medical menu.**
Check the *Show Poisoning* setting is enabled. If it's off, poisoning and intoxication are intentionally hidden from the menu.

### **AI mortars never fire sarin/VX/mustard.**
Correct — AI mortars are restricted to choking agents by design. Use the gas module, Zeus, or a player-crewed mortar to deploy the Level 2 agents.