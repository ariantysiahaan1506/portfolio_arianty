select * from heartdiseasetrain_test ht ;

--no 1. 
select 
	target, 
	avg(age) as average_age,
	count(*) as totalpatients
from
	heartdiseasetrain_test ht 
group by target;

--no 2. 
select 
	sex, 
	count(*) as totalpatients,
	target
from
	heartdiseasetrain_test ht 
group by sex, target;

--no 3. 
select 
	age,
	sex,
	cholestoral ,
	target
from
	heartdiseasetrain_test ht 
where 
	cholestoral >250 and "target" =1;
	

--no 4. 
select 
	chest_pain_type,
	count(*) as Total_Patients_with_Heart_Diseases
from 
	heartdiseasetrain_test ht 
where 
	"target" =1
group by
	chest_pain_type ;


--no 4b. 
select 
	avg (oldpeak) as avg_oldpeak,
	target
from
	heartdiseasetrain_test ht 
group by target ;

--no 5. 
select 
	age,
	oldpeak,
	ht. exercise_induced_angina,
	target
from 
	heartdiseasetrain_test ht 
where 
	oldpeak > 0.56 and exercise_induced_angina ='Yes';

--no 6. 
select 
	age,
	sex,
	count(*) as totalpatients
from
	heartdiseasetrain_test ht 
group by
	age, sex
order by
	age;	

--no 7. 
select 
	age,
	ht.cholestoral ,
	"target" 
from 
	heartdiseasetrain_test ht 
where
	ht.cholestoral >200 and target=1;
	


--no 8. 
select 
	avg(ht.resting_blood_pressure) as avg_resting_blood_pressure,
	"target" 
from heartdiseasetrain_test ht 
group by target;


--no 9. 
select 
	sex,
	case
		when ht.resting_blood_pressure <=120 then 'Normal'
		when ht.resting_blood_pressure>120 then 'High Blood Pressure'
	end as blood_pressure_category,
	count(*) as TotalPatients
from heartdiseasetrain_test ht
group by sex, blood_pressure_category;
	end
	
--no 10. 	
select 
	age,
	ht.cholestoral ,
	"target" 
from 
	heartdiseasetrain_test ht 
where 
	ht.cholestoral > (select avg(ht2.cholestoral ) from heartdiseasetrain_test ht2) ;
	

--no 11. 
with average_stats as (
	select 
		target,
		avg(age) as avg_age,
		avg(cholestoral) as avg_chol
	from
		heartdiseasetrain_test ht 
	group by
		target
)
select 
	ht.age ,
	ht.cholestoral ,
	ht."target" ,
	a.avg_age,
	a.avg_chol
from 
	heartdiseasetrain_test ht
join 
	average_stats a on ht."target" = a.target
where
	ht.age >a.avg_age and ht.cholestoral >a.avg_chol;
	
--no 12. 
with average_chol as (
	select
		avg(ht.cholestoral) as avg_chol
	from 	
		heartdiseasetrain_test ht 
	where 
		ht.exercise_induced_angina='Yes'
)
select
	age,
	cholestoral,
	exercise_induced_angina,
	target 
from
	heartdiseasetrain_test ht2
where 
	cholestoral>(select a.avg_chol from average_chol a);


--no 13. 
with cte_angina as(
		with average_chol as (
			select
				avg(ht.cholestoral) as avg_chol
			from 	
				heartdiseasetrain_test ht 
			where 
				ht.exercise_induced_angina='Yes'
		)
		select
			age,
			cholestoral,
			exercise_induced_angina,
			target 
		from
			heartdiseasetrain_test ht2
		where 
			cholestoral>(select a.avg_chol from average_chol a)
)
select c.exercise_induced_angina, count(*) as totalpatients
from cte_angina c
group by c.exercise_induced_angina;


--no 14. 
select 
	age,
	cholestoral,
	target, 
	case
		when cholestoral>250 and age>(select avg(age) from heartdiseasetrain_test ht where target=1) then 'high risk'
		else 'low risk'
	end as risk_category
from 
	heartdiseasetrain_test ht 
where 
	target=1;
	
--no 15. 	
with cte_1 as
(select 
	age,
	cholestoral,
	target, 
	case
		when cholestoral>250 and age>(select avg(age) from heartdiseasetrain_test ht where target=1) then 'high risk'
		else 'low risk'
	end as risk_category
from 
	heartdiseasetrain_test ht 
where 
	target=1
)
select c. risk_category, count (*) as totalpatients
from cte_1 c
group by c.risk_category;