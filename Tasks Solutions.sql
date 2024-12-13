use hospitals

select * from dbo.doctors

select * from dbo.admissions

select * from dbo.patients

select * from dbo.province_names

--------------------------- Task 1 -----------------------------------
--Show first name, last name, and gender of patients whose gender is 'M'
----------------------------------------------------------------------
select dbo.patients.first_name,last_name,gender
from dbo.patients
where dbo.patients.gender = 'M'

--------------------------- Task 2 -----------------------------------
--Show first name and last name of patients who does not have allergies. (null)
----------------------------------------------------------------------
select dbo.patients.first_name, dbo.patients.last_name
from dbo.patients
where dbo.patients.allergies !='NULL'

--------------------------- Task 3 -----------------------------------
--Show first name of patients that start with the letter 'C'
----------------------------------------------------------------------
select first_name
from patients
where first_name like 'c%'

--------------------------- Task 4 -----------------------------------
--Show first name and last name of patients that weight within the range of 100 to 120 (inclusive)
----------------------------------------------------------------------
select first_name, last_name
from patients
where [weight] between 100 and 120

--------------------------- Task 5 -----------------------------------
--Update the patients table for the allergies column. If the patient's allergies is null then replace it with 'NKA'
----------------------------------------------------------------------
update patients
set allergies = 'NKA'
where allergies = 'NULL'

select * from patients
---rechange NKA to null As it needed in next tasks
update patients
set allergies = 'NULL'
where allergies = 'NKA'

--------------------------- Task 6 -----------------------------------
--Show first name, last name, and the full province name of each patient.
--Example: 'Ontario' instead of 'ON'
----------------------------------------------------------------------
select patients.first_name, patients.last_name, province_names.province_name
from patients inner join province_names on patients.province_id = province_names.province_id

--------------------------- Task 7 -----------------------------------
--Show how many patients have a birth_date with 2010 as the birth year.
----------------------------------------------------------------------
select count(*)
from patients
where year(birth_date) = '2010'

--------------------------- Task 8 -----------------------------------
--Write a query to find list of patients first_name, last_name, and allergies where allergies are not null and are from the city of 'Hamilton'
----------------------------------------------------------------------
select first_name, last_name, allergies
from patients
where allergies != 'NULL' and city = 'Hamilton'

--------------------------- Task 10 -----------------------------------
-- Write a query to find the first_name, last name and birth date of patients who has height greater than 160 and weight greater than 70
----------------------------------------------------------------------
select first_name, last_name, birth_date
from patients
where height > 160 and weight > 70

--------------------------- Task 11 -----------------------------------
--Based on the cities that our patients live in, show unique cities that are in province_id 'NS'?
----------------------------------------------------------------------
select distinct city
from patients 
where province_id = 'NS'

--------------------------- Task 12 -----------------------------------
--Show the first_name, last_name, and height of the patient with the greatest height.
----------------------------------------------------------------------
select top(1) first_name,last_name,height
from patients
order by height desc

--------------------------- Task 13 -----------------------------------
--Show the patient id and the total number of admissions for patient_id 579.
----------------------------------------------------------------------
select patient_id , COUNT(*) as [total number of admissions]
from admissions
group by patient_id
having patient_id = 579

--------------------------- Task 14 -----------------------------------
--Show all columns for patients who have one of the following patient_ids: 1,45,534,879,1000
----------------------------------------------------------------------
select * from patients
where patient_id in (1,45,534,879,1000)

--------------------------- Task 15 -----------------------------------
--Show all the columns from admissions where the patient was admitted and discharged on the same day.
----------------------------------------------------------------------
select * from admissions
where admission_date = discharge_date

--------------------------- Task 16 -----------------------------------
--Show first name and last name concatinated into one column to show their full name patient.
----------------------------------------------------------------------
select full_name = first_name + ' ' + last_name
from patients

select  concat(first_name,' ', last_name) as full_name
from patients

--------------------------- Task 17 -----------------------------------
--Show patient_id, first_name, last_name from patients whose does not have any records in the admissions table. 
--(Their patient_id does not exist in any admissions.patient_id rows.)
----------------------------------------------------------------------
select patient_id, first_name, last_name 
from patients
where patient_id not in (select patient_id from admissions)

--------------------------- Task 18 -----------------------------------
-- display the first name, last name and number of duplicate patients based on their first name and last name.
----------------------------------------------------------------------
select first_name, last_name,count(*) as [number of duplicate]
from patients
group by first_name,last_name
order by [number of duplicate] desc

