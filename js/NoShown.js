/*
{
   "Left_Map_Type":["All","All","All","All","All","All","All","All","All","All","All","All","All","All","All","All","All","All","All","All","All","All","All","All","All","All","All","All","All","All","All","All","All","All","All","All","All","All","All","All","All","Female Breast Cancer"],
   "Left_Map_Case":["Male_Cases","Male_Rate","Female_Cases","Female_Rate","White_Cases","White_Rate","Black_Cases","Black_Rate","Hispanic_Cases","Hispanic_Rate","Asian_Pacific_Islander_Cases","Asian_Pacific_Islander_Rate","Other_Race_Ethnicity_Cases","Other_Race_Ethnicity_Rate","Age_Group_0_to_14_Cases","Age_Group_0_to_14_Rate","Age_Group_15_to_24_Cases","Age_Group_15_to_24_Rate","Age_Group_25_to_44_Cases","Age_Group_25_to_44_Rate","Age_Group_45_to_64_Cases","Age_Group_45_to_64_Rate","Age_Group_65Plus_Cases","Age_Group_65Plus_Rate","Age_Adjusted_Rate","Age_Group_0_to_14_Cases","Age_Group_0_to_14_Rate","Age_Group_15_to_24_Cases","Age_Group_15_to_24_Rate","Age_Group_25_to_44_Cases","Age_Group_25_to_44_Rate","Age_Group_45_to_64_Cases","Age_Group_45_to_64_Rate","Age_Group_65Plus_Cases","Age_Group_65Plus_Rate","Age_Group_25_to_44_Cases","Age_Group_25_to_44_Rate","Age_Group_45_to_64_Cases","Age_Group_45_to_64_Rate","Age_Group_65Plus_Cases","Age_Group_65Plus_Rate","All"],
   "Right_Map_SSDF":["Race","Race","Race","Race","Race","Race","Race","Race","Race","Race","Race","Race","Race","Race","Race","Race","Race","Race","Race","Race","Race","Race","Race","Race","Age","Age","Age","Age","Age","Age","Age","Age","Age","Age","Age","Education","Education","Education","Education","Education","Education","Gender"],
   "Right_Map_Select":["All","All","All","All","All","All","All","All","All","All","All","All","All","All","All","All","All","All","All","All","All","All","All","All","All","All","All","All","All","All","All","All","All","All","All","All","All","All","All","All","All","Male Population"],
   "Show_or_not":["x","x","x","x","x","x","x","x","x","x","x","x","x","x","x","x","x","x","x","x","x","x","x","x","x","x","x","x","x","x","x","x","x","x","x","x","x","x","x","x","x","x"]
}
*/ 

// SDFs -> Socio-economic and Demographic Factors
// Delete this SDFs from CENSUS2010, CENSUS2011, CENSUS2012, CENSUS2013, CENSUSaverage at very first time once.
// Match SDFdetail only, because all SDFdetails are unique. 
// Delete this SDFs from CATEGORY_DESCRIPTIONS_MASTER
// Match SDFgroup and SDFdetail both.
var MUST_REMOVE_SDFs = [
//	["SDFgroup",         "SDFdetail"                               ],
	["Economic Factor",  "Population Where Poverty Was Determined" ],
	["Economic Factor",  "Population In Armed Forces"              ],
	["Economic Factor",  "Households"                              ],
];

var NO_SHOWNS = [
//	["Left_Map_Type",        "Left_Map_Case",                 "Right_Map_SDF",    "Right_Map_Select",               "Show_or_not"],
	["*",                    "Male_Cases",                    "Race",             "*",                                        "x"],
	["*",                    "Male_Rate",                     "Race",             "*",                                        "x"],
	["*",                    "Female_Cases",                  "Race",             "*",                                        "x"],
	["*",                    "Female_Rate",                   "Race",             "*",                                        "x"],
	["*",                    "White_Cases",                   "Race",             "*",                                        "x"],
	["*",                    "White_Rate",                    "Race",             "*",                                        "x"],
	["*",                    "Black_Cases",                   "Race",             "*",                                        "x"],
	["*",                    "Black_Rate",                    "Race",             "*",                                        "x"],
	["*",                    "Hispanic_Cases",                "Race",             "*",                                        "x"],
	["*",                    "Hispanic_Rate",                 "Race",             "*",                                        "x"],
	["*",                    "Asian_Pacific_Islander_Cases",  "Race",             "*",                                        "x"],
	["*",                    "Asian_Pacific_Islander_Rate",   "Race",             "*",                                        "x"],
	["*",                    "Other_Race_Ethnicity_Cases",    "Race",             "*",                                        "x"],
	["*",                    "Other_Race_Ethnicity_Rate",     "Race",             "*",                                        "x"],
	["*",                    "Age_Group_0_to_14_Cases",       "Race",             "*",                                        "x"],
	["*",                    "Age_Group_0_to_14_Rate",        "Race",             "*",                                        "x"],
	["*",                    "Age_Group_15_to_24_Cases",      "Race",             "*",                                        "x"],
	["*",                    "Age_Group_15_to_24_Rate",       "Race",             "*",                                        "x"],
	["*",                    "Age_Group_25_to_44_Cases",      "Race",             "*",                                        "x"],
	["*",                    "Age_Group_25_to_44_Rate",       "Race",             "*",                                        "x"],
	["*",                    "Age_Group_45_to_64_Cases",      "Race",             "*",                                        "x"],
	["*",                    "Age_Group_45_to_64_Rate",       "Race",             "*",                                        "x"],
	["*",                    "Age_Group_65Plus_Cases",        "Race",             "*",                                        "x"],
	["*",                    "Age_Group_65Plus_Rate",         "Race",             "*",                                        "x"],
	["*",                    "Age_Adjusted_Rate",             "Age",              "*",                                        "x"],
	["*",                    "Age_Group_0_to_14_Cases",       "Age",              "*",                                        "x"],
	["*",                    "Age_Group_0_to_14_Rate",        "Age",              "*",                                        "x"],
	["*",                    "Age_Group_15_to_24_Cases",      "Age",              "*",                                        "x"],
	["*",                    "Age_Group_15_to_24_Rate",       "Age",              "*",                                        "x"],
	["*",                    "Age_Group_25_to_44_Cases",      "Age",              "*",                                        "x"],
	["*",                    "Age_Group_25_to_44_Rate",       "Age",              "*",                                        "x"],
	["*",                    "Age_Group_45_to_64_Cases",      "Age",              "*",                                        "x"],
	["*",                    "Age_Group_45_to_64_Rate",       "Age",              "*",                                        "x"],
	["*",                    "Age_Group_65Plus_Cases",        "Age",              "*",                                        "x"],
	["*",                    "Age_Group_65Plus_Rate",         "Age",              "*",                                        "x"],
	["*",                    "Age_Group_0_to_14_Cases",       "Education",        "*",                                        "x"],
	["*",                    "Age_Group_0_to_14_Rate",        "Education",        "*",                                        "x"],
	["*",                    "Age_Group_15_to_24_Cases",      "Education",        "*",                                        "x"],
	["*",                    "Age_Group_15_to_24_Rate",       "Education",        "*",                                        "x"],
	["Female Breast Cancer", "*",                             "Gender",           "Male Population",                          "x"],
];