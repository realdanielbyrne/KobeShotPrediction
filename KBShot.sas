libname xl XLSX 
  '/home/gkodi0/project2Data.xlsx';

data data; set xl.KobeDataProj2;  RandNumber = ranuni(11);  run;

libname x2 XLSX 
  '/home/gkodi0/project2Pred.xlsx';

data dataPred; set x2.Sheet1;   run;

data dataKB;                                                                                                                                                                                                              
 set data;  
 time_remaining = 60*minutes_remaining+seconds_remaining;
 if time_remaining eq 0 then time_remaining = 1;
 
if action_type eq "Alley Oop Dunk Shot" then action_type_cat=1;
if action_type eq "Alley Oop Layup shot" then action_type_cat=2;
if action_type eq "Cutting Layup Shot" then action_type_cat=3;
if action_type eq "Driving Bank shot" then action_type_cat=4;
if action_type eq "Driving Dunk Shot" then action_type_cat=5;
if action_type eq "Driving Finger Roll Layup Shot" then action_type_cat=6;
if action_type eq "Driving Finger Roll Shot" then action_type_cat=7;
if action_type eq "Driving Floating Bank Jump Shot" then action_type_cat=8;
if action_type eq "Driving Floating Jump Shot" then action_type_cat=9;
if action_type eq "Driving Hook Shot" then action_type_cat=10;
if action_type eq "Driving Jump shot" then action_type_cat=11;
if action_type eq "Driving Layup Shot" then action_type_cat=12;
if action_type eq "Driving Reverse Layup Shot" then action_type_cat=13;
if action_type eq "Driving Slam Dunk Shot" then action_type_cat=14;
if action_type eq "Dunk Shot" then action_type_cat=15;
if action_type eq "Fadeaway Bank shot" then action_type_cat=16;
if action_type eq "Fadeaway Jump Shot" then action_type_cat=17;
if action_type eq "Finger Roll Layup Shot" then action_type_cat=18;
if action_type eq "Finger Roll Shot" then action_type_cat=19;
if action_type eq "Floating Jump shot" then action_type_cat=20;
if action_type eq "Follow Up Dunk Shot" then action_type_cat=21;
if action_type eq "Hook Bank Shot" then action_type_cat=22;
if action_type eq "Hook Shot" then action_type_cat=23;
if action_type eq "Jump Bank Shot" then action_type_cat=24;
if action_type eq "Jump Hook Shot" then action_type_cat=25;
if action_type eq "Jump Shot" then action_type_cat=26;
if action_type eq "Layup Shot" then action_type_cat=27;
if action_type eq "Pullup Bank shot" then action_type_cat=28;
if action_type eq "Pullup Jump shot" then action_type_cat=29;
if action_type eq "Putback Dunk Shot" then action_type_cat=30;
if action_type eq "Putback Layup Shot" then action_type_cat=31;
if action_type eq "Putback Slam Dunk Shot" then action_type_cat=32;
if action_type eq "Reverse Dunk Shot" then action_type_cat=33;
if action_type eq "Reverse Layup Shot" then action_type_cat=34;
if action_type eq "Reverse Slam Dunk Shot" then action_type_cat=35;
if action_type eq "Running Bank shot" then action_type_cat=36;
if action_type eq "Running Dunk Shot" then action_type_cat=37;
if action_type eq "Running Finger Roll Layup Shot" then action_type_cat=38;
if action_type eq "Running Finger Roll Shot" then action_type_cat=39;
if action_type eq "Running Hook Shot" then action_type_cat=40;
if action_type eq "Running Jump Shot" then action_type_cat=41;
if action_type eq "Running Layup Shot" then action_type_cat=42;
if action_type eq "Running Pull-Up Jump Shot" then action_type_cat=43;
if action_type eq "Running Reverse Layup Shot" then action_type_cat=44;
if action_type eq "Running Slam Dunk Shot" then action_type_cat=45;
if action_type eq "Running Tip Shot" then action_type_cat=46;
if action_type eq "Slam Dunk Shot" then action_type_cat=47;
if action_type eq "Step Back Jump shot" then action_type_cat=48;
if action_type eq "Tip Layup Shot" then action_type_cat=49;
if action_type eq "Tip Shot" then action_type_cat=50;
if action_type eq "Turnaround Bank shot" then action_type_cat=51;
if action_type eq "Turnaround Fadeaway shot" then action_type_cat=52;
if action_type eq "Turnaround Finger Roll Shot" then action_type_cat=53;
if action_type eq "Turnaround Hook Shot" then action_type_cat=54;
if action_type eq "Turnaround Jump Shot" then action_type_cat=55;
if combined_shot_type eq "Bank Shot" then comb_type_cat=1;
if combined_shot_type eq "Dunk " then comb_type_cat=2;
if combined_shot_type eq "Hook Shot" then comb_type_cat=3;
if combined_shot_type eq "Jump Shot" then comb_type_cat=4;
if combined_shot_type eq "Layup" then comb_type_cat=5;
if combined_shot_type eq "Tip Shot" then comb_type_cat=6;  
if shot_type eq "2PT Field Goal" then shot_type_cat=1;
if shot_type eq "3PT Field Goal" then shot_type_cat=2;  
if shot_zone_area eq "Back Court(BC)" then shot_zone_cat=1;
if shot_zone_area eq "Center(C)" then shot_zone_cat=2;
if shot_zone_area eq "Left Side Center(LC)" then shot_zone_cat=3;
if shot_zone_area eq "Left Side(L)" then shot_zone_cat=4; 
if shot_zone_area eq "Right Side Center(RC)" then shot_zone_cat=5;
if shot_zone_area eq "Right Side(R)" then shot_zone_cat=6;   
if shot_zone_basic eq "Above the Break 3" then shot_zone_bas_cat=1; 
if shot_zone_basic eq "Backcourt" then shot_zone_bas_cat=2;  
if shot_zone_basic eq "In The Paint (Non-RA)" then shot_zone_bas_cat=3;  
if shot_zone_basic eq "Left Corner 3" then shot_zone_bas_cat=4;  
if shot_zone_basic eq "Mid-Range" then shot_zone_bas_cat=5;  
if shot_zone_basic eq "Restricted Area" then shot_zone_bas_cat=6;   
if shot_zone_basic eq "Right Corner 3" then shot_zone_bas_cat=7;  
if shot_zone_range eq "16-24 ft." then shot_zone_range_cat=1; 
if shot_zone_range eq "24+ ft." then shot_zone_range_cat=2; 
if shot_zone_range eq "8-16 ft." then shot_zone_range_cat=3; 
if shot_zone_range eq "Back Court Shot" then shot_zone_range_cat=4;
if shot_zone_range eq "Less Than 8 ft." then shot_zone_range_cat=5;
if opponent eq "POR" then opponent_cat=1;
if opponent eq "UTA" then opponent_cat=2;
if opponent eq "VAN" then opponent_cat=3;
if opponent eq "LAC" then opponent_cat=4;
if opponent eq "HOU" then opponent_cat=5;
if opponent eq "SAS" then opponent_cat=6;
if opponent eq "DEN" then opponent_cat=7;
if opponent eq "SAC" then opponent_cat=8;
if opponent eq "CHI" then opponent_cat=9;
if opponent eq "GSW" then opponent_cat=10;
if opponent eq "MIN" then opponent_cat=11;
if opponent eq "IND" then opponent_cat=12;
if opponent eq "SEA" then opponent_cat=13;
if opponent eq "DAL" then opponent_cat=14;
if opponent eq "PHI" then opponent_cat=15;
if opponent eq "DET" then opponent_cat=16;
if opponent eq "MIL" then opponent_cat=17;
if opponent eq "TOR" then opponent_cat=18;
if opponent eq "MIA" then opponent_cat=19;
if opponent eq "PHX" then opponent_cat=20;
if opponent eq "CLE" then opponent_cat=21;
if opponent eq "NJN" then opponent_cat=22;
if opponent eq "NYK" then opponent_cat=23;
if opponent eq "CHA" then opponent_cat=24;
if opponent eq "WAS" then opponent_cat=25;
if opponent eq "ORL" then opponent_cat=26;
if opponent eq "ATL" then opponent_cat=27;
if opponent eq "MEM" then opponent_cat=28;
if opponent eq "BOS" then opponent_cat=29;
if opponent eq "NOH" then opponent_cat=30;
if opponent eq "NOP" then opponent_cat=31;
if opponent eq "OKC" then opponent_cat=32;
if opponent eq "BKN" then opponent_cat=33;                                                                                                                                                                 
run;                                                                                                                                                                                                                     

