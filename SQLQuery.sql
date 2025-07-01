/*KPI 1*/
SELECT * FROM financial_loan 

 /*Total loan applications*/
 SELECT count(id) as Total_Applications from financial_loan  

 /*Month-to-date loan applications*/
 select count(id) as MTotal_Applications from financial_loan
 where MONTH(issue_date) = 12 AND YEAR(issue_date) = 2021

 /*Previous Month-to-date loan applications*/
 select count(id) as PMTotal_Applications from financial_loan
 where MONTH(issue_date) = 11 AND YEAR(issue_date) = 2021


/*KPI 2*/
select SUM(loan_amount) as Total_funded_amount from financial_loan

 /*Month-to-date funded amount*/
 select sum(loan_amount) as MFunded_Amount from financial_loan
 where MONTH(issue_date) = 12 AND YEAR(issue_date) = 2021

 /*Previous Month-to-date funded amount*/
 select sum(loan_amount) as PMFunded_Amount from financial_loan
 where MONTH(issue_date) = 11 AND YEAR(issue_date) = 2021

 
/*KPI 3*/
select SUM(total_payment) as Total_amount_recieved from financial_loan

 /*Month-to-date funded amount*/
 select sum(total_payment) as MTotal_amount_recieved from financial_loan
 where MONTH(issue_date) = 12 AND YEAR(issue_date) = 2021

 /*Previous Month-to-date funded amount*/
 select sum(total_payment) as PMTotal_amount_recieved from financial_loan
 where MONTH(issue_date) = 11 AND YEAR(issue_date) = 2021


/*KPI 4*/
select round(avg(int_rate)*100,2) as Average_int_rate from financial_loan

/*KPI 5*/
select round(avg(dti)*100,2) as debt_to_income from financial_loan


/*Good loan kpi*/
select 
 round((count(case when loan_status = 'Fully Paid' OR loan_status = 'Current' then id end)*100)/count(id),2) as good_loan_percentage
from financial_loan



select count(case when loan_status = 'Fully Paid' OR loan_status = 'Current' then id end) as Good_loan from financial_loan

select sum(case when loan_status in ('Fully Paid','Current') then loan_amount else 0 end) as Good_loan from financial_loan

select sum(loan_amount) as good_loan_amount from financial_loan
where loan_status = 'Fully Paid' OR loan_status = 'Current'


select sum(total_payment) as good_loan_ramount from financial_loan
where loan_status = 'Fully Paid' OR loan_status = 'Current'

/*Bad loan kpi*/

select 
(count(case when loan_status = 'Charged Off' then id end)) * 100.0 / count(id) as Bad_loan_percentage from financial_loan

select 
count(case when loan_status = 'Charged Off' then id end) as bad_loan from financial_loan

select
sum(case when loan_status = 'Charged Off' then loan_amount else 0 end) as bad_loan_famount from financial_loan

select
sum(case when loan_status = 'Charged Off' then total_payment else 0 end) as bad_loan_famount from financial_loan


/*Loan status grid view*/

select 
loan_status,
count(id) as total_loan_application,
sum(loan_amount) as Total_Funded_Amount,
sum(total_payment) as Total_Amount_Recieved,
round(avg(int_rate)*100,2) as Avg_int_rate,
round(avg(dti)*100,2) as Avg_dti
from financial_loan group by loan_status

select 
loan_status,
sum(loan_amount) as MTD_Funded_Amount,
sum(total_payment) as MTD_Amount_Recieved
from financial_loan 
where month(issue_date) = 12
group by loan_status

/*Dashboard 2*/
/*Monthly Trends by Issue Date*/

select
DATENAME(Month, issue_date) as Month,
count(id) as Total_Loan_Applications,
sum(loan_amount) as Total_funded_amount,
sum(total_payment) as Total_amount_recieved
from financial_loan
group by DATENAME(Month, issue_date), MONTH(issue_date)
order by MONTH(issue_date)


/*Regional Analysis by state*/

select
(address_state) as State,
count(id) as Total_Loan_Applications,
sum(loan_amount) as Total_funded_amount,
sum(total_payment) as Total_amount_recieved
from financial_loan
group by (address_state)

/*Loan Term Analysis*/

select
term as Term,
count(id) as Total_Loan_Applications,
sum(loan_amount) as Total_funded_amount,
sum(total_payment) as Total_amount_recieved
from financial_loan
group by term


/*Employee Length Analysis*/

select
emp_length as emp_length,
count(id) as Total_Loan_Applications,
sum(loan_amount) as Total_funded_amount,
sum(total_payment) as Total_amount_recieved
from financial_loan
group by emp_length
order by emp_length

/*Loan Purpose Breakdown*/

select
purpose as purpose,
count(id) as Total_Loan_Applications,
sum(loan_amount) as Total_funded_amount,
sum(total_payment) as Total_amount_recieved
from financial_loan
group by purpose
order by purpose

/*Home Ownership Analysis */

select
home_ownership as home_ownership,
count(id) as Total_Loan_Applications,
sum(loan_amount) as Total_funded_amount,
sum(total_payment) as Total_amount_recieved
from financial_loan
group by home_ownership
order by Total_Loan_Applications
