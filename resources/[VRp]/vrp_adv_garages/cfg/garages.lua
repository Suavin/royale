local cfg = {}

cfg.garage_types = {
	["Garagem"] = {
		_config = { gtype={"personal"} }
	},
	["HeliPonto"] = {
		_config = { gtype={"personal"} }
	},
	["Garagem2"] = {
		_config = { gtype={"personal"},permissions={"maconha.permissao"} },
	},
	["Garagem3"] = {
		_config = { gtype={"personal"},permissions={"meta.permissao"} },
	},
	["Garagem4"] = {
		_config = { gtype={"personal"},permissions={"tuning.permissao"} },
	},
	["Garagem5"] = {
		_config = { gtype={"personal"},permissions={"motoclub.permissao"} },
	},
	["Garagem6"] = {
		_config = { gtype={"personal"},permissions={"mafia.permissao"} },
	},
	["Garagem7"] = {
		_config = { gtype={"personal"},permissions={"cartel.permissao"} },
	},
	["Garagem8"] = {
		_config = { gtype={"personal"},permissions={"yakuza.permissao"} },
	},
	["Garagem9"] = {
		_config = { gtype={"personal"},permissions={"coca.permissao"} },
	},
	["Bulbasaur"]  = {
		_config = { gtype={"personal"},ghome="Bulbasaur" }
	},
	["Ivysaur"]  = {
		_config = { gtype={"personal"},ghome="Ivysaur" }
	},
	["Venusaur"]  = {
		_config = { gtype={"personal"},ghome="Venusaur" }
	},
	["Squirtle"]  = {
		_config = { gtype={"personal"},ghome="Squirtle" }
	},
	["Blastoise"]  = {
		_config = { gtype={"personal"},ghome="Blastoise" }
	},
	["Metapod"]  = {
		_config = { gtype={"personal"},ghome="Metapod" }
	},
	["Clefairy"]  = {
		_config = { gtype={"personal"},ghome="Clefairy" }
	},
	["Clefable"]  = {
		_config = { gtype={"personal"},ghome="Clefable" }
	},
	["Vulpix"]  = {
		_config = { gtype={"personal"},ghome="Vulpix" }
	},
	["Ninetales"]  = {
		_config = { gtype={"personal"},ghome="Ninetales" }
	},
	["Jigglypuff"]  = {
		_config = { gtype={"personal"},ghome="Jigglypuff" }
	},
	["Wigglytuff"]  = {
		_config = { gtype={"personal"},ghome="Wigglytuff" }
	},
	["Zubat"]  = {
		_config = { gtype={"personal"},ghome="Zubat" }
	},
	["Golbat"]  = {
		_config = { gtype={"personal"},ghome="Golbat" }
	},
	["Oddish"]  = {
		_config = { gtype={"personal"},ghome="Oddish" }
	},
	["Gloom"]  = {
		_config = { gtype={"personal"},ghome="Gloom" }
	},
	["Vileplume"]  = {
		_config = { gtype={"personal"},ghome="Vileplume" }
	},
	["Machoke"]  = {
		_config = { gtype={"personal"},ghome="Machoke" }
	},
	["Machamp"]  = {
		_config = { gtype={"personal"},ghome="Machamp" }
	},
	["Bellsprout"]  = {
		_config = { gtype={"personal"},ghome="Bellsprout" }
	},
	["Weepinbell"]  = {
		_config = { gtype={"personal"},ghome="Weepinbell" }
	},
	["Victreebel"]  = {
		_config = { gtype={"personal"},ghome="Victreebel" }
	},
	["Tentacool"]  = {
		_config = { gtype={"personal"},ghome="Tentacool" }
	},
	["Tentacruel"]  = {
		_config = { gtype={"personal"},ghome="Tentacruel" }
	},
	["Geodude"]  = {
		_config = { gtype={"personal"},ghome="Geodude" }
	},
	["Graveler"]  = {
		_config = { gtype={"personal"},ghome="Graveler" }
	},
	["Golem"]  = {
		_config = { gtype={"personal"},ghome="Golem" }
	},
	["Ponyta"]  = {
		_config = { gtype={"personal"},ghome="Ponyta" }
	},
	["Rapidash"]  = {
		_config = { gtype={"personal"},ghome="Rapidash" }
	},
	["Slowpoke"]  = {
		_config = { gtype={"personal"},ghome="Slowpoke" }
	},
	["Slowbro"]  = {
		_config = { gtype={"personal"},ghome="Slowbro" }
	},
	["Magnemite"]  = {
		_config = { gtype={"personal"},ghome="Magnemite" }
	},
	["Magneton"]  = {
		_config = { gtype={"personal"},ghome="Magneton" }
	},
	["Doduo"]  = {
		_config = { gtype={"personal"},ghome="Doduo" }
	},
	["Carros"] = {
		_config = { gtype={"store"} },
		["panto"] = { "panto",13000,25,-1 },
		["brioso"] = { "brioso",30000,30,30 },
		["oracle"] = { "oracle",40000,40,30 },
		["issi2"] = { "issi2",55000,50,30 },
		["mesa"] = { "mesa",65000,60,30 },
		["manana"] = { "manana",75000,70,30 },
		["burrito"] = { "burrito",80000,100,30 },
		["buccaneer"] = { "buccaneer",110000,50,30 },
		["baller"] = { "baller",150000,50,30 },
		["primo2"] = { "primo2",230000,60,30 },
		["jester"] = { "jester",270000,30,30 },
		["contender"] = { "contender",320000,30,30 },
		["sultan"] = { "sultan",360000,30,30 },
		["omnis"] = { "omnis",450000,20,30 },
		["elegy"] = { "elegy",560000,30,30 }
	},
	["Motos"] = {
		_config = { gtype={"store"} },
		["faggio"] = { "faggio",14000,15,30 },
		["faggio3"] = { "faggio",12000,15,30 },
		["Bike"] = { "Motorizada",50000,0,15 },
		["pcj"] = { "pcj",55000,15,30 },
		["enduro"] = { "enduro",65000,15,30 },
		["sanchez2"] = { "sanchez2",80000,15,30 },
		["avarus"] = { "avarus",85000,15,30 },
		["manchez"] = { "manchez",100000,15,30 },
		["sovereign"] = { "sovereign",140000,50,30 },
		["bati"] = { "bati",260000,15,30 },
		["bf400"] = { "bf400",350000,15,30 },
		["nightblade"] = { "nightblade",650000,15,30 },
		["hakuchou"] = { "hakuchou",760000,15,30 },
		["akuma"] = { "akuma",950000,15,30 }
	},
	["Importados"] = {
		_config = { gtype={"store"} },
		["ferrariitalia"] = { "ferrari italia",3400000,60,3 },
		["lamborghinihuracan"] = { "lamborghini huracan",3600000,60,3 },
		["nissanskyliner34"] = { "skyline r34",4300000,60,3 }
	},
	["Pegasus"] = {
		_config = { gtype={"store"} },
		["havok"] = { "Havok",1800000,70,10 },
		["stretch"] = { "Limosine",1200000,60,10 },
		["raptor"] = { "Raptor",550000,20,10 },
		["supervolito2"] = { "SuperVolito2",4580000,150,10 }
	},
	["VIPS"] = {
		_config = { gtype={"store"} },
		["audirs6"] = { "audi rs6",0,60,-1 },
		["s3sedan"] = { "audi s3",0,60,-1 },
		["rampage10"] = { "rampage10",0,60,-1 },
		["500x"] = { "CB 500",0,60,-1 },
		["toyotasupra"] = { "Toyota Supra",0,35,-1 },
		["nissan370z"] = { "Nissan 370z",0,30,-1 },
		["bmwm3f80"] = { "BMW M3F80",0,50,-1 }
	},
	["Motorista"] = {
		_config = { gtype={"rent"} },
		["coach"] = { "coach",0,0,-1 }
	},
	["PoliciaPaleto"] = {
		_config = { gtype={"rent"},permissions={"tooglen.perm"} },
		["policiacharger2018norte"] = { "Dodge Charger 2018",0,0,-1 },
		["policiatahoenorte"] = { "Chevrolet Tahoe",0,0,-1 },
		["policiasilverado"] = { "Chevrolet Silverado",0,0,-1 },
		["policiataurusnorte"] = { "Ford Taurus",0,0,-1 },
		["policiabmwr1200"] = { "BMW R1200",0,0,-1 }
	},
	["Policia"] = {
		_config = { gtype={"rent"},permissions={"toogle.perm"} },
		["policiacharger2018"] = { "Dodge Charger 2018",0,0,-1 },
		["policiatahoe"] = { "Chevrolet Tahoe",0,0,-1 },
		["policiataurus"] = { "Ford Taurus",0,0,-1 },
		["policet"] = { "Sprinter Highway",0,0,-1 },
		["polgs350"] = { "Lexus",0,0,-1 },
		["ghispo2"] = { "Masseratti Comando",0,0,-1 },
		["srt8police"] = { "Jeep",0,0,-1 },
		["policiavictoria"] = { "Crown Victoria",0,0,-1 },
		["policiabmwr1200"] = { "BMW R1200",0,0,-1 }
	},
	["PoliciaB"] = {
		_config = { gtype={"rent"},permissions={"policia.permissao"} },
		["pbus"] = { "Ônibus",0,0,-1 }
	},
	["PoliciaH"] = {
		_config = { gtype={"rent"},permissions={"toogle.perm"} },
		["policiaheli"] = { "Helicóptero",0,0,-1 }
	},
	["PoliciaPaletoH"] = {
		_config = { gtype={"rent"},permissions={"tooglen.perm"} },
		["policiahelinorte"] = { "Helicóptero",0,0,-1 }
	},
	["Paramedico"] = {
		_config = { gtype={"rent"},permissions={"paramedico.permissao"} },
		["ambulance"] = { "Ambulância",0,0,-1 },
		["paramedicocharger2014"] = { "Dodge Charger 2014",0,0,-1 }
	},
	["ParamedicoH"] = {
		_config = { gtype={"rent"},permissions={"paramedico.permissao"} },
		["paramedicoheli"] = { "Helicóptero",0,0,-1 }
	},
	["Mecanico"] = {
		_config = { gtype={"rent"},permissions={"mecanico.permissao"} },
		["flatbed"] = { "Reboque",0,0,-1 },
		["slamvan3"] = { "Pick Up",0,0,-1 }
	},
	["NewsH"] = {
		_config = { gtype={"rent"},permissions={"news.permissao"} },
		["newsheli"] = { "Heli News",0,0,-1 },
		["newsheli2"] = { "Heli News 2",0,0,-1 }
	},
	["News"] = {
		_config = { gtype={"rent"},permissions={"news.permissao"} },
		["newsvan"] = { "Van News",0,0,-1 }
	},
	["Taxista"] = {
		_config = { gtype={"rent"},permissions={"taxista.permissao"} },
		["taxi"] = { "Taxi",0,0,-1 }
	},
	["Carteiro"] = {
		_config = { gtype={"rent"} },
		["boxville2"] = { "Caminhão",0,0,-1 },
		["tribike3"] = { "Bicicleta",0,0,-1 }
	},
	["Lixeiro"] = {
		_config = { gtype={"rent"} },
		["trash"] = { "Caminhão 01",0,0,-1 },
		["trash2"] = { "Caminhão 02",0,0,-1 }
	},
	["Bicicletario"] = {
		_config = { gtype={"rent"} },
		["scorcher"] = { "Scorcher",0,0,-1 },
		["tribike"] = { "Tribike Verde",0,0,-1 },
		["tribike2"] = { "Tribike Vermelha",0,0,-1 },
		["fixter"] = { "Fixter",0,0,-1 },
		["cruiser"] = { "Cruiser",0,0,-1 },
		["bmx"] = { "Bmx",0,0,-1 }
	},
	["Embarcacoes"] = {
		_config = { gtype={"rent"} },
		["dinghy"] = { "dinghy",0,0,-1 },
		["jetmax"] = { "jetmax",0,0,-1 },
		["marquis"] = { "marquis",0,0,-1 },
		["seashark3"] = { "seashark3",0,0,-1 },
		["speeder"] = { "speeder",0,0,-1 },
		["speeder2"] = { "speeder2",0,0,-1 },
		["squalo"] = { "squalo",0,0,-1 },
		["suntrap"] = { "suntrap",0,0,-1 },
		["toro"] = { "toro",0,0,-1 },
		["toro2"] = { "toro2",0,0,-1 },
		["tropic"] = { "tropic",0,0,-1 },
		["tropic2"] = { "tropic2",0,0,-1 }
	},
	["Caminhao"] = {
		_config = { gtype={"rent"} },
		["phantom"] = { "caminhão 01",0,0,-1 },
		["packer"] = { "caminhão 02",0,0,-1 }
	},
	["Bike"] = {
		_config = { gtype={"rent"} },
		["bmx"] = { "bmx",350,22,-1 },
		["cruiser"] = { "cruiser",270,15,-1 },
		["fixter"] = { "fixter",370,25,-1 },
		["scorcher"] = { "scorcher",570,10,-1 },
		["tribike"] = { "tribike",770,25,-1 },
        ["tribike"] = { "tribike2",770,25,-1 },
		["tribike"] = { "tribike3",770,25,-1 },
	},
	["Vendedor"] = {
		_config = { gtype={"rent"},permissions={"conce.permissao"} },
		["ferrariitalia"] = { "ferrari italia",0,0,-1 },
		["paganihuayra"] = { "pagani huayra",0,0,-1 },
		["fordmustang"] = { "ford mustang",0,0,-1 },
		["fordmustanggt"] = { "ford mustang gt",0,0,-1 },
		["nissangtr"] = { "nissan gtr",0,0,-1 },
		["nissangtrnismo"] = { "nissan gtr nismo",0,0,-1 },
		["teslaprior"] = { "tesla prior",0,0,-1 },
		["nissanskyliner34"] = { "skyline r34",0,0,-1 },
		["audirs6"] = { "audi rs6",0,0,-1 },
		["bmwm3f80"] = { "bmw m3 f80",0,0,-1 },
		["bmwm4gts"] = { "bmw m4 gts",0,0,-1 },
		["lancerevolutionx"] = { "lancer evolution x",0,0,-1 },
		["mercedesamgc63"] = { "mercedes amg c63",0,0,-1 },
		["toyotasupra"] = { "toyota supra",0,0,-1 },
		["nissan370z"] = { "nissan 370z",0,0,-1 },
		["lamborghinihuracan"] = { "lamborghini huracan",0,0,-1 },
		["dodgechargersrt"] = { "dodge charger srt",0,0,-1 },
		["mazdarx7"] = { "mazda rx7",0,0,-1 }
	},
	["Bennys"] = {
		_config = { gtype={"shop"},permissions={"mecanico.permissao"} },
		_shop = {
			[0] = { "Aerofolio",0,"" },
			[1] = { "Saia Frontal",0,"" },
			[2] = { "Saia Traseira",0,"" },
			[3] = { "Saia",0,"" },
			[4] = { "Escapamento",0,"" },
			[5] = { "Interior",0,"" },
			[6] = { "Grades",0,"" },
			[7] = { "Capo",0,"" },
			[8] = { "Parachoque Direito",0,"" },
			[9] = { "Parachoque Esquerdo",0,"" },
			[10] = { "Tetos",0,"" },
--			[11] = { "Motor",0,"" },
--			[12] = { "Freios",0,"" },
--			[13] = { "Transmissao",0,"" },
			[14] = { "Buzina",0,"" },
			[15] = { "Suspensao",0,"" },
--			[16] = { "Blindagem",0,"" },
--			[18] = { "Turbo",0,"" },
			[20] = { "Fumaca",0,"" },
			[22] = { "Farois",0,"" },
			[23] = { "Rodas",0,"" },
			[24] = { "Rodas Traseiras",0,"" },
			[25] = { "Suporte de Placa",0,"" },
			[27] = { "Trims",0,"" },
			[28] = { "Enfeites",0,"" },
			[29] = { "Painel",0,"" },
			[30] = { "Lanterna",0,"" },
			[31] = { "Macaneta",0,"" },
			[32] = { "Bancos",0,"" },
			[33] = { "Volante",0,"" },
			[34] = { "H Shift",0,"" },
			[35] = { "Placas",0,"" },
			[36] = { "Caixa de Som",0,"" },
			[37] = { "Porta-Malas",0,"" },
			[38] = { "Hidraulica",0,"" },
			[39] = { "Placa de Motor",0,"" },
			[40] = { "Filtro de Ar",0,"" },
			[41] = { "Struts",0,"" },
			[42] = { "Capas",0,"" },
			[43] = { "Antenas",0,"" },
			[44] = { "Extra Trims",0,"" },
			[45] = { "Tanque",0,"" },
			[46] = { "Vidros",0,"" },
			[48] = { "Livery",0,"" },
			[49] = { "Tiras",0,"" }
		}
	}
}