data dataPredKB;                                                                                                                                                                                                              
 set dataPred;  
 time_remaining = 60*minutes_remaining+seconds_remaining;
 if time_remaining eq 0 then time_remaining = 1;
 if shot_made_flag eq 'NA' then shot_made_flag=''; 
 	shot_made_flag_new = input(shot_made_flag,3.0);
	drop shot_made_flag;
   rename shot_made_flag_new=shot_made_flag; 
if action_type eq "Alley Oop Dunk Shot" then action_type_cat=1;
if action_type eq "Alley Oop Layup shot" then action_type_cat=2;
if action_type eq "Cutting Layup Shot" then action_type_cat=3;
if action_type eq "Driving Bank shot" then action_type_cat=4;
if action_type eq "Driving Dunk Shot" then action_type_cat=5;
if action_type eq "Driving Finger Roll Layup Shot" then action_type_cat=6;
if action_type eq "Driving Finger Roll Shot" then action_type_cat=7;
if action_type eq "Driving Floating Bank Jump Shot" then action_type_cat=8;
if action_type eq "Driving Floating Jump Shot" then action_type_cat=9;
if action_type eq "Driving Hook Shot" then action_type_cat=10;
if action_type eq "Driving Jump shot" then action_type_cat=11;
if action_type eq "Driving Layup Shot" then action_type_cat=12;
if action_type eq "Driving Reverse Layup Shot" then action_type_cat=13;
if action_type eq "Driving Slam Dunk Shot" then action_type_cat=14;
if action_type eq "Dunk Shot" then action_type_cat=15;
if action_type eq "Fadeaway Bank shot" then action_type_cat=16;
if action_type eq "Fadeaway Jump Shot" then action_type_cat=17;
if action_type eq "Finger Roll Layup Shot" then action_type_cat=18;
if action_type eq "Finger Roll Shot" then action_type_cat=19;
if action_type eq "Floating Jump shot" then action_type_cat=20;
if action_type eq "Follow Up Dunk Shot" then action_type_cat=21;
if action_type eq "Hook Bank Shot" then action_type_cat=22;
if action_type eq "Hook Shot" then action_type_cat=23;
if action_type eq "Jump Bank Shot" then action_type_cat=24;
if action_type eq "Jump Hook Shot" then action_type_cat=25;
if action_type eq "Jump Shot" then action_type_cat=26;
if action_type eq "Layup Shot" then action_type_cat=27;
if action_type eq "Pullup Bank shot" then action_type_cat=28;
if action_type eq "Pullup Jump shot" then action_type_cat=29;
if action_type eq "Putback Dunk Shot" then action_type_cat=30;
if action_type eq "Putback Layup Shot" then action_type_cat=31;
if action_type eq "Putback Slam Dunk Shot" then action_type_cat=32;
if action_type eq "Reverse Dunk Shot" then action_type_cat=33;
if action_type eq "Reverse Layup Shot" then action_type_cat=34;
if action_type eq "Reverse Slam Dunk Shot" then action_type_cat=35;
if action_type eq "Running Bank shot" then action_type_cat=36;
if action_type eq "Running Dunk Shot" then action_type_cat=37;
if action_type eq "Running Finger Roll Layup Shot" then action_type_cat=38;
if action_type eq "Running Finger Roll Shot" then action_type_cat=39;
if action_type eq "Running Hook Shot" then action_type_cat=40;
if action_type eq "Running Jump Shot" then action_type_cat=41;
if action_type eq "Running Layup Shot" then action_type_cat=42;
if action_type eq "Running Pull-Up Jump Shot" then action_type_cat=43;
if action_type eq "Running Reverse Layup Shot" then action_type_cat=44;
if action_type eq "Running Slam Dunk Shot" then action_type_cat=45;
if action_type eq "Running Tip Shot" then action_type_cat=46;
if action_type eq "Slam Dunk Shot" then action_type_cat=47;
if action_type eq "Step Back Jump shot" then action_type_cat=48;
if action_type eq "Tip Layup Shot" then action_type_cat=49;
if action_type eq "Tip Shot" then action_type_cat=50;
if action_type eq "Turnaround Bank shot" then action_type_cat=51;
if action_type eq "Turnaround Fadeaway shot" then action_type_cat=52;
if action_type eq "Turnaround Finger Roll Shot" then action_type_cat=53;
if action_type eq "Turnaround Hook Shot" then action_type_cat=54;
if action_type eq "Turnaround Jump Shot" then action_type_cat=55;
if combined_shot_type eq "Bank Shot" then comb_type_cat=1;
if combined_shot_type eq "Dunk " then comb_type_cat=2;
if combined_shot_type eq "Hook Shot" then comb_type_cat=3;
if combined_shot_type eq "Jump Shot" then comb_type_cat=4;
if combined_shot_type eq "Layup" then comb_type_cat=5;
if combined_shot_type eq "Tip Shot" then comb_type_cat=6;  
if shot_type eq "2PT Field Goal" then shot_type_cat=1;
if shot_type eq "3PT Field Goal" then shot_type_cat=2;  
if shot_zone_area eq "Back Court(BC)" then shot_zone_cat=1;
if shot_zone_area eq "Center(C)" then shot_zone_cat=2;
if shot_zone_area eq "Left Side Center(LC)" then shot_zone_cat=3;
if shot_zone_area eq "Left Side(L)" then shot_zone_cat=4; 
if shot_zone_area eq "Right Side Center(RC)" then shot_zone_cat=5;
if shot_zone_area eq "Right Side(R)" then shot_zone_cat=6;   
if shot_zone_basic eq "Above the Break 3" then shot_zone_bas_cat=1; 
if shot_zone_basic eq "Backcourt" then shot_zone_bas_cat=2;  
if shot_zone_basic eq "In The Paint (Non-RA)" then shot_zone_bas_cat=3;  
if shot_zone_basic eq "Left Corner 3" then shot_zone_bas_cat=4;  
if shot_zone_basic eq "Mid-Range" then shot_zone_bas_cat=5;  
if shot_zone_basic eq "Restricted Area" then shot_zone_bas_cat=6;   
if shot_zone_basic eq "Right Corner 3" then shot_zone_bas_cat=7;  
if shot_zone_range eq "16-24 ft." then shot_zone_range_cat=1; 
if shot_zone_range eq "24+ ft." then shot_zone_range_cat=2; 
if shot_zone_range eq "8-16 ft." then shot_zone_range_cat=3; 
if shot_zone_range eq "Back Court Shot" then shot_zone_range_cat=4;
if shot_zone_range eq "Less Than 8 ft." then shot_zone_range_cat=5;
if opponent eq "POR" then opponent_cat=1;
if opponent eq "UTA" then opponent_cat=2;
if opponent eq "VAN" then opponent_cat=3;
if opponent eq "LAC" then opponent_cat=4;
if opponent eq "HOU" then opponent_cat=5;
if opponent eq "SAS" then opponent_cat=6;
if opponent eq "DEN" then opponent_cat=7;
if opponent eq "SAC" then opponent_cat=8;
if opponent eq "CHI" then opponent_cat=9;
if opponent eq "GSW" then opponent_cat=10;
if opponent eq "MIN" then opponent_cat=11;
if opponent eq "IND" then opponent_cat=12;
if opponent eq "SEA" then opponent_cat=13;
if opponent eq "DAL" then opponent_cat=14;
if opponent eq "PHI" then opponent_cat=15;
if opponent eq "DET" then opponent_cat=16;
if opponent eq "MIL" then opponent_cat=17;
if opponent eq "TOR" then opponent_cat=18;
if opponent eq "MIA" then opponent_cat=19;
if opponent eq "PHX" then opponent_cat=20;
if opponent eq "CLE" then opponent_cat=21;
if opponent eq "NJN" then opponent_cat=22;
if opponent eq "NYK" then opponent_cat=23;
if opponent eq "CHA" then opponent_cat=24;
if opponent eq "WAS" then opponent_cat=25;
if opponent eq "ORL" then opponent_cat=26;
if opponent eq "ATL" then opponent_cat=27;
if opponent eq "MEM" then opponent_cat=28;
if opponent eq "BOS" then opponent_cat=29;
if opponent eq "NOH" then opponent_cat=30;
if opponent eq "NOP" then opponent_cat=31;
if opponent eq "OKC" then opponent_cat=32;
if opponent eq "BKN" then opponent_cat=33;                                                                                                                                                                 
run;                                                  

