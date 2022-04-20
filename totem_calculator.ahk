#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.
; #Warn  ; Enable warnings to assist with detecting common errors.
;SendMode Input  ; Recommended for new scripts due to its superior speed and reliability.
SetWorkingDir %A_ScriptDir%  ; Ensures a consistent starting directory.
#SingleInstance, Force
#NoTrayIcon

;*************************DEFAULT VALUES*********************************
;*******************************************************************
global upgradeTypes := Array("Utility", "Efficiency", "Quality", "Total")
;global materials := Array("Coins","Oak Wood","Pine Wood","Birch Wood","Maple Wood","Hickory Wood","Iron","Steel Rod","Copper Bolt","Copper Plate","Green Gear","Blue Gear","Pink Gear","Gearbox")
global materials := [["Coins", 1],["Oak Wood", 500],["Pine Wood", 650],["Birch Wood", 700],["Maple Wood", 800],["Hickory Wood", 900],["Iron", 400],["Steel Rod", 20000],["Copper Bolt", 15000],["Copper Plate", 90000],["Green Gear", 15000],["Blue Gear", 30000],["Pink Gear", 1000000],["Gearbox", 2500000]]

global totem := {}
totem.Utility["Coins"] := Array(253,391,537,695,868,2000,1062,1279,1523,1800,2111,6000,2463,2857,3299,3793,4342,20000,4950,5621,6360,7169,8054,30000,9017,10064,11197,12422,13741,50000,15159,16679,18307,20045,21897,70000,23868,25962,28182,30532,33017,100000,35640,38405,41316,44377,47593,200000,50966,54502,58203,62074,66120)
totem.Utility["Oak Wood"] := Array(12,19,26,34,43,0,53,63,76,90,105,0,123,142,164,189,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0) 
totem.Utility["Pine Wood"] := Array(0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,108,0,123,140,159,179,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0) 
totem.Utility["Birch Wood"] := Array(0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,100,0,112,125,139,155,171,0,189,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0) 
totem.Utility["Maple Wood"] := Array(0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,104,114,125,136,0,149,162,176,190,0,0,0,0,0,0,0,0,0,0,0,0,0) 
totem.Utility["Hickory Wood"] := Array(0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,103,0,111,120,129,138,148,0,159,170,181,193,206) 
totem.Utility["Iron"] := Array(0,0,0,0,0,80,0,0,0,0,0,120,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0) 
totem.Utility["Steel Rod"] := Array(0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,4,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0) 
totem.Utility["Copper Bolt"] := Array(0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,20,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0) 
totem.Utility["Copper Plate"] := Array(0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,30,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0) 
totem.Utility["Green Gear"] := Array(0,0,0,0,0,2,0,0,0,0,0,6,0,0,0,0,0,10,0,0,0,0,0,16,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0) 
totem.Utility["Blue Gear"] := Array(0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,4,0,0,0,0,0,8,0,0,0,0,0,12,0,0,0,0,0,0,0,0,0,0,0) 
totem.Utility["Pink Gear"] := Array(0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,4,0,0,0,0,0) 
totem.Utility["Gearbox"] := Array(0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,2,0,0,0,0,0,4,0,0,0,0,0,12,0,0,0,0,0) 

