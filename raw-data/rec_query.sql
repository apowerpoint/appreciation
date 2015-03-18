set pagesize 0
set linesize 471
set feedback off
set heading off 
set echo off
SET TERMOUT on 

spool fact_recognition.csv

select  
  to_char(fact_recognition_key)
  || ','  || to_char(nomination_nominee_id)
  || ','  || to_char(eproduct_recipient_id)
  || ','  || to_char(user_transaction_id)
  || ','  || to_char(reward_code_id)
  || ',"' || to_char(customer.sold_to_party_nbr) ||'"'
  || ','  || to_char(prog.program_key) 
  || ',"' || PROG.PROGRAM_NAME || '"'
  || ','  || to_char(al.award_level_key) 
  || ',"' || AL.AWARD_LEVEL_NAME || '"'
  || ','  || to_char(rl.award_level_key) 
  || ',"' || rl.award_level_name || '"' 
  || ','  || to_char(S.RECOGNITION_STATUS_KEY) 
  || ',"' || S.RECOGNITION_STATUS_NAME || '"'
  || ','  || to_char(f.issued_date_key)
  || ','  || to_char(F.CANCELLED_DATE_KEY)
  || ','  || to_char(f.declined_date_key)
  || ','  || to_char(f.recognition_date_key)
  || ','  || to_char(f.final_approval_date_key)
  || ','  || to_char(f.giver_user_key)
  || ','  || to_char(F.RECEIVER_USER_KEY)
  || ','  || to_char(F.PROXY_GIVER_USER_KEY)
  || ','  || to_char(GBU.BUSINESS_UNIT_ID) 
  || ',"' || GBU.BUSINESS_UNIT_NAME || '"'
  || ','  || to_char(GBU.PARENT_BUSINESS_UNIT_ID)
  || ','  || to_char(RBU.BUSINESS_UNIT_ID) 
  || ',"' || RBU.BUSINESS_UNIT_NAME || '"'
  || ','  || to_char(RBU.PARENT_BUSINESS_UNIT_ID)
  || ','  || to_char(PBU.BUSINESS_UNIT_ID) 
  || ',"' || PBU.BUSINESS_UNIT_NAME || '"'
  || ','  || to_char(PBU.PARENT_BUSINESS_UNIT_ID)
  || ','  || to_char(days_to_approve)
  || ','  || to_char(points_value)
  || ','  || to_char(GA.ACTIVITY_ID) 
  || ',"' || GA.ACTIVITY_DESCR || '"'
  || ','  || to_char(ra.activity_id)
  || ',"' || ra.activity_descr || '"' as all_data
from fact_recognition f
inner join dim_customer customer on CUSTOMER.CUSTOMER_KEY = F.CUSTOMER_KEY -- type 2
inner join dim_program prog on prog.program_key = F.PROGRAM_KEY
inner join dim_award_level al on Al.AWARD_LEVEL_KEY = f.award_level_key
inner join dim_award_level rl on rl.award_level_key = f.recommended_award_level_key
inner join dim_recognition_status s on S.RECOGNITION_STATUS_KEY = f.recognition_status_key
inner join dim_business_unit gbu on GBU.BUSINESS_UNIT_KEY = F.GIVER_BUSINESS_UNIT_KEY
inner join dim_business_unit rbu on rbu.business_unit_key = F.RECEIVER_BUSINESS_UNIT_KEY
inner join dim_business_unit pbu on pbu.business_unit_key = f.proxy_business_unit_key
inner join dim_activity ga on ga.activity_key = F.GIVER_ACTIVITY_KEY
inner join dim_activity ra on ra.activity_key = F.RECEIVER_ACTIVITY_KEY
--where rownum < 10
; 
/

spool off

set echo on
set feedback on 
SET TERMOUT ON
quit

