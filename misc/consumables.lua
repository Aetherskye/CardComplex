SMODS.Consumable {
    key = 'science',
    set = 'Tarot',
    config = {max_highlighted = 1, mod_conv = 'm_ocj_mirror'},
    loc_vars = function(self, info_queue,card)
        info_queue[#info_queue + 1] = G.P_CENTERS[card.ability.mod_conv]
        return {vars = {card.ability.max_highlighted}}
    end


}