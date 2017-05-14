Data Cleaning
================

``` r
na.strings = c('N/A', 'Prefer not to disclose', 'Other', 'Rather not say', 'Other (please specify)')
survey.raw = read.csv('../data/stack_overflow_survey_2016.csv', na.strings = na.strings)
```

Let's take a look at all the available columns and occupations

``` r
colnames(survey.raw)
```

    ##  [1] "X"                                "collector"                       
    ##  [3] "country"                          "un_subregion"                    
    ##  [5] "so_region"                        "age_range"                       
    ##  [7] "age_midpoint"                     "gender"                          
    ##  [9] "self_identification"              "occupation"                      
    ## [11] "occupation_group"                 "experience_range"                
    ## [13] "experience_midpoint"              "salary_range"                    
    ## [15] "salary_midpoint"                  "big_mac_index"                   
    ## [17] "tech_do"                          "tech_want"                       
    ## [19] "aliens"                           "programming_ability"             
    ## [21] "employment_status"                "industry"                        
    ## [23] "company_size_range"               "team_size_range"                 
    ## [25] "women_on_team"                    "remote"                          
    ## [27] "job_satisfaction"                 "job_discovery"                   
    ## [29] "dev_environment"                  "commit_frequency"                
    ## [31] "hobby"                            "dogs_vs_cats"                    
    ## [33] "desktop_os"                       "unit_testing"                    
    ## [35] "rep_range"                        "visit_frequency"                 
    ## [37] "why_learn_new_tech"               "education"                       
    ## [39] "open_to_new_job"                  "new_job_value"                   
    ## [41] "job_search_annoyance"             "interview_likelihood"            
    ## [43] "how_to_improve_interview_process" "star_wars_vs_star_trek"          
    ## [45] "agree_tech"                       "agree_notice"                    
    ## [47] "agree_problemsolving"             "agree_diversity"                 
    ## [49] "agree_adblocker"                  "agree_alcohol"                   
    ## [51] "agree_loveboss"                   "agree_nightcode"                 
    ## [53] "agree_legacy"                     "agree_mars"                      
    ## [55] "important_variety"                "important_control"               
    ## [57] "important_sameend"                "important_newtech"               
    ## [59] "important_buildnew"               "important_buildexisting"         
    ## [61] "important_promotion"              "important_companymission"        
    ## [63] "important_wfh"                    "important_ownoffice"             
    ## [65] "developer_challenges"             "why_stack_overflow"

``` r
levels(survey.raw$occupation)
```

    ##  [1] ""                                                     
    ##  [2] "Analyst"                                              
    ##  [3] "Back-end web developer"                               
    ##  [4] "Business intelligence or data warehousing expert"     
    ##  [5] "Data scientist"                                       
    ##  [6] "Database administrator"                               
    ##  [7] "Designer"                                             
    ##  [8] "Desktop developer"                                    
    ##  [9] "Developer with a statistics or mathematics background"
    ## [10] "DevOps"                                               
    ## [11] "Embedded application developer"                       
    ## [12] "Engineering manager"                                  
    ## [13] "Enterprise level services developer"                  
    ## [14] "Executive (VP of Eng., CTO, CIO, etc.)"               
    ## [15] "Front-end web developer"                              
    ## [16] "Full-stack web developer"                             
    ## [17] "Graphics programmer"                                  
    ## [18] "Growth hacker"                                        
    ## [19] "Machine learning developer"                           
    ## [20] "Mobile developer"                                     
    ## [21] "Mobile developer - Android"                           
    ## [22] "Mobile developer - iOS"                               
    ## [23] "Mobile developer - Windows Phone"                     
    ## [24] "other"                                                
    ## [25] "Product manager"                                      
    ## [26] "Quality Assurance"                                    
    ## [27] "Student"                                              
    ## [28] "System administrator"

Filter data scientists

``` r
survey.ds = survey.raw[survey.raw$occupation == 'Data scientist', 2:ncol(survey.raw)]
survey.ds[survey.ds == ''] = NA

nrow(survey.ds)
```

    ## [1] 800

``` r
survey.ds = survey.ds[complete.cases(survey.ds[, 'country']),]
nrow(survey.ds)
```

    ## [1] 796

``` r
write.csv(survey.ds, '../data/stack_overflow_survey_2016_ds.csv', na = 'NA', row.names = F)
```
