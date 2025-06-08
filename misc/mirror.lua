SMODS.Atlas {
    key = 'mirror_card',
    path = 'mirror.png',
    px = 76,
    py = 95


}

SMODS.Enhancement {
    key = 'mirror',
    atlas = 'mirror_card',
    pos = {x=0,y=0},
    config = {
        x_chips = 1.5,
        extra = {
            odds = 16,
            destroying = false
        } 
    },
    loc_vars = function(self, info_queue, card)
        return {
            vars = {
                card.ability.extra.odds,
                card.ability.x_chips

            }

        }
    end,
    calculate = function(self,card,context)
        if context.main_scoring and context.cardarea == G.play and pseudorandom('mirror') < G.GAME.probabilities.normal / card.ability.extra.odds then
            card.ability.extra.destroying = true
        end
        if context.destroy_card and context.destroy_card == card and card.ability.extra.destroying == true then
            return {remove = true}
        end
    end

}