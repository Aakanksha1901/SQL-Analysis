create database HEALTHCARE;
use HEALTHCARE;

select * from heart_patient;

-- BASIC SQL QUESTIONS
-- Count the total number of patients.
select count(*) as total_patients  from heart_patient;

-- Find the average age of patients.
select avg(age) as average_age from heart_patient;


-- List all distinct chest pain types.
select distinct chest_pain_type from heart_patient;

-- Count how many male and female patients are there.
select gender, count(*) patient_number from heart_patient
group by gender;

-- Find patients older than 60 years.
select * from heart_patient where age > 60;

-- Count patients with heart disease.
select count(*)  heart_disease from heart_patient where heart_disease = 1;

-- Retrieve patients with cholesterol level greater than 240.
select * from heart_patient where cholesterol > 240;

-- Show patients with fasting blood sugar > 120 mg/dl.
select * from heart_patient where fasting_blood_sugar = 1;

-- List patients who have exercise-induced angina.
select * from heart_patient where exercise_induced_angina = "YES";

-- Find the minimum and maximum resting blood pressure.
select min(resting_bp) as minimum_bp , max(resting_bp) as maxium_bp from heart_patient;

-- percentage of patiemts with heart disease
SELECT 
    (SUM(CASE WHEN heart_disease = 1 THEN 1 ELSE 0 END) * 100.0 / COUNT(*)) 
    AS heart_disease_percentage
FROM heart_patient;

-- INTERMEDIATE SQL QUESTIONS
-- Count heart disease cases grouped by gender.
select gender, count(*) as Total_heart_disease_patient from heart_patient where heart_disease =1
group by gender;

-- Find the average cholesterol level by chest pain type.
select chest_pain_type , avg(cholesterol) as avg_colestrol_count from heart_patient
group by chest_pain_type;


-- List patients with heart disease and age above 55.
select * from heart_patient where heart_disease = 1 and age > 55; 

-- Count patients grouped by chest pain type.
select chest_pain_type , count(*) as total_patients from heart_patient 
group by chest_pain_type;


-- Find the average max heart rate by gender.
select gender , avg(max_heart_rate) as Average_max_heartrate from heart_patient
group by gender;

-- Retrieve patients with normal ECG and no heart disease.
select * from heart_patient where resting_ecg = "Normal" and heart_disease = 0;

-- Count how many patients have 0 major vessels affected.
select num_major_vessels ,count(*) as Total_Patients  from heart_patient where num_major_vessels = 0;

-- Find patients with oldpeak greater than 2.0.
select * from heart_patient where oldpeak > 2.0; 

-- Group patients by thalassemia and count cases.
select thalassemia , count(*) as total_patients from heart_patient
group by thalassemia;

-- Find the top 10 patients with the highest cholesterol.
select * from heart_patient order by cholesterol desc limit 10;



-- MEDIUM LEVEL SQL QUESTIONS

-- Find the percentage of patients with heart disease.
SELECT 
    (SUM(CASE WHEN heart_disease = 1 THEN 1 ELSE 0 END) * 100.0 / COUNT(*)) 
    AS heart_disease_percentage
FROM heart_patient;


-- Compare average cholesterol for patients with and without heart disease.
select heart_disease, avg(cholesterol) as avg_cholesterol from heart_patient
group by heart_disease;


-- Find age-wise distribution of heart disease cases.
select age , count(*) as total_patients from heart_patient where heart_disease = 1
group by age
order by age;

-- Identify chest pain types most associated with heart disease.
select chest_pain_type as CP, count(*) as cases from heart_patient where heart_disease = 1
group by chest_pain_type
order by cases desc;


-- Find patients who have: Heart disease Exercise-induced angina Cholesterol > 250
SELECT *
FROM heart_patient
WHERE heart_disease = 1
  AND exercise_induced_angina = 1
  AND cholesterol > 250;

-- Rank patients by maximum heart rate (use window functions).


-- Find gender-wise heart disease ratio.
SELECT
    gender,
    COUNT(CASE WHEN heart_disease = 1 THEN 1 END) * 1.0 / COUNT(*) AS heart_disease_ratio
FROM heart_patient
GROUP BY gender;

-- Determine which slope type has the highest heart disease cases.
select max(slope) as hight_heart_disease from heart_patient where heart_disease = 1;


----- Find patients whose resting BP is above the dataset average.
select * from heart_patient where resting_bp > (select avg(resting_bp) from heart_patient);


-- Create a view showing only high-risk patients (heart disease = 1 and age > 60).