totem.Efficiency["Coins"] := Array(211,326,448,579,724,1000,885,1065,1269,1500,1759,3000,2052,2381,2749,3161,3618,10000,4125,4684,5300,5974,6711,15000,7514,8386,9331,10351,11451,25000,12632,13899,15256,16704,18248,35000,19890,21635,23485,25443,27514,50000,29700,32004,34430,36981,39661,100000,42472,45418,48503,51729,55100)
totem.Efficiency["Oak Wood"] := Array(10,16,22,28,36,0,44,53,63,75,87,0,102,119,137,158,180,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0) 
totem.Efficiency["Pine Wood"] := Array(0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,103,117,132,149,167,0,187,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0) 
totem.Efficiency["Birch Wood"] := Array(0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,104,116,129,143,0,157,173,190,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0) 
totem.Efficiency["Maple Wood"] := Array(0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,104,114,0,124,135,146,159,171,0,185,0,0,0,0,0,0,0,0,0,0) 
totem.Efficiency["Hickory Wood"] := Array(0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,100,107,115,123,0,132,141,151,161,172) 
totem.Efficiency["Iron"] := Array(0,0,0,0,0,40,0,0,0,0,0,60,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0) 
totem.Efficiency["Steel Rod"] := Array(0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,2,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0) 
totem.Efficiency["Copper Bolt"] := Array(0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,10,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0) 
totem.Efficiency["Copper Plate"] := Array(0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,15,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0) 
totem.Efficiency["Green Gear"] := Array(0,0,0,0,0,1,0,0,0,0,0,3,0,0,0,0,0,5,0,0,0,0,0,8,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0) 
totem.Efficiency["Blue Gear"] := Array(0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,2,0,0,0,0,0,4,0,0,0,0,0,6,0,0,0,0,0,0,0,0,0,0,0) 
totem.Efficiency["Pink Gear"] := Array(0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,2,0,0,0,0,0) 
totem.Efficiency["Gearbox"] := Array(0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1,0,0,0,0,0,2,0,0,0,0,0,6,0,0,0,0,0) 

totem.Quality["Coins"] := Array(264,408,560,724,905,1250,1106,1332,1587,1875,2199,3750,2565,2976,3437,3951,4523,12500,5156,5855,6625,7468,8389,18750,9393,10483,11664,12939,14313,31250,15790,17374,19070,20880,22810,43750,24863,27044,29356,31804,34392,62500,37125,40005,43037,46226,49576,125000,53090,56773,60628,64661,68875)
totem.Quality["Oak Wood"] := Array(13,20,28,36,45,0,55,66,79,93,109,0,128,148,171,197,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0) 
totem.Quality["Pine Wood"] := Array(0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,113,0,128,146,165,186,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0) 
totem.Quality["Birch Wood"] := Array(0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,104,0,117,131,145,161,178,0,197,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0) 
totem.Quality["Maple Wood"] := Array(0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,108,119,130,142,0,155,169,183,198,0,0,0,0,0,0,0,0,0,0,0,0,0) 
totem.Quality["Hickory Wood"] := Array(0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,107,0,116,125,134,144,154,0,165,177,189,202,215) 
totem.Quality["Iron"] := Array(0,0,0,0,0,50,0,0,0,0,0,75,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0) 
totem.Quality["Steel Rod"] := Array(0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,2,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0) 
totem.Quality["Copper Bolt"] := Array(0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,12,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0) 
totem.Quality["Copper Plate"] := Array(0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,18,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0) 
totem.Quality["Green Gear"] := Array(0,0,0,0,0,1,0,0,0,0,0,3,0,0,0,0,0,6,0,0,0,0,0,10,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0) 
totem.Quality["Blue Gear"] := Array(0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,2,0,0,0,0,0,5,0,0,0,0,0,7,0,0,0,0,0,0,0,0,0,0,0) 
totem.Quality["Pink Gear"] := Array(0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,2,0,0,0,0,0) 
totem.Quality["Gearbox"] := Array(0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1,0,0,0,0,0,2,0,0,0,0,0,7,0,0,0,0,0) 

global numberOfTotems := 1
global lmcRate := 27000
global upgradeTotem := {}

global GuiPosX := A_ScreenWidth // 3
global GuiPosY := A_ScreenHeight // 3

global startingUtility := 0
global startingEfficiency := 0
global startingQuality := 0
global startingTotal := startingUtility + startingEfficiency + startingQuality
global endingUtility := 0
global endingEfficiency := 0
global endingQuality := 0
global endingTotal := endingUtility + endingEfficiency + endingQuality

global viewToggle := 1
global views := Array("Quantity view", "Coins view", "LMC view")

global tabTotemCalculator := "Totem Calculator"
global tabSettings := "Settings"
global tabInfo := "Info"

;==========================================settings handling
settingsFileName := StrReplace(A_ScriptName, "ahk", "ini")
if (!FileExist(settingsFileName)){
	Gosub, saveSettings
	Gosub, savePrices
}
Gosub, loadSettings
Gosub, loadPrices

;*************************GUI*********************************
;*******************************************************************

