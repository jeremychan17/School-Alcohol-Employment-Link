#delimit;
set more 1;
log using smoke1regs.log, replace;

****************************************************************************

                                 REGRESS1

****************************************************************************

This program estimates OLS regressions of wages on smoking.  It first
estimates alternative specifications differing by the control variables
included.  Then models are estimated by demographic group.  In all cases,
only full-time, full-year workers are included in the analysis;

* Regression models are estimated for 1984 and 1991 NLSY data;


clear;
set maxobs 15000;
use smoke1;

drop if mtreduc == . | ftreduc == . | higrad91 == . | 
        mtrwrk == . | ftrwrk == . | urban14 == .| urban91 == . | 
        south == .| south91 == . | numkid91 == . | numsibs == . |
        marrd91 == . | female == .| nonwhite == . | afqt == . | 
        age91 == . | mtrpres == . | ftrpres == . | bothpar == . | 
        mtronly == . | ftronly == . | smkdly91 == .;

* Regressions for 1991;

reg lnhrwg91 smkdly91 if fullyr91 == 1 [pweight=weight79], robust;
reg lnhrwg91 smkdly91 higrad91 if fullyr91 == 1 [pweight=weight79], robust;
reg lnhrwg91 smkdly91 exp91 south91 urban91 numkid91 
              marrd91 nonwhite female higrad91 afqt if fullyr91 == 1 
              [pweight=weight79], robust;
reg lnhrwg91 smkdly91 exp91 south91 urban91 numkid91 
              marrd91 nonwhite female higrad91 afqt urban14 south 
              mtreduc ftreduc mtrwrk14 ftrwrk14 numsibs bothpar mtronly 
              if fullyr91 == 1 [pweight=weight79], robust;
reg lnhrwg91 smkdly91 exp91 south91 urban91 numkid91 
              marrd91 nonwhite female higrad91 afqt urban14 south 
              mtreduc ftreduc mtrwrk14 ftrwrk14 numsibs bothpar mtronly 
        profocc saleocc clerocc craftocc operocc tranocc labocc
        farmocc servocc prhhocc if fullyr91 == 1 [pweight=weight79], robust;
areg lnhrwg91 smkdly91 exp91 south91 urban91 numkid91 
               marrd91 nonwhite female higrad91 afqt urban14 south 
               mtreduc ftreduc mtrwrk14 ftrwrk14 numsibs bothpar mtronly 
        profocc saleocc clerocc craftocc operocc tranocc labocc
        farmocc servocc prhhocc if fullyr91 == 1 [pweight=weight79], 
        absorb(state91) robust;


* examine whether the number of years smoked affects your wages;

gen yrssmok = age91 - agesmk92;
gen smkagint = yrssmok*smkdly91;

reg lnhrwg91 smkdly91 smkagint exp91 south91 urban91 numkid91 marrd91
        nonwhite female higrad91 afqt urban14 south mtreduc ftreduc mtrwrk14
        ftrwrk14 numsibs bothpar mtronly if fullyr91 == 1 
        [pweight=weight79], robust;


* examine the effects of different levels of smoking on wages;

reg lnhrwg91 smkdly91 amtsmk exp91 south91 urban91 
              numkid91 marrd91 nonwhite female higrad91 afqt urban14 
              south mtreduc ftreduc mtrwrk14 ftrwrk14 numsibs 
              bothpar mtronly if fullyr91 == 1 [pweight=weight79], robust;


* examine whether including tenure on the job along with experience
  significantly alters the results;

reg lnhrwg91 smkdly91 exp91 tenure91 south91 urban91 numkid91 marrd91
        nonwhite female higrad91 afqt urban14 south mtreduc ftreduc mtrwrk14
        ftrwrk14 numsibs bothpar mtronly if fullyr91 == 1 
        [pweight=weight79], robust;


* examine whether the returns to experience is affected by whether or not
  you smoke.  If smokers have a higher rate of time preference, then we
  should expect the interaction term to be negative;

gen smokexp = smkdly91*exp91;