data trainKB; set dataKB; if RandNumber <= 1/4 then delete;                                                                                                                                                                                         
run;                                                                                                                                                                                                                     
                                                                                                                                                                                                                         
data testKB; set dataKB; if RandNumber > 1/4 then delete;                                                                                                                                                                                         
run; 

/** priors '0' 0.5538 '1' 0.4462 */

proc reg data=dataKB ;
model shot_made_flag = action_type_cat comb_type_cat shot_type_cat shot_zone_cat shot_zone_bas_cat shot_zone_range_cat opponent_cat lat lon time_remaining period playoffs shot_distance attendance arena_temp avgnoisedb / r;
output out=kbCook cookd=cooks student=students rstudent=studresid;
run;

proc sort data=kbCook out=outSortKB;
by descending cooks;
run;

proc print data=outSortKB (obs=10);
 var recId cooks;
run;

      
      
proc corr data=dataKB;
var  action_type_cat comb_type_cat shot_zone_cat opponent_cat lon period playoffs time_remaining shot_distance attendance arena_temp ;
run;




proc reg data=dataKB plots=all;
model shot_made_flag = action_type_cat comb_type_cat shot_zone_cat opponent_cat lat lon time_remaining period playoffs shot_distance attendance arena_temp / vif  tol collin;
run;