cfg.garages = {
	{ "Bennys",-327.22,-144.47,39.05,false,0 },
	{ "Bennys",-323.03,-132.89,38.96,false,0 },
	{ "VIPS",-1609.23,-1040.89,-17.78,false,0 },
	{ "Pegasus",-700.43,-1401.55,5.49,false,0 },
	{ "Carros",-38.84,-1099.29,26.42,false,0 },
	{ "Motos",-43.23,-1097.60,26.42,false,0 },
	{ "News",-536.98,-887.10,25.18,false,80 },
	{ "NewsH",-582.14,-920.94,36.83,false,81 },
	{ "Importados",-47.82,-1095.89,26.42,false,0 },
	{ "Garagem",55.43,-876.19,30.66,true,1 },
	{ "Garagem",317.25,2623.14,44.46,true,2 },
	{ "Garagem",-773.34,5598.15,33.60,true,3 },
	{ "Garagem",275.23,-345.54,45.17,true,4 },
	{ "Garagem",596.40,90.65,93.12,true,5 },
	{ "Garagem",-340.76,265.97,85.67,true,6 },
	{ "Garagem",-2030.01,-465.97,11.60,true,7 },
	{ "Garagem",-1184.92,-1510.00,4.64,true,8 },
	{ "Garagem",-73.44,-2004.99,18.27,true,9 },
	{ "Garagem",214.02,-808.44,31.01,true,10 },
	{ "Garagem",-348.88,-874.02,31.31,true,11 },
	{ "Garagem",67.74,12.27,69.21,true,12 },
	{ "Garagem",361.90,297.81,103.88,true,13 },
	{ "Garagem2",84.98,-1967.35,20.75,true,72 },
	{ "Garagem3",-215.9,-1691.76,34.01,true,73 },
	{ "Garagem4",-219.46,-1310.89,31.3,true,74 },
	{ "Garagem5",854.66,-2113.56,31.58,true,75 },
	{ "Garagem6",-2671.79,1312.53,147.45,true,76 },
	{ "Garagem7",-75.02,6255.54,31.08,true,79 },
	{ "Garagem8",-949.90,-1467.24,6.80,true,82 },
	{ "Garagem9",337.61,-2035.82,21.37,true,83 },
	{ "HeliPonto",-696.86,-1423.62,5.00,true,84 },
	{ "Policia",458.33,-1008.09,28.27,false,14 },
	{ "Policia",1851.23,3683.34,34.26,false,15 },
	{ "PoliciaPaleto",-450.03,6003.54,31.49,false,77 },
	{ "PoliciaPaletoH",-451.36,5984.91,31.36,false,78 },
	{ "Paramedico",295.12,-600.61,43.30,false,17 },
	{ "Paramedico",1815.96,3678.71,34.27,false,18 },
	{ "Paramedico",-248.14,6332.97,32.42,false,19 },
	{ "Mecanico",-368.63,-101.57,39.54,false,20 },
	{ "Taxista",895.36,-179.28,74.70,false,21 },
	{ "Carteiro",68.95,126.94,79.20,false,22 },
	{ "Lixeiro",-341.58,-1567.46,25.22,false,23 },
	{ "Motorista",453.89,-600.57,28.58,false,24 },
	{ "Bicicletario",-1177.82,-1564.45,4.47,false,25 },
	{ "Bicicletario",-896.17,-781.21,15.91,false,26 },
	{ "Bicicletario",-250.727,-1529.59,31.58,false,27 },
	{ "Embarcacoes",-1605.19,-1164.37,1.28,false,28 },
	{ "Embarcacoes",-1522.68,1494.92,111.58,false,29 },
	{ "Embarcacoes",1337.36,4269.71,31.50,false,30 },
	{ "Embarcacoes",-192.32,791.54,198.10,false,31 },
	{ "Bulbasaur",-789.45,307.83,85.70,false,32 },
	{ "Ivysaur",164.79,-575.29,43.86,false,33 },
	{ "Venusaur",-1299.98,-410.16,35.75,false,34 },
	{ "Squirtle",-1437.50,-545.39,34.74,false,35 },
	{ "Blastoise",-927.69,-393.46,38.96,false,36 },
	{ "Metapod",-337.06,207.71,88.57,false,37 },
	{ "Clefairy",1401.35,1114.99,114.83,false,38 },
	{ "Clefable",-1149.42,-1535.88,4.35,false,39 },
	{ "Vulpix",-809.62,189.91,72.47,false,40 },
	{ "Ninetales",-188.88,500.52,134.64,false,41 },
	{ "Jigglypuff",350.45,438.48,147.47,false,42 },
	{ "Wigglytuff",391.12,428.44,144.10,false,43 },
	{ "Zubat",-682.91,601.79,143.66,false,44 },
	{ "Golbat",-755.32,627.34,142.76,false,45 },
	{ "Oddish",-865.31,696.79,149.00,false,46 },
	{ "Gloom",131.63,565.70,183.87,false,47 },
	{ "Vileplume",-1323.06,445.33,99.80,false,48 },
	{ "Machoke",-1492.95,421.42,111.24,false,49 },
	{ "Machamp",-1405.56,540.03,122.92,false,50 },
	{ "Bellsprout",-1365.74,603.67,133.87,false,51 },
	{ "Weepinbell",-963.26,761.97,175.46,false,52 },
	{ "Victreebel",-440.65,684.42,153.06,false,53 },
	{ "Tentacool",1290.13,-585.26,71.74,false,54 },
	{ "Tentacruel",1311.15,-592.49,72.92,false,55 },
	{ "Geodude",1344.92,-609.22,74.35,false,56 },
	{ "Graveler",1359.97,-620.09,74.33,false,57 },
	{ "Golem",1392.43,-607.50,74.33,false,58 },
	{ "Ponyta",1404.30,-570.85,74.34,false,59 },
	{ "Rapidash",1366.80,-544.94,74.33,false,60 },
	{ "Slowpoke",1360.39,-537.19,73.77,false,61 },
	{ "Slowbro",1321.85,-525.14,72.12,false,62 },
	{ "Magnemite",1314.76,-516.79,71.39,false,63 },
	{ "Magneton",-23.59,-1427.51,30.65,false,64 },
	{ "Doduo",24.41,541.41,176.02,false,65 },
	{ "Caminhao",1196.80,-3253.68,7.09,false,66 },
	{ "PoliciaH",463.24,-982.53,43.69,false,67 },
	{ "ParamedicoH",338.37,-586.76,74.16,false,68 },
	{ "PoliciaB",473.06,-1019.21,28.10,false,69 },
	{ "Vendedor",-26.69,-1089.85,26.42,false,70 },
	{ "Bike",-1031.80,-2729.61,13.75,false,71 }
}

return cfg