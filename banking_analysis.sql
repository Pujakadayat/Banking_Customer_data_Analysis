-- Customer Segmentation By Loyalty Classification
select 
Loyalty_Classification,
count(*) as customer_count,
Avg(Estimated_Income) as avg_income
from banking
group by Loyalty_Classification

-- Age demographic Analysis

select
Case
when Age < 30 Then '18-30'
when Age <50 Then  '30-49'
when Age < 65 then '50-64'
Else '65+'
End age_group,
count(*) as total_customers,
Avg(Bank_Deposits) as avg_deposits
from banking
group by age_group
order by avg_deposits desc


-- Income Band Distribution

Select 
Income_Band,Nationality, Count(*) as count
from banking
group by Income_Band,Nationality
Order by Income_Band, count desc

-- Financial Product Usage Analysis

-- credit card usage patterns

Select 
Amount_of_Credit_cards,
count(*) as customers,
Avg(Credit_Card_Balance) as avg_balance
from banking
Group by Amount_of_Credit_cards 


-- Revenue and Profitability Analysis

-- Fee structure revenue

select 
Fee_Structure,
count(*) as customers,
Sum(Bank_Deposits + Checking_Accounts+ Saving_Accounts) as total_deposits,
Avg(Credit_Card_Balance) as avg_balance
from banking 
group by Fee_Structure

-- Customer with High assets
select
Client_Id,
Name,
(Bank_Deposits + Checking_Accounts+ Saving_Accounts+ Superannuation_Savings) as total_assets,
Loyalty_Classification
from banking
order by total_assets desc

-- Credit Risk Analysis

select 
case 
when Credit_Card_Balance / coalesce(Estimated_Income,0) > 0.5 Then 'High Risk'
when Credit_Card_Balance / coalesce(Estimated_Income,0) > 0.3 Then 'Medium Risk'
else 'Low Risk'
end as risk_level,
count(*) as customers,
avg(Bank_Loans) as avg_Loans
from banking
Group by risk_level;

-- Debt to income ratio analysis

Select
Income_Band,
Avg((Bank_Loans + Credit_Card_Balance) / coalesce(Estimated_Income,0)) as avg_debt_to_income_ratio,
count(*) as customers
from banking 
group by Income_Band
order by avg_debt_to_income_ratio desc

-- Ranking customers within loyalty tiers

Select
Client_id,Name,Loyalty_Classification,
Bank_Deposits,
Rank() over(Partition by Loyalty_Classification order by Bank_Deposits desc) as rank_in_tier
from banking

-- Running total of deposit by Joined date
select
Joined_Bank,
Bank_Deposits,
Sum(Bank_Deposits) over(order by Joined_Bank) as cumulative_deposits
from banking
Order by Joined_Bank