/* one of lda model - The probability of Kobe making a shot decreases linearly with respect to the distance he is from the hoop*/
proc discrim data=dataKB pool=test out=discrimCategorizedKB crossvalidate ;
class  shot_made_flag  ;
 var attendance avgnoisedb shot_distance shot_zone_bas_cat shot_zone_range_cat ;
 priors '0' = 0.5538 '1' = 0.4462;
 
run;

proc discrim data=dataKB pool=test testdata=dataPredKB testout=discrimPredictKB out=discrimKB crossvalidate ;
class  shot_made_flag  ;
 var attendance avgnoisedb shot_distance shot_zone_bas_cat shot_zone_range_cat ;
 priors '0' = 0.5538 '1' = 0.4462;
 
run;

/* The relationship between the distance Kobe is from the basket and the odds of him making the shot */
proc freq data=dataKB order=data;
   weight shot_distance;
   tables playoffs*shot_made_flag / riskdiff(equal var=null cl=wald) relrisk;
run;


/*--------------------------------------*/
/** Unused model data start */

proc logistic data = dataKB plots= all;
 class   shot_type
         shot_zone_area shot_zone_basic shot_zone_range /param=ref;
 model shot_made_flag(event='1') = attendance avgnoisedb shot_distance shot_zone_bas_cat shot_zone_range_cat
                                   / ctable lackfit clparm=wald cl pcorr ;
 output out=logisticOut predprobs=x p=predprob resdev=resdev reschi=pearres;
 Score data=dataPredKB out=logisticCategorized;
