SMODS.Atlas  {
    key = '2ethera',
    path = 'Toother.png',
    px = 71,
    py = 95
}

SMODS.Joker {
    key = '2ether',
    pos = {x=0,y=0},
    soul_pos = {x=1,y=0},
    atlas = '2ethera',
    rarity = 1,
    cost = 50,
    config = { extra ={
        cardRetriggers = 2,
        cardMult = 2,
        cardChips = 22,
        cardUltBonus = 2,
        type = 'Three of a Kind'

    }},
    loc_vars = function(self, info_queue, card)
        return { vars = {
            card.ability.extra.cardRetriggers, 
            card.ability.extra.cardMult, 
            card.ability.extra.cardChips,
            card.ability.extra.cardUltBonus
        }}
    end,
    calculate = function(self,card,context)
        if context.repetition and context.cardarea == G.play then
            if context.other_card:get_id() == 2 then
                return {repetitions = card.ability.extra.cardRetriggers}
            end

        end
        if context.individual and context.cardarea == G.play then
            if context.other_card:get_id() == 2 then
                return {
                    mult = card.ability.extra.cardMult,
                    chips = card.ability.extra.cardChips
                }
            end
        end
        if context.joker_main and next(context.poker_hands['Three of a Kind']) then
            local bonus = true
            print(context.poker_hands)
            for k,v in pairs(G.play.cards) do
                if v:get_id() ~= 2 then
                    bonus = false
                end
            end
            if bonus == true then
                return {ee_mult = 2} 
            else
                return
            end
        end
    end
}

