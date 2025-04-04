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
