CREATE TABLE apple_description_final as 
select * from appleStore_description1
UNION ALL
select * FROM appleStore_description2
UNION ALL
SELECT * from appleStore_description3
UNION all 
select * from appleStore_description4

 -- CHECKING IF THE COMBINED TABLE HAS NO DUPLICATE OR MISSING ENTRIES
 
 SELECT COUNT(DISTINCT id) AS DISID FROM AppleStore
 SELECT COUNT(DISTINCT id) AS DISID2 FROM apple_description_final
 
 select count(*) as missing from AppleStore where track_name  is NULL
 select count(*) as mmissign2 from apple_description_final where track_name is NULL

-- Checking the number of apps per genre

select prime_genre,count(*) as Number_of_Apps from AppleStore 
group by prime_genre order by Number_of_Apps DESC

--Checking the minimum ,maximum and average rating of all apps from the appstore

SELECT min(user_rating) as MinRating,
       max(user_rating) as MaxRating,
       avg(user_rating) as AverageRating From AppleStore
       
 --Checking the average rating per genre - Top 10
 
 Select prime_genre , avg(user_rating) as AverageRating from AppleStore
 group by prime_genre
 order by AverageRating DESC LIMIT 10
 
 --Checking the average rating per genre - Bottom 10
 
 Select prime_genre , avg(user_rating) as AverageRating from AppleStore
 group by prime_genre
 order by AverageRating ASC LIMIT 10
 
 -- Checking the ratings of paid vs free apps
 
 SELECT case 
        when price>0 then 'Paid' 
        else 'Free'
        end as Free_or_Paid, 
        avg(user_rating) as AvgRating from AppleStore group by Free_or_Paid
        
 -- Check if apps with more languages have higher ratings
 
 Select case 
        When lang_num<5 then '<5 Languages'
        When lang_num<10 then '<10 Languages'
        When lang_num BETWEEN 10 and 20 then '10-20 languages'
        else '>30 Languages'
        end as language_category, avg(user_rating) as AvgRating FROM AppleStore
 GROUP BY language_category
 order by AvgRating DESC
 
 -- Check the relation between length of app description and average user rating 
 
 SELECT Case 
        when length(app_desc) <500 then 'Short'
        when length(app_desc) between 500 and 1000 then 'Medium'
        Else 'Long' 
        END as description_length , avg(user_rating) as AvgRating
 from AppleStore as a
 join apple_description_final  as b
 on a.id=b.id
 group by description_length
 order by AvgRating desc 
 
 -- check the top rated apps for each genre 
 
 Select prime_genre,track_name,user_rating FROM
        (SELECT prime_genre,track_name,user_rating, 
               RANK()OVER(PARTITION BY prime_genre 
                          order by user_rating desc) as rank
        from AppleStore) where rank=1 GROUP by prime_genre
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        

 
 