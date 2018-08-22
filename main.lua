    local sz = require("sz")--写 showUI 前必须插入这一句
    local json = sz.json--写 showUI 前必须插入这一句
	require("TSLib")
    w,h = getScreenSize();
	--graphic data
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
	--procedure trying to lauch game and to find the right raid
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
	--dialog("ok",200)
	testokbutton();
	Find_Click(backbutton,90,0,220,120,330)
	waitScreen(10000)
	--the host finding the daily raid
	if multiColor(adventure,90) then
		tap(356,1004)
		--dialog("clicked",300)
	end
	waitScreen(3500)
	pp=0
	flag=multiColor(huodong,90)
	while (flag~=true) and (pp<=6) do
		moveTo(570,690,320,740,30,50)
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
	