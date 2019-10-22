local cfg = {}

cfg.groups = {
	["dev"] = {
		"admin.permissao",
		"dev.permissao",
		"mod.permissao",
		"wl.permissao",
		"apreender.veiculo"
	},
	["admin3"] = {
		"admin.permissao",
		"mod.permissao",
		"wl.permissao",
		"apreender.veiculo"
	},
	["mod"] = {
		"mod.permissao",
		"wl.permissao",
		"apreender.veiculo"
	},
	["suporte"] = {
		"wl.permissao",
		"apreender.veiculo"
	},
    ["conce"] = {
		"conce.permissao"
	},
	["ComandoPolicia"] = {
		_config = {
			title = "ComandoPolicia",
			gtype = "job"
		},
		"comando.permissao",
		"policia.permissao",
		"polpar.permissao",
		"pm.cloakroom",
		"apreender.veiculo"
	},
	["Policia"] = {
		_config = {
			title = "Policia",
			gtype = "job"
		},
		"policia.permissao",
		"polpar.permissao",
		"pm.cloakroom",
		"toogle.perm",
		"apreender.veiculo"
	},
	["PoliciaNorte"] = {
		_config = {
			title = "PoliciaNorte",
			gtype = "job"
		},
		"policia.permissao",
		"polpar.permissao",
		"pm.cloakroom",
		"caixinha.norte",
		"tooglen.perm",
		"apreender.veiculo"
	},
	["DiretorParamedico"] = {
		_config = {
			title = "DiretorParamedico",
			gtype = "job"
		},
		"paramedico.permissao",
		"polpar.permissao",
		"diretor.permissao"
	},
	["Paramedico"] = {
		_config = {
			title = "Paramedico",
			gtype = "job"
		},
		"paramedico.permissao",
		"polpar.permissao"
	},
	["PaisanaPolicia"] = {
		_config = {
			title = "PaisanaPolicia",
			gtype = "job"
		},
		"paisanapolicia.permissao"
	},
	["PaisanaPoliciaN"] = {
		_config = {
			title = "PaisanaPolicia",
			gtype = "job"
		},
		"paisanapolician.permissao"
	},
	["PaisanaPoliciaComando"] = {
		_config = {
			title = "PaisanaPolicia",
			gtype = "job"
		},
		"paisanapoliciacomando.permissao"
	},
	["PaisanaParamedico"] = {
		_config = {
			title = "PaisanaParamedico",
			gtype = "job"
		},
		"paisanaparamedico.permissao"
	},
	["Mecanico"] = {
		_config = {
			title = "Mecanico",
			gtype = "job"
		},
		"mecanico.permissao"
	},
	["PaisanaMecanico"] = {
		_config = {
			title = "PaisanaMecanico",
			gtype = "job"
		},
		"paisanamecanico.permissao"
	},
	["RoyaleNews"] = {
		_config = {
			title = "Jornalista",
			gtype = "job"
		},
		"news.permissao"
	},	
	["Judiciario"] = {
		_config = {
			title = "Judiciario",
			gtype = "job"
		},
		"judiciario.permissao"
	},		
	["Taxista"] = {
		_config = {
			title = "Taxista",
			gtype = "job"
		},
		"taxista.permissao"
	},
	["PaisanaTaxista"] = {
		_config = {
			title = "PaisanaTaxista",
			gtype = "job"
		},
		"paisanataxista.permissao"
	},
	["Alertas"] = {
		_config = {
			title = "Alertas"
		},
		"alertas.permissao"
	},
	["Bronze"] = {
		_config = {
			title = "Bronze"
		},
		"bronze.permissao"
	},
	["Prata"] = {
		_config = {
			title = "Prata"
		},
		"prata.permissao"
	},
	["Ouro"] = {
		_config = {
			title = "Ouro"
		},
		"ouro.permissao",
		"mochila.permissao"
	},
	["Platina"] = {
		_config = {
			title = "Platina"
		},
		"platina.permissao",
		"mochila.permissao"
	},
	["Motoclub"] = {
		_config = {
			title = "Motoclub",
			gtype = "job"
		},
		"motoclub.permissao"
	},
	["Trafico"] = {
		_config = {
			title = "Trafico",
			gtype = "job"
		},
		"trafico.permissao",
		"entrada.permissao"
	},
	["Cartel"] = {
		_config = {
			title = "Cartel",
			gtype = "job"
		},
		"cartel.permissao"
	},
	["Yakuza"] = {
		_config = {
			title = "Yakuza",
			gtype = "job"
		},
		"yakuza.permissao"
	},
	["Bennys"] = {
		_config = {
			title = "Bennys",
			gtype = "job"
		},
		"tuning.permissao"
	},
	["Tequilala"] = {
		_config = {
			title = "Tequilala",
			gtype = "job"
		},
		"tequilala.permissao"
	},
	["Roxos"] = {
		_config = {
			title = "Roxos",
			gtype = "job"
		},
		"trafico.permissao",
		"maconha.permissao"
	},
	["Verdes"] = {
		_config = {
			title = "Verdes",
			gtype = "job"
		},
		"trafico.permissao",
		"meta.permissao"
	},
	["Amarelos"] = {
		_config = {
			title = "Amarelos",
			gtype = "job"
		},
		"trafico.permissao",
		"coca.permissao"
	},
	["Mafia"] = {
		_config = {
			title = "Mafia",
			gtype = "job"
		},
		"mafia.permissao"
	}
}

cfg.users = {
	[1] = { "admin3" }
}

cfg.selectors = {}

return cfg