    local sz = require("sz")--写 showUI 前必须插入这一句
    local json = sz.json--写 showUI 前必须插入这一句
	require("TSLib")
    w,h = getScreenSize();
	--wait till the screen freeze
	function waitScreen(lim)
		local i,timesum,fcount
		local tbl={}
		for i=0,10 do
			tbl[i]=getColor(15+i*66, 55+120*i)
		end
		timesum=0
		while timesum<=10000 do
			timesum=timesum+500
			fcount=0
			for i=0,10 do
				if getColor(15+i*66, 55+120*i)==tbl[i] then
					fcount=fcount+1
				end
				tbl[i]=getColor(15+i*66, 55+120*i)
			end
			if fcount>=7 then
				return 1
			end
			mSleep(500)
		end
		dialog("tle screen",2000)
		return 0
	end
	--wait till the loading sign fade
	function waitLoad(lim)
		local timesum=0
		local x,y
		while timesum<=lim do
			x,y = findMultiColorInRegionFuzzy( 0xf5f5f5, "22|19|0xf4f4f4,300|159|0x272b53,319|-47|0x43506a", 90, 70, 700, 719, 1279);
			if(x==-1) then
				return 1
			end
			mSleep(400)
			timesum=timesum+400
		end
		dialog("tle load", 2000)
		return 0
	end
	
	--try to lauch game and to find the right raid
	flag=runApp("jp.co.mixi.monsterstrikeCN")
	mSleep(3000)
	if flag==1 then
		dialog("Game launching failed",100)
	end
	darkangelface={
	{  501,  828, 0x9cefef},
	{  463,  901, 0x5a9ade},
	{  350,  762, 0xfff7f7},
	}
	while true do
		if multiColor(darkangelface)== true then
				break
		end
		mSleep(50)
	end
	okbutton={
	{  0, 0, 0xee6800},
	{  -54, 6, 0xffffff},
	{  -84, -8, 0xffffff},
	{  -134, -17, 0xf27800},
	}
	tap(339,754)
	mSleep(2000)
	tap(339,754)
	waitScreen(60000)
	waitLoad(5000)
	x,y=findMultiColorInRegionFuzzyByTable(okbutton, 90, 0, 0, 719, 1279)
	waitScreen(60000)
	while (x~=-1) do
		x,y=findMultiColorInRegionFuzzyByTable(okbutton, 90, 0, 0, 719, 1279)
		tap(x,y)
		dialog("bingo",200)
		waitScreen(60000)
	end
	
	
	
	