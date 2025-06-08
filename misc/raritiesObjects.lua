--Concepts in Shop

SMODS.ObjectType {
    key = 'conceptsInPacks',
    cards = {
        ["j_ocj_Rust"] = true,
		["j_ocj_skye"] = true,
		["j_ocj_aethercard"] = true



    },
}

SMODS.ObjectType {
    key = 'conceptsInShops',
    cards = {
        ["j_ocj_Rust"] = true,



    },
}


--RARITY
con = { -- list for variables that each joker of the 'concept' rarity will use to define if they can be in the shop.
    aeth = false,
    skye = false,
    rust = true,
    tooth = false,

}

local conceptRad = SMODS.Gradient {
	key = 'conceptr',
	colours = {
		HEX("a37d1d"),
		HEX('a31d96'),
		HEX('3fd1cf'),
		G.C.RED

	},
	cycle = 15,
	interpolation = 'trig'

}

SMODS.Rarity {
	key = 'concept',
	loc_txt = {
		name = 'Concept'
	},

	badge_colour = conceptRad,
	default_weight = 100

}

SMODS.Rarity {
	key = 'faux_legendary',
	loc_txt = {
		name = 'Concept'

	}

}


--CHOOSING A RANDOM CONCEPT 
cc = {}
cc.conPacks = {
	prej .. "Rust",
	prej .. "skye",
	prej .. "aethercard"
}

--[[what the fuck is eveb happening here. 
fuck you cmt]]--
cc.randomCon = function()
	local owned = {}
	for k,v in ipairs(G.jokers.cards) do
		owned[#owned + 1] = v.config.center_key
	end
	local possible = {}
	local key1 = 1
	for k,v in ipairs(cc.conPacks) do
		print(owned)
		print(v)
		if glf.findstring(v, owned) == true then
			
		else
			possible[#possible + 1] = v
		end
	end
	if #possible ~= 0 then
		print(possible)
		local i = math.random(1, #possible)

		local conceptChose = possible[i]
		return conceptChose
	else
		return "j_ocj_Rust"
	end
end