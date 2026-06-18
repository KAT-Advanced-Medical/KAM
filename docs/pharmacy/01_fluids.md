# Intravenous Fluid & Catheter Logistics

## Access Protocols & Needle Engineering
Administering blood products, plasma, or crystalloid options requires establishing access.

* **16g Intravenous Catheter (IV):** Restricted to peripheral upper/lower extremities. Cannot flow if a Tourniquet is applied higher up the target limb. Easily prone to clotting blocks if TXA or EACA blocks are pushed down the line.
* **FAST Intraosseous Module (IO):** Mounted exclusively onto the central Torso plate. Bypasses peripheral limb checks but inflicts sharp systemic pain points upon insertion.

### Flow Dynamics & Multipliers
The **IV Flow Control Interface** allows customized management of fluid transfer rates.

<div style="background-color:#1e272e; color:#00d2d3; padding:15px; border-radius:5px; font-family:monospace; font-size:10pt; line-height:1.4;">
  [IV FLOW CONTROL MONITOR]<br>
  -----------------------------------------<br>
  &nbsp;&nbsp;[LINE 1]&nbsp;&nbsp;IO&nbsp;&nbsp;--&nbsp;&nbsp;(RATE: 1.5)&nbsp;&nbsp;--&nbsp;&nbsp;[TORSO]<br>
  &nbsp;&nbsp;[LINE 2]&nbsp;&nbsp;IV&nbsp;&nbsp;--&nbsp;&nbsp;(RATE: 0.5)&nbsp;&nbsp;--&nbsp;&nbsp;[LEFT ARM]<br>
  &nbsp;&nbsp;[LINE 3]&nbsp;&nbsp;IV&nbsp;&nbsp;--&nbsp;&nbsp;(RATE: 0.0)&nbsp;&nbsp;--&nbsp;&nbsp;[RIGHT LEG]<br>
  -----------------------------------------<br>
  <span style="color:#ff5252;">* Flow control ranges step from 0.0 (Stopped) to 1.5 (Maximum Overdrive Rate)</span>
</div>

* **Line Monitoring & Clearance:** If transfer velocities freeze, perform **Inspect Catheter**. If an explicit occlusion warning appears, use a **Saline Flush** (requires minimum 30ml Saline volume reserve inside personal kit to clear lines).
* **Catheter Removal Mechanics:** Ripping out an active line while fluid transfers are running returns a portion of the fluid volume to the medic's field kit inventory.

---

## Blood Group Compatibility Matrix
Using mismatched blood combinations triggers immediate, severe cardiac indexing failures, ending in rapid flatline arrest. Mismatch sequences must be neutralized via **CWMP** administration.

<table style="width:100%; border:1px solid #ccc; font-size:10pt; text-align:center;">
  <tr style="background-color:#c0392b; color:white;">
    <th>Recipient Group</th>
    <th>O-</th>
    <th>O+</th>
    <th>B-</th>
    <th>B+</th>
    <th>A-</th>
    <th>A+</th>
    <th>AB-</th>
    <th>AB+</th>
  </tr>
  <tr>
    <td style="background-color:#f1c40f;"><b>AB+</b></td>
    <td>✔</td><td>✔</td><td>✔</td><td>✔</td><td>✔</td><td>✔</td><td>✔</td><td>✔</td>
  </tr>
  <tr style="background-color:#fafafa;">
    <td style="background-color:#f1c40f;"><b>AB-</b></td>
    <td>✔</td><td>✖</td><td>✔</td><td>✖</td><td>✔</td><td>✖</td><td>✔</td><td>✖</td>
  </tr>
  <tr>
    <td style="background-color:#f1c40f;"><b>A+</b></td>
    <td>✔</td><td>✔</td><td>✖</td><td>✖</td><td>✔</td><td>✔</td><td>✖</td><td>✖</td>
  </tr>
  <tr style="background-color:#fafafa;">
    <td style="background-color:#f1c40f;"><b>A-</b></td>
    <td>✔</td><td>✖</td><td>✖</td><td>✖</td><td>✔</td><td>✖</td><td>✖</td><td>✖</td>
  </tr>
  <tr>
    <td style="background-color:#f1c40f;"><b>B+</b></td>
    <td>✔</td><td>✔</td><td>✔</td><td>✔</td><td>✖</td><td>✖</td><td>✖</td><td>✖</td>
  </tr>
  <tr style="background-color:#fafafa;">
    <td style="background-color:#f1c40f;"><b>B-</b></td>
    <td>✔</td><td>✖</td><td>✔</td><td>✖</td><td>✖</td><td>✖</td><td>✖</td><td>✖</td>
  </tr>
  <tr>
    <td style="background-color:#f1c40f;"><b>O+</b></td>
    <td>✔</td><td>✔</td><td>✖</td><td>✖</td><td>✖</td><td>✖</td><td>✖</td><td>✖</td>
  </tr>
  <tr style="background-color:#fafafa;">
    <td style="background-color:#f1c40f;"><b>O-</b></td>
    <td>✔</td><td>✖</td><td>✖</td><td>✖</td><td>✖</td><td>✖</td><td>✖</td><td>✖</td>
  </tr>
</table>

---

## Chemical Fluid Profiles & Properties
*Note: Infusing whole blood or plasma expands the active systemic coagulation pool, potentially overfilling total clotting baseline levels.*

* **Whole Blood**
  * *1000ml:* pH Impact: $+800$ | Coagulation Factor Boost: $+16$
  * *500ml:* pH Impact: $+400$ | Coagulation Factor Boost: $+8$
  * *250ml:* pH Impact: $+200$ | Coagulation Factor Boost: $+4$
* **Fresh Frozen Plasma**
  * *1000ml:* pH Impact: $+500$ | Coagulation Factor Boost: $+20$
  * *500ml:* pH Impact: $+250$ | Coagulation Factor Boost: $+10$
  * *250ml:* pH Impact: $+100$ | Coagulation Factor Boost: $+5$
* **Normal Saline (Crystalloids)**
  * *1000ml:* pH Impact: $-750$ | Coagulation Factor Boost: $0$
  * *500ml:* pH Impact: $-350$ | Coagulation Factor Boost: $0$
  * *250ml:* pH Impact: $-150$ | Coagulation Factor Boost: $0$
