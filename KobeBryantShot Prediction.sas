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

PROC SURVEYSELECT  DATA=kobeshots outall OUT=kobe METHOD=srs SAMPRATE=0.1;
RUN;

PROC SQL; 
CREATE TABLE WORK.kobetrain 
AS 
SELECT 
DISTINCT * FROM WORK.KOBE KOBE
where kobe.selected = 0; 
QUIT;

PROC SQL; 
CREATE TABLE WORK.kobetest 
AS 
SELECT 
DISTINCT * FROM WORK.KOBE KOBE
where kobe.selected = 1; 
QUIT;


/*
 * shotdistance = glm(shot_made_flag~ shot_distance + combined_shot_type + shot_type, data=kobe,family="binomial")
 */
 ods graphics on;
proc logistic data=kobeshots descending;
  class combined_shot_type shot_type / param=ref ;
  model shot_made_flag(event='1') = shot_distance combined_shot_type shot_type;
  oddsratio shot_distance;
  output out=logisticOut predprobs=X p=predprob resdev=resdev reschi=pearres;
run;
 ods graphics off;


ods graphics on;
proc logistic data=kobetrain descending;
  class shot_type / param=ref ;
  model shot_made_flag(event='1') = shot_distance shot_type/ lackfit cl pcorr ctable pprob= (0.4 to 0.6 by 0.1);;
  oddsratio shot_distance;
  output out=logisticOut predprobs=X p=predprob resdev=resdev reschi=pearres;
run;
 ods graphics off;
 
ods graphics on;
proc logistic data=kobetrain descending;
  class shot_zone_range / param=ref ;
  model shot_made_flag(event='1') = shot_distance shot_zone_range/ lackfit cl pcorr ctable pprob= (0.4 to 0.6 by 0.1);;
  oddsratio shot_distance;
  output out=logisticOut predprobs=X p=predprob resdev=resdev reschi=pearres;
run;
ods graphics off;
 

proc logistic data=kobetrain descending outmodel = kobetrained;
  class combined_shot_type shot_type shot_zone_range/ param=ref ;
  model shot_made_flag(event='1') = shot_distance combined_shot_type shot_zone_range/ lackfit cl pcorr ctable pprob= (0.4 to 0.6 by 0.1);
  output out=logisticOut predprobs=X p=predprob resdev=resdev reschi=pearres;
run;

proc print data = logisticout(obs=10);run;


