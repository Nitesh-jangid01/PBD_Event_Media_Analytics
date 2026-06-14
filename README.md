🎯 17th Pravasi Bharatiya Divas — Event Media Analytics
Tools: MySQL · Excel · Power BI
---
🏛️ About This Project
The 17th Pravasi Bharatiya Divas (PBD) Convention was held in Indore, Madhya Pradesh, India from January 8–10, 2023. It is India's largest diaspora convention organised by the Government of India, bringing together Non-Resident Indians (NRIs) and Persons of Indian Origin (PIOs) from across the world.
This project builds a complete Event Media Intelligence Dashboard analysing:
Media accreditation and journalist management across 3 event days
Coverage reach, Ad Value Equivalency (AVE), and sentiment analysis
Session-wise attendance and media deployment analytics
International media impact across 15 countries
> **Personal Note:** I worked on-ground at the 17th PBD Convention 2023 as part of the media management team under the **Madhya Pradesh Public Relations (MPPR) Department**. My responsibilities included issuing entry passes to journalists, coordinating broadcast setup requests, and managing journalist movement and arrival schedules across venue zones. This project is built on the data framework that mirrors that exact real-world experience.
---
📁 Project Structure
```
pbd-event-media-analytics/
├── data/
│   ├── event_accreditations.csv     ← 400 journalist accreditation records
│   ├── event_media_coverage.csv     ← 600 media coverage pieces across 3 days
│   └── event_sessions.csv          ← 42 sessions with attendance & media data
├── sql/
│   └── PBD_Event_SQL.sql  ← 10 SQL scripts
├── excel/
│   └── PBD_Event_Media_Analytics.xlsx  ← 8-sheet Excel workbook
├── powerbi_Dashboard screenshots/
│   ├── <img width="1537" height="862" alt="Event_Overview" src="https://github.com/user-attachments/assets/63dd0b4e-9ba9-4685-b794-39dead0c1e97" />

│   ├── <img width="1540" height="862" alt="Accreditation_Report" src="https://github.com/user-attachments/assets/05696cb5-67ea-4d33-818f-31e5f72205bc" />

│   ├── <img width="1540" height="865" alt="Coverage_Intelligence" src="https://github.com/user-attachments/assets/591d28e8-5440-4aaa-8aea-f19d478e3a1d" />

│   ├── <img width="1540" height="862" alt="Session_Operations" src="https://github.com/user-attachments/assets/1ca4271c-7188-4406-b77e-b1e2892181c4" />

│   └── <img width="1540" height="862" alt="International_Impact" src="https://github.com/user-attachments/assets/33977a6a-ced2-4441-b9bb-59e111d0f242" />

└── README.md
```
---
📊 Dataset Overview
Table	Records	Key Columns
event_accreditations	400	journalist_type, media_organization, country_of_media, entry_pass_issued, day_assigned, zone_access, broadcast_setup_requested, accreditation_status
event_media_coverage	600	session_covered, journalist_type, coverage_type, headline_sentiment, estimated_reach, ad_value_equivalency, online_shares, is_international_media
event_sessions	42	session_type, event_day, venue_zone, capacity, attended_delegates, attendance_rate_pct, media_personnel_present, live_broadcast, estimated_tv_reach
Event: 17th Pravasi Bharatiya Divas Convention
Location: Indore, Madhya Pradesh, India
Dates: January 8, 9, and 10, 2023
Organised by: Government of India
Nature: International Government Diaspora Convention
---
🔑 Key Findings
Media Accreditation:
400 journalists accredited across 6 journalist types (Print, TV, Digital, Radio, International, Photographer)
358 entry passes issued (89.5% pass issuance rate)
86.0% accreditation approval rate across all applications
15 countries represented in media accreditation
204 broadcast setup requests processed for TV and International media teams
Media Coverage:
600 coverage pieces published across all 3 event days
Total estimated reach: 924.4 Million across all media and countries
Total Ad Value Equivalency (AVE): ₹256.36 Crore — the economic value of all media coverage
68.7% positive coverage — strong sentiment outcome for a government event
7.36 Million online shares generated across all coverage pieces
121 live broadcast pieces produced across TV and digital channels
92.7% of coverage came from international or cross-border media organisations
Sessions & Operations:
42 sessions held across 3 days and 6 venue zones
Average attendance rate: 75.1% across all session types
1,901 media personnel deployed across all sessions
20 sessions had live broadcast coverage
Average TV reach per live session: 6.79 Million viewers
15 countries represented per session on average
---
🗂️ Excel Workbook — 7 Sheets
Sheet	Contents
Accreditation_Data	Full 400-record journalist accreditation database
Media_Coverage_Data	600 coverage records with reach, AVE, sentiment
Session_Data	42 sessions with attendance and media deployment
Event_Intelligence_Dashboard	KPI summary + journalist type + day-by-day coverage
Media_Operations_Tracker	Pass management tracker with colour-coded pass status
Session_Analytics	Attendance rates and media deployment by session type
International_Media_Impact	Country-wise reach, AVE, sentiment breakdown
---
🗄️ SQL Scripts Overview
Script	What It Does
Step 1	Database and table creation (3 tables)
Step 2	Event KPI executive summary
Step 3	Day-by-day coverage analytics (Jan 8, 9, 10)
Step 4	Media accreditation management report by journalist type
Step 5	Coverage intelligence by journalist type and sentiment
Step 6	Session attendance and media analytics
Step 7	International media impact ranked by country reach
Step 8	Accreditation vs coverage linkage (LEFT JOIN analysis)
Step 9	Process improvement flags — operational discrepancies
Step 10	Zone-wise media deployment analysis
SQL techniques used:
Multi-table LEFT JOIN (accreditations linked to coverage)
Window Functions — RANK() for country reach ranking
Conditional aggregation — COUNTIF logic using CASE WHEN
DIVIDE() for safe percentage calculations
NULLIF() to prevent division by zero errors
GROUP BY with multiple dimensions (zone + day combinations)
---
📈 Power BI Dashboard — 5 Pages
Page	Focus	Key Visuals
01 — Event Overview	Overall event media intelligence	6 KPI cards, day-wise bar chart, sentiment donut, journalist type grouped bar
02 — Accreditation Report	Pass management and journalist tracking	Stacked bar by status, pass tracker table with traffic-light formatting
03 — Coverage Intelligence	Reach, AVE, and coverage type breakdown	Session coverage bar, coverage type donut, reach treemap, AVE bar
04 — Session & Operations	Attendance rates and media deployment	Attendance rate bar with 80% benchmark, media deployment line, zone map
05 — International Impact	Country-wise coverage and global reach	Filled map by country, top 10 countries bar, India vs International donut

