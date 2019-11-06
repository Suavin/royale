local cfg = {}

cfg.items = {
	["OAB"] = { "OAB",0.03 },
	["pills"] = { "Pirulas",0.1 },
	["bandagem"] = { "Bandagem",0.7 },
	["ferramenta"] = { "Ferramenta",3 },
	----------------------------------------------
	["encomenda"] = { "Encomenda",1.5 },
	["sacodelixo"] = { "Saco de Lixo",2 },
	["garrafadeleite"] = { "Garrafa de Leite",0.5 },
	["tora"] = { "Tora de Madeira",0.6 },
	["orgao"] = { "Órgão",1.2 },
	----------------------------------------------
	["isca"] = { "Isca",0.6 },
	["camarao"] = { "Camarãozinho",0.5 },
	["mochila"] = { "Mochila",1 },
	["garrafavazia"] = { "Garrafa Vazia",0.2 },
	["roupas"] = { "Roupas",1.5 },
	["alianca"] = { "Aliança",0 },
	["cerveja"] = { "Cerveja",0.7 },
	["tequila"] = { "Tequila",0.7 },
	["vodka"] = { "Vodka",0.7 },
	["whisky"] = { "Whisky",0.7 },
	["conhaque"] = { "Conhaque",0.7 },
	["absinto"] = { "Absinto",0.7 },
	["militec"] = { "Oléo de Motor",5.0 },
	["repairkit"] = { "Kit de Reparos",10 },
	----------------------------------------------
	["dinheirosujo"] = { "Dinheiro Sujo",0 },
	["pack"] = { "Pack de Drogas",1.5 },
	["algemas"] = { "Algemas",1 },
	["capuz"] = { "Capuz",0.5 },
	["colete"] = { "Colete",5 },
	["alicate"] = { "Alicate",1.5 },
	["lockpick"] = { "Lockpick",10 },
	["masterpick"] = { "Masterpick",10 },
	["placa"] = { "Placa",0.8 },
	["rebite"] = { "Rebite",0.8 },
	["pendrive"] = { "Pendrive",0.1 },
	["energetico"] = { "Energético",0.3 },
	-----------------------------------------------
	["etiqueta"] = { "Etiqueta",0 },
	["carnedecormorao"] = { "Carne de Cormorão",1.7 },
	["carnedecorvo"] = { "Carne de Corvo",1.7 },
	["carnedeaguia"] = { "Carne de Águia",1.8 },
	["carnedecervo"] = { "Carne de Cervo",1.9 },
	["carnedecoelho"] = { "Carne de Coelho",1.7 },
	["carnedecoyote"] = { "Carne de Coyote",2 },
	["carnedelobo"] = { "Carne de Lobo",2 },
	["carnedepuma"] = { "Carne de Puma",2.3 },
	["carnedejavali"] = { "Carne de Javali",2.4 },
	----------------------------------------------
	["dourado"] = { "Dourado",15 },
	["corvina"] = { "Corvina",3 },
	["salmao"] = { "Salmão",4 },
	["pacu"] = { "Pacu",1.5 },
	["pintado"] = { "Pintado",2 },
	["pirarucu"] = { "Pirarucu",5 },
	["tilapia"] = { "Tilápia",1.5 },
	["tucunare"] = { "Tucunaré",5 },
	["lambari"] = { "Lambari",0.5 },
	----------------------------------------------
	["atum"] = { "Atum",15 },
	["espada"] = { "Peixe Espada",8 },
	["xareu"] = { "Xareu",3 },
	["tubarao"] = { "Tubarão",15 },
	["bicuda"] = { "Bicuda",2 },
	["marlim"] = { "Marlim Azul",5 },
	["tainha"] = { "Tainha",5 },
	["pampo"] = { "Pampo",0.5 },
	["nero"] = { "Peixe Nero",50 },
	----------------------------------------------
	["toclonecards"] = { "Cartão",0.25 },
    ["clonedcards"] = { "Cartão Clonado",0.35 },
	----------------------------------------------
	["adubo"] = { "Adubo",0.8 },
	["fertilizante"] = { "Fertilizante",0.8 },
	["maconha"] = { "Maconha",0.5 },
	----------------------------------------------
	["reagentesdemeta"] = { "Reagentes De Metanfetamina",0.8 },
	["preparodemeta"] = { "Preparo De Metanfetamina",0.8 },
	["metanfetamina"] = { "Metanfetamina",0.5 },
	--------------------------------
	["reagentesdecoca"] = { "Reagentes De Cocaina",0.8 },
	["preparodecoca"] = { "Preparo De Cocaina",0.8 },
	["cocaina"] = { "Cocaina",0.5 },
	----------------------------------------------
	["capsula"] = { "Cápsula",0.01 },
	["polvora"] = { "Pólvora",0.005 },
	["ferro"] = { "Ferro",0.01 },
	["carbono"] = { "Carbono",0.01 },
	["aco"] = { "Aço",0.005 },
	----------------------------------------------
	["relogioroubado"] = { "Relógio Roubado",0.3 },
	["pulseiraroubada"] = { "Pulseira Roubada",0.2 },
	["anelroubado"] = { "Anel Roubado",0.2 },
	["diamante"] = { "Diamante",0.3 },
	["colarroubado"] = { "Colar Roubado",0.2 },
	["brincoroubado"] = { "Brinco Roubado",0.2 },
	["carteiraroubada"] = { "Carteira Roubada",0.2 },
	["carregadorroubado"] = { "Carregador Roubado",0.2 },
	["tabletroubado"] = { "Tablet Roubado",0.2 },
	["sapatosroubado"] = { "Sapatos Roubado",0.2 },
	["vibradorroubado"] = { "Vibrador Roubado",0.2 },
	["perfumeroubado"] = { "Perfume Roubado",0.2 },
	["maquiagemroubada"] = { "Maquiagem Roubada",0.2 }
}

local function load_item_pack(name)
	local items = module("cfg/item/"..name)
	if items then
		for k,v in pairs(items) do
			cfg.items[k] = v
		end
	end
end

load_item_pack("armamentos")

return cfg