reg lnhrwg91 smkdly91 exp91 smokexp south91 urban91 numkid91 marrd91
        nonwhite female higrad91 afqt urban14 south mtreduc ftreduc mtrwrk14
        ftrwrk14 numsibs bothpar mtronly if fullyr91 == 1 
        [pweight=weight79], robust;


* repeat the analysis for 1984;

clear;
set maxobs 15000;
use smoke1;

drop if mtreduc == . | ftreduc == . | higrad84 == . | 
        mtrwrk == . | ftrwrk == . | urban14 == .| urban84 == . | 
        south == .| south84 == . | numkid84 == . | numsibs == . |
        marrd84 == . | female == .| nonwhite == . | afqt == . | 
        age84 == . | mtrpres == . | ftrpres == . | bothpar == . | 
        mtronly == . | ftronly == . | smkdly84 == .;

* Regressions for 1984;

reg lnhrwg84 smkdly84 if fullyr84 == 1 [pweight=weight79], robust;
reg lnhrwg84 smkdly84 higrad84 if fullyr84 == 1 [pweight=weight79], robust;
reg lnhrwg84 smkdly84 exp84 south84 urban84 numkid84 
              marrd84 nonwhite female higrad84 afqt if fullyr84 == 1 
              [pweight=weight79], robust;
reg lnhrwg84 smkdly84 exp84 south84 urban84 numkid84 
              marrd84 nonwhite female higrad84 afqt urban14 south 
              mtreduc ftreduc mtrwrk14 ftrwrk14 numsibs bothpar mtronly 
              if fullyr84 == 1 [pweight=weight79], robust;
reg lnhrwg84 smkdly84 exp84 south84 urban84 numkid84 
              marrd84 nonwhite female higrad84 afqt urban14 south 
              mtreduc ftreduc mtrwrk14 ftrwrk14 numsibs bothpar mtronly 
        profocc saleocc clerocc craftocc operocc tranocc labocc
        farmocc servocc prhhocc if fullyr84 == 1 [pweight=weight79], robust;
areg lnhrwg84 smkdly84 exp84 south84 urban84 numkid84 
               marrd84 nonwhite female higrad84 afqt urban14 south 
               mtreduc ftreduc mtrwrk14 ftrwrk14 numsibs bothpar mtronly 
        profocc saleocc clerocc craftocc operocc tranocc labocc
        farmocc servocc prhhocc if fullyr84 == 1 [pweight=weight79], 
         absorb(state84) robust;


* examine whether the number of years smoked affects your wages;

gen yrssmok = age84 - agesmk92;
gen smkagint = yrssmok*smkdly84;

reg lnhrwg84 smkdly84 smkagint exp84 south84 urban84 numkid84 marrd84
        nonwhite female higrad84 afqt urban14 south mtreduc ftreduc mtrwrk14
        ftrwrk14 numsibs bothpar mtronly if fullyr84 == 1 
        [pweight=weight79], robust;


* examine the effects of different levels of smoking on wages;

reg lnhrwg84 smkdly84 amtsmk exp84 south84 urban84 
              numkid84 marrd84 nonwhite female higrad84 afqt urban14 
              south mtreduc ftreduc mtrwrk14 ftrwrk14 numsibs 
              bothpar mtronly if fullyr84 == 1 [pweight=weight79], robust;


* examine whether including tenure on the job along with experience
  significantly alters the results;

reg lnhrwg84 smkdly84 exp84 tenure84 south84 urban84 numkid84 marrd84
        nonwhite female higrad84 afqt urban14 south mtreduc ftreduc mtrwrk14
        ftrwrk14 numsibs bothpar mtronly if fullyr84 == 1 
        [pweight=weight79], robust;


* examine whether the returns to experience is affected by whether or not
  you smoke.  If smokers have a higher rate of time preference, then we
  should expect the interaction term to be negative;

gen smokexp = smkdly84*exp84;

reg lnhrwg84 smkdly84 exp84 smokexp south84 urban84 numkid84 marrd84
        nonwhite female higrad84 afqt urban14 south mtreduc ftreduc mtrwrk14
        ftrwrk14 numsibs bothpar mtronly if fullyr84 == 1 
        [pweight=weight79], robust;



log close;

