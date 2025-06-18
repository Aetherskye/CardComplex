ca = {}

SMODS.Atlas {
    key = 'caliart',
    path = 'caligatus2.png',
    px = 71,
    py = 95

}
-- the code in here is jank af I need to revise it.
SMODS.Joker {
    key = 'caligatus',
    rarity = 3,
    config = {
        extra = {
            odd1 = 8,
            odd2 = 16,
            redo = 0
        }
    },
    atlas = 'caliart',
    pos = {x=0,y=0},
    loc_vars = function(self,info_queue,card)
        return {vars = {
            card.ability.extra.odd1,
            card.ability.extra.odd2
        }}
    end,
    add_to_deck = function(self,card, from_debuff)
        mi.Odds = card.ability.extra.odd1
    end,
    remove_from_deck = function(self, card, from_debuff)
        mi.Odds = 1
    end,
    calculate = function(self,card,context)
        if context.repetition and context.cardarea == G.play and SMODS.has_enhancement(context.other_card, 'm_ocj_mirror') then

            --Hardcode in Oops all 6s functionality. It's not good but im old -Red
            local mirror = context.other_card
            local break50 = 1
            local pityreach = pseudorandom('cali', 25, 45)
            
            repeat
                
                print(card.ability.extra.redo)
                break50 = pseudorandom('mirrored', 1,2)
                if break50 == 1 then
                    card.ability.extra.redo = card.ability.extra.redo + 1
                end
                print(break50)
                pityreach = pityreach + 1
            until break50 == 2 or pityreach > 50
            mirror.ability.extra.destroying = true
            print(mirror.ability.extra.destroying)
            return {repetitions = card.ability.extra.redo}
        end
    end

}


SMODS.Joker {
    key = 'caligatus2',
    
    atlas = 'caliart',
    pos = {x=1,y=0},
    soul_pos = {x=4,y=1},
    config = {
        extra = {
            odd1 = 4,
            odd2 = 16,
            redo = 0,
            mirrorChips = 2
        }
    },
    rarity = "ocj_concept",
    loc_vars = function(self,info_queue,card)
        return {vars = {
            card.ability.extra.odd1,
            card.ability.extra.odd2
        }}
    end,
    add_to_deck = function(self,card, from_debuff)
        mi.Odds = card.ability.extra.odd1
        local caliloc
        for k,v in ipairs(G.jokers.cards) do
            if v.config.center_key == 'j_ocj_caligatus' then
                caliloc = k
            else
                caliloc = nil
            end
        end
        if caliloc ~= nil then
            G.jokers.cards[caliloc]:start_dissolve()
        end
    end,
    remove_from_deck = function(self, card, from_debuff)
        mi.Odds = 1
    end,
    in_pool = function(self,args) -- Temp obtainment method. will be changed once cmt is added
        if SMODS.find_card('j_ocj_caligatus', false) then
            return true
        else
            return false
        end
    end,
    calculate = function(self,card,context)
        if context.repetition and context.cardarea == G.play and SMODS.has_enhancement(context.other_card, 'm_ocj_mirror') then

            --Hardcode in Oops all 6s functionality. It's not good but im old -Red
            local mirror = context.other_card
            local break50 = 1
            local pityreach = pseudorandom('cali', 25, 45)
            
            repeat
                
                print(card.ability.extra.redo)
                break50 = pseudorandom('mirrored', 1,2)
                if break50 == 1 then
                    card.ability.extra.redo = card.ability.extra.redo + 1
                end
                print(break50)
                pityreach = pityreach + 1
            until break50 == 2 or pityreach > 50
            mirror.ability.extra.destroying = true
            print(mirror.ability.extra.destroying)
            return {repetitions = card.ability.extra.redo}
        end
        if context.individual and context.cardarea == G.play and SMODS.has_enhancement(context.other_card, 'm_ocj_mirror') then
            local mirror = context.other_card

            mirror.ability.x_chips = card.ability.extra.mirrorChips
        end
    end

}