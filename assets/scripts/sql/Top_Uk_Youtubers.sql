/*
data cleaing steps

1. Remove unnecessary columnns by only selecting the ones we need
2. Extract the YouTube channel names from the first columns
3. Rename the column nammes

*/

select 
	NOMBRE,
	total_subscribers,
	total_views,
	total_videos
from top_uk_youtubers_2024

select CHARINDEX('@', nombre), NOMBRE from top_uk_youtubers_2024

create view view_uk_youtubers_2024 as

select 
	cast(substring(nombre, 1, charindex('@', nombre)-1) as varchar(100)) as channel_name,
	total_subscribers,
	total_views,
	total_videos

from 
	top_uk_youtubers_2024


--1.	The data needs to be 100 records of Youtube channels (row count test)
--2.	The data needs 4 fields (column count test)
--3.	The channel name column must be string format, an the other columns must be numerical data types (data type check)
--4.	Each record must be unique in the dataset (duplicate count check)

--row count - 100
--column caount - 4
--Data types

--channel_name = varchar
--total_subscribers = intenger
--total_views = intenger
--total_videos = intenger

--Dupluicate count = 0

--1. row count check
select count(*) as no_of_rows
from view_uk_youtubers_2024

--2. column count check

select
	count(*) as column_count
from 
	INFORMATION_SCHEMA.COLUMNS
where
	table_name='view_uk_youtubers_2024'

--3. Data type check

select
	column_name,
	data_type
from 
	INFORMATION_SCHEMA.COLUMNS
where
	table_name='view_uk_youtubers_2024'

--4. Duplicate record check

select 
	channel_name,
	COUNT(*)as duplicate_count
from 
	view_uk_youtubers_2024
group by 
	channel_name
having 
	count(*) > 1