--------------------------- Task 19 -----------------------------------
--For every admission, display the patient's full name, their admission diagnosis, and their doctor's full name who diagnosed their problem.
----------------------------------------------------------------------
select [Patient Full Name] = patients.first_name + ' ' + patients.last_name, admissions.diagnosis, concat(doctors.first_name,' ',doctors.last_name) as [Doctor Full Name]
from admissions inner join patients on admissions.patient_id = patients.patient_id 
				inner join doctors on admissions.attending_doctor_id = doctors.doctor_id

--------------------------- Task 20 -----------------------------------
--Show unique birth years from patients and order them by ascending
----------------------------------------------------------------------
select distinct year(birth_date) as birth_year
from patients
order by birth_year

--------------------------- Task 21 -----------------------------------
-- Show all allergies ordered by popularity. Remove NULL values from query.
----------------------------------------------------------------------
select patients.allergies, count(*) as popularity
from patients
where allergies != 'NULL'
group by allergies
order by popularity desc

--------------------------- Task 22 -----------------------------------
--Show first name, last name and role of every person that is either patient or doctor. The roles are either "Patient" or "Doctor"
----------------------------------------------------------------------
select first_name, last_name, role = 'patient'
from patients 
union 
select first_name, last_name, role = 'doctor'
from doctors

--------------------------- Task 23 -----------------------------------
--Show the city and the total number of patients in the city.Order from most to least patients and then by city name ascending.
----------------------------------------------------------------------
select city, count(*) as [number of patients in city]
from patients
group by city
order by [number of patients in city] desc, city asc

--------------------------- Task 24 -----------------------------------
-- Show patient_id, diagnosis from admissions. Find patients admitted multiple times for the same diagnosis.
----------------------------------------------------------------------
select admissions.patient_id, admissions.diagnosis
from admissions
group by patient_id,diagnosis
having count(*) > 1

