/* Kobe Data Import */
%web_drop_table(WORK.kobeshots);
FILENAME REFFILE '/folders/myfolders/project2Data.xlsx';

/* Kobe Predict Data Import */
%web_drop_table(WORK.kobeshots);
FILENAME REFFILE1 '/folders/myfolders/project2Pred.xlsx';

PROC IMPORT DATAFILE=REFFILE
	DBMS=XLSX
	OUT=WORK.kobeshots;
	GETNAMES=YES;
RUN;

PROC IMPORT DATAFILE=REFFILE1
	DBMS=XLSX
	OUT=WORK.kobeshotsPred;
	GETNAMES=YES;
RUN;

PROC CONTENTS DATA=WORK.kobeshotsPred ; RUN;
%web_open_table(WORK.kobeshotsPred);


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

if shot_type = "2PT Field Goal" then shot_type_cat = 0;
if shot_type = "3PT Field Goal" then shot_type_cat = 1;

if prxmatch ("/@/",matchup) > 0 then home = 1; else home = 0 ;

run;

/** updated NA data in the prediction file */
data kobeshotsPred; set kobeshotsPred;
if shot_made_flag eq 'NA' then shot_made_flag=''; 
 	shot_made_flag_new = input(shot_made_flag,3.0);
	drop shot_made_flag;
   rename shot_made_flag_new=shot_made_flag; 
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

if shot_type = "2PT Field Goal" then shot_type_cat = 0;
if shot_type = "3PT Field Goal" then shot_type_cat = 1;

if prxmatch ("/@/",matchup) > 0 then home = 1; else home = 0 ;

run;

/** Transforming the time variables */
data kobeshots; 
 set kobeshots;  
 time_remaining = 60*minutes_remaining+seconds_remaining;
run;

data kobeshotsPred; 
 set kobeshotsPred;  
 time_remaining = 60*minutes_remaining+seconds_remaining;
run;

PROC SURVEYSELECT  DATA=kobeshots outall OUT=kobe METHOD=srs SAMPRATE=0.1;
RUN;

PROC SURVEYSELECT  DATA=kobeshotsPred outall OUT=kobePred METHOD=srs SAMPRATE=0.1;
RUN;

/** Checking correlation between the selected variables */
proc sgscatter data=kobe;
matrix lat lon time_remaining playoffs shot_distance attendance arena_temp avgnoisedb / diagonal=(kernel histogram);
run;

/** Checking outliers */
proc reg data=kobe ;
model shot_made_flag =  lat lon time_remaining period playoffs shot_distance attendance arena_temp avgnoisedb / r;
output out=kbCook cookd=cooks student=students rstudent=studresid;
run;

proc sort data=kbCook out=outSortKB;
by descending cooks;
run;

proc print data=outSortKB (obs=10);
 var recId cooks;
run;

/** Running principal components for dataset */
proc princomp cov prefix=k data=kobe out=kobe;
var time_remaining attendance arena_temp avgnoisedb;
run;

proc princomp cov prefix=k data=kobePred out=kobePred;
var time_remaining attendance arena_temp avgnoisedb;
run;

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

proc sort data = kobetrain;
by shot_type;
run;



/* shot_type Analysis - •	The odds of Kobe making a shot decrease with respect to the distance he is from the hoop */
proc logistic data = kobetrain plots = all;
  class shot_type combined_shot_type(ref='Jump Shot') /param=ref;
  model shot_made_flag(event='1') = shot_distance shot_type k1 combined_shot_type
                                   / ctable lackfit clparm=wald cl pcorr ;    
	contrast 'shot_distance vs. shot_type' shot_distance 1 -1 0 0 0 0 ;
  output out=logisticOut predprobs=I p=predprob resdev=resdev reschi=pearres;
run;


title "Examine Senisitivity and Speicificity for Logistic";
proc freq data=logisticOut; tables shot_made_flag*_into_/nocol nopercent; run;

/* playoffs Analysis - •	The relationship between the distance Kobe is from the basket and the odds of him making the shot is different if they are in the playoffs */
proc logistic data = kobetrain plots = all;
  class shot_type playoffs /param=ref;
  model shot_made_flag(event='1') = shot_distance k1 playoffs combined_shot_type
                                   / ctable lackfit clparm=wald cl pcorr;   
  contrast 'shot_distance vs playoffs' shot_distance 2 0 -1 -1;
  output out=logisticOut predprobs=I p=predprob resdev=resdev reschi=pearres;
run;


/* LDA with Shot_type principle componenet analysis and shot_distance */
/* Predicting for shot_made_flag for the prediction file data using LDA */
proc discrim data=kobe pool=test testdata=kobetkobePredest testout=discrimPredictKB out=discrimKB crossvalidate ;
class  shot_made_flag  ;
 var  shot_distance k1 shot_type_cat;
 priors '0' = 0.5538 '1' = 0.4462;
run;

title "Examine Senisitivity and Speicificity for Discrim";
proc freq data =discrimKB; tables shot_made_flag*_into_/nocol nopercent; run; 

/** Predicting for shot_made_flag for the prediction file data */
proc logistic data = kobe plots = all;
  class shot_type home combined_shot_type(ref='Jump Shot') /param=ref;
  model shot_made_flag(event='1') = shot_distance shot_type k1 combined_shot_type
                                   / ctable lackfit clparm=wald cl pcorr pprob=.4 .5 .6;    
	contrast 'shot_distance vs. shot_type' shot_distance 1 -1 0 0 0 0 ;
  output out=logisticOut predprobs=I p=predprob resdev=resdev reschi=pearres;
  Score data=kobePred out = logisticPred;
run;
