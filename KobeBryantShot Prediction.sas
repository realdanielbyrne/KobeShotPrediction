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


/*
 * shotdistance = glm(shot_made_flag~ shot_distance + combined_shot_type + shot_type, data=kobe,family="binomial")
 */
proc logistic data=kobeshots descending;

  class combined_shot_type shot_type / param=ref ;
  model shot_made_flag(event='1') = shot_distance combined_shot_type shot_type;
  output out=logisticOut predprobs=I p=predprob resdev=resdev reschi=pearres;
run;

