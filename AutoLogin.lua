local sz = require("sz")--写 showUI 前必须插入这一句
local json = sz.json--写 showUI 前必须插入这一句
require("TSLib")
darkangelface={
{  501,  828, 0x9cefef},
{  463,  901, 0x5a9ade},
{  350,  762, 0xfff7f7},
}
okbutton={
{  0, 0, 0xee6800},
{  -54, 6, 0xffffff},
{  -84, -8, 0xffffff},
{  -134, -17, 0xf27800},
}
backbutton= {{0,0,0xbdffff},{39,-2,0x0056e9},{30,-4,0x005deb},{12,-3,0xbdffff},}
adventure={
{  314, 1025, 0xab7200},
{  320, 1025, 0xab7200},
{  405, 1028, 0xc17e00},
}
huodong={
{  312,  702, 0xd1d8dc},
{  384,  753, 0xfffefe},
{  364,  667, 0x7c5c5a},
{  364,  695, 0x0c0a12},
}
loadsign={
{  562,  805, 0x43506a},
{  563, 1028, 0x454d68},
{  155, 1025, 0x454d68},
{  155,  806, 0x43506a},
}
raidicon={{0,0,0x170088},{80,8,0x9f322d},{27,-55,0x003388},{78,-60,0x0f9925},{115,-26,0xccaa00},}
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
	dialog("tle screen",2000)
	return 0
end
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
	dialog("tle load", 900)
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
pp="";
data10=""
UINew()
UIEdit("pp","序号","",15,"left","255,0,0")--返回值为字符串，若文本框内容为：测试，则返回 edt == "测试"
UIShow()	
	if appIsRunning("jp.co.mixi.monsterstrikeCN")==1 then
		closeApp("jp.co.mixi.monsterstrikeCN")
		mSleep(1000)
	end
	data10=readFileString("/sdcard/Pictures/1/1 ("..pp..")/data10.bin")
	flag=writeFileString("/data/data/jp.co.mixi.monsterstrikeCN/data10.bin",data10,"w")
	mSleep(3000)
	runApp("jp.co.mixi.monsterstrikeCN")

	