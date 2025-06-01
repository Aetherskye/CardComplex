--BIG THANKS TO N FOR LETTING ME REFERENCE HIS CODE!!

--[[
Seems like I don't understand this enitrely, 
Jokers/UI.lua; attempt to index 'area' (A Nil Value)

Maybe ask N' for a few clairifications on what certain parts of codes mean.
I think I'm starting to understand the nesting lists/objects now.
]]--
AEUI = {}
function skyeTest()
    print("success")
    
end
AEUI.create_sell_and_use_buttons = function(card,args)
    local args = args or {}
    local use = nil
    local sell = nil
    if args.sell then
        sell = {
            n = G.UIT.C,
            config = {align = "cr"},
            nodes = {
                {
                n = G.UIT.C,
                config = { ref_table = card, align = "cr", padding = 0.1, r=0.08, minw = 1.25, minh = 0, hover = true, colour = G.C.UI.BACKGROUND_INACTIVE, one_press = true, button = 'sell_card', func = 'can_sell_card'},
                nodes = {
                    {n = G.UIT.B, config = {w=0.1,h=0.6}},
                    {
                        n = G.UIT.C,
                        config = { align = "tm"},
                        nodes = {
                            {
                        n = G.UIT.R,
                        config = {align = "cm", maxw = 1.25},
                        nodes = {
                            {n = G.UIT.T, config = {text = localize('b_sell'), colour = G.C.UI.TEXT_LIGHT, scale = 0.4, shadow = true}}
                        }
                        },
                        {
                        n = G.UIT.R,
                        config = {align = "cm"},
                        nodes = {
                            {n = G.UIT.T, config = {text = localize('$'), colour = G.C.WHITE, scale = 0.4, shadow = true}},
                            {n = G.UIT.T, config = {ref_table = card, ref_value = 'sell_cost_label', colour = G.C.WHITE, scale = 0.55, shadow = true}}
                         }

                        }


                        }

                    
                        
                    }

                }
                }



            }

        }
    end
    if args.use and card.facing ~= 'back' then
        use = {
            n = G.UIT.C,
            config = {align = "cr"},
            nodes = {
                --nodes should be nested deeper - N'! im goign to cry nvm Ns da best
                {
                n = G.UIT.C,
                config = { ref_table = card, align = "cr", maxw = 1.25, padding = 0.1, r = 0.08, minw = 1.25, minh = 0, hover = true, shadow = true, colour = G.C.GREEN, one_press = true, button = 'ocj_can_use'},
                nodes = {
                    {n = G.UIT.B, config = {w = 0.1, h = 0.6}},
                    {n = G.UIT.T, config = { text = localize('b_use'), colour = G.C.WHITE, scale = 0.55, shadow = true}}

                }
            }
            } 
        }
    end
    return {
        n = G.UIT.ROOT,
        config = {
            align = "cr",
            padding = 0,
            colour = G.C.CLEAR
        },
        nodes = {
            { n = G.UIT.C,
            config = { 
                padding = 0, align = 'cl'
                },
            nodes = {
                use and {
                    n = G.UIT.R,
                    config = {align = 'cl'},
                    nodes = {use}
                    } or nil,
                sell and {
                    n = G.UIT.R,
                    config = { align = 'cl'},
                    nodes = {sell}
                }
                
                }
            }
        }
    }

end
-- cassandra/deja try codign (fails horribly) (sorry artist)
local card_highlight_ref = Card.highlight
function Card:highlight(is_highlighted)
    local ret = card_highlight_ref(self, is_highlighted)
    
    self.highlighted = is_highlighted
    
    if self.label == 'j_ocj_skye' then
         if self.children.use_button then
            self.children.use_button:remove()
            self.children.use_button = nil
        end
        self.children.use_button = UIBox{
            definition = AEUI.create_sell_and_use_buttons(self, {use=true, sell = true}),
            config = {
                align = "cr",
                offset = {x=-0.4,y=0},
                parent = self
           }

        }
    end
   
    return ret
    

end