---
💡 Business Recommendations
International media relations should be prioritised for future PBD editions — 92.7% of reach came from international media organisations, confirming their outsized impact
Accreditation processing should begin 7 days before the event — the pre-event accreditation timeline shows a last-minute surge; earlier processing reduces operational pressure
Cultural Program and Inaugural Ceremony drive the most online shares — these sessions should be prioritised for social media amplification in future editions
Sessions with attendance below 75% need capacity rebalancing — either reduce registered seats or improve delegate communication and reminders
TV broadcast setups should be pre-confirmed 48 hours in advance — 204 broadcast setup requests across 3 days creates significant logistics pressure on media management teams
---
🛠️ How to Run
SQL
Open MySQL Workbench
Run `Project2_PBD_Event_SQL.sql` — scripts are numbered Step 1 to Step 10
Use Table Data Import Wizard to load all 3 CSV files
Run each step in order
Excel
Open `Project2_PBD_Event_Media_Analytics.xlsx`
All 7 sheets are pre-built and formatted
The `Media_Operations_Tracker` sheet mirrors the real pass management process from the event
Power BI
Open Power BI Desktop → Home → Get Data → Excel Workbook → select the .xlsx file
Load the `Accreditation_Data`, `Media_Coverage_Data`, and `Session_Data` sheets
---
🎓 Skills Demonstrated
JD Requirement	How Demonstrated
Analyse data to identify trends, gaps, growth opportunities	SQL Steps 3, 5, 7 — day-wise trends, coverage intelligence, country ranking
Build dashboards and trackers	5-page Power BI dashboard + Media_Operations_Tracker Excel sheet
Generate business reports for leadership	Event_Intelligence_Dashboard sheet + Page 1 Power BI overview
CRM data management and reporting accuracy	400-record accreditation database with pass status tracking
Market research and brand analysis	International_Media_Impact sheet — reach and sentiment by country
Process improvement and operational solutions	SQL Step 9 — operational flags for accreditation discrepancies
High-quality presentations for stakeholders	5 custom Power BI background templates (saffron gold government theme)
Structured and accurate databases	3-table relational schema with LEFT JOIN linkage between accreditations and coverage
Cross-functional collaboration	Project mirrors real coordination between media teams, PR department, and venue operations
---
🏛️ Real-World Context
This project is directly inspired by the analyst's on-ground experience at the 17th PBD Convention, Indore 2023 working under the MPPR (Madhya Pradesh Public Relations) Department. Tasks performed on the ground that are reflected in this analytics project:
Real Task Performed	Analytics Mirror in This Project
Issuing and tracking entry passes for 350+ journalists	Media_Operations_Tracker sheet + Pass Status KPI card
Coordinating broadcast setup requests for TV crews	Broadcast Setups measure + SQL Step 4
Managing journalist arrival times across venue zones	Zone-wise deployment analysis — SQL Step 10
Liaising with journalists and releasing event schedules	Accreditation Timeline chart — Page 2 Power BI
Monitoring media coverage across 3 event days	Day-by-day coverage analytics — SQL Step 3 + Page 1 chart
---
👤 Author
Nitesh Jangid
Data Analyst | Business Analyst
Indore, India
[LinkedIn](www.linkedin.com/in/nitesh-jangid) · [GitHub](https://github.com/Nitesh-jangid01/)
---
This project is part of a portfolio targeting Business Analyst roles in Advertising, PR, and Events industries. The PBD Convention project carries particular significance as it is built on direct professional experience from the event itself.
