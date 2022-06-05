use mavenfuzzyfactory;

SELECT * FROM orders;

############ Analyzing top traffic sources for fictional website store
################## examples 

SELECT * FROM website_sessions WHERE website_session_id=1059;
SELECT * FROM website_pageviews WHERE website_session_id=1059;
SELECT * FROM orders WHERE website_session_id=1059;

SELECT ws.utm_content,
	COUNT(DISTINCT ws.website_session_id) AS sessions,
    COUNT(DISTINCT o.order_id) AS orders,
    COUNT(DISTINCT o.order_id)/COUNT(DISTINCT ws.website_session_id) AS sessions_to_orders_conv_rt
FROM website_sessions AS ws
	LEFT JOIN orders AS o
		ON o.website_session_id = ws.website_session_id
WHERE ws.website_session_id BETWEEN 1000 AND 2000
GROUP BY ws.utm_content
ORDER BY sessions DESC;

############ assignment: find top traffic sources

SELECT 
	ws.utm_source,
    ws.utm_campaign,
    ws.http_referer,
    COUNT(DISTINCT ws.website_session_id) AS sessions
FROM website_sessions AS ws
WHERE created_at < '2012-04-12'
GROUP BY ws.utm_source,
    ws.utm_campaign,
    ws.http_referer
ORDER BY sessions DESC;

# ASSIGNMENT: traffic source conversion rates

SELECT 
    COUNT(DISTINCT ws.website_session_id) AS sessions,
    COUNT(DISTINCT o.order_id) AS orders,
    ROUND((COUNT(DISTINCT o.order_id)/COUNT(DISTINCT ws.website_session_id) * 100), 2) AS sessions_to_orders_conv_rt
FROM website_sessions AS ws
	LEFT JOIN orders AS o
		ON o.website_session_id = ws.website_session_id
WHERE ws.created_at < '2012-04-14'
	AND ws.utm_source = 'gsearch'
    AND ws.utm_campaign = 'nonbrand';
