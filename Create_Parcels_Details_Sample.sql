--------------------
-- Add parcel_id index to parcels and tax roll tables
--------------------
CREATE INDEX idxTaxPIDmarion 
	ON web_map.taxroll_marion (parcel_id);
CREATE INDEX idxPIDmarion 
	ON web_map.parcels_marion (parcelno);

--------------------
-- Create parcels full table using parcels t1 and taxroll t2
--------------------
CREATE TABLE web_map.parcels_marion_full as (
	SELECT t1.geom, 
		CAST(t2.jv as numeric) jv, 
		ROUND(CAST(ST_Area(t1.geom) as numeric),0) area, 
		t2.dor_uc, 
		t1.parcelno
	FROM web_map.parcels_marion t1, 
		 web_map.taxroll_marion t2
	WHERE t1.parcelno = t2.parcel_id);

--------------------
-- Alter table
--------------------
ALTER TABLE web_map.parcels_marion_full add column id SERIAL PRIMARY KEY;
ALTER TABLE web_map.parcels_marion_full add column lu varchar; 

--------------------
-- Update landuse
--------------------
UPDATE web_map.parcels_marion_full
SET lu = CASE
	WHEN CAST(dor_uc as int) >= 0 AND CAST(dor_uc as int) < 10 THEN 'r' -- residential
	WHEN CAST(dor_uc as int) >= 10 AND CAST(dor_uc as int) < 40 THEN 'c' -- commercial
	WHEN CAST(dor_uc as int) >= 40 AND CAST(dor_uc as int) < 50 THEN 'i' -- industrial
	WHEN CAST(dor_uc as int) >= 50 AND CAST(dor_uc as int) < 70 THEN 'a' -- agri
	WHEN CAST(dor_uc as int) >= 70 AND CAST(dor_uc as int) < 80 THEN 'in' -- institutional
	WHEN CAST(dor_uc as int) >= 80 AND CAST(dor_uc as int) < 90 THEN 'g' -- gov
	WHEN CAST(dor_uc as int) >= 90 AND CAST(dor_uc as int) < 100 THEN 'o' -- other
	END;

ALTER TABLE web_map.parcels_marion_full drop column dor_uc;
--------------------
--------------------

select * from web_map.parcels_marion_full
limit 500
