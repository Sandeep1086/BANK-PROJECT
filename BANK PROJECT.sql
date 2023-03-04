create database Bank_data
use bank_data

DROP TABLE train
CREATE TABLE train (
	age DECIMAL(38, 0) NOT NULL, 
	job VARCHAR(13) NOT NULL, 
	marital VARCHAR(8) NOT NULL, 
	education VARCHAR(9) NOT NULL, 
	`default` VARCHAR(10) NOT NULL, 
	balance DECIMAL(38, 0) NOT NULL, 
	housing VARCHAR(10) NOT NULL, 
	loan VARCHAR(20)  NOT NULL, 
	contact VARCHAR(9) NOT NULL, 
	day DECIMAL(38, 0) NOT NULL, 
	month VARCHAR(20)  NOT NULL, 
	duration DECIMAL(38, 0) NOT NULL, 
	campaign DECIMAL(38, 0) NOT NULL, 
	pdays DECIMAL(38, 0) NOT NULL, 
	previous DECIMAL(38, 0) NOT NULL, 
	poutcome VARCHAR(7) NOT NULL, 
	y VARCHAR(10)  NOT NULL
);

LOAD DATA INFILE 
'E:/test.csv'
into table train
FIELDS TERMINATED BY ';'
ENCLOSED BY '"'
lines terminated by '\n'
IGNORE 1 ROWS;


LOAD DATA INFILE 
'E:/train.csv'
into table train
FIELDS TERMINATED BY ';'
ENCLOSED BY '"'
lines terminated by '\n'
IGNORE 1 ROWS;


select * from train

select * from train order by age asc 

alter table train rename column marital to marital_status
alter table train rename column education to education_attainment
alter table train rename column `default` to credit_default
alter table train rename column balance to yearly_balance_ave
alter table train rename column housing to housing_loan
alter table train rename column loan to personal_loan
alter table train rename column contact to contact_type
alter table train rename column day to last_contact_day
alter table train rename column month to last_contact_month
alter table train rename column duration to last_contact_duration
alter table train rename column campaign to current_contact_count
alter table train rename column previous_idle_days to previous_contacted_days
alter table train rename column previous to previous_contact_count
alter table train rename column poutcome to previous_outcome
alter table train rename column y to current_outcome

select * from train where current_contact_count in (select max(current_contact_count) from train)

1. # create a list who they have credit , house loan or personal loan they wont be availed for futher loan approval...

select age,job,marital_status,credit_default,housing_loan,personal_loan ,

case
    when credit_default = 'yes' then 'No'
    when housing_loan = 'yes' then 'No'
    when personal_loan = 'yes' then 'No'
    else 'Yes'
    end as Further_Loan_Approval
 from train
 
 2. #  show in  which month max number of contact_duration is there??????
   
    select last_contact_month,last_contact_duration from train order by last_contact_duration desc

3. # show the profile details who they have not been contacted yet ???????
  
  select job,age,marital_status,education_attainment,previous_contacted_days as Not_contacted_yet from train where previous_contacted_days  = -1
  
 4.  # show the details who they have been contacted in last 30 days ??????
 
 select job,age,marital_status,education_attainment,contact_type ,last_contact_day from train where last_contact_day < 30 order by last_contact_day asc
 
 5.  # show the data of senior citizen who have credit_default ?????
 
 select age as Senior_citizen , credit_default from train where age > 60 and credit_default = 'yes'
 
 6. # show the details who has personal_loan with a postive current_outcome ????
 
 select age,job,personal_loan,current_outcome from train where current_outcome = 'yes' and personal_loan = 'yes' order by job
 

 
 