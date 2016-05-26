// Loading Data
// Loading on Mac
use "/Users/Jeremy/Documents/GitHub/School-Alcohol-Employment-Link/Dataset/alcohol.dta", clear

// Loading on PC
use "C:\Users\Jeremy\Dropbox\Documents\GitHub\School-Alcohol-Employment-Link\Dataset\alcohol.dta", clear

* Cleaning data

# delimit ; // change delimiter to ;

// Removes NA values
drop if age == . | sex == . | race == . | health == . | higrad == . | 
famsz == . | marst == . | afqtrev == . | urate == . | region == . | 
wdad14 == . | dadhgc == . | wmom14 == . | momhgc == . | numsib == .;

// Keeps only variables of interest
keep age sex race health higrad famsz marst afqtrev urate region wdad14 dadhgc
wmom14 momhgc numsib drnk6m empst year momwork dadwork;

// Keep 1994 obs
keep if year == 94;

# delimit cr // change delimiter to carriage

* Creating correct variables

// No active in armed forces, create dummy variable 1 if employed, 2 otherwise
// Labor Variable
gen emp = 0
replace emp = 1 if empst == 1 | empst == 2
label variable emp "1 if employed"

// Alcohol Variable
// Make default category 0 drinks (drnk_freq1)
tab drnk6m, gen(drnk_freq)

rename drnk_freq1 drnk_freq0
label variable drnk_freq0 "0 times"

rename drnk_freq2 drnk_freq1
label variable drnk_freq1 "1 time"

rename drnk_freq3 drnk_freq2
label variable drnk_freq2 "2 or 3 times"

rename drnk_freq4 drnk_freq3
label variable drnk_freq3 "4 or 5 times"

rename drnk_freq5 drnk_freq4
label variable drnk_freq4 "6 or 7 times"

rename drnk_freq6 drnk_freq5
label variable drnk_freq5 "8 or 9 times"

rename drnk_freq7 drnk_freq6
label variable drnk_freq6 "10 or more times"

// Male: use male as default
gen male = 0
replace male = 1 if sex == 1
label variable male "1 if male"

// Race: Use other as default
rename race race_temp
tab race_temp, gen(race)
label variable race1 "Hispanic"
label variable race2 "Black"
label variable race3 "Other"

// Marital status: use marst2 as default
rename marst marst_temp
tab marst_temp, gen(marst)
label variable marst1 "Never married"
label variable marst2 "Married with spouse present"
label variable marst3 "Other"

// Region: use region 3 (South) as default
tab region, gen(reg)
label variable reg1 "Northeast"
label variable reg2 "North Central"
label variable reg3 "South"
label variable reg4 "West"

// Dad's education interaction term
gen dad_educ = wdad14*dadhgc
label variable dad_educ "Interaction between Dad's education and living"

// Mom's education interaction term
gen mom_educ = wmom14*momhgc
label variable mom_educ "Interaction between Mom's education and living"

// Dad's employment status interaction term
gen dad_work = wdad14*dadwork
label variable dad_work "Interaction between Dad's employment and living"

// Mom's employment status interaction term
gen mom_work = wmom14*momwork
label variable mom_work "Interaction between Mom's employment and living"


* First regression, no demographics, 1994 data, regress emp on drinking
probit emp drnk_freq1 drnk_freq2 drnk_freq3 drnk_freq4 drnk_freq5 drnk_freq6, robust
mfx compute

* Second regression, controlling for individual differences
# delimit ; // change delimiter to ;
probit emp drnk_freq1 drnk_freq2 drnk_freq3 drnk_freq4 drnk_freq5 drnk_freq6
age male race1 race2 health higrad famsz marst1 marst3 afqtrev, robust;
# delimit cr // change delimiter to carriage
mfx compute

* Third regression, controlling for individual differences and geographic area
# delimit ; // change delimiter to ;
probit emp drnk_freq1 drnk_freq2 drnk_freq3 drnk_freq4 drnk_freq5 drnk_freq6
age male race1 race2 health higrad famsz marst1 marst3 reg1 reg2 reg4 urate afqtrev,
robust;
# delimit cr // change delimiter to carriage
mfx compute

* Fourth regression, controlling for individual, geographic, and fam hist demo.
# delimit ' // change delimiter to ;
probit emp drnk_freq1 drnk_freq2 drnk_freq3 drnk_freq4 drnk_freq5 drnk_freq6
age male race1 race2 health higrad famsz marst1 marst3 afqtrev 
reg1 reg2 reg4 urate
dad_educ mom_educ dad_work mom_work,robust;
# delimit cr // change delimiter to carriage

* create confusion matrix of accurate predictions
# delimit ; // change delimiter to ;
probit emp drnk_freq1 drnk_freq2 drnk_freq3 drnk_freq4 drnk_freq5 drnk_freq6
age male race1 race2 health higrad famsz marst1 marst3 afqtrev 
reg1 reg2 reg4 urate
dad_educ mom_educ dad_work mom_work,robust;
# delimit cr // change delimiter to carriage
predict phat2
gen pred = 0
replace pred = 1 if phat2 >= .5
tab pred emp

* Graphs
hist drnk6m

