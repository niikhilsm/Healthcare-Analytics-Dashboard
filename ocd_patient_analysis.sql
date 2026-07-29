CREATE DATABASE health_data ;
USE health_data ;



-- EDA over OCD Patients Data.




-- 1. Count & Pct of F vs M that have OCD & -- Average Obsession Score by Gender
with data as(
SELECT 
Gender,
count(`Patient ID`) as patient_count,
round(avg(`Y-BOCS Score (Obsessions)`),2) as avg_obs_score
FROM health_data.patients
Group By Gender
Order by patient_count 
)

select
	sum(case when Gender = 'Female' then patient_count else 0 end) as count_female,
	sum(case when Gender = 'Male' then patient_count else 0 end) as count_male,

	round(sum(case when Gender = 'Female' then patient_count else 0 end)/
	(sum(case when Gender = 'Female' then patient_count else 0 end)+sum(case when Gender = 'Male' then patient_count else 0 end)) *100,2)
	 as pct_female,

    round(sum(case when Gender = 'Male' then patient_count else 0 end)/
	(sum(case when Gender = 'Female' then patient_count else 0 end)+sum(case when Gender = 'Male' then patient_count else 0 end)) *100,2)
	 as pct_male
 
from data ;





-- 2. Count of Patients by Ethnicity and their respective Average Obsession Score
select
	Ethnicity,
	count(`Patient ID`) as patient_count,
	avg(`Y-BOCS Score (Obsessions)`) as obs_score
From health_data.patients
Group by Ethnicity
Order by patient_count;






-- 3. Number of people diagnosed with OCD MoM

alter table health_data.patients
modify `OCD Diagnosis Date` date;

select
date_format(`OCD Diagnosis Date`, '%Y-%m-01 00:00:00') as month,
-- `OCD Diagnosis Date`
count(`Patient ID`) as patient_count
from health_data.patients
group by month
Order by month ;






-- 4. What is the most common Obsession Type (Count) & it's respective Average Obsession Score

Select
`Obsession Type`,
count(`Patient ID`) as patient_count,
round(avg(`Y-BOCS Score (Obsessions)`),2) as obs_score
from health_data.patients
group by `Obsession Type`
Order by  patient_count ;







-- 5. What is the most common Compulsion type (Count) & it's respective Average Obsession Score

Select
`Compulsion Type`,
count(`Patient ID`) as patient_count,
round(avg(`Y-BOCS Score (Obsessions)`),2) as obs_score
from health_data.patients
group by `Compulsion Type`
Order by patient_count ;

