;========================layout
headerPosY := 35
bodyPosY := 170
footerPosY := 375
sectionWidth := 90
sectionPosX1 := sectionWidth * 1.1 + 10
sectionPosX2 := sectionPosX1 + sectionWidth
sectionPosX3 := sectionPosX2 + sectionWidth
sectionPosX4 := sectionPosX3 + sectionWidth
lineSpacing := 5
sectionSpacing := 20
;========================controls
Gui, Add, Tab3, , %tabTotemCalculator%|%tabSettings%
Gui, Tab, %tabTotemCalculator%
Gui, Add, Text, x+15 y%headerPosY% hidden section, LABELS
Gui, Add, Text, xs y+15, Starting level:
Gui, Add, Text, y+15, Ending level:
Gui, Add, Text, y+60, Totem count:

Gui, Add, Text, x20 y+5 w460 0x10, SEPARATOR

;labels
Gui, Add, Text, xs y%bodyPosY% hidden
text := ""
loop, % materials.length() {
			text .= materials[A_Index][1] . "`n"
}
text .= "`nTOTAL(LMC)`nTOTAL(coins)"
Gui, Add, Text, y+%lineSpacing%, %text%


Gui, Add, Text, x%sectionPosX1% y%headerPosY% section, UTILITY
Gui, Add, Edit, xs w35 Number Limit2, %startingUtility%
Gui, Add, Updown, vStartingUtility gLevelsCheck Range0-53, %startingUtility%
Gui, Add, Edit, xs w35 y+%lineSpacing% Number Limit2, %endingUtility%
Gui, Add, Updown, vEndingUtility gLevelsCheck Range0-53, %endingUtility%
Gui, Add, Button, w35 y+%lineSpacing% gButtonMaxUtility -TabStop, Max

Gui, Add, Edit, xs y+25 w55 Number Limit5 gLevelsCheck, %numberOfTotems%
Gui, Add, Updown, Range1-10000 vNumberOfTotems gLevelsCheck, %numberOfTotems%

Gui, Add, Text, xs y%bodyPosY% hidden
textUtility := getOutputByUpgradeTypeView("Utility", viewToggle)
Gui, Add, Text, y+%lineSpacing% w%sectionWidth% vTextUtility, %textUtility%

Gui, Add, Text, x%sectionPosX2% y%headerPosY% section, EFFICIENCY
Gui, Add, Edit, xs w35 Number Limit2, %startingEfficiency%
Gui, Add, Updown, vStartingEfficiency gLevelsCheck Range0-53, %startingEfficiency%
Gui, Add, Edit, xs w35 y+%lineSpacing% Number Limit2, %endingEfficiency%
Gui, Add, Updown, vEndingEfficiency gLevelsCheck Range0-53, %endingEfficiency%
Gui, Add, Button, w35 y+%lineSpacing% gButtonMaxEfficiency -TabStop, Max
Gui, Add, Button, xs y+25 w80 gButtonViewToggle vViewToggle -TabStop, % views[viewToggle]

Gui, Add, Text, xs y%bodyPosY% hidden
textEfficiency := getOutputByUpgradeTypeView("Efficiency", viewToggle)
Gui, Add, Text, y+%lineSpacing% w%sectionWidth% vtextEfficiency, %textEfficiency%

Gui, Add, Text, x%sectionPosX3% y%headerPosY% section, QUALITY
Gui, Add, Edit, xs w35 Number Limit2, %startingQuality%
Gui, Add, Updown, vStartingQuality gLevelsCheck Range0-53, %startingQuality%
Gui, Add, Button, x+5 gButtonStartingLevelReset -TabStop, Reset
Gui, Add, Edit, xs w35 y+%lineSpacing% Number Limit2, %endingQuality%
Gui, Add, Updown, vEndingQuality gLevelsCheck Range0-53, %endingQuality%
Gui, Add, Button, x+5 gButtonEndingLevelReset -TabStop, Reset
Gui, Add, Button, xs w35 y+%lineSpacing% gButtonMaxQuality -TabStop, Max
Gui, Add, Button, x+5 gButtonEndingLevelMaxAll w50 -TabStop, Max All
Gui, Add, Button, xs y+5 w180 h40 gLevelsCheck Default, CALCULATE

Gui, Add, Text, xs y%bodyPosY% hidden
textQuality := getOutputByUpgradeTypeView("Quality", viewToggle)
Gui, Add, Text, y+%lineSpacing% w%sectionWidth% vtextQuality, %textQuality%

