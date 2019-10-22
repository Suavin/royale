function tvRP.getNearestVehicles(radius)
	local r = {}
	local px,py,pz = tvRP.getPosition()

	local vehs = {}
	local it,veh = FindFirstVehicle()
	if veh then
		table.insert(vehs,veh)
	end
	local ok
	repeat
		ok,veh = FindNextVehicle(it)
		if ok and veh then
			table.insert(vehs,veh)
		end
	until not ok
	EndFindVehicle(it)

	for _,veh in pairs(vehs) do
		local x,y,z = table.unpack(GetEntityCoords(veh,true))
		local distance = GetDistanceBetweenCoords(x,y,z,px,py,pz,true)
		if distance <= radius then
			r[veh] = distance
		end
	end
	return r
end

function tvRP.getNearestVehicle(radius)
	local veh
	local vehs = tvRP.getNearestVehicles(radius)
	local min = radius+0.0001
	for _veh,dist in pairs(vehs) do
		if dist < min then
			min = dist
			veh = _veh
		end
	end
	return veh 
end

function tvRP.ejectVehicle()
	local ped = PlayerPedId()
	if IsPedSittingInAnyVehicle(ped) then
		local veh = GetVehiclePedIsIn(ped,false)
		TaskLeaveVehicle(ped,veh,4160)
	end
end

