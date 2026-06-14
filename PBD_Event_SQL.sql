-- ============================================================
-- PBD CONVENTION — EVENT MEDIA ANALYTICS
-- 17th Pravasi Bharatiya Divas, Indore, Jan 8-10 2023
-- Tools: MySQL | Power BI | Excel
-- Author: Nitesh Jangid
-- JD Alignment: Business reporting, operational tracking,
--               stakeholder dashboards, process improvement
-- ============================================================

CREATE DATABASE pbd_event_db;
USE pbd_event_db;

-- EVENT KPI EXECUTIVE SUMMARY
SELECT
    COUNT(DISTINCT a.accreditation_id) AS total_media_accredited,
    COUNT(DISTINCT CASE WHEN a.entry_pass_issued = 1 THEN a.accreditation_id END) AS passes_issued,
    COUNT(DISTINCT a.country_of_media) AS countries_represented,
    COUNT(DISTINCT a.journalist_type) AS journalist_types,
    ROUND(AVG(CASE WHEN a.accreditation_status = 'Approved' THEN 1.0 ELSE 0.0 END ) * 100,1) AS approval_rate_pct
    FROM event_accreditations a;

SELECT
    COUNT(*) AS total_coverage_pieces,
    SUM(CAST(estimated_reach AS BIGINT)) AS total_estimated_reach,
    SUM(CAST(ad_value_equivalency AS BIGINT)) AS total_ad_value_equiv,
    SUM(CAST(online_shares AS BIGINT)) AS total_online_shares,
    ROUND(SUM(CASE WHEN headline_sentiment = 'Positive' THEN 1 ELSE 0 END) * 100.0 / COUNT(*),1) AS positive_pct,
    ROUND(SUM(CASE WHEN is_international_media = 1 THEN 1 ELSE 0 END) * 100.0 / COUNT(*), 1) AS international_coverage_pct
    FROM event_media_coverage;


-- DAY-BY-DAY COVERAGE ANALYTICS
SELECT
    event_day,
    COUNT(*)                                      AS coverage_pieces,
    SUM(estimated_reach)                          AS total_reach,
    SUM(ad_value_equivalency)                     AS total_ave,
    SUM(online_shares)                            AS online_shares,
    ROUND(SUM(CASE WHEN headline_sentiment='Positive' THEN 1 ELSE 0 END)*100.0/COUNT(*),1) AS positive_pct,
    COUNT(DISTINCT media_organization)            AS unique_media_orgs,
    COUNT(DISTINCT country_of_media)              AS countries_covered
FROM event_media_coverage
GROUP BY event_day
ORDER BY event_day;


-- MEDIA ACCREDITATION MANAGEMENT 
SELECT
    journalist_type,
    COUNT(*) AS total_accredited,
    SUM(CASE WHEN accreditation_status = 'Approved' THEN 1 ELSE 0 END) AS approved,
    SUM(CASE WHEN accreditation_status = 'Pending' THEN 1 ELSE 0 END) AS pending,
    SUM(CASE WHEN accreditation_status = 'Rejected' THEN 1 ELSE 0 END) AS rejected,
    ROUND(SUM(CASE WHEN accreditation_status = 'Approved' THEN 1 ELSE 0 END) * 100.0 / COUNT(*), 1) AS approval_rate_pct,
    SUM(CASE WHEN entry_pass_issued = 1 THEN 1 ELSE 0 END) AS passes_issued,
    SUM(CASE WHEN broadcast_setup_requested = 1 THEN 1 ELSE 0 END) AS broadcast_setups
    FROM event_accreditations
    GROUP BY journalist_type
    ORDER BY total_accredited DESC;


-- COVERAGE INTELLIGENCE BY JOURNALIST TYPE
SELECT
    journalist_type,
    headline_sentiment,
    COUNT(*)                                      AS coverage_count,
    SUM(estimated_reach)                          AS total_reach,
    SUM(ad_value_equivalency)                     AS total_ave,
    SUM(online_shares)                            AS total_shares,
    ROUND(AVG(estimated_reach),0)                 AS avg_reach_per_coverage,
    ROUND(COUNT(*)*100.0/SUM(COUNT(*))
        OVER (PARTITION BY journalist_type),1)   AS sentiment_share_pct
FROM event_media_coverage
GROUP BY journalist_type, headline_sentiment
ORDER BY journalist_type, total_reach DESC;