run;


proc logistic data=dataKB order=data plots=all;
model shot_made_flag = action_type_cat comb_type_cat shot_type_cat shot_zone_cat shot_zone_bas_cat shot_zone_range_cat opponent_cat lat lon time_remaining period playoffs shot_distance attendance arena_temp avgnoisedb;
run;

proc discrim data=dataKB pool=test crossvalidate ;
class shot_made_flag;
var time_remaining period  shot_distance attendance arena_temp ;
priors '0' = 0.5538 '1' = 0.4462;
run;

proc logistic data=trainKB order=data plots=all;
class shot_made_flag/ param = ref;
model shot_made_flag = lon time_remaining period playoffs shot_distance attendance arena_temp ;
Score data=testKB;
run;

proc logistic data=trainKB order=data plots=all;
class action_type combined_shot_type shot_type opponent shot_zone_area / param=ref;
model shot_made_flag(event='1') =  action_type combined_shot_type  shot_type time_remaining period  shot_distance attendance arena_temp ;
Score data=testKB;
run;

proc logistic data=dataKB order=data plots=all;
class combined_shot_type shot_type shot_zone_range/ param=ref desc;
 model shot_made_flag(event='0') = shot_distance combined_shot_type shot_zone_range/ ctable lackfit clparm=wald cl pcorr ;
 by shot_zone_range;
 run;

proc glmselect data=dataKB;
class action_type combined_shot_type shot_type opponent shot_zone_area;
model shot_made_flag = action_type combined_shot_type lon time_remaining period playoffs shot_distance attendance arena_temp ;
run;


proc princomp prefix=k data=dataKB out=pcKB;
var lon time_remaining period shot_distance attendance arena_temp avgnoisedb;
run;

proc logistic data=pcKB order=data plots=all;
model shot_made_flag = k1 k2 k3 k4 k5 k6 k7 k8 ;
run;



proc logistic data = dataKB plots= all;
 class   shot_type
         shot_zone_area shot_zone_basic shot_zone_range /param=ref;
 model shot_made_flag(event='1') = attendance avgnoisedb shot_distance shot_zone_bas_cat shot_zone_range_cat
                                   / ctable lackfit clparm=wald cl pcorr ;
 output out=logisticOut predprobs=x p=predprob resdev=resdev reschi=pearres;
 Score data=dataPredKB out=logisticCategorized;
run;

proc princomp cov prefix=k data=dataKB out=pcKB;
var lon time_remaining period playoffs attendance avgnoisedb  shot_zone_bas_cat shot_zone_range_cat ;
run;

proc sort data=pcKB;
by shot_zone_range;
run;

data trainPCKB; set pcKB; if RandNumber <= 1/4 then delete;                                                                                                                                                                                         
run;                                                                                                                                                                                                                     
                                                                                                                                                                                                                         
data testPCKB; set pcKB; if RandNumber > 1/4 then delete;                                                                                                                                                                                         
run;

/** Unused model data end */

/*--------------------------------------*/