Gui, Add, Text, x%sectionPosX4% y%headerPosY% section, TOTAL
Gui, Add, Edit, xs w35 vStartingTotal Number Limit3 ReadOnly -TabStop, %startingTotal%
Gui, Add, Edit, xs w35 y+%lineSpacing% vEndingTotal Number Limit3 ReadOnly -TabStop, %endingTotal%
Gui, Add, Text, xs y%bodyPosY% hidden
textTotal := getOutputByUpgradeTypeView("Total", viewToggle)
Gui, Add, Text, y+%lineSpacing% w%sectionWidth% vtextTotal, %textTotal%

Gui, Add, StatusBar
SB_SetText("Totem Calculator v0.1.1 Made by @Shadow_of_the_noob#3380")

Gui, Tab, %tabSettings%
Gui, Add, Text, x20 y%headerPosY% hidden
;customPrices := ""
Gosub, loadCustomPrices
Gui, Add, Edit, w200 h200 y+%lineSpacing% -HScroll -VScroll vEditCustomPrices, %editCustomPrices%
Gui, Add, Button, gSaveCustomPrices, Save Prices
Gui, Add, Button, x+5 gLoadDefaultPrices, Reset Prices

;*************************TO DO*********************************
;add user inventory and calculate shopping list (item to shop = total - inventory on hand)
;*******************************************************************

Gosub, initializeTotem
Gosub, updateMaterials	
Gui, Show, x%GuiPosX% y%GuiPosY%
return

;*************************FUNCTIONS*********************************
;*******************************************************************
calculateMaterialCount(upgradeType, upgradeMaterial, endingLevel, startingLevel := 0, numberOfTotems := 1) {
			loopCount := endingLevel - startingLevel
			if (loopCount <= 0) {
				return, 0
			}
			loop, %loopCount%  {
				materialCount += totem[upgradeType][upgradeMaterial][A_Index + startingLevel] * numberOfTotems
			}
			return, materialCount	
		}
		
		getOutputByUpgradeTypeView(upgradeType, viewToggle){
			text := ""
			totalCoins := 0
			loop, % materials.length() {
				material := materials[A_Index][1]
				quantity := upgradeTotem[upgradeType][material]
				if (viewToggle == 1) {
					text .= commaFormat(quantity) . "`n"
				}
				price := materials[A_Index][2]
				coins := quantity * price
				;totalCoins += viewToggle == 1 ? 0 : coins
				totalCoins += coins
				if (viewToggle == 2) {
					text .= commaFormat(coins) . "`n"
				}
				if (viewToggle == 3) {
					text .= commaFormat(coinToLmc(coins)) . "`n"
				}
			}
			text .= "`n" . commaFormat(coinToLmc(totalCoins)) . "`n" . commaFormat(totalCoins)
				;commaFormat(viewToggle == 2 ? totalCoins : coinToLmc(totalCoins)) ;. "`n"
			return,  text
		}
			
			getTotalByUpgradeType(upgradeType, viewToggle){
				if (viewToggle == 1) {
					return, 0
				}
				total := 0
				loop, % materials.length() {
					material := materials[A_Index][1]
					quantity := upgradeTotem[upgradeType][material]
					price := materials[A_Index][2]
					coins := quantity * price
					total += coins
				}
				return, viewToggle == 2 ? commaFormat(total) : commaFormat(coinToLmc(total))
			}
			updateMaterialsByType(upgradeType, endingLevel, startingLevel := 0, numberOfTotems := 1){
				loop, % materials.length() {
					material := materials[A_Index][1]
					upgradeTotem["Total"][material] -= upgradeTotem[upgradeType][material]	;take out the old stuffs
					materialCount := calculateMaterialCount(upgradeType, material, endingLevel, startingLevel, numberOfTotems)
					upgradeTotem[upgradeType][material] := materialCount
					upgradeTotem["Total"][material] += materialCount						;add in the new stuffs
				}
			}
			
			updateTotal(){
				
			}
			
			coinToLmc(coin){
				return, coin / lmcRate
			}
			
			lmcToCoin(lmc){
				return, lmc * lmcRate
			}
			
			commaFormat(num) {
				if (num == 0) {
					return "-"
				}
				VarSetCapacity(fNum,64)
				DllCall("GetNumberFormat",UInt,0x0409,UInt,0,Str,Num,UInt,0,Str,fNum,Int,32)
				return SubStr(fNum,1,StrLen(fNum) - 3)
			}
			