--------------------------- Task 25 -----------------------------------
-- Show the province_id(s), sum of height; where the total sum of its patient's height is greater than or equal to 7,000.
----------------------------------------------------------------------
select patients.province_id, sum(patients.height) as [total sum of its patient's height]
from patients
group by province_id
having sum(height) >= 7000 

--------------------------- Task 26 -----------------------------------
-- Show all columns for patient_id 542's most recent admission_date.
----------------------------------------------------------------------
select top 1 *
from admissions
where patient_id = 542
order by admission_date desc

--------------------------- Task 27 -----------------------------------
--Show all of the days of the month (1-31) and how many admission_dates occurred on that day. Sort by the day with most admissions to least admissions.
----------------------------------------------------------------------
select day(admissions.admission_date) as [addmission_day], count(*) as [number of admission_dates occurred on that day]
from admissions
group by day(admission_date)
order by [number of admission_dates occurred on that day] desc

--------------------------- Task 28 -----------------------------------
--Show the difference between the largest weight and smallest weight for patients with the last name 'Maroni'
----------------------------------------------------------------------
select [weight_difference] = max(weight) - min(weight)
from patients
where last_name = 'Maroni'

--------------------------- Task 29 -----------------------------------
--We want to display each patient's full name in a single column. Their last_name in all upper letters must appear first,
--then first_name in all lower case letters. Separate the last_name and first_name with a comma. Order the list by the first_name in decending order
----------------------------------------------------------------------
select CONCAT(UPPER(last_name),',',LOWER(first_name)) as [Full Name]
from patients
order by first_name desc

--------------------------- Task 30,35 -----------------------------------
--Show all patient's first_name, last_name, and birth_date who were born in the 1970s decade. Sort the list starting from the earliest birth_date.
----------------------------------------------------------------------
select patients.first_name, patients.last_name, patients.birth_date
from patients
where year(birth_date) = '1970'
order by birth_date asc

--------------------------- Task 31 -----------------------------------
--Show first and last name, allergies from patients which have allergies to either 'Penicillin' or 'Morphine'.
--Show results ordered ascending by allergies then by first_name then by last_name.
----------------------------------------------------------------------
select patients.first_name, patients.last_name, patients.allergies
from patients
where allergies in ('Penicillin','Morphine')
order by allergies asc, first_name, last_name

--------------------------- Task 32 -----------------------------------
--Display every patient's first_name.
--Order the list by the length of each name and then by alphabetically.
----------------------------------------------------------------------
select patients.first_name
from patients
order by LEN(first_name),first_name

--------------------------- Task 33 -----------------------------------
--Show patient_id, attending_doctor_id, and diagnosis for admissions that match one of the two criteria:
--1. patient_id is an odd number and attending_doctor_id is either 1, 5, or 19.
--2. attending_doctor_id contains a 2 and the length of patient_id is 3 characters.
----------------------------------------------------------------------
select admissions.patient_id, admissions.attending_doctor_id, admissions.diagnosis
from admissions
where (patient_id % 2 != 0 and attending_doctor_id in (1,5,19)) or (attending_doctor_id like '%2%' and LEN(patient_id) = 3)

--another solution
select admissions.patient_id, admissions.attending_doctor_id, admissions.diagnosis
from admissions
where patient_id % 2 != 0 and attending_doctor_id in (1,5,19) 
union
select admissions.patient_id, admissions.attending_doctor_id, admissions.diagnosis
from admissions
where attending_doctor_id like '%2%' and LEN(patient_id) = 3

--------------------------- Task 34 -----------------------------------
--Show the total amount of male patients and the total amount of female patients in the patients table. Display the two results in the same row.
----------------------------------------------------------------------
select count(case when gender = 'M' then 1 end) as [total amount of male], count(case when gender = 'F' then 1 end) as [total amount of female]
from patients

--another solution
select [total amount of male] = (select count(*) from patients where gender = 'M'), 
	   [total amount of female] = (select count(*) from patients where gender = 'F')

--------------------------- Task 36 -----------------------------------
--Show unique first names from the patients table which only occurs once in the list.
--For example, if two or more people are named 'John' in the first_name column then don't include their name in the output list.
--If only 1 person is named 'Leo' then include them in the output.
----------------------------------------------------------------------
select patients.first_name
from patients
group by first_name 
having count(*) = 1

--------------------------- Task 37 -----------------------------------
--Show patient_id and first_name from patients where their first_name start and ends with 's' and is at least 6 characters long.
----------------------------------------------------------------------
select patients.patient_id, patients.first_name
from patients
where first_name like 's%s' and LEN(first_name) >= 6

--------------------------- Task 38 -----------------------------------
--Show patient_id, first_name, last_name from patients whos diagnosis is 'Dementia'.
----------------------------------------------------------------------
select patients.patient_id, patients.first_name, patients.last_name
from patients
where patient_id in (select patient_id from admissions where diagnosis = 'Dementia')

--------------------------- Task 39 -----------------------------------
--Display the total amount of patients for each province. Order by descending.
----------------------------------------------------------------------
select province_names.province_name, count(*) as [total amount of patients for each province]
from patients inner join province_names on patients.province_id = province_names.province_id
group by province_name
order by [total amount of patients for each province] desc

--------------------------- Task 40 -----------------------------------
--For each doctor, display their id, full name, and the first and last admission date they attended.
----------------------------------------------------------------------
select doctors.doctor_id, concat(doctors.first_name,' ',doctors.last_name) as full_name, min(admissions.admission_date) as [first_admission_date], max(admissions.admission_date) as [last_admission_date]
from admissions inner join doctors on admissions.attending_doctor_id = doctors.doctor_id
group by doctors.doctor_id,doctors.first_name, doctors.last_name
order by doctor_id

--------------------------- Task 41 -----------------------------------
--Show all of the patients grouped into weight groups.
--Show the total amount of patients in each weight group.
--Order the list by the weight group decending.
--For example, if they weight 100 to 109 they are placed in the 100 weight group, 110-119 = 110 weight group, etc.
----------------------------------------------------------------------
select weight_group = (weight/10)*10, count(*) as [number of patients in weight group]
from patients
group by weight/10
order by weight_group desc

--------------------------- Task 42 -----------------------------------
--Show patient_id, weight, height, isObese from the patients table.
--Display isObese as a boolean 0 or 1.
--Obese is defined as weight(kg)/(height(m)2) >= 30.
--weight is in units kg.
--height is in units cm.
----------------------------------------------------------------------
select patients.patient_id, patients.weight, patients.height, 
	   isObese = CASE WHEN patients.weight/SQUARE(cast(patients.height as float)/100) >=30 THEN 1 ELSE 0 END 
from patients

--------------------------- Task 43 -----------------------------------
--Show patient_id, first_name, last_name, and attending doctor's specialty.
--Show only the patients who has a diagnosis as 'Epilepsy' and the doctor's first name is 'Lisa'
----------------------------------------------------------------------
select admissions.patient_id, patients.first_name, patients.last_name, doctors.specialty as [doctor_specialty]
from admissions inner join patients on patients.patient_id = admissions.patient_id
				inner join doctors on doctors.doctor_id = admissions.attending_doctor_id
where admissions.diagnosis = 'Epilepsy' and doctors.first_name = 'Lisa'

--------------------------- Task 44 -----------------------------------
--All patients who have gone through admissions, can see their medical documents on our site.
--Those patients are given a temporary password after their first admission. Show the patient_id and temp_password.
--The password must be the following, in order:
--1. patient_id
--2. the numerical length of patient's last_name
--3. year of patient's birth_date
----------------------------------------------------------------------
select patients.patient_id, CONCAT(patients.patient_id, Len(patients.Last_Name),year(patients.birth_date)) as temp_password
from patients
where patients.patient_id in (select distinct patient_id from admissions)

--------------------------- Task 45 -----------------------------------
--Each admission costs $50 for patients without insurance, and $10 for patients with insurance. All patients with an even patient_id have insurance.
--Give each patient a 'Yes' if they have insurance, and a 'No' if they don't have insurance. Add up the admission_total cost for each has_insurance group.
----------------------------------------------------------------------
select has_insurance = case when admissions.patient_id%2 = 0 then 'Yes' else 'No' end,
	   sum(case when admissions.patient_id%2 = 0 then 10 else 50 end) as admission_total_cost
from admissions
group by admissions.patient_id%2 

--another solution
select has_insurance = 'yes', sum(10) as admission_total_cost
from admissions
where patient_id %2 =0
union 
select has_insurance = 'no', sum(50) as admission_total_cost
from admissions
where patient_id %2 =0

--------------------------- Task 46 -----------------------------------
--Show the provinces that has more patients identified as 'M' than 'F'. Must only show full province_name
----------------------------------------------------------------------
select province_names.province_name
from province_names
where province_id in (select patients.province_id
					  from patients
					  group by province_id
					  having count(case when gender = 'M'then 1 end) > count(case when gender = 'F' then 1 end))

--another solution
select province_names.province_name
from province_names
where province_id in (select p1.province_id
					  from patients as p1
					  where gender  = 'M'
					  group by province_id
					  having count(*) > (select count(*) from patients as p2 where p1.province_id = p2.province_id and gender = 'F'))

--------------------------- Task 47 -----------------------------------
-- We are looking for a specific patient. Pull all columns for the patient who matches the following criteria:
-- First_name contains an 'r' after the first two letters.
-- Identifies their gender as 'F'
-- Born in February, May, or December
-- Their weight would be between 60kg and 80kg
-- Their patient_id is an odd number
-- They are from the city 'Kingston'
----------------------------------------------------------------------
select *
from patients
where first_name like '__r%' and gender = 'F' and month(birth_date) in (2,5,12) and weight between 60 and 80 and patient_id%2 != 0 and city = 'Kingston'

--------------------------- Task 48 -----------------------------------
--Show the percent of patients that have 'M' as their gender. Round the answer to the nearest hundreth number and in percent form.
----------------------------------------------------------------------
select [percent of male patients] = concat(round((count(case when gender = 'M' then 1 end)/cast(count(*) as float))*100,2),'%')
from patients

--another solution
select [percent of male patients] = concat(round(((select count(*) from patients where gender = 'M')/cast(count(*) as float))*100,2),'%')
from patients 

--------------------------- Task 49 -----------------------------------
-- Sort the province names in ascending order in such a way that the province 'Ontario' is always on top.
----------------------------------------------------------------------
select province_names.province_name
from province_names
order by case when province_name = 'Ontario' then 0 else 1 end, province_name asc

--------------------------- Task 50 -----------------------------------
--We need a breakdown for the total amount of admissions each doctor has started each year.
--Show the doctor_id, doctor_full_name, specialty, year, total_admissions for that year.
----------------------------------------------------------------------
select main.attending_doctor_id, CONCAT_WS(' ',doctors.first_name,doctors.last_name) as full_name, doctors.specialty,main.admission_year,main.total_admission
from doctors inner join (
						select admissions.attending_doctor_id, year(admissions.admission_date) as admission_year, total_admission = count(*)
						from admissions 
						group by admissions.attending_doctor_id, year(admission_date)) as main 
			 on main.attending_doctor_id = doctors.doctor_id
order by attending_doctor_id
