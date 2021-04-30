clear
set more off

capture log close
log using "acesdepression_log.log", replace

use "acesdepression_data.dta"

* ANALYSIS FOR MAIN SECTION OF PAPER
	* summary statistics (Table 1)
		* stratified by sex
			tab female, m
			tabstat age, stats(n mean sd min max p50 p25 p75)
			tab agebin female, m row col
			tab primary_complete female, m row col
			tab religion female, m row col
			tab married female, m row col
			tab hivstat_binary female, m row col
			
			tab acecat female, m row col
			tabstat total_ace, stats(n mean sd min max p50 p25 p75)
			ttest total_ace, by(female)
			
			tabstat hscld_bolton, stats(n mean sd min max p50 p25 p75)
			ttest hscld_bolton, by(female)
			tab hscld_bolton_yn female, m row col
			tab depress_dsm female, m row col
			tab suic_ideation female, m row col
		
	* prevalence of 9 types of ACEs (Table 2)
		* stratified by sex 
			tab ace_aphys female, m row col
			tab ace_aemot female, m row col
			tab ace_asexu female, m row col
			tab ace_fdrug female, m row col
			tab ace_fmntl female, m row col
			tab ace_fdivo female, m row col
			tab ace_fjail female, m row col
			tab ace_fviol female, m row col
			tab ace_pnegl female, m row col
			
	* regression models - cum. ACEs score and dep. sx severity, MDD, and suic. ideation
		* adjusted for clustering at village level (Table 3, S1 Table)
			global xlist female age primary_complete married hivstat_binary i.aindexq
			
			regress hscld_bolton total_ace, vce(cluster vid)
			regress hscld_bolton total_ace $xlist, vce(cluster vid)
			
			poisson depress_dsm total_ace, irr vce(cluster vid)
			poisson depress_dsm total_ace $xlist, vce(cluster vid)
			
			poisson suic_ideation total_ace, irr vce(cluster vid)
			poisson suic_ideation total_ace $xlist, irr vce(cluster vid)
			
	* regression models - cum. ACEs score and dep. sx severity, MDD, and suic. ideation
		* adjusted for clustering at household level (S2 Table)
			regress hscld_bolton total_ace $xlist, vce(cluster vid)
			boottest total_ace
			
			regress hscld_bolton total_ace $xlist, vce(cluster vid_hhid)

			poisson depress_dsm total_ace $xlist, vce(cluster vid_hhid)

			poisson suic_ideation total_ace $xlist, irr vce(cluster vid_hhid)
		
	* regression models - cum. ACEs score and dep. sx severity
		* stratified by age bin, adjusted for clustering at village level (S3 Table)
			regress hscld_bolton total_ace $xlist c.total_ace#c.age, vce(cluster vid)
			
			regress hscld_bolton total_ace if agebin==0, vce(cluster vid)
			regress hscld_bolton total_ace if agebin==1, vce(cluster vid)
			regress hscld_bolton total_ace if agebin==2, vce(cluster vid)
			regress hscld_bolton total_ace $xlist if agebin==0, vce(cluster vid)
			regress hscld_bolton total_ace $xlist if agebin==1, vce(cluster vid)
			regress hscld_bolton total_ace $xlist if agebin==2, vce(cluster vid)			

	* regression models - categorical ACEs score and dep. sx severity, MDD, and suic. ideation
		* adjusted for clustering at village level (Table 4, S4 Table)
			regress hscld_bolton i.acecat, vce(cluster vid)
			regress hscld_bolton i.acecat $xlist, vce(cluster vid)
			
			poisson depress_dsm i.acecat, irr vce(cluster vid)
			poisson depress_dsm i.acecat $xlist, vce(cluster vid)
			
			poisson suic_ideation i.acecat, irr vce(cluster vid)
			poisson suic_ideation i.acecat $xlist, irr vce(cluster vid)

	* regression models - each of 9 ACEs and dep. sx severity, MDD, and suic. ideation
		* adjusted for clustering at village level (S5 Table)
			regress hscld_bolton ace_aphys, vce(cluster vid)
			regress hscld_bolton ace_aemot, vce(cluster vid)
			regress hscld_bolton ace_asexu, vce(cluster vid)
			regress hscld_bolton ace_fdrug, vce(cluster vid)
			regress hscld_bolton ace_fmntl, vce(cluster vid)
			regress hscld_bolton ace_fdivo, vce(cluster vid)
			regress hscld_bolton ace_fjail, vce(cluster vid)
			regress hscld_bolton ace_fviol, vce(cluster vid)
			regress hscld_bolton ace_pnegl, vce(cluster vid)
			regress hscld_bolton ace_aphys $xlist, vce(cluster vid)
			regress hscld_bolton ace_aemot $xlist, vce(cluster vid)
			regress hscld_bolton ace_asexu $xlist, vce(cluster vid)
			regress hscld_bolton ace_fdrug $xlist, vce(cluster vid)
			regress hscld_bolton ace_fmntl $xlist, vce(cluster vid)
			regress hscld_bolton ace_fdivo $xlist, vce(cluster vid)
			regress hscld_bolton ace_fjail $xlist, vce(cluster vid)
			regress hscld_bolton ace_fviol $xlist, vce(cluster vid)
			regress hscld_bolton ace_pnegl $xlist, vce(cluster vid)
			
			poisson depress_dsm ace_aphys, irr vce(cluster vid)
			poisson depress_dsm ace_aemot, irr vce(cluster vid)
			poisson depress_dsm ace_asexu, irr vce(cluster vid)
			poisson depress_dsm ace_fdrug, irr vce(cluster vid)
			poisson depress_dsm ace_fmntl, irr vce(cluster vid)
			poisson depress_dsm ace_fdivo, irr vce(cluster vid)
			poisson depress_dsm ace_fjail, irr vce(cluster vid)
			poisson depress_dsm ace_fviol, irr vce(cluster vid)
			poisson depress_dsm ace_pnegl, irr vce(cluster vid)
			poisson depress_dsm ace_aphys $xlist, irr vce(cluster vid)
			poisson depress_dsm ace_aemot $xlist, irr vce(cluster vid)
			poisson depress_dsm ace_asexu $xlist, irr vce(cluster vid)
			poisson depress_dsm ace_fdrug $xlist, irr vce(cluster vid)
			poisson depress_dsm ace_fmntl $xlist, irr vce(cluster vid)
			poisson depress_dsm ace_fdivo $xlist, irr vce(cluster vid)
			poisson depress_dsm ace_fjail $xlist, irr vce(cluster vid)
			poisson depress_dsm ace_fviol $xlist, irr vce(cluster vid)
			poisson depress_dsm ace_pnegl $xlist, irr vce(cluster vid)
			
			poisson suic_ideation ace_aphys, irr vce(cluster vid)
			poisson suic_ideation ace_aemot, irr vce(cluster vid)
			poisson suic_ideation ace_asexu, irr vce(cluster vid)
			poisson suic_ideation ace_fdrug, irr vce(cluster vid)
			poisson suic_ideation ace_fmntl, irr vce(cluster vid)
			poisson suic_ideation ace_fdivo, irr vce(cluster vid)
			poisson suic_ideation ace_fjail, irr vce(cluster vid)
			poisson suic_ideation ace_fviol, irr vce(cluster vid)
			poisson suic_ideation ace_pnegl, irr vce(cluster vid)
			poisson suic_ideation ace_aphys $xlist, irr vce(cluster vid)
			poisson suic_ideation ace_aemot $xlist, irr vce(cluster vid)
			poisson suic_ideation ace_asexu $xlist, irr vce(cluster vid)
			poisson suic_ideation ace_fdrug $xlist, irr vce(cluster vid)
			poisson suic_ideation ace_fmntl $xlist, irr vce(cluster vid)
			poisson suic_ideation ace_fdivo $xlist, irr vce(cluster vid)
			poisson suic_ideation ace_fjail $xlist, irr vce(cluster vid)
			poisson suic_ideation ace_fviol $xlist, irr vce(cluster vid)
			poisson suic_ideation ace_pnegl $xlist, irr vce(cluster vid)
			
log close