;*************************ROUTINES*********************************
;*******************************************************************
			
			initializeTotem:
			for _, upgradeType in upgradeTypes {
				upgradeTotem[upgradeType] := {}
				loop, % materials.length() {
					material := materials[A_Index][1]
					upgradeTotem[upgradeType][material] := 0
				}
			}	
			return
			
			updateMaterials:
			updateMaterialsByType("Utility", endingUtility, startingUtility, numberOfTotems)
			updateMaterialsByType("Efficiency", endingEfficiency, startingEfficiency, numberOfTotems)
			updateMaterialsByType("Quality", endingQuality, startingQuality, numberOfTotems)
			Gosub, UpdateView
			return
			
			
			LevelsCheck:
			Gui, Submit, NoHide
			startingUtility := Min(startingUtility, 53)
			startingEfficiency := Min(startingEfficiency, 53)
			startingQuality := Min(startingQuality, 53)
			startingTotal := startingUtility + startingEfficiency + startingQuality
			
			
			endingUtility := Max(endingUtility, startingUtility)
			endingUtility := Min(endingUtility, 53)
			endingEfficiency := Max(endingEfficiency, startingEfficiency)
			endingEfficiency := Min(endingEfficiency, 53)
			endingQuality := Max(endingQuality, startingQuality)
			endingQuality := Min(endingQuality, 53)
			endingTotal := endingUtility + endingEfficiency + endingQuality
			
			GuiControl, , startingUtility, %startingUtility%
			GuiControl, , startingEfficiency, %startingEfficiency%
			GuiControl, , startingQuality, %startingQuality%
			GuiControl, , startingTotal, %startingTotal%
			
			GuiControl, , endingUtility, %endingUtility%
			GuiControl, , endingEfficiency, %endingEfficiency%
			GuiControl, , endingQuality, %endingQuality%
			GuiControl, , endingTotal, %endingTotal%
			Gosub, updateMaterials
			return
			
			UpdateView:
			textUtility := getOutputByUpgradeTypeView("Utility", viewToggle)
			textEfficiency := getOutputByUpgradeTypeView("Efficiency", viewToggle)
			textQuality := getOutputByUpgradeTypeView("Quality", viewToggle)
			textTotal := getOutputByUpgradeTypeView("Total", viewToggle)
			GuiControl, , textUtility, %textUtility%
			GuiControl, , textEfficiency, %textEfficiency%
			GuiControl, , textQuality, %textQuality%
			GuiControl, , textTotal, %textTotal%
			GuiControl, , viewToggle, % views[viewToggle]	
			return
			
			ButtonViewToggle:
			viewToggle++
			if (viewToggle > 3){
				viewToggle := 1
			}
			GuiControl, , viewToggle, % views[viewToggle]	
			Gosub, UpdateView
			return
			
			
			ButtonStartingLevelReset:
			GuiControl, , StartingUtility, 0
			GuiControl, , StartingEfficiency, 0
			GuiControl, , StartingQuality, 0
			Gosub, LevelsCheck
			return
			
			ButtonEndingLevelReset:
			GuiControl, , EndingUtility, 0
			GuiControl, , EndingEfficiency, 0
			GuiControl, , EndingQuality, 0
			Gosub, LevelsCheck
			return
			
			
			ButtonEndingLevelMaxAll:
			GuiControl, , EndingUtility, 53
			GuiControl, , EndingEfficiency, 53
			GuiControl, , EndingQuality, 53
			Gosub, LevelsCheck
			return
			
			ButtonMaxUtility:
			GuiControl, , EndingUtility, 53
			Gosub, LevelsCheck
			return
			
			ButtonMaxEfficiency:
			GuiControl, , EndingEfficiency, 53
			Gosub, LevelsCheck
			return
			
			ButtonMaxQuality:
			GuiControl, , EndingQuality, 53
			Gosub, LevelsCheck
			return
			
			loadSettings:
