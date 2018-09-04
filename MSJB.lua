local sz = require("sz")--写 showUI 前必须插入这一句
local json = sz.json--写 showUI 前必须插入这一句
require("TSLib")
w,h = getScreenSize();
--graphic data
darkangelface={{  501,  828, 0x9cefef},{  463,  901, 0x5a9ade},{  350,  762, 0xfff7f7},}
okbutton={{  0, 0, 0xee6800},{  -54, 6, 0xffffff},{  -84, -8, 0xffffff},{  -134, -17, 0xf27800},}
backbutton= {{0,0,0xbdffff},{39,-2,0x0056e9},{30,-4,0x005deb},{12,-3,0xbdffff},}
adventure={{  314, 1025, 0xab7200},{  320, 1025, 0xab7200},{  405, 1028, 0xc17e00},}
huodong={{  312,  702, 0xd1d8dc},{  384,  753, 0xfffefe},{  364,  667, 0x7c5c5a},{  364,  695, 0x0c0a12},}
loadsign={{  562,  805, 0x43506a},{  563, 1028, 0x454d68},{  155, 1025, 0x454d68},{  155,  806, 0x43506a},}
raidicon={{0,0,0x170088},{80,8,0x9f322d},{27,-55,0x003388},{78,-60,0x0f9925},{115,-26,0xccaa00},}
player4={{  475,  765, 0xf5f5f5},{  487,  775, 0xf5f5f5},{  450,  794, 0x2a292d},{  348,  766, 0xf5f5f5},}
joinbutton={{   48,  741, 0x808080},{   84,  787, 0x282529},{  123,  817, 0x5d5c5d},{  117,  739, 0x808080},{   55,  814, 0x545354},}
room1={{  442,  541, 0x00bd00},{  442,  569, 0x009e00},{  350,  552, 0xffffff},{  409,  547, 0xffffff},}
closebutton={{  423,  926, 0x00ba00},{  413,  943, 0x00a700},{  295,  921, 0x00b800},{  303,  950, 0x009700},}
freshbutton={{  270,  368, 0x00bd00},{  301,  388, 0xffffff},{  410,  394, 0xffffff},{  449,  367, 0x00c700},}
menu={{  595, 1131, 0x1053df},{  620, 1131, 0xffffff},{  640, 1131, 0x1053df},{  671, 1131, 0xffffff},}
indexorange={{  359, 1222, 0xdd6c00},{  715, 1225, 0xd85900},{  360, 1270, 0x803500},}
--wait till the screen freeze
function waitScreen(lim)
	local i,timesum,fcount
	local tbl={}
	for i=0,20 do
		tbl[i]=getColor(15+i*33, 55+60*i)
	end
	local timesum=0
	while timesum<=lim do
		fcount=0
		for i=0,20 do
			if getColor(15+i*33, 55+60*i)==tbl[i] then
				fcount=fcount+1
			end
			tbl[i]=getColor(15+i*33, 55+60*i)
		end
		if fcount>=15 then
			return 1
		end
		mSleep(800)
		timesum=timesum+800;
	end
	toast("tle screen",2000)
	return 0
end
--function to test the bloody okbutton
function testokbutton()
	local x,y
	x,y=findMultiColorInRegionFuzzyByTable(okbutton, 90,225,630,490, 1240)
	while (x~=-1) do
		tap(x,y)
		--dialog("bingo",200)
		waitScreen(60000)
		x,y=findMultiColorInRegionFuzzyByTable(okbutton, 90, 225, 630, 490, 1240)
	end
	return 0
 end
--a function to wait till the loading sign fade
function waitLoad(lim)
	local timesum=0
	local flag
	flag=multiColor(loadsign,90)
	while (flag==false) and (timesum<=3500) do
		flag=multiColor(loadsign,90)
		mSleep(500)
		timesum=timesum+500
	end
	timesum=0
	--dialog("prewait done",300)
	while (flag)and(timesum<=lim) do
		flag=multiColor(loadsign,90)
		if(flag==false) then
			--dialog("load done",2000)
			return 1
		end
		mSleep(1000)
		timesum=timesum+1000
	end
	toast("tle load", 900)
	return 0
end
--a function to locate a button and then click
function Find_Click(tmp,fuz,x1,y1,x2,y2)
	local x,y=findMultiColorInRegionFuzzyByTable(tmp,fuz,x1,y1,x2,y2)
	if (x~=-1) then
		tap(x,y)
		return 1
	else
		return 0
	end
end
--procedure trying to lauch game and goto the index
function Launch_index()
	local flag
	if appIsRunning("jp.co.mixi.monsterstrikeCN")==1 then
		closeApp("jp.co.mixi.monsterstrikeCN")
		mSleep(5000)
	end
	flag=runApp("jp.co.mixi.monsterstrikeCN")
	mSleep(3000)
	if flag==1 then
		dialog("Game launching failed",100)
	end

	while true do
		if multiColor(darkangelface)== true then
			break
		end
		mSleep(50)
	end

	tap(339,754)
	mSleep(2000)
	tap(339,754)
	waitScreen(10000)
	waitLoad(10000)
	waitScreen(60000)
	mSleep(2000)
	--dialog("ok",200)
	while (multiColor(adventure)==false) do
		mSleep(2000)
		testokbutton()
		mSleep(2000)
		tap(59,1218)
		mSleep(2000)
	end
