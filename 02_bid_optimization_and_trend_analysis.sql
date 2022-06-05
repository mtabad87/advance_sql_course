use mavenfuzzyfactory;

### bid optimization & trend analysis

SELECT 
	YEAR(created_at),
    WEEK(created_at),
    MIN(DATE(created_at)) AS week_start,
    COUNT(DISTINCT website_session_id) AS sessions
FROM website_sessions
WHERE website_session_id BETWEEN 100000 AND 115000
GROUP BY 1, 2;

SELECT 
	primary_product_id,
    COUNT(DISTINCT CASE WHEN items_purchased = 1 THEN order_id ELSE NULL END) AS single_item_orders,
    COUNT(DISTINCT CASE WHEN items_purchased = 2 THEN order_id ELSE NULL END) AS two_item_orders
FROM orders AS o
WHERE order_id BETWEEN 31000 AND 32000
GROUP BY 1;


### ASSIGNMENT : traffic source trending

SELECT 
	MIN(DATE(created_at)) AS week_start_date,
    COUNT(DISTINCT website_session_id) AS sessions
FROM website_sessions
WHERE created_at > '2012-03-19' AND created_at < '2012-05-10'
	AND utm_source = 'gsearch'
    AND utm_campaign = 'nonbrand'
GROUP BY YEAR(created_at), WEEK(created_at);


###Assignment bid optimization for paid traffic

SELECT 
	ws.device_type,
    COUNT(DISTINCT ws.website_session_id) AS sessions,
    COUNT(DISTINCT o.order_id) AS orders,
    ROUND(COUNT(DISTINCT o.order_id)/COUNT(DISTINCT ws.website_session_id) * 100, 2) AS sessions_to_orders_conv_rt
FROM website_sessions AS ws
	LEFT JOIN orders AS o
		ON ws.website_session_id = o.website_session_id
WHERE ws.created_at < '2012-05-11'
	AND ws.utm_source = 'gsearch'
    AND ws.utm_campaign = 'nonbrand'
GROUP BY ws.device_type;

###assignment trending with granular segments

SELECT 
	MIN(DATE(created_at)) AS week_start_date,
    COUNT(DISTINCT CASE WHEN device_type = 'desktop' THEN website_session_id ELSE NULL END) AS dtop_sessions,
    COUNT(DISTINCT CASE WHEN device_type = 'mobile' THEN website_session_id ELSE NULL END) AS mob_sessions
FROM website_sessions
WHERE created_at > '2012-04-15' AND created_at < '2012-06-09'
	AND utm_source = 'gsearch'
    AND utm_campaign = 'nonbrand'
GROUP BY YEAR(created_at), WEEK(created_at);
