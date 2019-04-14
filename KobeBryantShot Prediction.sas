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

data kobeshots; set kobeshots;
if shot_zone_basic = "Above the Break" then szBasic = 4;
if shot_zone_basic = "Backcourt" then szBasic = 4;
if shot_zone_basic = "In The Paint (Non-RA)" then szBasic = 1;
if shot_zone_basic = "Left Corner" then szBasic = 3;
if shot_zone_basic = "Mid-Range" then szBasic = 2;
if shot_zone_basic = "Restricted Area" then szBasic = 1;
if shot_zone_basic = "Right Corner" then szBasic = 3;
if shot_zone_range = "24+ ft." then szRange = 3;
if shot_zone_range = "8-16 ft." then szRange = 2;
if shot_zone_range = "Back Court Shot" then szRange = 4;
if shot_zone_range = "Less Than 8ft." then szRange = 1;
run;


data kobeshots; 
 set kobeshots;  
 time_remaining = 60*minutes_remaining+seconds_remaining;
run;

PROC SURVEYSELECT  DATA=kobeshots outall OUT=kobe METHOD=srs SAMPRATE=0.1;
RUN;

/*
proc sql;
create table WORK.kobeclean 
as
select *
from work.kobe kobe
where ( kobe.shot_zone_range <> 'Back Court Shot' );
quit;
*/

PROC SQL; 
CREATE TABLE WORK.kobetrain 
AS 
SELECT 
DISTINCT * FROM WORK.kobe kobe
where kobe.selected = 0; 
QUIT;

PROC SQL; 
CREATE TABLE WORK.kobetest 
AS 
SELECT 
DISTINCT * FROM WORK.kobe kobe
where kobe.selected = 1; 
QUIT;

proc princomp cov prefix=k data=kobetrain out=pcKB;
var time_remaining attendance arena_temp avgnoisedb;
run;

proc logistic data = pcKB plots = all;
  class shot_type /param=ref;
  model shot_made_flag(event='1') = shot_distance k1 shot_type szBasic
                                    / ctable lackfit clparm=wald cl pcorr ;
  output out=logisticOut predprobs=x p=predprob resdev=resdev reschi=pearres;
run;  

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

data kobeshots; set kobeshots;
if shot_zone_basic = "Above the Break" then szBasic = 4;
if shot_zone_basic = "Backcourt" then szBasic = 4;
if shot_zone_basic = "In The Paint (Non-RA)" then szBasic = 1;
if shot_zone_basic = "Left Corner" then szBasic = 3;
if shot_zone_basic = "Mid-Range" then szBasic = 2;
if shot_zone_basic = "Restricted Area" then szBasic = 1;
if shot_zone_basic = "Right Corner" then szBasic = 3;
if shot_zone_range = "24+ ft." then szRange = 3;
if shot_zone_range = "8-16 ft." then szRange = 2;
if shot_zone_range = "Back Court Shot" then szRange = 4;
if shot_zone_range = "Less Than 8ft." then szRange = 1;
run;


data kobeshots; 
 set kobeshots;  
 time_remaining = 60*minutes_remaining+seconds_remaining;
run;

PROC SURVEYSELECT  DATA=kobeshots outall OUT=kobe METHOD=srs SAMPRATE=0.1;
RUN;

/*
proc sql;
create table WORK.kobeclean 
as
select *
from work.kobe kobe
where ( kobe.shot_zone_range <> 'Back Court Shot' );
quit;
*/

PROC SQL; 
CREATE TABLE WORK.kobetrain 
AS 
SELECT 
DISTINCT * FROM WORK.kobe kobe
where kobe.selected = 0; 
QUIT;

PROC SQL; 
CREATE TABLE WORK.kobetest 
AS 
SELECT 
DISTINCT * FROM WORK.kobe kobe
where kobe.selected = 1; 
QUIT;

proc princomp cov prefix=k data=kobetrain out=pcKB;
var time_remaining attendance arena_temp avgnoisedb;
run;

proc logistic data = pcKB plots = all;
  class shot_type /param=ref;
  model shot_made_flag(event='1') = shot_distance k1 shot_type szBasic
                                    / ctable lackfit clparm=wald cl pcorr ;
  output out=logisticOut predprobs=x p=predprob resdev=resdev reschi=pearres;
run;  

proc logistic data = pcKB plots = all;
  class shot_type /param=ref;
  model shot_made_flag(event='1') = shot_distance k1 shot_type szBasic szRange
                                   / ctable lackfit clparm=wald cl pcorr;
  contrast   'shot distance vs all' shot_distance 5 -1 -1 -1 -1 -1    /estimate=prob;                          
  output out=logisticOut predprobs=I p=predprob resdev=resdev reschi=pearres;
run;



