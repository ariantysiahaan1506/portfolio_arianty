
select *
from 
	online_retail;
	
--no 1.
select 
	"StockCode" ,
	"Description" ,
	sum("Quantity"*"UnitPrice") as total_sales
from 
	online_retail
group by
	"StockCode" , "Description" 
order by 
	total_sales desc;
	
--no 2.
select
	"CustomerID",
	sum("Quantity"*"UnitPrice") as total_spend
from
	online_retail or2 
group by
	"CustomerID"
order by 
	total_spend desc
limit 5;
	
--no 3
select 
	date_trunc('month', "InvoiceDate") as month,
	count(distinct "InvoiceNo") as number_of_orders,
	sum("Quantity"*"UnitPrice") as total_sales
from
	online_retail or2 
group by
	month
order by 
	month;
	

--no 4.

select
	"StockCode",
	"Description",
	sum("Quantity") as total_units_sold
from
	online_retail or2 
group by
	"StockCode", "Description" 
order by 
	total_units_sold desc
limit 1;

--no 5
select
	"CustomerID",
	"InvoiceNo",
	sum("Quantity" * "UnitPrice") as total_transaction_value
from
	online_retail or2 
group by
	"CustomerID", "InvoiceNo"
order by 
	total_transaction_value	desc 
limit 1;

--no 6
select
	"StockCode",
	"Description",
	count(distinct "InvoiceNo") as number_of_transactions
from
	online_retail or2 
group by
	"StockCode", "Description" 
order by 
	number_of_transactions desc;
	
--no 7
select
	"CustomerID",
	count(distinct "StockCode") as products_purchased
from
	online_retail or2 
group by
	"CustomerID"
order by 
	products_purchased desc;
	
--no 8a
--menambahkan kolom persen_diskon
alter table online_retail 
add column persen_diskon decimal (5,2);
--mengupdate isian kolom persen_diskon
update online_retail 
set persen_diskon = case 
WHEN "InvoiceDate" BETWEEN '2010-04-01' AND '2010-12-31' THEN 0.30
    WHEN "InvoiceDate" BETWEEN '2011-01-01' AND '2011-12-31' THEN 0.35
    ELSE 0.40
end;
--melihat kolom persen diskon dengan pivot
select "persen_diskon"
from online_retail or2 
group by persen_diskon ;
--melihat tabel invoice date dan persen diskon
select "InvoiceDate", "persen_diskon"
from online_retail or2 ;


--no 8b
select or2."InvoiceDate", or2."UnitPrice",
case 
	when OR2."UnitPrice" <=1.25 then 0.1
	when or2."UnitPrice" >1.25  and or2."UnitPrice" <=2.08 then 0.15
	when or2."UnitPrice" >2.08 and or2."UnitPrice" <=4.13 then 0.2
	else 0.25
end as persentase_gross_laba
from online_retail or2 ;

--no 8c
select or2."InvoiceDate", or2."CustomerID", or2."UnitPrice",
case 
	when OR2."UnitPrice" <=1.25 then 0.1
	when or2."UnitPrice" >1.25  and or2."UnitPrice" <=2.08 then 0.15
	when or2."UnitPrice" >2.08 and or2."UnitPrice" <=4.13 then 0.2
	else 0.25
end as persentase_gross_laba,
	(or2."UnitPrice"*(1- or2."persen_diskon")) as penjualan_bersih
	from 
online_retail or2;

--no 8d
select or2."InvoiceDate", or2."CustomerID", or2."UnitPrice",
case 
	when OR2."UnitPrice" <=1.25 then 0.1
	when or2."UnitPrice" >1.25  and or2."UnitPrice" <=2.08 then 0.15
	when or2."UnitPrice" >2.08 and or2."UnitPrice" <=4.13 then 0.2
	else 0.25
end as persentase_gross_laba,
	(or2."UnitPrice"*(1- or2."persen_diskon")) as penjualan_bersih,
	("UnitPrice" * (1- "persen_diskon")*
case 
	when OR2."UnitPrice" <=1.25 then 0.1
	when or2."UnitPrice" >1.25  and or2."UnitPrice" <=2.08 then 0.15
	when or2."UnitPrice" >2.08 and or2."UnitPrice" <=4.13 then 0.2
	else 0.25
	end) as keuntungan_bersih
from 
online_retail or2
order by "InvoiceDate" DESC;