-- SESSION ATTENDANCE & MEDIA ANALYTICS
SELECT
    s.session_type,
    COUNT(*) AS total_sessions,
    SUM(s.capacity) AS total_capacity,
    SUM(s.registered_delegates) AS total_registered,
    SUM(s.attended_delegates) AS total_attended,
    ROUND(AVG(s.attendance_rate_pct),1) AS avg_attendance_pct,
    SUM(s.media_personnel_present) AS total_media,
    SUM(CASE WHEN s.live_broadcast = 1 THEN 1 ELSE 0 END) AS live_broadcasts,
    ROUND(AVG(NULLIF(s.estimated_tv_reach,0)),0) AS avg_tv_reach,
    ROUND(AVG(s.countries_represented),1) AS avg_countries
FROM event_sessions s
GROUP BY s.session_type
ORDER BY total_attended DESC;


-- INTERNATIONAL MEDIA IMPACT
SELECT
    country_of_media,
    COUNT(*)                                      AS coverage_pieces,
    SUM(estimated_reach)                          AS total_reach,
    SUM(ad_value_equivalency)                     AS total_ave,
    SUM(online_shares)                            AS total_shares,
    ROUND(SUM(CASE WHEN headline_sentiment='Positive' THEN 1 ELSE 0 END)*100.0/COUNT(*),1) AS positive_pct,
    COUNT(DISTINCT media_organization)            AS unique_media_orgs,
    RANK() OVER (ORDER BY SUM(estimated_reach) DESC) AS reach_rank
FROM event_media_coverage
GROUP BY country_of_media
ORDER BY total_reach DESC;

-- ACCREDITATION vs COVERAGE LINKAGE
SELECT TOP 20
    a.journalist_type,
    a.country_of_media,
    a.accreditation_status,
    a.zone_access,
    COUNT(c.coverage_id)                          AS coverage_produced,
    SUM(c.estimated_reach)                        AS total_reach_generated,
    SUM(c.ad_value_equivalency)                   AS total_ave_generated,
    ROUND(SUM(c.estimated_reach)/NULLIF(COUNT(c.coverage_id),0),0) AS avg_reach_per_piece
FROM event_accreditations a
LEFT JOIN event_media_coverage c ON c.linked_accreditation = a.accreditation_id
WHERE a.accreditation_status = 'Approved'
GROUP BY a.journalist_type, a.country_of_media, a.accreditation_status, a.zone_access
ORDER BY total_reach_generated DESC;


-- STEP 9: PROCESS IMPROVEMENT FLAGS — MEDIA 
SELECT
    accreditation_id,
    journalist_name,
    journalist_type,
    media_organization,
    country_of_media,
    day_assigned,
    accreditation_status,
    entry_pass_issued,
    broadcast_setup_requested,
    CASE
        WHEN accreditation_status = 'Pending' AND entry_pass_issued = 1 THEN 'FLAG: Pass issued without approval'
        WHEN accreditation_status = 'Approved' AND entry_pass_issued = 0 THEN 'FLAG: Approved but no pass issued'
        WHEN broadcast_setup_requested = 1 AND journalist_type = 'Print' THEN 'FLAG: Broadcast setup for print journalist'
        WHEN accreditation_status = 'Rejected' AND entry_pass_issued = 1 THEN 'FLAG: Pass issued to rejected journalist'
        ELSE 'OK'
    END AS operational_flag
    FROM event_accreditations
    WHERE accreditation_status <> 'Approved' OR entry_pass_issued = 0
    ORDER BY operational_flag DESC;

    
-- STEP 10: ZONE-WISE MEDIA DEPLOYMENT ANALYSIS
SELECT
    a.zone_access,
    a.day_assigned,
    COUNT(DISTINCT a.accreditation_id)            AS media_accredited,
    COUNT(DISTINCT CASE WHEN a.entry_pass_issued= 1 THEN a.accreditation_id END) AS passes_issued,
    COUNT(c.coverage_id)                          AS coverage_produced,
    SUM(c.estimated_reach)                        AS total_reach,
    ROUND(SUM(c.estimated_reach)/NULLIF(COUNT(DISTINCT a.accreditation_id),0),0) AS reach_per_journalist
FROM event_accreditations a
LEFT JOIN event_media_coverage c ON c.linked_accreditation=a.accreditation_id
GROUP BY a.zone_access, a.day_assigned
ORDER BY a.day_assigned, total_reach DESC;




-- ============================================================


