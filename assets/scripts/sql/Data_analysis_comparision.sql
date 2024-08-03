 
 /*

 1.Define variables
 2.Create a CTE that rounds the average views per video
 3.Select the columns that are required for the analysis
 4.Filter the results by the YouTube channels with the highest subscriber bases
 5.Order by net_profit (from highest to lowest)


 */
 --1.
 DECLARE @conversionRate FLOAT = 0.02;	-- The conversion rate @ 2%
 DECLARE @productCost MONEY = 5.0;	-- The product cost @ $5
 DECLARE @campaignCost MONEY = 50000.0; -- The campaign cost @ $50,000


 --2.
 WITH ChannelData AS (
	SELECT
		channel_name,
		total_views,
		total_videos,
		ROUND((CAST(total_views as FLOAT) / total_videos), -4) AS rounded_avg_views_per_video
	from 
		youtube_db.dbo.view_uk_youtubers_2024
)



--3. 

SELECT 
	channel_name,
	rounded_avg_views_per_video,
	(rounded_avg_views_per_video*@conversionRate) as  potential_units_sold_per_video,
	(rounded_avg_views_per_video*@conversionRate*@productCost) as  potential_revenue_sold_per_video,
	(rounded_avg_views_per_video*@conversionRate*@productCost)-@campaignCost as  net_profit
FROM 
	ChannelData

-- 4.
WHERE channel_name in ('NoCopyRightSounds', 'DanTDM', 'Dan Rhodes')

--5.
Order By
	net_profit DESC