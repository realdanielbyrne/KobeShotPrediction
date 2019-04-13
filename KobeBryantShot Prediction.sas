/* Kobe Data Import */

%web_drop_table(WORK.kobeshots);
FILENAME REFFILE '/home/byrned0/KobeBryantShotPrediction/project2Data.xlsx';

PROC IMPORT DATAFILE=REFFILE
	DBMS=XLSX
	OUT=WORK.kobeshots;
	GETNAMES=YES;
RUN;

PROC CONTENTS DATA=WORK.kobeshots ; RUN;
%web_open_table(WORK.kobeshots);

data kobeshots; 
 set kobeshots;  
 time_remaining = 60*minutes_remaining+seconds_remaining;
run;

PROC SURVEYSELECT  DATA=kobeshots outall OUT=kobe METHOD=srs SAMPRATE=0.1;
RUN;

proc sql;
create table WORK.kobeclean 
as
select *
from work.kobe kobe
where ( kobe.shot_zone_range <> 'Back Court Shot' );
quit;

PROC SQL; 
CREATE TABLE WORK.kobetrain 
AS 
SELECT 
DISTINCT * FROM WORK.kobeclean kobeclean
where kobeclean.selected = 0; 
QUIT;

PROC SQL; 
CREATE TABLE WORK.kobetest 
AS 
SELECT 
DISTINCT * FROM WORK.kobeclean kobeclean
where kobeclean.selected = 1; 
QUIT;

proc princomp cov prefix=k data=kobetrain out=pcKB;
var lat lon time_remaining attendance arena_temp avgnoisedb;
run;

proc sort data=pcKB;
by shot_zone_range;
run;

proc logistic data = pcKB plots= all;
  class    shot_type 
          shot_zone_area shot_zone_basic shot_zone_range /param=ref;
  model shot_made_flag(event='1') = shot_distance k1 shot_type*shot_zone_area  
                                    / ctable lackfit clparm=wald cl pcorr ;
  output out=logisticOut predprobs=x p=predprob resdev=resdev reschi=pearres;
run;  