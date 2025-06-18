SMODS.Atlas {
    key = 'mirror_card',
    path = 'mirror.png',
    px = 76,
    py = 95


}
mi = {}
mi.Odds = 1 
mi.Odds2 = 16
SMODS.Enhancement {
    key = 'mirror',
    atlas = 'mirror_card',
    pos = {x=0,y=0},
    config = {
        x_chips = 1.5,
        extra = {
            destroying = false,
        } 
    },
    loc_vars = function(self, info_queue, card)
        return {
            vars = {
                mi.Odds2,
                card.ability.x_chips,
                mi.Odds

            }

        }
    end,
    calculate = function(self,card,context)
        if context.main_scoring and context.cardarea == G.play and pseudorandom('mirror') < mi.Odds / mi.Odds2 then
            card.ability.extra.destroying = true
        end
        if context.destroy_card and context.destroy_card == card and card.ability.extra.destroying == true then
            return {remove = true}
        end
    end

}