;load Gui settings
			IniRead, GuiPosX, %settingsFileName%, Last Session, GuiPosX, % A_ScreenWidth // 3
			IniRead, GuiPosY, %settingsFileName%, Last Session, GuiPosY, % A_ScreenHeight // 3
;load values from settings
			IniRead, numberOfTotems, %settingsFileName%, Last Session, numberOfTotems, 1
			IniRead, lmcRate, %settingsFileName%, Last Session, lmcRate, 27000
			
			IniRead, startingUtility, %settingsFileName%, Last Session, startingUtility, 0
			IniRead, startingEfficiency, %settingsFileName%, Last Session, startingEfficiency, 0
			IniRead, startingQuality, %settingsFileName%, Last Session, startingQuality, 0
			startingTotal := startingUtility + startingEfficiency + startingQuality
			IniRead, endingUtility, %settingsFileName%, Last Session, endingUtility, 53
			IniRead, endingEfficiency, %settingsFileName%, Last Session, endingEfficiency, 53
			IniRead, endingQuality, %settingsFileName%, Last Session, endingQuality, 53
			endingTotal := endingUtility + endingEfficiency + endingQuality
			
			IniRead, viewToggle, %settingsFileName%, Last Session, viewToggle, 1
			return
			
			loadPrices:
	;loading material prices
			loop, % materials.length() {
				material := materials[A_Index][1]
				if (material != "Coins") {
					IniRead, price, %settingsFileName%, Material Price, %material%, -1
					if (price == -1) {
						price := materials[A_Index][2]	;this is the default value
						IniWrite, %price%, %settingsFileName%, Material Price, %material%
					}
					materials[A_Index][2] := price
				}
			}
			return
			
			
			
			saveSettings:
;save Gui settings
			WinGetPos, GuiPosX, GuiPosY,,, A
			IniWrite, %GuiPosX%, %settingsFileName%, Last Session, GuiPosX
			IniWrite, %GuiPosY%, %settingsFileName%, Last Session, GuiPosY
			
;save last session settings
			IniWrite, %numberOfTotems%, %settingsFileName%, Last Session, numberOfTotems
			IniWrite, %lmcRate%, %settingsFileName%, Last Session, lmcRate
			IniWrite, %startingUtility%, %settingsFileName%, Last Session, startingUtility
			IniWrite, %startingEfficiency%, %settingsFileName%, Last Session, startingEfficiency
			IniWrite, %startingQuality%, %settingsFileName%, Last Session, startingQuality
			IniWrite, %endingUtility%, %settingsFileName%, Last Session, endingUtility
			IniWrite, %endingEfficiency%, %settingsFileName%, Last Session, endingEfficiency
			IniWrite, %endingQuality%, %settingsFileName%, Last Session, endingQuality
			IniWrite, %viewToggle%, %settingsFileName%, Last Session, viewToggle
			return
			
			savePrices:
;save prices
			loop, % materials.length() {
				material := materials[A_Index][1]
				price := materials[A_Index][2]
				if (material != "Coins") {
					IniWrite, %price%, %settingsFileName%, Material Price, %material%
				}
			}
			return
			
			
			LoadDefaultPrices:
			Gui, Submit, NoHide
			MsgBox, 4, Warning, Are you sure? This will reset prices to default settings.
			IfMsgBox, Yes
			{
				Gosub, saveSettings
				IniDelete, %settingsFileName%, Material Price
				Reload
			}
			return
			
			^l::
			loadCustomPrices:
			IniRead, editCustomPrices, %settingsFileName%, Material Price
			GuiControl, , editCustomPrices, %editCustomPrices%
			GuiControl, , viewToggle, % views[viewToggle]	
			Gosub, loadPrices
			Gosub, LevelsCheck
			return
			
			^s::
			saveCustomPrices:
			Gui, Submit, NoHide
			IniWrite, %editCustomPrices%, %settingsFileName%, Material Price
			Gosub, loadPrices
			Gosub, savePrices
			Gosub, LevelsCheck
			SB_SetText("Your custom prices have been saved to a file")
			return
			
			GuiClose:
			Gui, Submit, NoHide
			Gosub, saveSettings
			Gosub, savePrices
			ExitApp
			
