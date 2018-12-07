-- **************
-- BROWARD COUNTY, FL PEOPLE
-- **************
-- DELETE FROM `people`;
SELECT @jurisdiction := 1000;
INSERT INTO `people` 
            (`jurisdiction_id`, 
             -- `reporting_entity`, 
             `local_id`, 
             `date`, 
             `first_name`, 
             `last_name`, 
             `sex`, 
             `dob`, 
             `birthplace`,
             `race_id`,
			 `image_url`,
			 `thumb_url`
			 ) 
SELECT @jurisdiction AS `jurisdiction_id`, 
       -- "Broward" AS `reporting_entity`, 
       `id`, 
       `date`, 
       Substring_index(`name`, " ", 1), 
       Substring_index(`name`, " ", -(LENGTH(`name`) - LENGTH( REPLACE ( `name`, " ", "") ))),
       `sex`, 
       `dob`, 
       `birthplace`,
	   CASE
			WHEN LOWER(`race`) = "white" THEN "W"
			WHEN LOWER(`race`) = "black" THEN "B"
			WHEN LOWER(`race`) = "hispanic" THEN "H"
			ELSE "O"
	   END,
	   `Large_image_url`,
	   `thumb_url`
FROM   `table1`;


-- **************
-- MIAMI-DADE COUNTY, FL PEOPLE
-- **************
-- DELETE FROM `people`;
SELECT @jurisdiction := 1001;
INSERT INTO `people` 
	(`jurisdiction_id`, 
	 `reporting_entity`, 
	 `local_id`, 
	 `date`, 
	 `first_name`, 
	 `last_name`, 
	 `sex`, 
	 `dob`, 
	 `race_id`, 
	 `address`, 
	 `city`, 
	 `state`, 
	 `zip`) 
SELECT @jurisdiction AS `jurisdiction_id`, 
   `agency`, 
   `id`, 
   `date`, 
   `first_name`, 
   `last_name`, 
   `sex`, 
   `dob`, 
   CASE 
	 WHEN Lower(`race`) = "w" THEN "W" 
	 WHEN Lower(`race`) = "b" THEN "B" 
	 WHEN Lower(`race`) = "h" THEN "H" 
	 WHEN Lower(`race`) = "l" THEN "H"
	 ELSE "O" 
   END, 
   CASE 
	 WHEN `apt` IS NOT NULL && `apt` <> '' THEN
	 Concat(`street`," #", `apt`)  -- concat apt to address where available
	 ELSE `street` 
   END, 
   `city`, 
   `state`, 
   `zip` 
FROM   `table2`;