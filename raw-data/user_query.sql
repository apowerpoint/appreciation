set pagesize 0
set linesize 120
set feedback off
set heading off 
set echo off
SET TERMOUT OFF 

spool dim_user.csv

--SELECT 'user_key,system_user_id,employment_status,account_claimed_dt,hire_dt,user_security_role,sold_to_party_nbr,business_unit_id,current_yn,effective_dts,next_effective_dts' from dual;
select cast(trim(to_char(user_key) 
  || ','  || to_char(system_user_id) 
  || ',"' || employment_status || '"'
  || ','  || to_char(account_claimed_dt, 'yyyymmdd')
  || ','  || to_char(hire_dt, 'yyyymmdd')
  || ',"' || lower(user_security_role) || '"'
  || ',"' || sold_to_party_nbr || '"'
  || ','  || manager_system_user_id
  || ','  || business_unit_id 
  || ',"' || current_yn || '"'
  || ','  || to_char(effective_dts, 'yyyymmdd')
  || ','  || to_char(next_effective_dts, 'yyyymmdd')) as varchar2(110))
from dim_user 
--where rownum < 10
; 
/

spool off

set echo on
set feedback on 
SET TERMOUT ON
quit