function tvRP.isInVehicle()
	return IsPedSittingInAnyVehicle(PlayerPedId())
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- MODELHASH
-----------------------------------------------------------------------------------------------------------------------------------------
local vehList = {
	{ hash = -344943009, name = "blista", price = 60000, banido = false },
	{ hash = 1549126457, name = "brioso", price = 30000, banido = false },
	{ hash = -1130810103, name = "dilettante", price = 60000, banido = false },
	{ hash = -1177863319, name = "issi2", price = 55000, banido = false },
	{ hash = -431692672, name = "panto", price = 15000, banido = false },
	{ hash = -1450650718, name = "prairie", price = 10000, banido = false },
	{ hash = 841808271, name = "rhapsody", price = 7000, banido = false },
	{ hash = 330661258, name = "cogcabrio", price = 120000, banido = false },
	{ hash = -5153954, name = "exemplar", price = 80000, banido = false },
	{ hash = -591610296, name = "f620", price = 55000, banido = false },
	{ hash = -391594584, name = "felon", price = 55000, banido = false },
	{ hash = -89291282, name = "felon2", price = 80000, banido = false },
	{ hash = -624529134, name = "jackal", price = 60000, banido = false },
	{ hash = 1348744438, name = "oracle", price = 40000, banido = false },
	{ hash = -511601230, name = "oracle2", price = 80000, banido = false },
	{ hash = 1349725314, name = "sentinel", price = 50000, banido = false },
	{ hash = 873639469, name = "sentinel2", price = 60000, banido = false },
	{ hash = 1581459400, name = "windsor", price = 150000, banido = false },
	{ hash = -1930048799, name = "windsor2", price = 170000, banido = false },
	{ hash = -1122289213, name = "zion", price = 50000, banido = false },
	{ hash = -1193103848, name = "zion2", price = 60000, banido = false },
	{ hash = -1205801634, name = "blade", price = 100000, banido = false },
	{ hash = -682211828, name = "buccaneer", price = 110000, banido = false },
	{ hash = -1013450936, name = "buccaneer2", price = 240000, banido = false },
	{ hash = 349605904, name = "chino", price = 120000, banido = false },
	{ hash = -1361687965, name = "chino2", price = 240000, banido = false },
	{ hash = 784565758, name = "coquette3", price = 170000, banido = false },
	{ hash = 80636076, name = "dominator", price = 180000, banido = false },
	{ hash = 723973206, name = "dukes", price = 150000, banido = false },
	{ hash = -2119578145, name = "faction", price = 150000, banido = false },
	{ hash = -1790546981, name = "faction2", price = 200000, banido = false },
	{ hash = -2039755226, name = "faction3", price = 350000, banido = false },
	{ hash = -1800170043, name = "gauntlet", price = 145000, banido = false },
	{ hash = 15219735, name = "hermes", price = 280000, banido = false },
	{ hash = 37348240, name = "hotknife", price = 180000, banido = false },
	{ hash = 525509695, name = "moonbeam", price = 180000, banido = false },
	{ hash = 1896491931, name = "moonbeam2", price = 220000, banido = false },
	{ hash = -1943285540, name = "nightshade", price = 270000, banido = false },
	{ hash = 1507916787, name = "picador", price = 150000, banido = false },
	{ hash = -58917837, name = "ratloader2", price = 180000, banido = false },
	{ hash = -227741703, name = "ruiner", price = 150000, banido = false },
	{ hash = -1685021548, name = "sabregt", price = 240000, banido = false },
	{ hash = 223258115, name = "sabregt2", price = 150000, banido = false },
	{ hash = 729783779, name = "slamvan", price = 150000, banido = false },
	{ hash = 833469436, name = "slamvan2", price = 190000, banido = false },
	{ hash = 1119641113, name = "slamvan3", price = 200000, banido = false },
	{ hash = 1923400478, name = "stalion", price = 150000, banido = false },
	{ hash = 972671128, name = "tampa", price = 170000, banido = false },
	{ hash = -825837129, name = "vigero", price = 170000, banido = false },
	{ hash = -498054846, name = "virgo", price = 150000, banido = false },
	{ hash = -899509638, name = "virgo2", price = 250000, banido = false },
	{ hash = 16646064, name = "virgo3", price = 180000, banido = false },
	{ hash = 2006667053, name = "voodoo", price = 220000, banido = false },
	{ hash = 1871995513, name = "yosemite", price = 350000, banido = false },
	{ hash = 1126868326, name = "bfinjection", price = 80000, banido = false },
	{ hash = -349601129, name = "bifta", price = 190000, banido = false },
	{ hash = -1435919434, name = "bodhi2", price = 170000, banido = false },
	{ hash = -1237253773, name = "dubsta3", price = 240000, banido = false },
	{ hash = -2064372143, name = "mesa3", price = 160000, banido = false },
	{ hash = 1645267888, name = "rancherxl", price = 200000, banido = false },
	{ hash = -1207771834, name = "rebel", price = 220000, banido = false },
	{ hash = -2045594037, name = "rebel2", price = 250000, banido = false },
	{ hash = -1532697517, name = "riata", price = 250000, banido = false },
	{ hash = -1189015600, name = "sandking", price = 350000, banido = false },
	{ hash = 989381445, name = "sandking2", price = 300000, banido = false },
	{ hash = -81417329, name = "s3sedan", price = 0, banido = false },
	{ hash = 829927215, name = "rampage10", price = 0, banido = false },
	{ hash = -1165155784, name = "500x", price = 0, banido = false },
	{ hash = -808831384, name = "baller", price = 150000, banido = false },
	{ hash = 142944341, name = "baller2", price = 130000, banido = false },
	{ hash = 1878062887, name = "baller3", price = 140000, banido = false },
	{ hash = 634118882, name = "baller4", price = 150000, banido = false },
	{ hash = 470404958, name = "baller5", price = 300000, banido = false },
	{ hash = 666166960, name = "baller6", price = 310000, banido = false },
	{ hash = 850565707, name = "bjxl", price = 100000, banido = false },
	{ hash = 2006918058, name = "cavalcade", price = 110000, banido = false },
	{ hash = -789894171, name = "cavalcade2", price = 130000, banido = false },
	{ hash = 683047626, name = "contender", price = 320000, banido = false },
	{ hash = 1177543287, name = "dubsta", price = 150000, banido = false },
	{ hash = -394074634, name = "dubsta2", price = 180000, banido = false },
	{ hash = -1137532101, name = "fq2", price = 100000, banido = false },
	{ hash = -1775728740, name = "granger", price = 280000, banido = false },
	{ hash = -1543762099, name = "gresley", price = 150000, banido = false },
	{ hash = 884422927, name = "habanero", price = 100000, banido = false },
	{ hash = 1221512915, name = "seminole", price = 110000, banido = false },
	{ hash = 1337041428, name = "serrano", price = 150000, banido = false },
	{ hash = 1203490606, name = "xls", price = 150000, banido = false },
	{ hash = -432008408, name = "xls2", price = 350000, banido = false },
	{ hash = -1809822327, name = "asea", price = 50000, banido = false },
	{ hash = -1903012613, name = "asterope", price = 60000, banido = false },
	{ hash = 906642318, name = "cog55", price = 200000, banido = false },
	{ hash = 704435172, name = "cog552", price = 350000, banido = false },
	{ hash = -2030171296, name = "cognoscenti", price = 250000, banido = false },
	{ hash = -604842630, name = "cognoscenti2", price = 350000, banido = false },
	{ hash = -1477580979, name = "stanier", price = 60000, banido = false },
	{ hash = 1723137093, name = "stratum", price = 70000, banido = false },
	{ hash = 1123216662, name = "superd", price = 200000, banido = false },
	{ hash = -1894894188, name = "surge", price = 100000, banido = false },
	{ hash = -1008861746, name = "tailgater", price = 100000, banido = false },
	{ hash = 1373123368, name = "warrener", price = 90000, banido = false },
	{ hash = 1777363799, name = "washington", price = 120000, banido = false },
	{ hash = 767087018, name = "alpha", price = 160000, banido = false },
	{ hash = -1041692462, name = "banshee", price = 240000, banido = false },
	{ hash = 1274868363, name = "bestiagts", price = 220000, banido = false },
	{ hash = 1039032026, name = "blista2", price = 50000, banido = false },
	{ hash = -591651781, name = "blista3", price = 70000, banido = false },
	{ hash = -304802106, name = "buffalo", price = 240000, banido = false },
	{ hash = 736902334, name = "buffalo2", price = 240000, banido = false },
	{ hash = 2072687711, name = "carbonizzare", price = 250000, banido = false },
	{ hash = -1045541610, name = "comet2", price = 200000, banido = false },
	{ hash = -2022483795, name = "comet3", price = 230000, banido = false },
	{ hash = 108773431, name = "coquette", price = 200000, banido = false },
	{ hash = 196747873, name = "elegy", price = 560000, banido = false },
	{ hash = -566387422, name = "elegy2", price = 280000, banido = false },
	{ hash = -1995326987, name = "feltzer2", price = 200000, banido = false },
	{ hash = -1089039904, name = "furoregt", price = 250000, banido = false },
	{ hash = 499169875, name = "fusilade", price = 180000, banido = false },
	{ hash = 2016857647, name = "futo", price = 150000, banido = false },
	{ hash = -1297672541, name = "jester", price = 270000, banido = false },
	{ hash = 544021352, name = "khamelion", price = 180000, banido = false },
	{ hash = -1372848492, name = "kuruma", price = 240000, banido = false },
	{ hash = -142942670, name = "massacro", price = 290000, banido = false },
	{ hash = -411549476, name = "Bike", price = 50000, banido = false },
	{ hash = 1032823388, name = "ninef", price = 250000, banido = false },
	{ hash = -1461482751, name = "ninef2", price = 250000, banido = false },
	{ hash = -777172681, name = "omnis", price = 450000, banido = false },
	{ hash = 867799010, name = "pariah", price = 400000, banido = false },
	{ hash = -377465520, name = "penumbra", price = 120000, banido = false },
	{ hash = -1529242755, name = "raiden", price = 210000, banido = false },
	{ hash = -1934452204, name = "rapidgt", price = 220000, banido = false },
	{ hash = 1737773231, name = "rapidgt2", price = 240000, banido = false },
	{ hash = 719660200, name = "ruston", price = 300000, banido = false },
	{ hash = -1485523546, name = "schafter3", price = 180000, banido = false },
	{ hash = 1489967196, name = "schafter4", price = 190000, banido = false },
	{ hash = -746882698, name = "schwarzer", price = 150000, banido = false },
	{ hash = 1104234922, name = "sentinel3", price = 150000, banido = false },
	{ hash = -1757836725, name = "seven70", price = 300000, banido = false },
	{ hash = 1886268224, name = "specter", price = 280000, banido = false },
	{ hash = 1074745671, name = "specter2", price = 310000, banido = false },
	{ hash = 1741861769, name = "streiter", price = 200000, banido = false },
	{ hash = 970598228, name = "sultan", price = 360000, banido = false },
	{ hash = 384071873, name = "surano", price = 270000, banido = false },
	{ hash = -1071380347, name = "tampa2", price = 180000, banido = false },
	{ hash = 1887331236, name = "tropos", price = 150000, banido = false },
	{ hash = 1102544804, name = "verlierer2", price = 330000, banido = false },
	{ hash = 117401876, name = "btype", price = 320000, banido = false },
	{ hash = -831834716, name = "btype2", price = 400000, banido = false },
	{ hash = -602287871, name = "btype3", price = 340000, banido = false },
	{ hash = 941800958, name = "casco", price = 310000, banido = false },
	{ hash = -1311154784, name = "cheetah", price = 370000, banido = false },
	{ hash = 1011753235, name = "coquette2", price = 250000, banido = false },
	{ hash = -1566741232, name = "feltzer3", price = 200000, banido = false },
	{ hash = -2079788230, name = "gt500", price = 250000, banido = false },
	{ hash = -1405937764, name = "infernus2", price = 250000, banido = false },
	{ hash = 1051415893, name = "jb700", price = 200000, banido = false },
	{ hash = -1660945322, name = "mamba", price = 240000, banido = false },
	{ hash = -2124201592, name = "manana", price = 75000, banido = false },
	{ hash = -433375717, name = "monroe", price = 240000, banido = false },
	{ hash = 1830407356, name = "peyote", price = 150000, banido = false },
	{ hash = 1078682497, name = "pigalle", price = 250000, banido = false },
	{ hash = 2049897956, name = "rapidgt3", price = 190000, banido = false },
	{ hash = 1841130506, name = "retinue", price = 150000, banido = false },
	{ hash = 1770332643, name = "dloader", price = 150000, banido = false },
	{ hash = 1545842587, name = "stinger", price = 200000, banido = false },
	{ hash = -2098947590, name = "stingergt", price = 230000, banido = false },
	{ hash = 1504306544, name = "torero", price = 160000, banido = false },
	{ hash = 464687292, name = "tornado", price = 140000, banido = false },
	{ hash = 1531094468, name = "tornado2", price = 160000, banido = false },
	{ hash = -1797613329, name = "tornado5", price = 250000, banido = false },
	{ hash = -982130927, name = "turismo2", price = 250000, banido = false },
	{ hash = -391595372, name = "viseris", price = 210000, banido = false },
	{ hash = 758895617, name = "ztype", price = 400000, banido = false },
	{ hash = -1216765807, name = "adder", price = 500000, banido = false },
	{ hash = -313185164, name = "autarch", price = 610000, banido = false },
	{ hash = 633712403, name = "banshee2", price = 300000, banido = false },
	{ hash = -1696146015, name = "bullet", price = 350000, banido = false },
	{ hash = 223240013, name = "cheetah2", price = 210000, banido = false },
	{ hash = -1291952903, name = "entityxf", price = 400000, banido = false },
	{ hash = 1426219628, name = "fmj", price = 450000, banido = false },
	{ hash = 1234311532, name = "gp1", price = 430000, banido = false },
	{ hash = 418536135, name = "infernus", price = 410000, banido = false },
	{ hash = 1034187331, name = "nero", price = 390000, banido = false },
	{ hash = 1093792632, name = "nero2", price = 420000, banido = false },
	{ hash = 1987142870, name = "osiris", price = 400000, banido = false },
	{ hash = -1758137366, name = "penetrator", price = 420000, banido = false },
	{ hash = -1829802492, name = "pfister811", price = 460000, banido = false },
	{ hash = 234062309, name = "reaper", price = 500000, banido = false },
	{ hash = 1352136073, name = "sc1", price = 430000, banido = false },
	{ hash = -295689028, name = "sultanrs", price = 300000, banido = false },
	{ hash = 1663218586, name = "t20", price = 500000, banido = false },
	{ hash = 272929391, name = "tempesta", price = 520000, banido = false },
	{ hash = 408192225, name = "turismor", price = 500000, banido = false },
	{ hash = 2067820283, name = "tyrus", price = 500000, banido = false },
	{ hash = 338562499, name = "vacca", price = 500000, banido = false },
	{ hash = -998177792, name = "visione", price = 600000, banido = false },
	{ hash = -1622444098, name = "voltic", price = 380000, banido = false },
	{ hash = -1403128555, name = "zentorno", price = 700000, banido = false },
	{ hash = -599568815, name = "sadler", price = 180000, banido = false },
	{ hash = -16948145, name = "bison", price = 200000, banido = false },
	{ hash = 2072156101, name = "bison2", price = 180000, banido = false },
	{ hash = 1069929536, name = "bobcatxl", price = 240000, banido = false },
	{ hash = -1346687836, name = "burrito", price = 80000, banido = false },
	{ hash = -907477130, name = "burrito2", price = 240000, banido = false },
	{ hash = -1743316013, name = "burrito3", price = 240000, banido = false },
	{ hash = 893081117, name = "burrito4", price = 240000, banido = false },
	{ hash = -310465116, name = "minivan", price = 100000, banido = false },
	{ hash = -1126264336, name = "minivan2", price = 200000, banido = false },
	{ hash = 1488164764, name = "paradise", price = 240000, banido = false },
	{ hash = -119658072, name = "pony", price = 240000, banido = false },
	{ hash = 943752001, name = "pony2", price = 240000, banido = false },
	{ hash = 1162065741, name = "rumpo", price = 240000, banido = false },
	{ hash = -1776615689, name = "rumpo2", price = 240000, banido = false },
	{ hash = 1475773103, name = "rumpo3", price = 250000, banido = false },
	{ hash = -810318068, name = "speedo", price = 240000, banido = false },
	{ hash = 699456151, name = "surfer", price = 50000, banido = false },
	{ hash = 65402552, name = "youga", price = 240000, banido = false },
	{ hash = 1026149675, name = "youga2", price = 240000, banido = false },
	{ hash = 486987393, name = "huntley", price = 100000, banido = false },
	{ hash = 1269098716, name = "landstalker", price = 130000, banido = false },
	{ hash = 914654722, name = "mesa", price = 65000, banido = false },
	{ hash = -808457413, name = "patriot", price = 250000, banido = false },
	{ hash = -1651067813, name = "radi", price = 100000, banido = false },
	{ hash = 2136773105, name = "rocoto", price = 100000, banido = false },
	{ hash = -376434238, name = "tyrant", price = 600000, banido = false },
	{ hash = -2120700196, name = "entity2", price = 480000, banido = false },
	{ hash = -988501280, name = "cheburek", price = 150000, banido = false },
	{ hash = 1115909093, name = "hotring", price = 300000, banido = false },
	{ hash = -214906006, name = "jester3", price = 240000, banido = false },
	{ hash = -1259134696, name = "flashgt", price = 320000, banido = false },
	{ hash = -1267543371, name = "ellie", price = 300000, banido = false },
	{ hash = 1046206681, name = "michelli", price = 160000, banido = false },
	{ hash = 1617472902, name = "fagaloa", price = 300000, banido = false },
	{ hash = -986944621, name = "dominator3", price = 300000, banido = false },
	{ hash = 931280609, name = "issi3", price = 160000, banido = false },
	{ hash = -1134706562, name = "taipan", price = 500000, banido = false },
	{ hash = 1909189272, name = "gb200", price = 170000, banido = false },
	{ hash = -1961627517, name = "stretch", price = 1200000, banido = false },
	{ hash = -2107990196, name = "guardian", price = 500000, banido = false },
	{ hash = 1672195559, name = "akuma", price = 950000, banido = false },
	{ hash = -2115793025, name = "avarus", price = 85000, banido = false },
	{ hash = -2140431165, name = "bagger", price = 240000, banido = false },
	{ hash = -114291515, name = "bati", price = 260000, banido = false },
	{ hash = 86520421, name = "bf400", price = 350000, banido = false },
	{ hash = 11251904, name = "carbonrs", price = 300000, banido = false },
	{ hash = 6774487, name = "chimera", price = 280000, banido = false },
	{ hash = 390201602, name = "cliffhanger", price = 250000, banido = false },
	{ hash = 2006142190, name = "daemon", price = 200000, banido = false },
	{ hash = -1404136503, name = "daemon2", price = 200000, banido = false },
	{ hash = 822018448, name = "defiler", price = 380000, banido = false },
	{ hash = -239841468, name = "diablous", price = 350000, banido = false },
	{ hash = 1790834270, name = "diablous2", price = 380000, banido = false },
	{ hash = -1670998136, name = "double", price = 300000, banido = false },
	{ hash = 1753414259, name = "enduro", price = 65000, banido = false },
	{ hash = 2035069708, name = "esskey", price = 260000, banido = false },
	{ hash = -1842748181, name = "faggio", price = 14000, banido = false },
	{ hash = 55628203, name = "faggio2", price = 5000, banido = false },
	{ hash = -1289178744, name = "faggio3", price = 12000, banido = false },
	{ hash = 627535535, name = "fcr", price = 320000, banido = false },
	{ hash = -757735410, name = "fcr2", price = 320000, banido = false },
	{ hash = 741090084, name = "gargoyle", price = 280000, banido = false },
	{ hash = 1265391242, name = "hakuchou", price = 760000, banido = false },
	{ hash = -255678177, name = "hakuchou2", price = 450000, banido = false },
	{ hash = 301427732, name = "hexer", price = 180000, banido = false },
	{ hash = -159126838, name = "innovation", price = 210000, banido = false },
	{ hash = 640818791, name = "lectro", price = 310000, banido = false },
	{ hash = -1523428744, name = "manchez", price = 100000, banido = false },
	{ hash = -634879114, name = "nemesis", price = 280000, banido = false },
	{ hash = -1606187161, name = "nightblade", price = 650000, banido = false },
	{ hash = -909201658, name = "pcj", price = 55000, banido = false },
	{ hash = -893578776, name = "ruffian", price = 280000, banido = false },
	{ hash = 788045382, name = "sanchez", price = 150000, banido = false },
	{ hash = -1453280962, name = "sanchez2", price = 80000, banido = false },
	{ hash = 1491277511, name = "sanctus", price = 350000, banido = false },
	{ hash = 743478836, name = "sovereign", price = 140000, banido = false },
	{ hash = 1836027715, name = "thrust", price = 300000, banido = false },
	{ hash = -140902153, name = "vader", price = 280000, banido = false },
	{ hash = -1353081087, name = "vindicator", price = 250000, banido = false },
	{ hash = -609625092, name = "vortex", price = 300000, banido = false },
	{ hash = -618617997, name = "wolfsbane", price = 230000, banido = false },
	{ hash = -1009268949, name = "zombiea", price = 230000, banido = false },
	{ hash = -570033273, name = "zombieb", price = 235000, banido = false },
	{ hash = -2128233223, name = "blazer", price = 200000, banido = false },
	{ hash = -440768424, name = "blazer4", price = 300000, banido = false },
	{ hash = 744705981, name = "frogger", price = 0, banido = false },
	{ hash = -1660661558, name = "maverick", price = 0, banido = false },
	{ hash = 710198397, name = "supervolito", price = 0, banido = false },
	{ hash = -405626514, name = "shotaro", price = 1000000, banido = false },
	{ hash = -1848994066, name = "neon", price = 300000, banido = false },
	{ hash = 1392481335, name = "cyclone", price = 800000, banido = false },
	{ hash = -2048333973, name = "italigtb", price = 520000, banido = false },
	{ hash = -482719877, name = "italigtb2", price = 530000, banido = false },
	{ hash = 1939284556, name = "vagner", price = 590000, banido = false },
	{ hash = 917809321, name = "xa21", price = 550000, banido = false },
	{ hash = 1031562256, name = "tezeract", price = 800000, banido = false },
	{ hash = -956048545, name = "taxi", price = 0, banido = true },
	{ hash = -2072933068, name = "coach", price = 0, banido = true },
	{ hash = -713569950, name = "bus", price = 0, banido = true },
	{ hash = -713569950, name = "bus", price = 0, banido = true },
	{ hash = 1353720154, name = "flatbed", price = 0, banido = true },
	{ hash = -233098306, name = "boxville2", price = 0, banido = true },
	{ hash = 1917016601, name = "trash", price = 0, banido = true },
	{ hash = -1255698084, name = "trash2", price = 0, banido = true },
	{ hash = -1150599089, name = "primo", price = 120000, banido = false },
	{ hash = -2040426790, name = "primo2", price = 230000, banido = false },
	{ hash = 2123327359, name = "prototipo", price = 0, banido = false },  -- VIP
	{ hash = -1289722222, name = "ingot", price = 160000, banido = false },
	{ hash = -1173768715, name = "ferrariitalia", price = 3400000, banido = false },
	{ hash = -1683569033, name = "paganihuayra", price = 1500000, banido = false },
	{ hash = -1573350092, name = "fordmustang", price = 1000000, banido = false },
	{ hash = 1106910537, name = "fordmustanggt", price = 1000000, banido = false },
	{ hash = -60313827, name = "nissangtr", price = 1150000, banido = false },
	{ hash = 351980252, name = "teslaprior", price = 700000, banido = false },
	{ hash = -4816535, name = "nissanskyliner34", price = 4300000, banido = false },
	{ hash = 1676738519, name = "audirs6", price = 2200000, banido = false },
	{ hash = 1114244595, name = "lamborghinihuracan", price = 3600000, banido = false },
	{ hash = 1601422646, name = "dodgechargersrt", price = 1400000, banido = false },
	{ hash = -420911112, name = "patriot2", price = 550000, banido = false },
	{ hash = 219613597, name = "speedo4", price = 240000, banido = false },
	{ hash = 321186144, name = "stafford", price = 400000, banido = false },
	{ hash = 500482303, name = "swinger", price = 250000, banido = false },
	{ hash = 2139203625, name = "brutus", price = 350000, banido = false },
	{ hash = -1566607184, name = "clique", price = 360000, banido = false },
	{ hash = 1591739866, name = "deveste", price = 800000, banido = false },
	{ hash = 1279262537, name = "deviant", price = 300000, banido = false },
	{ hash = -2096690334, name = "impaler", price = 300000, banido = false },
	{ hash = 444994115, name = "imperator", price = 400000, banido = false },
	{ hash = -331467772, name = "italigto", price = 700000, banido = false },
	{ hash = -507495760, name = "schlagen", price = 600000, banido = false },
	{ hash = -1168952148, name = "toros", price = 310000, banido = false },
	{ hash = 1456744817, name = "tulip", price = 300000, banido = false },
	{ hash = -49115651, name = "vamos", price = 320000, banido = false },
	{ hash = -27326686, name = "deathbike", price = 350000, banido = false },
	{ hash = -121446169, name = "kamacho", price = 400000, banido = false },
	{ hash = 2034235290, name = "mazdarx7", price = 1000000, banido = false },
	{ hash = 670022011, name = "nissangtrnismo", price = 1200000, banido = false },
	{ hash = -13524981, name = "bmwm4gts", price = 950000, banido = false },
	{ hash = 1978088379, name = "lancerevolutionx", price = 0, banido = false },
	{ hash = 132097997, name = "mercedesamgc63", price = 850000, banido = false },
	{ hash = -157095615, name = "bmwm3f80", price = 0, banido = false }, -- vipp
	{ hash = 723779872, name = "toyotasupra", price = 0, banido = false }, --vipp
	{ hash = -2015218779, name = "nissan370z", price = 0, banido = false }, --vipp
	{ hash = 1743739647, name = "policiacharger2018", price = 0, banido = true },
	{ hash = -1737942312, name = "policiacharger2018norte", price = 0, banido = true },
	{ hash = 1884511084, name = "policiasilverado", price = 0, banido = true },
	{ hash = 1865641415, name = "policiatahoe", price = 0, banido = true },
	{ hash = -164329993, name = "policiatahoenorte", price = 0, banido = true },
	{ hash = 112218935, name = "policiataurus", price = 0, banido = true },
	{ hash = 1611501436, name = "policiavictoria", price = 0, banido = true },
	{ hash = -1624991916, name = "policiabmwr1200", price = 0, banido = true },
	{ hash = -875050963, name = "policiaheli", price = 0, banido = true },
	{ hash = -792745162, name = "paramedicoambu", price = 0, banido = true },
	{ hash = 108063727, name = "paramedicocharger2014", price = 0, banido = true },
	{ hash = 2020690903, name = "paramedicoheli", price = 0, banido = true },
	{ hash = -2007026063, name = "pbus", price = 0, banido = true },
	{ hash = 1127861609, name = "tribike", price = 0, banido = true },
	{ hash = -1233807380, name = "tribike2", price = 0, banido = true },
	{ hash = -400295096, name = "tribike3", price = 0, banido = true },
	{ hash = -186537451, name = "scorcher", price = 0, banido = true },
	{ hash = -836512833, name = "fixter", price = 0, banido = true },
	{ hash = 448402357, name = "cruiser", price = 0, banido = true },
	{ hash = 1131912276, name = "bmx", price = 0, banido = true },
	{ hash = 1033245328, name = "dinghy", price = 0, banido = true },
	{ hash = 861409633, name = "jetmax", price = 0, banido = true },
	{ hash = -1043459709, name = "marquis", price = 0, banido = true },
	{ hash = -311022263, name = "seashark3", price = 0, banido = true },
	{ hash = 231083307, name = "speeder", price = 0, banido = false },
	{ hash = 437538602, name = "speeder2", price = 0, banido = true },
	{ hash = 400514754, name = "squalo", price = 0, banido = true },
	{ hash = -282946103, name = "suntrap", price = 0, banido = true },
	{ hash = 1070967343, name = "toro", price = 0, banido = true },
	{ hash = 908897389, name = "toro2", price = 0, banido = true },
	{ hash = 290013743, name = "tropic", price = 0, banido = true },
	{ hash = 1448677353, name = "tropic2", price = 0, banido = true },
	{ hash = 1131912276, name = "bmx", price = 0, banido = true },
	{ hash = -2137348917, name = "phantom", price = 0, banido = true },
	{ hash = 569305213, name = "packer", price = 0, banido = true },
	{ hash = -1984275979, name = "havok", price = 1800000, banido = false },
	{ hash = -1671539132, name = "supervolito2", price = 4580000, banido = false },
	{ hash = -674927303, name = "raptor", price = 550000, banido = false },
	{ hash = 489769895, name = "policiataurusnorte", price = 0, banido = true },
	{ hash = -304857564, name = "ghispo2", price = 0, banido = true }
}

function tvRP.ModelName(radius)
	local veh = tvRP.getNearestVehicle(radius)
	if IsEntityAVehicle(veh) then
		local lock = GetVehicleDoorLockStatus(veh) >= 2
		local x,y,z = table.unpack(GetEntityCoords(PlayerPedId()))
		for k,v in pairs(vehList) do
			if v.hash == GetEntityModel(veh) then
				if v.name then
					return GetVehicleNumberPlateText(veh),v.name,VehToNet(veh),parseInt(v.price),v.banido,lock,GetDisplayNameFromVehicleModel(v.name),GetStreetNameFromHashKey(GetStreetNameAtCoord(x,y,z))
				end
			end
		end
	end
end

function tvRP.ModelName2()
	local veh = GetVehiclePedIsUsing(PlayerPedId())
	if IsEntityAVehicle(veh) then
		for k,v in pairs(vehList) do
			if v.hash == GetEntityModel(veh) then
				if v.name then
					return GetVehicleNumberPlateText(veh),v.name,parseInt(v.price),v.banido,VehToNet(veh),veh
				end
			end
		end
	end
end