end
--the host finding the daily raid
function Index2host() 
	mSleep(2000)
	if multiColor(adventure,90) then
		tap(356,1004)
		--dialog("clicked",300)
	end
	waitScreen(3500)
	local pp=0
	flag=multiColor(huodong,90)
	while (flag~=true) and (pp<=6) do
		moveTo(570,690,410,740,30,50)
		mSleep(3000)
		pp=pp+1
		flag=multiColor(huodong,90)
	end
	tap(355,705)
	pp=0
	while (Find_Click(raidicon,90,525,320,670,1120)==0) and (pp<=10) do
		moveTo(351,900,290,476)
		mSleep(1000)
		pp=pp+1
	end
	mSleep(1000)
	tap(366,611)
	mSleep(2000)	
	testokbutton()
	tap(354,858)
	waitScreen(10000)
	testokbutton()
end

function Host_wait(lim)
	local timer
	timer=0
	mSleep(6000)
	while (multiColor(player4)==true) and (timer<=lim) do
		mSleep(3000)
		timer=timer+3000
	end
	tap(515,990)
	while (multiColor(menu)==false) and (timer<lim) do
		mSleep(1000)
		timer=timer+1000
	end
end

function Account_switch(num)
	local data10=""
	if appIsRunning("jp.co.mixi.monsterstrikeCN")==1 then
		closeApp("jp.co.mixi.monsterstrikeCN")
		mSleep(1000)
	end
	data10=readFileString("/sdcard/Pictures/1/1 ("..num..")/data10.bin")
	flag=writeFileString("/data/data/jp.co.mixi.monsterstrikeCN/data10.bin",data10,"w")
end

function Index2join()
	local timer=0
	local flag
	while (multiColor(joinbutton)==false) and (timer<=5000) do
		mSleep(800)
		timer=timer+800
	end
	tap(613,1016)
	waitScreen(1500)
	testokbutton()
	waitScreen(1500)
	tap(356,852)
	while multiColor(room1)==false do
		testokbutton()
		if multiColor(closebutton)==true then
			tap(360,942)
			waitScreen(3000)
		end
		if multiColor(freshbutton)==true then
			tap(354,393)
			waitScreen(2000)
		end
		mSleep(2000)
	end
	tap(345,419)
	flag=false
	timer=0
	while (flag~=true) and (timer<=2000000) do
		flag=multiColor(menu)
		mSleep(1500)
		timer=timer+1500
	end
	if flag==false then 
		toast("game loading failure",5000)
	end
end
--GamePlayStrategy
function PlayStrategy()
	local flag=false
	local timer=0
	while (flag~=true) and (timer<=40000) do
		flag=multiColor(menu)
		mSleep(1500)
		timer=timer+1500
	end
	toast("game!",3000)
	flag=multiColor(menu,50)
	while (flag==true) do
		flag=multiColor(menu,50)
		testokbutton()
		mSleep(600)
		moveTo(518,347,207,318,20,100)
		mSleep(1000)
		tap(346,454)
		mSleep(3000)
		flag=flag or multiColor(menu,50)
		testokbutton()
		mSleep(600)
		moveTo(518,347,207,318,20,100)
		mSleep(1000)
		tap(346,454)
		mSleep(3000)
		flag=flag or multiColor(menu,50)
	end
	toast("Break OuT",10000)
end
--BacktomainScreen
function Back2Index()
	local timer=0
	while(multiColor(indexorange)==false)and(timer<=90000) do
		testokbutton()
		mSleep(800)
		tap(356,1118)
		mSleep(1500)
		timer=timer+2300
	end
	timer=0
	while (multiColor(adventure)==false) and (timer<=20000)do
		mSleep(2000)
		testokbutton()
		mSleep(2000)
		tap(59,1218)
		timer=timer+2000
	end
end

	


--where everything starts
gp=0
UINew()
UIRadio("rdo","大号,小号1,小号2,小号3","0",-1,0)--6 个单选选项，默认选择选项 2
UIEdit("gp","序号","",15,"left","255,0,0")--返回值为字符串，若文本框内容为：测试，则返回 edt == "测试"
UIShow()
role=1
if rdo == "大号"then    --返回值为字符型
	role=1
    toast("选择了大号",1000)
elseif rdo == "小号1" then
	role=2
    toast("选择了小号1",1000)
elseif rdo == "小号2" then
	role=3
    toast("选择了小号2",1000)
elseif rdo == "小号3" then
	role=4
    toast("选择了小号3",1000)
end

i=0
if role==1 then
	Account_switch(0)
	Launch_index()
	while true do
		Index2join()
		PlayStrategy()
		Back2Index()
	end
elseif role==2 then
	Account_switch(1+gp*3)
	Launch_index()
	while true do
		for i=1,2 do
			Index2host()
			Host_wait(90000)
			PlayStrategy()
			Back2Index()
		end
		for i=1,2 do
			Index2join()
			PlayStrategy()
			Back2Index()
		end
		gp=gp+1
		Account_switch(1+gp*3)
		Launch_index()
	end
elseif role==3 then
	Account_switch(2+gp*3)
	Launch_index()
	while true do
		for i=1,2 do
			Index2join()
			PlayStrategy()
			Back2Index()
		end
		for i=1,2 do
			Index2host()
			Host_wait(90000)
			PlayStrategy()
			Back2Index()
		end
		gp=gp+1
		Account_switch(2+gp*3)
		Launch_index()
	end
elseif role==4 then 
	Account_switch(3+gp*3)
	Launch_index()
	while true do
		for i=1,4 do
			Index2join()
			PlayStrategy()
			Back2Index()
		end
		gp=gp+1
		Account_switch(3+gp*3)
		Launch_index()
	end
end

	
	


