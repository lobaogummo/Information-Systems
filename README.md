# Information-Systems

Grade: 17,67/20

Green Manufacturing Information System (GMAN) — SINF M.EEC 2024/25

An Industry 4.0 project that builds a Green Manufacturing Information System (GMAN) for a wood-log processing line. GMAN connects edge devices, a cloud database, and a web dashboard to monitor energy and environment data, apply rule-based control, and enable scalable, configurable deployments across multiple production lines.

What is GMAN?

GMAN is a multi-tier information system that:

Collects real-time data (power, temp, humidity, light, vibration, air pressure, …) from a 5-station simulated line.

Controls actuators (lights, compressor, …) via rules at line, cell, and equipment level (manual control can override rules).

Stores layout, specs, rules, and timeseries in a PostgreSQL database.

Visualizes KPIs and status on a Grafana dashboard, optionally exposing manual controls.

It is robust to change (sensors/actuators can be added/removed) and scales to multiple lines and layouts.

Architecture
Edge Layer (Dinasore)
 ├─ Simulated sensors & actuators
 ├─ Rule engine (line/cell/equipment + manual override)
 └─ State updates (on/off), data push to DB

Cloud/Data Layer (PostgreSQL)
 ├─ Line layout & station metadata
 ├─ Sensor/actuator catalogue (incl. locations)
 ├─ Control rules
 └─ Timeseries storage

Presentation Layer (Grafana + Web)
 ├─ Line/cell/equipment views
 ├─ KPIs, trends, alarms
 └─ Optional: manual actuator control


Typical rules (examples):

Total power consumption > 10 kW ⇒ turn off selected equipment

Compressed air pressure < 6 bar ⇒ turn compressor ON

Cell-level or equipment-level rules override broader rules; manual overrides all

Project Scope & Deliverables (by Sprint)
Sprint 0 — Foundations

Create GitLab repository and share with PL teacher

Write Product Vision in README.md (target users, needs, benefits, goals)

Prepare development environment

Sprint 1 — Edge & System Concept

UML Use-Case Diagram + textual specs (in wiki)

Product Backlog and Sprint-1 user stories (repo + wiki)

Architecture Diagram (software components; wiki)

Digital Model: implement and document the edge app in Dinasore

4DIAC-IDE: implement the Digital Model (as specified)

Sensor data table: normal ranges, units (wiki)

Digital Story: end-to-end production flow narrative (wiki)

Sprint 2 — Data Model & Integration

UML Class Diagram (wiki)

Relational Model (wiki)

PostgreSQL implementation (repo + shown in class)

Dinasore → PostgreSQL real-time ingestion (repo + shown in class)

Sprint 3 — Dashboard & Analytics

Grafana dashboard (repo + shown in class)

Data analytics methods/rules (Grafana or Dinasore; repo + shown in class)

Integration: apply analytics to the simulated line

