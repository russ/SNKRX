BuyScreen = Object:extend()
BuyScreen:implement(State)
BuyScreen:implement(GameObject)
function BuyScreen:init(name)
  self:init_state(name)
  self:init_game_object()
end


function BuyScreen:on_exit()
  self.main:destroy()
  self.effects:destroy()
  self.ui:destroy()
  self.t:destroy()
  self.main = nil
  self.effects = nil
  self.ui = nil
  self.shop_text = nil
  self.party_text = nil
  self.sets_text = nil
  self.items_text = nil
  self.ng_text = nil
  self.level_text = nil
  self.characters = nil
  self.sets = nil
  self.cards = nil
  self.info_text = nil
  unit_count_max = #self.units
  self.units = nil
  self.passives = nil
  self.player = nil
  self.t = nil
  self.springs = nil
  self.flashes = nil
  self.hfx = nil
  self.tutorial_button = nil
  self.restart_button = nil
  self.level_button = nil
  if self.ssyn_text then
    self.ssyn_text.dead = true
    self.ssyn_text = nil
  end
  if self.hsyn_text then
    self.hsyn_text.dead = true
    self.hsyn_text = nil
  end
  self.osyn_text = nil
  self.oversyns = nil
end


function BuyScreen:on_enter(from, level, loop, units, passives, shop_level, shop_xp)
  self.level = level
  self.loop = loop
  self.units = units
  self.passives = passives
  self.shop_level = shop_level
  self.shop_xp = shop_xp
  camera.x, camera.y = gw/2, gh/2
  max_units = math.clamp(7 + current_new_game_plus + self.loop, 7, 12)

  input:set_mouse_visible(true)

  -- steam.friends.setRichPresence('steam_display', '#StatusFull')
  -- steam.friends.setRichPresence('text', 'Shop - Level ' .. self.level)

  self.main = Group()
  self.effects = Group()
  self.ui = Group()
  self.tutorial = Group()

  self.locked = locked_state and locked_state.locked
  LockButton{group = self.main, x = 205, y = 18, parent = self}

  self:set_cards(self.shop_level, nil, true, from.name == 'arena')
  self:set_party_and_sets()
  self:set_items()

  self.shop_text = Text({{text = '[wavy_mid, fg]shop [fg]- gold: [yellow]' .. gold, font = pixul_font, alignment = 'center'}}, global_text_tags)
  self.party_text = Text({{text = '[wavy_mid, fg]party ' .. tostring(#units) .. '/' .. tostring(max_units), font = pixul_font, alignment = 'center'}}, global_text_tags)
  self.sets_text = Text({{text = '[wavy_mid, fg]classes', font = pixul_font, alignment = 'center'}}, global_text_tags)
  self.osyn_textstate = 0
  self.sets_text.x = 310
  self.sets_text.y = 20
  self.items_text = Text({{text = '[wavy_mid, fg]items', font = pixul_font, alignment = 'center'}}, global_text_tags)
  self.ng_text = Text({{text = '[fg]NG+' .. current_new_game_plus, font = pixul_font, alignment = 'center'}}, global_text_tags)
  local get_elite_str = function(lvl)
    if cycle_level(self.level) % 6 == 0 or cycle_level(self.level) == 25 then return ' (elite)'
    elseif (lvl-(25*self.loop)) % 3 == 0 then return ' (hard)'
    else return '' end
  end
  self.level_text = Text({{text = '[fg]Lv.' .. tostring(self.level) .. get_elite_str(self.level), font = pixul_font, alignment = 'center'}}, global_text_tags)

  RerollButton{group = self.main, x = 150, y = 18, parent = self}
  GoButton{group = self.main, x = gw - 120, y = gh - 20, parent = self}
  LevelButton{group = self.main, x = gw/2, y = 18, parent = self}
  self.tutorial_button = Button{group = self.main, x = gw/2 + 129, y = 18, button_text = '?', fg_color = 'bg10', bg_color = 'bg', action = function()
    self.in_tutorial = true
    self.title_text = Text2{group = self.tutorial, x = gw/2, y = 35, lines = {{text = '[fg]WELCOME TO [wavy_crazyyy, red]SNKRX!', font = fat_font, alignment = 'center'}}}
    self.tutorial_text = Text2{group = self.tutorial, x = 228, y = 160, lines = {
      {text = '[fg]You control a snake of multiple heroes that auto-attack nearby enemies.', font = pixul_font, height_multiplier = 1.2},
      {text = '[fg]You can steer the snake left or right by pressing [yellow]A/D[fg] or [yellow]left/right arrows[fg].', font = pixul_font, height_multiplier = 2.2},
      {text = '[fg]Combine the same heroes to level them up:', font = pixul_font, height_multiplier = 1.2},
      {text = '[fg]At [yellow]Lv.3[fg] heroes unlock special effects.', font = pixul_font, height_multiplier = 2.2},
      {text = '[fg]Hire heroes of the same classes to unlock class passives:', font = pixul_font, height_multiplier = 1.2},
      {text = '[fg]Each hero can have between [yellow]1 to 3[fg] classes.', font = pixul_font, height_multiplier = 2.2},
      {text = '[fg]You gain [yellow]1 interest per 5 gold[fg], up to a maximum of 5.', font = pixul_font, height_multiplier = 1.2},
      {text = "[fg]This means that saving above [yellow]25 gold[fg] doesn't yield more interest.", font = pixul_font, height_multiplier = 2.2},
      {text = "[yellow, wavy_mid]Good luck!", font = pixul_font, height_multiplier = 2.2, alignment = 'center'},
    }}

    self.tutorial_cards = {}
    table.insert(self.tutorial_cards, TutorialCharacterPart{group = self.tutorial, x = gw/2 + 34, y = gh/2 - 30, character = 'swordsman', level = 1})
    table.insert(self.tutorial_cards, TutorialCharacterPart{group = self.tutorial, x = gw/2 + 54, y = gh/2 - 30, character = 'swordsman', level = 1})
    table.insert(self.tutorial_cards, TutorialCharacterPart{group = self.tutorial, x = gw/2 + 74, y = gh/2 - 30, character = 'swordsman', level = 1})
    table.insert(self.tutorial_cards, TutorialCharacterPart{group = self.tutorial, x = gw/2 + 34, y = gh/2 - 10, character = 'swordsman', level = 2})
    table.insert(self.tutorial_cards, TutorialCharacterPart{group = self.tutorial, x = gw/2 + 54, y = gh/2 - 10, character = 'swordsman', level = 2})
    table.insert(self.tutorial_cards, TutorialCharacterPart{group = self.tutorial, x = gw/2 + 74, y = gh/2 - 10, character = 'swordsman', level = 2})
    table.insert(self.tutorial_cards, TutorialCharacterPart{group = self.tutorial, x = gw/2 + 114, y = gh/2 - 30, character = 'swordsman', level = 2})
    table.insert(self.tutorial_cards, TutorialCharacterPart{group = self.tutorial, x = gw/2 + 114, y = gh/2 - 10, character = 'swordsman', level = 3})
    table.insert(self.tutorial_cards, TutorialClassIcon{group = self.tutorial, x = gw/2 + 114, y = gh/2 + 18, class = 'warrior', units = {}})
    table.insert(self.tutorial_cards, TutorialClassIcon{group = self.tutorial, x = gw/2 + 134, y = gh/2 + 18, class = 'warrior', units = {{character = 'swordsman'}, {character = 'barbarian'}, {character = 'juggernaut'}}})
    table.insert(self.tutorial_cards, TutorialClassIcon{group = self.tutorial, x = gw/2 + 154, y = gh/2 + 18, class = 'warrior', units = {{character = 'swordsman'}, {character = 'barbarian'}, {character = 'juggernaut'},
      {character = 'vagrant'}, {character = 'outlaw'}, {character = 'blade'}}
    })

    self.close_button = Button{group = self.tutorial, x = gw - 20, y = 20, button_text = 'x', bg_color = 'bg', fg_color = 'bg10', action = function()
      trigger:after(0.01, function()
        self:quit_tutorial()
      end)
    end}
  end, mouse_enter = function(b)
    b.info_text = InfoText{group = main.current.ui, force_update = true}
    b.info_text:activate({
      {text = '[fg]guide', font = pixul_font, alignment = 'center'},
    }, nil, nil, nil, nil, 16, 4, nil, 2)
    b.info_text.x, b.info_text.y = b.x, b.y + 20
  end, mouse_exit = function(b)
    if not b.info_text then return end
    b.info_text:deactivate()
    b.info_text.dead = true
    b.info_text = nil
  end}

  self.restart_button = Button{group = self.ui, x = gw/2 + 148, y = 18, force_update = true, button_text = 'R', fg_color = 'bg10', bg_color = 'bg', action = function(b)
    self.transitioning = true
    ui_transition2:play{pitch = random:float(0.95, 1.05), volume = 0.5}
    ui_switch2:play{pitch = random:float(0.95, 1.05), volume = 0.5}
    ui_switch1:play{pitch = random:float(0.95, 1.05), volume = 0.5}
    locked_state = nil
    TransitionEffect{group = main.transitions, x = gw/2, y = gh/2, color = state.dark_transitions and bg[-2] or fg[0], transition_action = function()
      slow_amount = 1
      music_slow_amount = 1
      run_time = 0
      gold = 3
      passives = {}
      main_song_instance:stop()
      run_passive_pool = {
        'centipede', 'ouroboros_technique_r', 'ouroboros_technique_l', 'amplify', 'resonance', 'ballista', 'call_of_the_void', 'crucio', 'speed_3', 'damage_4', 'shoot_5', 'death_6', 'lasting_7',
        'defensive_stance', 'offensive_stance', 'kinetic_bomb', 'porcupine_technique', 'last_stand', 'seeping', 'deceleration', 'annihilation', 'malediction', 'hextouch', 'whispers_of_doom',
        'tremor', 'heavy_impact', 'fracture', 'meat_shield', 'hive', 'baneling_burst', 'blunt_arrow', 'explosive_arrow', 'divine_machine_arrow', 'chronomancy', 'awakening', 'divine_punishment',
        'assassination', 'flying_daggers', 'ultimatum', 'magnify', 'echo_barrage', 'unleash', 'reinforce', 'payback', 'enchanted', 'freezing_field', 'burning_field', 'gravity_field', 'magnetism',
        'insurance', 'dividends', 'berserking', 'unwavering_stance', 'unrelenting_stance', 'blessing', 'haste', 'divine_barrage', 'orbitism', 'psyker_orbs', 'psychosink', 'rearm', 'taunt', 'construct_instability',
        'intimidation', 'vulnerability', 'temporal_chains', 'ceremonial_dagger', 'homing_barrage', 'critical_strike', 'noxious_strike', 'infesting_strike', 'burning_strike', 'lucky_strike', 'healing_strike', 'stunning_strike',
        'silencing_strike', 'culling_strike', 'lightning_strike', 'psycholeak', 'divine_blessing', 'hardening', 'kinetic_strike',
      }
      reset_syn_pow()
      reset_lateups()
      max_units = math.clamp(7 + current_new_game_plus, 7, 12)
      main:add(BuyScreen'buy_screen')
      system.save_run()
      main:go_to('buy_screen', 1, 0, {}, passives, 1, 0)
    end, text = Text({{text = '[wavy, ' .. tostring(state.dark_transitions and 'fg' or 'bg') .. ']restarting...', font = pixul_font, alignment = 'center'}}, global_text_tags)}
  end, mouse_enter = function(b)
    b.info_text = InfoText{group = main.current.ui, force_update = true}
    b.info_text:activate({
      {text = '[fg]restart run', font = pixul_font, alignment = 'center'},
    }, nil, nil, nil, nil, 16, 4, nil, 2)
    b.info_text.x, b.info_text.y = b.x, b.y + 20
  end, mouse_exit = function(b)
    if not b.info_text then return end
    b.info_text:deactivate()
    b.info_text.dead = true
    b.info_text = nil
  end}

  LateUpgradeButton{group = self.main, x = 296 - 18*0.9, y = 16, parent = self, type = 1}
  LateUpgradeButton{group = self.main, x = 296 + 18*2.5, y = 16, parent = self, type = 2}

  trigger:tween(1, main_song_instance, {volume = 0.2, pitch = 1}, math.linear)

  locked_state = {locked = self.locked, cards = {self.cards[1] and self.cards[1].unit, self.cards[2] and self.cards[2].unit, self.cards[3] and self.cards[3].unit}} 
  save_run_by_ref(self)
end

function info_text_die(info_text_ref)
  if info_text_ref then
    info_text_ref:deactivate()
    info_text_ref.dead = true
    info_text_ref = nil
  end
end

function BuyScreen:ssyn_text_die()
  info_text_die(self.ssyn_text)
end

function BuyScreen:hsyn_text_die()
  info_text_die(self.hsyn_text)
end

function BuyScreen:osyn_text_die()
  self:ssyn_text_die()
  self:hsyn_text_die()
  self.osyn_textstate = 0
end

function BuyScreen:getOversynList(oversyn_t)
  self.oversyns = {}
  for _, v in ipairs(oversyn_t) do
    if oversyn_level[v] > 0 then
      table.insert(self.oversyns, { text = 
      strc({'[',oversyn_cols[v],']',v,' ',oversyn_level[v]}), font = pixul_font, alignment = 'center', height_multiplier = 1}
      )
      table.insert(self.oversyns, { text = 
      strc({'[',oversyn_cols[v],']',oversyn_desc[v]()}), font = pixul_font, alignment = 'center', height_multiplier = 1}
      )
    end
  end
end

function BuyScreen:dirtyOsynDisplay(dt)
  local x, y = camera:get_mouse_position()
  local halfwidth = self.sets_text.w * 0.5
  local halfheight = self.sets_text.h * 0.5
  if y > self.sets_text.y - halfheight and y <= self.sets_text.y + halfheight then
    if x > self.sets_text.x - halfwidth and x <= self.sets_text.x then
      if self.osyn_textstate ~= 1 then
        self:hsyn_text_die()
        self.ssyn_text = InfoText{group = main.current.ui, force_update = true}
        self:getOversynList(sup_syns)
        self.ssyn_text:activate(self.oversyns, gw/2, gh/2, nil, nil, 16, 2, nil, 2)
        pop2:play{pitch = random:float(0.9, 1.0), volume = 0.5}
        self.osyn_textstate = 1
      end
    elseif x > self.sets_text.x and x < self.sets_text.x + halfwidth then
      if self.osyn_textstate ~= 2 then
        self:ssyn_text_die()
        self.hsyn_text = InfoText{group = main.current.ui, force_update = true}
        self:getOversynList(hyp_syns)
        self.hsyn_text:activate(self.oversyns, gw/2, gh/2, nil, nil, 16, 2, nil, 2)
        pop2:play{pitch = random:float(1.0, 1.1), volume = 0.5}
        self.osyn_textstate = 2
      end
    else
      self:osyn_text_die()
    end
  else
    self:osyn_text_die()
  end
  if self.ssyn_text then
    self.ssyn_text:update(dt)
  end
  if self.hsyn_text then
    self.hsyn_text:update(dt)
  end
end


function BuyScreen:update(dt)
  if main_song_instance:isStopped() then
    main_song_instance = _G[random:table{'song1', 'song2', 'song3', 'song4', 'song5'}]:play{volume = 0.2}
  end

  if not self.paused then
    run_time = run_time + dt
  end

  self:update_game_object(dt*slow_amount)

  if not self.in_tutorial and not self.paused then
    self.main:update(dt*slow_amount)
    self.effects:update(dt*slow_amount)
    self.ui:update(dt*slow_amount)
    if self.shop_text then self.shop_text:update(dt) end
    if self.sets_text then self.sets_text:update(dt) end
    if self.party_text then self.party_text:update(dt) end
    if self.items_text then self.items_text:update(dt) end
    if self.ng_text then self.ng_text:update(dt) end
    if self.level_text then self.level_text:update(dt) end
    --dirty supersynergy and hypersynergy display
    self:dirtyOsynDisplay(dt)
  else
    self.ui:update(dt*slow_amount)
    self.tutorial:update(dt*slow_amount)
  end

  if self.in_tutorial and input.escape.pressed then
    self:quit_tutorial()
  end

  if input.escape.pressed and not self.transitioning and not self.in_tutorial then
    if not self.paused then
      open_options(self)
    else
      close_options(self)
    end
  end

  for _, part in ipairs(self.characters) do
    part.y = 40 + (part.i-1)*19
  end
end


function BuyScreen:quit_tutorial()
  self.in_tutorial = false
  self.tutorial_text.dead = true
  self.tutorial_text = nil
  self.title_text.dead = true
  self.title_text = nil
  for _, t in ipairs(self.tutorial_cards) do t.dead = true end
  self.close_button.dead = true
  self.close_button = nil
  self.tutorial_cards = {}
  self.tutorial:update(0)
end


function BuyScreen:draw()
  self.main:draw()
  self.effects:draw()
  if self.items_text then self.items_text:draw(32, 145) end
  if self.level_text then self.level_text:draw(265, gh - 20) end

  if self.unit_grabbed then
    local x, y = camera:get_mouse_position()
    y = math.clamp(y, 40, 40 + (#self.units-1)*19)
    graphics.push(self.unit_grabbed.x, y, 0)
      graphics.rectangle(self.unit_grabbed.x, y, 14, 14, 3, 3, bg[5])
      graphics.print_centered(self.unit_grabbed.level, pixul_font, self.unit_grabbed.x + 0.5, y + 2, 0, 1, 1, 0, 0, bg[10])
      for _, part in ipairs(self.unit_grabbed.parts) do
        part:draw(y)
      end
    graphics.pop()
  end

  if self.shop_text then self.shop_text:draw(64, 20) end
  if self.sets_text then self.sets_text:draw(self.sets_text.x, self.sets_text.y) end
  if self.party_text then self.party_text:draw(440, 20) end
  if current_new_game_plus > 0 then self.ng_text:draw(265, gh - 40) end

  if self.paused then graphics.rectangle(gw/2, gh/2, 2*gw, 2*gh, nil, nil, modal_transparent) end
  self.ui:draw()

  if self.in_tutorial then
    graphics.rectangle(gw/2, gh/2, 2*gw, 2*gh, nil, nil, modal_transparent_2)
    arrow:draw(gw/2 + 93, gh/2 - 30, 0, 0.4, 0.35)
    arrow:draw(gw/2 + 93, gh/2 - 10, 0, 0.4, 0.35)
  end
  self.tutorial:draw()
end


function BuyScreen:buy(character, i)
  local bought
  if table.any(self.units, function(v) return v.character == character end) and gold >= character_tiers[character] then
    if table.any(self.units, function(v) return v.character == character and v.level == 3 end) then
      if not self.info_text then
        self.info_text = InfoText{group = main.current.ui}
        self.info_text:activate({
          {text = "[fg]this unit has already reached max level", font = pixul_font, alignment = 'center'},
        }, nil, nil, nil, nil, 16, 4, nil, 2)
        self.info_text.x, self.info_text.y = gw - 140, gh - 20
      end
      self.t:after(2, function() self.info_text:deactivate(); self.info_text.dead = true; self.info_text = nil end, 'info_text')
    else
      gold = gold - character_tiers[character]
      self.shop_text:set_text{{text = '[wavy_mid, fg]shop [fg]- [fg, nudge_down]gold: [yellow, nudge_down]' .. gold, font = pixul_font, alignment = 'center'}}
      for _, unit in ipairs(self.units) do
        if unit.character == character then
          if unit.level == 1 then
            unit.reserve[1] = unit.reserve[1] + 1
            if unit.reserve[1] > 1 then
              unit.reserve[1] = 0
              unit.level = 2
              unit.spawn_effect = true
            end
          elseif unit.level == 2 then
            unit.reserve[1] = unit.reserve[1] + 1
            if unit.reserve[1] > 2 then
              if unit.reserve[2] == 1 then
                unit.reserve[2] = 0
                unit.reserve[1] = 0
                unit.level = 3
                unit.spawn_effect = true
              else
                unit.reserve[2] = unit.reserve[2] + 1
                unit.reserve[1] = 0
              end
            end
          end
        end
      end
      bought = true
    end
  else
    if #self.units >= max_units then
      if not self.info_text then
        self.info_text = InfoText{group = main.current.ui}
        self.info_text:activate({
          {text = '[fg]maximum number of units [yellow](' .. max_units .. ') [fg]reached', font = pixul_font, alignment = 'center'},
        }, nil, nil, nil, nil, 16, 4, nil, 2)
        self.info_text.x, self.info_text.y = gw - 140, gh - 20
      end
      self.t:after(2, function() self.info_text:deactivate(); self.info_text.dead = true; self.info_text = nil end, 'info_text')
    else
      if gold >= character_tiers[character] then
        gold = gold - character_tiers[character]
        self.shop_text:set_text{{text = '[wavy_mid, fg]shop [fg]- [fg, nudge_down]gold: [yellow, nudge_down]' .. gold, font = pixul_font, alignment = 'center'}}
        table.insert(self.units, {character = character, level = 1, reserve = {0, 0}})
        bought = true
      end
    end
  end
  self:set_party_and_sets()
  return bought
end


function BuyScreen:gain_gold(amount)
  gold = gold + (amount or 0)
  self.shop_text:set_text{{text = '[wavy_mid, fg]shop [fg]- [fg, nudge_down]gold: [yellow, nudge_down]' .. gold, font = pixul_font, alignment = 'center'}}
end


function BuyScreen:set_cards(shop_level, dont_spawn_effect, first_call, from_arena)
  if self.cards then for i = 1, 3 do if self.cards[i] then self.cards[i]:die(dont_spawn_effect) end end end
  self.cards = {}
  local all_units = {}
  local unit_1
  local unit_2
  local unit_3
  local shop_level = shop_level or 1
  local tier_weights = level_to_shop_odds[shop_level]
  repeat 
    unit_1 = random:table(tier_to_characters[random:weighted_pick(unpack(tier_weights))])
    unit_2 = random:table(tier_to_characters[random:weighted_pick(unpack(tier_weights))])
    unit_3 = random:table(tier_to_characters[random:weighted_pick(unpack(tier_weights))])
    all_units = {unit_1, unit_2, unit_3}
  until not table.all(all_units, function(v) return table.any(non_attacking_characters, function(u) return v == u end) end)
  if first_call and locked_state then
    if from_arena then
      if locked_state.cards[1] then 
          self.cards[1] = ShopCard{group = self.main, x = 60, y = 75, w = 80, h = 90, unit = locked_state.cards[1], parent = self, i = 1}
      else
        self.cards[1] = ShopCard{group = self.main, x = 60, y = 75, w = 80, h = 90, unit = unit_1, parent = self, i = 1} end
      if locked_state.cards[2] then 
          self.cards[2] = ShopCard{group = self.main, x = 140, y = 75, w = 80, h = 90, unit = locked_state.cards[2], parent = self, i = 2}
      else
        self.cards[2] = ShopCard{group = self.main, x = 140, y = 75, w = 80, h = 90, unit = unit_2, parent = self, i = 2} end
      if locked_state.cards[3] then 
          self.cards[3] = ShopCard{group = self.main, x = 220, y = 75, w = 80, h = 90, unit = locked_state.cards[3], parent = self, i = 3}
      else
        self.cards[3] = ShopCard{group = self.main, x = 220, y = 75, w = 80, h = 90, unit = unit_3, parent = self, i = 3} end
    else
      if locked_state.cards[1] then
        self.cards[1] = ShopCard{group = self.main, x = 60, y = 75, w = 80, h = 90, unit = locked_state.cards[1], parent = self, i = 1}
      else self.cards[1] = nil end
      if locked_state.cards[2] then
        self.cards[2] = ShopCard{group = self.main, x = 140, y = 75, w = 80, h = 90, unit = locked_state.cards[2], parent = self, i = 2}
      else self.cards[2] = nil end
      if locked_state.cards[3] then
        self.cards[3] = ShopCard{group = self.main, x = 220, y = 75, w = 80, h = 90, unit = locked_state.cards[3], parent = self, i = 3}
      else self.cards[3] = nil end
    end
  else
    self.cards[1] = ShopCard{group = self.main, x = 60, y = 75, w = 80, h = 90, unit = unit_1, parent = self, i = 1}
    self.cards[2] = ShopCard{group = self.main, x = 140, y = 75, w = 80, h = 90, unit = unit_2, parent = self, i = 2}
    self.cards[3] = ShopCard{group = self.main, x = 220, y = 75, w = 80, h = 90, unit = unit_3, parent = self, i = 3}
  end
end


function BuyScreen:set_party_and_sets()
  if self.characters then for _, part in ipairs(self.characters) do part:die() end end
  self.characters = {}
  local y = 40
  for i, unit in ipairs(self.units) do
    table.insert(self.characters, CharacterPart{group = self.main, x = gw - 30, y = y + (i-1)*19, character = unit.character, level = unit.level, reserve = unit.reserve, i = i, spawn_effect = unit.spawn_effect, parent = self, lead = (i == 1)})
    unit.spawn_effect = false
  end

  if self.sets then for _, icon in ipairs(self.sets) do icon:die(true) end end
  self.sets = {}
  local classes = get_classes(self.units)
  for i, class in ipairs(classes) do
    local x, y
    if #classes <= 6 then x, y = math.index_to_coordinates(i, 2)
    elseif #classes <= 12 then x, y = math.index_to_coordinates(i, 3) else
      x, y = math.index_to_coordinates(i, 4)
    end
    table.insert(self.sets, ClassIcon{group = self.main, x = 296 + (x-1)*18, y = 45 + (y-1)*48, class = class, units = self.units, parent = self})
  end
  see_oversyns(self.units)
end


function BuyScreen:set_items()
  if self.items then for _, item in ipairs(self.items) do item:die() end end
  self.items = {}
  local y = 182
  for k, passive in ipairs(self.passives) do
    local i, j = math.index_to_coordinates(k, 4)
    table.insert(self.items, ItemCard{group = self.main, x = 45 + (i-1)*60, y = y + (j-1)*50, w = 40, h = 50, passive = passive.passive , level = passive.level, xp = passive.xp, parent = self, i = k})
  end
end




SteamFollowButton = Object:extend()
SteamFollowButton:implement(GameObject)
function SteamFollowButton:init(args)
  self:init_game_object(args)
  self.interact_with_mouse = true
  self.shape = Rectangle(self.x, self.y, pixul_font:get_text_width('follow me on steam!') + 12, pixul_font.h + 4)
  self.text = Text({{text = '[greenm5]follow me on steam!', font = pixul_font, alignment = 'center'}}, global_text_tags)
end


function SteamFollowButton:update(dt)
  self:update_game_object(dt)
  if main.current.in_credits then return end

  if self.selected and input.m1.pressed then
    ui_switch2:play{pitch = random:float(0.95, 1.05), volume = 0.5}
    self.spring:pull(0.2, 200, 10)
    self.selected = true
    ui_switch1:play{pitch = random:float(0.95, 1.05), volume = 0.5}
    system.open_url'https://store.steampowered.com/dev/a327ex/'
  end
end


function SteamFollowButton:draw()
  graphics.push(self.x, self.y, 0, self.spring.x, self.spring.y)
    graphics.rectangle(self.x, self.y, self.shape.w, self.shape.h, 4, 4, self.selected and fg[0] or green[0])
    self.text:draw(self.x, self.y)
  graphics.pop()
end


function SteamFollowButton:on_mouse_enter()
  if main.current.in_credits then return end
  love.mouse.setCursor(love.mouse.getSystemCursor'hand')
  ui_hover1:play{pitch = random:float(1.3, 1.5), volume = 0.5}
  pop2:play{pitch = random:float(0.95, 1.05), volume = 0.5}
  self.selected = true
  self.text:set_text{{text = '[fgm5]follow me on steam!', font = pixul_font, alignment = 'center'}}
  self.spring:pull(0.05, 200, 10)
end


function SteamFollowButton:on_mouse_exit()
  if main.current.in_credits then return end
  love.mouse.setCursor()
  self.text:set_text{{text = '[greenm5]follow me on steam!', font = pixul_font, alignment = 'center'}}
  self.selected = false
end




WishlistButton = Object:extend()
WishlistButton:implement(GameObject)
function WishlistButton:init(args)
  self:init_game_object(args)
  self.interact_with_mouse = true
  if self.w_to_wishlist then
    self.shape = Rectangle(self.x, self.y, 85, 18)
    self.text = Text({{text = '[bg10]w to wishlist', font = pixul_font, alignment = 'center'}}, global_text_tags)
  else
    self.shape = Rectangle(self.x, self.y, 110, 18)
    self.text = Text({{text = '[bg10]wishlist on steam', font = pixul_font, alignment = 'center'}}, global_text_tags)
  end
end


function WishlistButton:update(dt)
  self:update_game_object(dt)

  if self.selected and input.m1.pressed then
    ui_switch2:play{pitch = random:float(0.95, 1.05), volume = 0.5}
    self.spring:pull(0.2, 200, 10)
    self.selected = true
    ui_switch1:play{pitch = random:float(0.95, 1.05), volume = 0.5}
    system.open_url'https://store.steampowered.com/app/915310/SNKRX/'
  end
end


function WishlistButton:draw()
  graphics.push(self.x, self.y, 0, self.spring.x, self.spring.y)
    graphics.rectangle(self.x, self.y, self.shape.w, self.shape.h, 4, 4, self.selected and fg[0] or bg[1])
    self.text:draw(self.x, self.y + 1)
  graphics.pop()
end


function WishlistButton:on_mouse_enter()
  ui_hover1:play{pitch = random:float(1.3, 1.5), volume = 0.5}
  pop2:play{pitch = random:float(0.95, 1.05), volume = 0.5}
  self.selected = true
  if self.w_to_wishlist then
    self.text:set_text{{text = '[fgm5]w to wishlist', font = pixul_font, alignment = 'center'}}
  else
    self.text:set_text{{text = '[fgm5]wishlist on steam', font = pixul_font, alignment = 'center'}}
  end
  self.spring:pull(0.2, 200, 10)
end


function WishlistButton:on_mouse_exit()
  if self.w_to_wishlist then
    self.text:set_text{{text = '[bg10]w to wishlist', font = pixul_font, alignment = 'center'}}
  else
    self.text:set_text{{text = '[bg10]wishlist on steam', font = pixul_font, alignment = 'center'}}
  end
  self.selected = false
end




RestartButton = Object:extend()
RestartButton:implement(GameObject)
function RestartButton:init(args)
  self:init_game_object(args)
  self.shape = Rectangle(self.x, self.y, pixul_font:get_text_width('restart') + 4, pixul_font.h + 4)
  self.interact_with_mouse = true
  self.text = Text({{text = '[bg10]NG+' .. tostring(current_new_game_plus), font = pixul_font, alignment = 'center'}}, global_text_tags)
end


function RestartButton:update(dt)
  if main.current.in_credits then return end
  self:update_game_object(dt)

  if self.selected and input.m1.pressed then
    main.current.transitioning = true
    ui_transition2:play{pitch = random:float(0.95, 1.05), volume = 0.5}
    ui_switch2:play{pitch = random:float(0.95, 1.05), volume = 0.5}
    ui_switch1:play{pitch = random:float(0.95, 1.05), volume = 0.5}
    TransitionEffect{group = main.transitions, x = gw/2, y = gh/2, color = state.dark_transitions and bg[-2] or fg[0], transition_action = function()
      slow_amount = 1
      music_slow_amount = 1
      run_time = 0
      gold = 3
      passives = {}
      main_song_instance:stop()
      run_passive_pool = {
        'centipede', 'ouroboros_technique_r', 'ouroboros_technique_l', 'amplify', 'resonance', 'ballista', 'call_of_the_void', 'crucio', 'speed_3', 'damage_4', 'shoot_5', 'death_6', 'lasting_7',
        'defensive_stance', 'offensive_stance', 'kinetic_bomb', 'porcupine_technique', 'last_stand', 'seeping', 'deceleration', 'annihilation', 'malediction', 'hextouch', 'whispers_of_doom',
        'tremor', 'heavy_impact', 'fracture', 'meat_shield', 'hive', 'baneling_burst', 'blunt_arrow', 'explosive_arrow', 'divine_machine_arrow', 'chronomancy', 'awakening', 'divine_punishment',
        'assassination', 'flying_daggers', 'ultimatum', 'magnify', 'echo_barrage', 'unleash', 'reinforce', 'payback', 'enchanted', 'freezing_field', 'burning_field', 'gravity_field', 'magnetism',
        'insurance', 'dividends', 'berserking', 'unwavering_stance', 'unrelenting_stance', 'blessing', 'haste', 'divine_barrage', 'orbitism', 'psyker_orbs', 'psychosink', 'rearm', 'taunt', 'construct_instability',
        'intimidation', 'vulnerability', 'temporal_chains', 'ceremonial_dagger', 'homing_barrage', 'critical_strike', 'noxious_strike', 'infesting_strike', 'burning_strike', 'lucky_strike', 'healing_strike', 'stunning_strike',
        'silencing_strike', 'culling_strike', 'lightning_strike', 'psycholeak', 'divine_blessing', 'hardening', 'kinetic_strike',
      }
      reset_syn_pow()
      reset_lateups()
      max_units = math.clamp(7 + current_new_game_plus, 7, 12)
      system.save_state()
      main:add(BuyScreen'buy_screen')
      system.save_run()
      main:go_to('buy_screen', 1, 0, {}, passives, 1, 0)
    end, text = Text({{text = '[wavy, ' .. tostring(state.dark_transitions and 'fg' or 'bg') .. ']restarting...', font = pixul_font, alignment = 'center'}}, global_text_tags)}
  end
end


function RestartButton:draw()
  graphics.push(self.x, self.y, 0, self.spring.x, self.spring.y)
    graphics.rectangle(self.x, self.y, self.shape.w, self.shape.h, 4, 4, self.selected and fg[0] or bg[1])
    self.text:draw(self.x, self.y + 1, 0, 1, 1)
  graphics.pop()
end


function RestartButton:on_mouse_enter()
  if main.current.in_credits then return end
  ui_hover1:play{pitch = random:float(1.3, 1.5), volume = 0.5}
  pop2:play{pitch = random:float(0.95, 1.05), volume = 0.5}
  self.selected = true
  self.text:set_text{{text = '[fgm5]NG+' .. tostring(current_new_game_plus), font = pixul_font, alignment = 'center'}}
  self.spring:pull(0.2, 200, 10)
end


function RestartButton:on_mouse_exit()
  if main.current.in_credits then return end
  self.text:set_text{{text = '[bg10]NG+' .. tostring(current_new_game_plus), font = pixul_font, alignment = 'center'}}
  self.selected = false
end




Button = Object:extend()
Button:implement(GameObject)
function Button:init(args)
  self:init_game_object(args)
  self.shape = Rectangle(self.x, self.y, args.w or (pixul_font:get_text_width(self.button_text) + 8), pixul_font.h + 4)
  self.interact_with_mouse = true
  self.text = Text({{text = '[' .. self.fg_color .. ']' .. self.button_text, font = pixul_font, alignment = 'center'}}, global_text_tags)
end


function Button:update(dt)
  self:update_game_object(dt)
  if main.current.in_credits and not self.credits_button then return end

  if self.hold_button then
    if self.selected and input.m1.pressed then
      self.press_time = love.timer.getTime()
      self.spring:pull(0.2, 200, 10)
    end
    if self.press_time then
      if input.m1.down and love.timer.getTime() - self.press_time > self.hold_button then
        self:action()
        self.press_time = nil
        self.spring:pull(0.1, 200, 10)
      end
    end
    if input.m1.released then
      self.press_time = nil
      self.spring:pull(0.1, 200, 10)
    end
  else
    if self.selected and input.m1.pressed then
      if self.action then
        self:action()
      end
    end
    if self.selected and input.m2.pressed then
      if self.action_2 then
        self:action_2()
      end
    end
  end
end


function Button:draw()
  graphics.push(self.x, self.y, 0, self.spring.x, self.spring.y)
    if self.hold_button and self.press_time then
      graphics.set_line_width(5)
      graphics.set_color(fg[-5])
      graphics.arc('open', self.x, self.y, 0.6*self.shape.w, 0, math.remap(love.timer.getTime() - self.press_time, 0, self.hold_button, 0, 1)*2*math.pi)
      graphics.set_line_width(1)
    end
    graphics.rectangle(self.x, self.y, self.shape.w, self.shape.h, 4, 4, self.selected and fg[0] or _G[self.bg_color][0])
    self.text:draw(self.x, self.y + 1, 0, 1, 1)
  graphics.pop()
end


function Button:on_mouse_enter()
  if main.current.in_credits and not self.credits_button then return end
  ui_hover1:play{pitch = random:float(1.3, 1.5), volume = 0.5}
  pop2:play{pitch = random:float(0.95, 1.05), volume = 0.5}
  self.selected = true
  self.text:set_text{{text = '[fgm5]' .. self.button_text, font = pixul_font, alignment = 'center'}}
  self.spring:pull(0.2, 200, 10)
  if self.mouse_enter then self:mouse_enter() end
end


function Button:on_mouse_exit()
  if main.current.in_credits and not self.credits_button then return end
  self.text:set_text{{text = '[' .. self.fg_color .. ']' .. self.button_text, font = pixul_font, alignment = 'center'}}
  self.selected = false
  if self.mouse_exit then self:mouse_exit() end
end


function Button:set_text(text)
  self.button_text = text
  self.text:set_text{{text = '[' .. self.fg_color .. ']' .. self.button_text, font = pixul_font, alignment = 'center'}}
  self.spring:pull(0.2, 200, 10)
end




GoButton = Object:extend()
GoButton:implement(GameObject)
function GoButton:init(args)
  self.growth = 1
  self:init_game_object(args)
  self.shape = Rectangle(self.x, self.y, 28, 18)
  self.interact_with_mouse = true
  self.text = Text({{text = '[greenm5]GO!', font = pixul_font, alignment = 'center'}}, global_text_tags)
end


function GoButton:update(dt)
  self:update_game_object(dt)
  if self.selected then
    self.growth = self.growth + dt*0.1
  else
    local shrink_speed = dt*50.0
    local dist = (1 - self.growth) * shrink_speed
    if math.abs(dist) > 1 then
      dist = math.sign(dist) * shrink_speed
    end
    if dist * shrink_speed + self.growth < 1 then
      self.growth = 1
    else
      self.growth = self.growth + dist * shrink_speed
    end
  end
  if ((self.selected and input.m1.pressed) or input.enter.pressed) and not self.transitioning then
    if #self.parent.units == 0 then
      if not self.info_text then
        error1:play{pitch = random:float(0.95, 1.05), volume = 0.5}
        self.info_text = InfoText{group = main.current.ui}
        self.info_text:activate({
          {text = '[fg]cannot start the round with [yellow]0 [fg]units', font = pixul_font, alignment = 'center'},
        }, nil, nil, nil, nil, 16, 4, nil, 2)
        self.info_text.x, self.info_text.y = gw/2, gh/2 + 10
      end
      self.t:after(2, function() self.info_text:deactivate(); self.info_text.dead = true; self.info_text = nil end, 'info_text')

    else
      locked_state = {locked = self.parent.locked, cards = {self.parent.cards[1] and self.parent.cards[1].unit, self.parent.cards[2] and self.parent.cards[2].unit, self.parent.cards[3] and self.parent.cards[3].unit}} 
      ui_switch2:play{pitch = random:float(0.95, 1.05), volume = 0.5}
      self.spring:pull(0.2, 200, 10)
      self.selected = true
      ui_switch1:play{pitch = random:float(0.95, 1.05), volume = 0.5}
      ui_transition1:play{pitch = random:float(0.95, 1.05), volume = 0.5}
      self.transitioning = true
      save_run_by_ref(self.parent)
      TransitionEffect{group = main.transitions, x = self.x, y = self.y, color = state.dark_transitions and bg[-2] or character_colors[random:table(self.parent.units).character], transition_action = function()
        main:add(Arena'arena')
        main:go_to('arena', self.parent.level, self.parent.loop, self.parent.units, self.parent.passives, self.parent.shop_level, self.parent.shop_xp, self.parent.locked)
      end, text = Text({{text = '[wavy, ' .. tostring(state.dark_transitions and 'fg' or 'bg') .. ']level ' .. tostring(self.parent.level) .. '/' .. tostring(25*(self.parent.loop+1)), font = pixul_font, alignment = 'center'}}, global_text_tags)}
    end

    if input.enter.pressed then self.selected = false end
  end
end


function GoButton:draw()
  local truex = self.x
  local truey = self.y
  if self.selected then
    truex = truex + (math.random() - 0.5)*self.growth*2
    truey = truey + (math.random() - 0.5)*self.growth*2
  end
  graphics.push(truex, truey, 0, self.spring.x, self.spring.y)
    graphics.rectangle(truex, truey, self.shape.w*self.growth, self.shape.h*self.growth, 4, 4, self.selected and red[-5] or green[0])
    self.text:draw(truex, truey + 1, 0, 1, 1)
  graphics.pop()
end


function GoButton:on_mouse_enter()
  ui_hover1:play{pitch = random:float(1.3, 1.5), volume = 0.5}
  pop2:play{pitch = random:float(0.95, 1.05), volume = 0.5}
  self.selected = true
  self.text:set_text{{text = '[red]GO!', font = pixul_font, alignment = 'center'}}
  self.spring:pull(0.2, 200, 10)
end


function GoButton:on_mouse_exit()
  self.text:set_text{{text = '[greenm5]GO!', font = pixul_font, alignment = 'center'}}
  self.selected = false
end


LockButton = Object:extend()
LockButton:implement(GameObject)
function LockButton:init(args)
  self:init_game_object(args)
  self.shape = Rectangle(self.x, self.y, 32, 16)
  self.interact_with_mouse = true
  if self.parent.locked then self.shape.w = 44
  else self.shape.w = 32 end
  if self.parent.locked then self.text = Text({{text = '[fgm5]' .. tostring(self.parent.locked and 'unlock' or 'lock'), font = pixul_font, alignment = 'center'}}, global_text_tags)
  else self.text = Text({{text = '[bg10]' .. tostring(self.parent.locked and 'unlock' or 'lock'), font = pixul_font, alignment = 'center'}}, global_text_tags) end
end


function LockButton:update(dt)
  self:update_game_object(dt)

  if self.selected and input.m1.pressed then
    self.parent.locked = not self.parent.locked
    locked_state = {locked = self.parent.locked, cards = {self.parent.cards[1] and self.parent.cards[1].unit, self.parent.cards[2] and self.parent.cards[2].unit, self.parent.cards[3] and self.parent.cards[3].unit}}
    save_run_by_ref(self.parent)
    ui_switch2:play{pitch = random:float(0.95, 1.05), volume = 0.5}
    self.selected = true
    self.spring:pull(0.2, 200, 10)
    self.text:set_text{{text = '[fgm5]' .. tostring(self.parent.locked and 'unlock' or 'lock'), font = pixul_font, alignment = 'center'}}
    if self.parent.locked then self.shape.w = 44
    else self.shape.w = 32 end
  end
end


function LockButton:draw()
  graphics.push(self.x, self.y, 0, self.spring.x, self.spring.y)
    graphics.rectangle(self.x, self.y, self.shape.w, self.shape.h, 4, 4, (self.selected or self.parent.locked) and fg[0] or bg[1])
    self.text:draw(self.x, self.y + 1)
  graphics.pop()
end


function LockButton:on_mouse_enter()
  ui_hover1:play{pitch = random:float(1.3, 1.5), volume = 0.5}
  pop2:play{pitch = random:float(0.95, 1.05), volume = 0.5}
  self.selected = true
  self.text:set_text{{text = '[fgm5]' .. tostring(self.parent.locked and 'unlock' or 'lock'), font = pixul_font, alignment = 'center'}}
  self.spring:pull(0.2, 200, 10)
end


function LockButton:on_mouse_exit()
  if not self.parent.locked then self.text:set_text{{text = '[bg10]' .. tostring(self.parent.locked and 'unlock' or 'lock'), font = pixul_font, alignment = 'center'}} end
  self.selected = false
end




LevelButton = Object:extend()
LevelButton:implement(GameObject)
function LevelButton:init(args)
  self:init_game_object(args)
  self.interact_with_mouse = true
  self.shape = Rectangle(self.x, self.y, 16, 16)
  self.text = Text({{text = '[bg10]' .. tostring(self.parent.shop_level), font = pixul_font, alignment = 'center'}}, global_text_tags)
  self.shop_xp = self.parent.shop_xp or 0
  self.max_xp = (self.parent.shop_level == 1 and 3) or (self.parent.shop_level == 2 and 4) or (self.parent.shop_level == 3 and 5) or (self.parent.shop_level == 4 and 6) or (self.parent.shop_level == 5 and 0)
end


function LevelButton:update(dt)
  self:update_game_object(dt)

  if self.selected and input.m1.released then
    if self.parent.shop_level >= 5 then return end
    if gold < 5 then
      self.spring:pull(0.2, 200, 10)
      self.selected = true
      error1:play{pitch = random:float(0.95, 1.05), volume = 0.5}
      if not self.info_text_2 then
        self.info_text_2 = InfoText{group = main.current.ui}
        self.info_text_2:activate({
          {text = '[fg]not enough gold', font = pixul_font, alignment = 'center'},
        }, nil, nil, nil, nil, 16, 4, nil, 2)
        self.info_text_2.x, self.info_text_2.y = gw/2, gh/2 + 30
      end
      self.t:after(2, function() self.info_text_2:deactivate(); self.info_text_2.dead = true; self.info_text_2 = nil end, 'info_text_2')
    else
      ui_switch2:play{pitch = random:float(0.95, 1.05), volume = 0.5}
      self.shop_xp = self.shop_xp + 1
      if self.shop_xp >= self.max_xp then
        self.shop_xp = 0
        self.parent.shop_level = self.parent.shop_level + 1
        self.max_xp = (self.parent.shop_level == 1 and 3) or (self.parent.shop_level == 2 and 4) or (self.parent.shop_level == 3 and 5) or (self.parent.shop_level == 4 and 6) or (self.parent.shop_level == 5 and 0)
      end
      self.parent.shop_xp = self.shop_xp
      self:create_info_text()
      self.selected = true
      self.spring:pull(0.2, 200, 10)
      gold = gold - 5
      self.parent.shop_text:set_text{{text = '[wavy_mid, fg]shop [fg]- [fg, nudge_down]gold: [yellow, nudge_down]' .. gold, font = pixul_font, alignment = 'center'}}
      self.text = Text({{text = '[bg10]' .. tostring(self.parent.shop_level), font = pixul_font, alignment = 'center'}}, global_text_tags)
      save_run_by_ref(self.parent)
    end
  end

  if self.selected and input.m2.pressed then
    if self.parent.shop_level <= 1 then return end
    if gold < 10 then
      self.spring:pull(0.2, 200, 10)
      self.selected = true
      error1:play{pitch = random:float(0.95, 1.05), volume = 0.5}
      if not self.info_text_2 then
        self.info_text_2 = InfoText{group = main.current.ui}
        self.info_text_2:activate({
          {text = '[fg]not enough gold', font = pixul_font, alignment = 'center'},
        }, nil, nil, nil, nil, 16, 4, nil, 2)
        self.info_text_2.x, self.info_text_2.y = gw/2, gh/2 + 30
      end
      self.t:after(2, function() self.info_text_2:deactivate(); self.info_text_2.dead = true; self.info_text_2 = nil end, 'info_text_2')
    else
      ui_switch2:play{pitch = random:float(0.95, 1.05), volume = 0.5}
      self.shop_xp = 0
      self.parent.shop_level = self.parent.shop_level - 1
      self.max_xp = (self.parent.shop_level == 1 and 3) or (self.parent.shop_level == 2 and 4) or (self.parent.shop_level == 3 and 5) or (self.parent.shop_level == 4 and 6) or (self.parent.shop_level == 5 and 0)
      self.parent.shop_xp = self.shop_xp
      self:create_info_text()
      self.selected = true
      self.spring:pull(0.2, 200, 10)
      gold = gold - 10
      self.parent.shop_text:set_text{{text = '[wavy_mid, fg]shop [fg]- [fg, nudge_down]gold: [yellow, nudge_down]' .. gold, font = pixul_font, alignment = 'center'}}
      self.text = Text({{text = '[bg10]' .. tostring(self.parent.shop_level), font = pixul_font, alignment = 'center'}}, global_text_tags)
      save_run_by_ref(self.parent)
    end
  end
end


function LevelButton:draw()
  graphics.push(self.x, self.y, 0, self.spring.x, self.spring.y)
    graphics.rectangle(self.x, self.y, self.shape.w, self.shape.h, 4, 4, self.selected and fg[0] or bg[1])
    self.text:draw(self.x, self.y + 1)
    for i = 1, self.max_xp do
      graphics.line(self.x - 4 + 0.9*self.shape.w + (i-1)*5, self.y - self.shape.h/3, self.x - 4 + 0.9*self.shape.w + (i-1)*5, self.y + self.shape.h/3, bg[1], 2)
    end
    for i = 1, self.shop_xp do
      graphics.line(self.x - 4 + 0.9*self.shape.w + (i-1)*5, self.y - self.shape.h/3, self.x - 4 + 0.9*self.shape.w + (i-1)*5, self.y + self.shape.h/3, fg[0], 2)
    end
  graphics.pop()
end


function LevelButton:create_info_text()
  if self.info_text then
    self.info_text:deactivate()
    self.info_text.dead = true
  end
  self.info_text = nil
  if self.parent.shop_level < 5 then
    local t11, t12 = get_shop_odds(self.parent.shop_level, 1), get_shop_odds(self.parent.shop_level+1, 1)
    local t21, t22 = get_shop_odds(self.parent.shop_level, 2), get_shop_odds(self.parent.shop_level+1, 2)
    local t31, t32 = get_shop_odds(self.parent.shop_level, 3), get_shop_odds(self.parent.shop_level+1, 3)
    local t41, t42 = get_shop_odds(self.parent.shop_level, 4), get_shop_odds(self.parent.shop_level+1, 4)
    self.info_text = InfoText{group = main.current.ui}
    self.info_text:activate({
      {text = '[yellow]Lv.' .. self.parent.shop_level .. '[fg] shop, XP: [yellow]' .. self.shop_xp .. '/' .. self.max_xp .. '[fg], +1 XP cost: [yellow]5', font = pixul_font, alignment = 'center', height_multiplier = 1.5},
      {text = '[bg10]chances of units appearing on the shop', font = pixul_font, alignment = 'center', height_multiplier = 1.25},
      {text = '[yellow]current shop level                  [fgm10]next shop level', font = pixul_font, alignment = 'left', height_multiplier = 1.25},
      {text = '[fg]tier 1: ' .. t11 .. '%' .. tostring(t11 < 10 and '  ' or '') .. '                                 [fgm8]tier 1: ' .. t12 .. '%', font = pixul_font, alignment = 'left', height_multiplier = 1.25},
      {text = '[green]tier 2: ' .. t21 .. '%' .. tostring(t21 < 10 and '  ' or '') .. '                                 [fgm6]tier 2: ' .. t22 .. '%', font = pixul_font, alignment = 'left', height_multiplier = 1.25},
      {text = '[blue]tier 3: ' .. t31 .. '%' .. tostring(t31 < 10 and '  ' or '') .. '                                 [fgm4]tier 3: ' .. t32 .. '%', font = pixul_font, alignment = 'left', height_multiplier = 1.25},
      {text = '[purple]tier 4: ' .. t41 .. '%' .. tostring(t41 < 10 and '  ' or '') .. '                                 [fgm2]tier 4: ' .. t42 .. '%', font = pixul_font, alignment = 'left', height_multiplier = 1.25},
    }, nil, nil, nil, nil, 16, 4, nil, 2)
    self.info_text.x, self.info_text.y = gw/2, gh/2 - 45
  elseif self.parent.shop_level == 5 then
    local t11 = get_shop_odds(self.parent.shop_level, 1)
    local t21 = get_shop_odds(self.parent.shop_level, 2)
    local t31 = get_shop_odds(self.parent.shop_level, 3)
    local t41 = get_shop_odds(self.parent.shop_level, 4)
    self.info_text = InfoText{group = main.current.ui}
    self.info_text:activate({
      {text = '[yellow]Lv.' .. self.parent.shop_level .. '[fg] shop', font = pixul_font, alignment = 'center', height_multiplier = 1.5},
      {text = '[bg10]chances of units appearing on the shop', font = pixul_font, alignment = 'center', height_multiplier = 1.25},
      {text = '[yellow]current shop level', font = pixul_font, alignment = 'left', height_multiplier = 1.25},
      {text = '[fg]tier 1: ' .. t11 .. '%', font = pixul_font, alignment = 'left', height_multiplier = 1.25},
      {text = '[green]tier 2: ' .. t21 .. '%', font = pixul_font, alignment = 'left', height_multiplier = 1.25},
      {text = '[blue]tier 3: ' .. t31 .. '%', font = pixul_font, alignment = 'left', height_multiplier = 1.25},
      {text = '[purple]tier 4: ' .. t41 .. '%', font = pixul_font, alignment = 'left', height_multiplier = 1.25},
    }, nil, nil, nil, nil, 16, 4, nil, 2)
    self.info_text.x, self.info_text.y = gw/2, gh/2 - 45
  end
end


function LevelButton:on_mouse_enter()
  ui_hover1:play{pitch = random:float(1.3, 1.5), volume = 0.5}
  pop2:play{pitch = random:float(0.95, 1.05), volume = 0.5}
  self.selected = true
  self.text:set_text{{text = '[fgm5]' .. tostring(self.parent.shop_level), font = pixul_font, alignment = 'center'}}
  self.spring:pull(0.2, 200, 10)
  self:create_info_text()
end


function LevelButton:on_mouse_exit()
  self.text:set_text{{text = '[bg10]' .. tostring(self.parent.shop_level), font = pixul_font, alignment = 'center'}}
  self.selected = false
  if self.info_text then
    self.info_text:deactivate()
    self.info_text.dead = true
  end
  self.info_text = nil
end




RerollButton = Object:extend()
RerollButton:implement(GameObject)
function RerollButton:init(args)
  self:init_game_object(args)
  self.interact_with_mouse = true
  if self.parent:is(BuyScreen) then
    self.shape = Rectangle(self.x, self.y, 54, 16)
    if self.parent.level > 1 then
      self.text = Text({{text = '[bg10]reroll: [yellow]2', font = pixul_font, alignment = 'center'}}, global_text_tags)
    else
      self.text = Text({{text = '[bg10]reroll: [white]0', font = pixul_font, alignment = 'center'}}, global_text_tags)
    end
  elseif self.parent:is(Arena) then
    self.shape = Rectangle(self.x, self.y, 60, 16)
    local merchant
    for _, unit in ipairs(self.parent.starting_units) do
      if unit.character == 'merchant' then
        merchant = unit
        break
      end
    end
    if self.parent.level == 3 or (merchant and merchant.level == 3) then
      self.free_reroll = true
      self.text = Text({{text = '[bg10]reroll: [yellow]0', font = pixul_font, alignment = 'center'}}, global_text_tags)
    else
      self.text = Text({{text = '[bg10]reroll: [yellow]5', font = pixul_font, alignment = 'center'}}, global_text_tags)
    end
  end
end


function RerollButton:update(dt)
  self:update_game_object(dt)

  if (self.selected and input.m1.pressed) or input.r.pressed then
    if self.parent:is(BuyScreen) then
      if gold < 2 and self.parent.level > 1 then
        self.spring:pull(0.2, 200, 10)
        self.selected = true
        error1:play{pitch = random:float(0.95, 1.05), volume = 0.5}
        if not self.info_text then
          self.info_text = InfoText{group = main.current.ui}
          self.info_text:activate({
            {text = '[fg]not enough gold', font = pixul_font, alignment = 'center'},
          }, nil, nil, nil, nil, 16, 4, nil, 2)
          self.info_text.x, self.info_text.y = gw/2, gh/2 + 10
        end
        self.t:after(2, function() self.info_text:deactivate(); self.info_text.dead = true; self.info_text = nil end, 'info_text')
      else
        ui_switch2:play{pitch = random:float(0.95, 1.05), volume = 0.5}
        self.parent.locked = false
        self.parent:set_cards(self.parent.shop_level, true)
        locked_state = {locked = self.parent.locked, cards = {self.parent.cards[1] and self.parent.cards[1].unit, self.parent.cards[2] and self.parent.cards[2].unit, self.parent.cards[3] and self.parent.cards[3].unit}} 
        self.selected = true
        self.spring:pull(0.2, 200, 10)
        if self.parent.level > 1 then
          gold = gold - 2
        end
        self.parent.shop_text:set_text{{text = '[wavy_mid, fg]shop [fg]- [fg, nudge_down]gold: [yellow, nudge_down]' .. gold, font = pixul_font, alignment = 'center'}}
        save_run_by_ref(self.parent)
      end
    elseif self.parent:is(Arena) then
      if gold < 5 and not self.free_reroll then
        self.spring:pull(0.2, 200, 10)
        self.selected = true
        error1:play{pitch = random:float(0.95, 1.05), volume = 0.5}
        if not self.info_text then
          self.info_text = InfoText{group = main.current.ui, force_update = true}
          self.info_text:activate({
            {text = '[fg]not enough gold', font = pixul_font, alignment = 'center'},
          }, nil, nil, nil, nil, 16, 4, nil, 2)
          self.info_text.x, self.info_text.y = gw/2, gh/2 + 10
        end
        self.t:after(2, function() self.info_text:deactivate(); self.info_text.dead = true; self.info_text = nil end, 'info_text')
      else
        ui_switch2:play{pitch = random:float(0.95, 1.05), volume = 0.5}
        self.parent:set_passives(true)
        self.selected = true
        self.spring:pull(0.2, 200, 10)
        if not self.free_reroll then gold = gold - 5 end
        self.parent.shop_text:set_text{{text = '[fg, nudge_down]gold: [yellow, nudge_down]' .. gold, font = pixul_font, alignment = 'center'}}
        self.free_reroll = false
        self.text = Text({{text = '[bg10]reroll: [yellow]5', font = pixul_font, alignment = 'center'}}, global_text_tags)
      end
    end

    if input.r.pressed then self.selected = false end
  end
end


function RerollButton:draw()
  graphics.push(self.x, self.y, 0, self.spring.x, self.spring.y)
    if self.parent:is(Arena) then
      graphics.rectangle(self.x, self.y, self.shape.w, self.shape.h, 4, 4, self.selected and fg[0] or bg[-2])
    else
      graphics.rectangle(self.x, self.y, self.shape.w, self.shape.h, 4, 4, self.selected and fg[0] or bg[1])
    end
    self.text:draw(self.x, self.y + 1)
  graphics.pop()
end


function RerollButton:on_mouse_enter()
  ui_hover1:play{pitch = random:float(1.3, 1.5), volume = 0.5}
  pop2:play{pitch = random:float(0.95, 1.05), volume = 0.5}
  self.selected = true
  if self.parent:is(BuyScreen) then
    if self.parent.level > 1 then
      self.text:set_text{{text = '[fgm5]reroll: 2', font = pixul_font, alignment = 'center'}}
    else
      self.text:set_text{{text = '[fgm5]reroll: 0', font = pixul_font, alignment = 'center'}}
    end
  elseif self.parent:is(Arena) then
    if self.free_reroll then
      self.text:set_text{{text = '[fgm5]reroll: 0', font = pixul_font, alignment = 'center'}}
    else
      self.text:set_text{{text = '[fgm5]reroll: 5', font = pixul_font, alignment = 'center'}}
    end
  end
  self.spring:pull(0.2, 200, 10)
end


function RerollButton:on_mouse_exit()
  if self.parent:is(BuyScreen) then
    if self.parent.level > 1 then
      self.text:set_text{{text = '[bg10]reroll: [yellow]2', font = pixul_font, alignment = 'center'}}
    else
      self.text:set_text{{text = '[bg10]reroll: [white]0', font = pixul_font, alignment = 'center'}}
    end
  elseif self.parent:is(Arena) then
    if self.free_reroll then
      self.text:set_text{{text = '[fgm5]reroll: [yellow]0', font = pixul_font, alignment = 'center'}}
    else
      self.text:set_text{{text = '[fgm5]reroll: [yellow]5', font = pixul_font, alignment = 'center'}}
    end
  end
  self.selected = false
end




TutorialCharacterPart = Object:extend()
TutorialCharacterPart:implement(GameObject)
function TutorialCharacterPart:init(args)
  self:init_game_object(args)
  self.shape = Rectangle(self.x, self.y, self.sx*20, self.sy*20)
  self.interact_with_mouse = true
  self.spring:pull(0.2, 200, 10)
end


function TutorialCharacterPart:update(dt)
  self:update_game_object(dt)
end


function TutorialCharacterPart:draw()
  graphics.push(self.x, self.y, 0, self.sx*self.spring.x, self.sy*self.spring.x)
    graphics.rectangle(self.x, self.y, 14, 14, 3, 3, self.highlighted and fg[0] or character_colors[self.character])
    graphics.print_centered(self.level, pixul_font, self.x + 0.5, self.y + 2, 0, 1, 1, 0, 0, self.highlighted and fg[-5] or _G[character_color_strings[self.character]][-10])
  graphics.pop()
end


function TutorialCharacterPart:on_mouse_enter()
  ui_hover1:play{pitch = random:float(1.3, 1.5), volume = 0.5}
  self.selected = true
  self.spring:pull(0.2, 200, 10)
  self.info_text = InfoText{group = main.current.tutorial}
  self.info_text:activate({
    {text = '[' .. character_color_strings[self.character] .. ']' .. self.character:capitalize() .. '[fg] - [yellow]Lv.' .. self.level,
    font = pixul_font, alignment = 'center', height_multiplier = 1.25},
    {text = '[fg]Classes: ' .. character_class_strings[self.character], font = pixul_font, alignment = 'center', height_multiplier = 1.25},
    {text = character_descriptions[self.character](self.level), font = pixul_font, alignment = 'center', height_multiplier = 2},
    {text = '[' .. (self.level == 3 and 'yellow' or 'light_bg') .. ']Lv.3 [' .. (self.level == 3 and 'fg' or 'light_bg') .. ']Effect - ' .. 
      (self.level == 3 and character_effect_names[self.character] or character_effect_names_gray[self.character]), font = pixul_font, alignment = 'center', height_multiplier = 1.25},
    {text = (self.level == 3 and character_effect_descriptions[self.character]() or character_effect_descriptions_gray[self.character]()), font = pixul_font, alignment = 'center'},
  }, nil, nil, nil, nil, 16, 4, nil, 2)
  self.info_text.x, self.info_text.y = gw/2, gh/2 + gh/4 - 12
end


function TutorialCharacterPart:on_mouse_exit()
  self.selected = false
  if self.info_text then
    self.info_text:deactivate()
    self.info_text.dead = true
  end
  self.info_text = nil
end



CharacterPart = Object:extend()
CharacterPart:implement(GameObject)
function CharacterPart:init(args)
  self:init_game_object(args)
  self.shape = Rectangle(self.x, self.y, self.sx*20, self.sy*20)
  self.interact_with_mouse = true
  self.parts = {}
  local x = self.x - 20
  if self.reserve then
    if self.reserve[2] and self.reserve[2] == 1 then
      table.insert(self.parts, CharacterPart{group = main.current.main, x = x, y = self.y, character = self.character, level = 2, i = self.i, parent = self})
      x = x - 20
    end
    for i = 1, self.reserve and self.reserve[1] or 0 do
      table.insert(self.parts, CharacterPart{group = main.current.main, x = x, y = self.y, character = self.character, level = 1, sx = 0.9, sy = 0.9, i = self.i, parent = self})
      x = x - 20
    end
  end
  self.spring:pull(0.2, 200, 10)
  if self.spawn_effect then SpawnEffect{group = main.current.effects, x = self.x, y = self.y, color = character_colors[self.character]} end
  self.just_created = true
  self.t:after(0.1, function() self.just_created = false end)
end


function CharacterPart:update(dt)
  self:update_game_object(dt)

  if self.cant_click then return end

  if not self.parent:is(CharacterPart) then
    if input.m1.pressed and self.colliding_with_mouse then
      self.grabbed = true
      self.parent.unit_grabbed = self
    end

    if self.grabbed and input.m1.released then
      self.grabbed = false
      self.parent.unit_grabbed = false
      self.spring:pull(0.2, 200, 10)
      --[[
      for i, unit in ipairs(self.parent.units) do
        print(unit.character)
      end
      for i, character in ipairs(self.parent.characters) do
        print(character.y, character.character, character.shape.y)
      end
      ]]--
      see_oversyns(self.parent.units)
      save_run_by_ref(self.parent)
    end

    for _, part in ipairs(self.parts) do
      part.grabbed = self.grabbed
    end

    if self.parent.unit_grabbed and self.parent.unit_grabbed == self then
      local x, y = camera:get_mouse_position()
      local i
      if y >= self.y - 19 and y <= self.y + 19 then i = self.i
      elseif y < self.y - 19 then i = self.i - 1
      elseif y > self.y + 19 then i = self.i + 1
      end
      i = math.clamp(i, 1, #self.parent.units)
      -- i = math.clamp(math.floor((y - 40)/19) + 1, 1, #self.parent.units)
      self.parent.units[self.i], self.parent.units[i] = self.parent.units[i], self.parent.units[self.i]
      self.parent.characters[self.i], self.parent.characters[i] = self.parent.characters[i], self.parent.characters[self.i]
      self.parent.characters[self.i].i, self.parent.characters[i].i = self.i, i
    end
  end

  if self.selected and input.m2.pressed and not self.just_created then
    _G[random:table{'coins1', 'coins2', 'coins3'}]:play{pitch = random:float(0.95, 1.05), volume = 0.5}
    if self.reserve then
      self.parent:gain_gold(self:get_sale_price())
      table.remove(self.parent.units, self.i)
      self:die()
      self.parent:set_party_and_sets()
      self.parent:refresh_cards()
      self.parent.party_text:set_text({{text = '[wavy_mid, fg]party ' .. tostring(#self.parent.units) .. '/' .. tostring(max_units), font = pixul_font, alignment = 'center'}})
      save_run_by_ref(self.parent)
    else
      self.parent.parent:gain_gold(self:get_sale_price())
      self.parent.parent.units[self.i].reserve[self.level] = self.parent.parent.units[self.i].reserve[self.level] - 1
      self:die()
      self.parent.parent:set_party_and_sets()
      self.parent.parent:refresh_cards()
      save_run_by_ref(self.parent.parent)
    end
  end

  self.shape:move_to(self.x, self.y)
  for _, part in ipairs(self.parts) do
    part.y = self.y
  end
end


function CharacterPart:draw(y)
  graphics.push(self.x, self.y, 0, self.sx*self.spring.x, self.sy*self.spring.x)
    if self.grabbed then
      --[[
      graphics.rectangle(self.x, self.y, 14, 14, 3, 3, bg[5])
      graphics.print_centered(self.level, pixul_font, self.x + 0.5, self.y + 2, 0, 1, 1, 0, 0, bg[10])
      ]]--
    else
      graphics.rectangle(self.x, self.y, 14, 14, 3, 3, self.highlighted and bg[10] or character_colors[self.character])
      graphics.print_centered(self.level, pixul_font, self.x + 0.5, self.y + 2, 0, 1, 1, 0, 0, self.highlighted and bg[5] or _G[character_color_strings[self.character]][-10])
    end
    if y then
      graphics.rectangle(self.x, y, 14, 14, 3, 3, bg[5])
      graphics.print_centered(self.level, pixul_font, self.x + 0.5, y + 2, 0, 1, 1, 0, 0, bg[10])
    end
  graphics.pop()
end


function CharacterPart:on_mouse_enter()
  ui_hover1:play{pitch = random:float(1.3, 1.5), volume = 0.5}
  self.selected = true
  self.spring:pull(0.2, 200, 10)
  self.info_text = InfoText{group = main.current.ui, force_update = self.force_update}
  self.info_text:activate({
    {text = '[' .. character_color_strings[self.character] .. ']' .. self.character:capitalize() .. '[fg] - [yellow]Lv.' .. self.level .. '[fg], tier [yellow]' .. character_tiers[self.character] .. '[fg] - sells for [yellow]' ..
      self:get_sale_price(), font = pixul_font, alignment = 'center', height_multiplier = 1.25},
    {text = '[fg]Classes: ' .. character_class_strings[self.character], font = pixul_font, alignment = 'center', height_multiplier = 1.25},
    {text = character_descriptions[self.character](self.level), font = pixul_font, alignment = 'center', height_multiplier = 2},
    {text = '[' .. (self.level == 3 and 'yellow' or 'light_bg') .. ']Lv.3 [' .. (self.level == 3 and 'fg' or 'light_bg') .. ']Effect - ' .. 
      (self.level == 3 and character_effect_names[self.character] or character_effect_names_gray[self.character]), font = pixul_font, alignment = 'center', height_multiplier = 1.25},
    {text = (self.level == 3 and character_effect_descriptions[self.character]() or character_effect_descriptions_gray[self.character]()), font = pixul_font, alignment = 'center'},
    {text = 'Dmg last round: [red]' .. (math.floor(damage_counters[self.character]) or '???'), font = pixul_font, alignment = 'center'},
    (self.lead) and {text = 'Body dmg -//-: [yellow]' .. (math.floor(damage_counters['body']) or '???'), font = pixul_font, alignment = 'center'} or nil,
    (self.lead) and {text = 'Kinetic dmg -//-: [yellowforc]' .. (math.floor(damage_counters['kinetic']) or '???'), font = pixul_font, alignment = 'center'} or nil,
    (self.lead) and {text = 'Other dmg -//-: [red]' .. (math.floor(damage_counters['other']) or '???'), font = pixul_font, alignment = 'center'} or nil,
  }, nil, nil, nil, nil, 16, 4, nil, 2)
  self.info_text.x, self.info_text.y = gw/2, gh/2 + 10

  --[[
  if self.parent:is(BuyScreen) then
    for _, set in ipairs(self.parent.sets) do
      if table.any(character_classes[self.character], function(v) return v == set.class end) then
        set:highlight()
      end
    end
  end
  ]]--
end


function CharacterPart:get_sale_price()
  if not character_tiers[self.character] then return 0 end
  local total = 0
  total = total + ((self.level == 1 and character_tiers[self.character]) or (self.level == 2 and 2*character_tiers[self.character]) or (self.level == 3 and 6*character_tiers[self.character]) or 0)
  if self.reserve then
    if self.reserve[2] then total = total + self.reserve[2]*character_tiers[self.character]*2 end
    if self.reserve[1] then total = total + self.reserve[1]*character_tiers[self.character] end
  end
  return total
end


function CharacterPart:on_mouse_exit()
  self.selected = false
  if self.info_text then
    self.info_text:deactivate()
    self.info_text.dead = true
  end
  self.info_text = nil

  --[[
  if self.parent:is(BuyScreen) then
    for _, set in ipairs(self.parent.sets) do
      if table.any(character_classes[self.character], function(v) return v == set.class end) then
        set:unhighlight()
      end
    end
  end
  ]]--
end


function CharacterPart:die()
  self.dead = true
  for _, part in ipairs(self.parts) do part:die() end
  if self.info_text then
    self.info_text:deactivate()
    self.info_text.dead = true
    self.info_text = nil
  end

  --[[
  if self.selected and self.parent:is(BuyScreen) then
    for _, set in ipairs(self.parent.sets) do
      if table.any(character_classes[self.character], function(v) return v == set.class end) then
        set:unhighlight()
      end
    end
  end
  ]]--
end


function CharacterPart:highlight()
  self.highlighted = true
  self.spring:pull(0.2, 200, 10)
end


function CharacterPart:unhighlight()
  self.highlighted = false
  self.spring:pull(0.05, 200, 10)
end




PassiveCard = Object:extend()
PassiveCard:implement(GameObject)
function PassiveCard:init(args)
  self:init_game_object(args)
  self.shape = Rectangle(self.x, self.y, self.w, self.h)
  self.interact_with_mouse = true
  self.passive_name =  Text({{text = '[fg, wavy_mid]' .. passive_names[self.passive], font = pixul_font, alignment = 'center'}}, global_text_tags)
  self.passive_description = passive_descriptions[self.passive]
  self.spring:pull(0.2, 200, 10)
end


function PassiveCard:update(dt)
  self:update_game_object(dt)
  self.passive_name:update(dt)

  if ((self.selected and input.m1.released) or input[tostring(self.card_i)].pressed) and self.arena.choosing_passives then
    self.arena.choosing_passives = false
    table.insert(self.arena.passives, {passive = self.passive, level = 1, xp = 0})
    self.arena:restore_passives_to_pool(self.card_i)
    trigger:tween(0.25, _G, {slow_amount = 1, music_slow_amount = 1}, math.linear, function()
      slow_amount = 1
      music_slow_amount = 1
      self.arena:transition()
    end)
    ui_switch1:play{pitch = random:float(0.95, 1.05), volume = 0.5}
    self:die()
  end
end


function PassiveCard:draw()
  graphics.push(self.x, self.y, 0, self.sx*self.spring.x, self.sy*self.spring.x)
    self.passive_name:draw(self.x, self.y - 20)
    _G[self.passive]:draw(self.x, self.y + 24, 0, 1, 1, 0, 0, fg[0])
  graphics.pop()
end


function PassiveCard:on_mouse_enter()
  self.selected = true
  ui_hover1:play{pitch = random:float(1.3, 1.5), volume = 0.5}
  self.spring:pull(0.2, 200, 10)
  self.info_text = InfoText{group = main.current.ui, force_update = true}
  self.info_text:activate({
    {text = self.passive_description, font = pixul_font, alignment = 'center', height_multiplier = 1.25},
  }, nil, nil, nil, nil, 16, 4, nil, 2)
  self.info_text.x, self.info_text.y = gw/2, gh/2 + gh/4 - 6
end


function PassiveCard:on_mouse_exit()
  self.selected = false
  self.info_text:deactivate()
  self.info_text.dead = true
  self.info_text = nil
end


function PassiveCard:die()
  self.dead = true
  if self.info_text then
    self.info_text:deactivate()
    self.info_text.dead = true
    self.info_text = nil
  end
end


--type 1 is BODY; type 2 is MOUTHS
LateUpgradeButton = Object:extend()
LateUpgradeButton:implement(GameObject)
function LateUpgradeButton:init(args)
  self:init_game_object(args)
  self.shape = Rectangle(self.x, self.y, 16, 26)
  self.interact_with_mouse = true
  self.type = args.type
  --self.lateup_txt =  Text({{text = lateup_descs[self.type], font = pixul_font, alignment = 'center'}}, global_text_tags)
  self.t:every(0.5, function() self.flash = not self.flash end)
  self.spring:pull(0.2, 200, 10)
end


function LateUpgradeButton:update(dt)
  self:update_game_object(dt)
  if self.selected and input.m1.released then
    if gold >= 200 then
      ui_switch1:play{pitch = random:float(0.95, 1.05), volume = 0.5}
      _G[random:table{'coins1', 'coins2', 'coins3'}]:play{pitch = random:float(0.95, 1.05), volume = 0.5}
      gold = gold - 200
      self.parent.shop_text:set_text{{text = '[wavy_mid, fg]shop [fg]- [fg, nudge_down]gold: [yellow, nudge_down]' .. gold, font = pixul_font, alignment = 'center'}}
      lateupgrade(self.type)
      self:on_mouse_exit()
      self:on_mouse_enter()
      save_run_by_ref(self.parent)
    else
      error1:play{pitch = random:float(0.95, 1.05), volume = 0.5}
      self.spring:pull(0.2, 200, 10)
    end
  end
end


function LateUpgradeButton:draw()
  graphics.push(self.x, self.y, 0, self.sx*self.spring.x, self.sy*self.spring.x)
  graphics.rectangle(self.x, self.y, 16, 24, 4, 4, self.highlighted and fg[0] or lateup_bgcol[self.type])
  lateup_imgs[self.type]:draw(self.x, self.y, 0, 0.3, 0.3, 0, 0, self.highlighted and fg[-5] or lateup_fgcol[self.type])
  graphics.pop()
end


function LateUpgradeButton:on_mouse_enter()
  self.selected = true
  ui_hover1:play{pitch = random:float(1.3, 1.5), volume = 0.5}
  self.spring:pull(0.2, 200, 10)
  local newblvl = lateup_lvls[1]
  local newmlvl = lateup_lvls[2]
  if self.type == 1 then newblvl = newblvl + 1 else newmlvl = newmlvl + 1 end
  self.info_text = InfoText{group = main.current.ui, force_update = true}
  self.info_text:activate({
    {text = strc({self.type==1 and "[greenheal]" or "[red]",self.type==1 and "Body " or "Mouths ",lateup_lvls[self.type]}), font = pixul_font, alignment = 'center', height_multiplier = 1.25},
    {text = "[fg]Current:", font = pixul_font, alignment = 'center', height_multiplier = 1.25},
    {text = "[yellow]"..lateup_descs[self.type][1](), font = pixul_font, alignment = 'center', height_multiplier = 1.25},
    {text = "[yellow]"..lateup_descs[self.type][2](), font = pixul_font, alignment = 'center', height_multiplier = 1.25},
    {text = "[fg]Next upgrade:", font = pixul_font, alignment = 'center', height_multiplier = 1.25},
    {text = "[fg]"..lateup_descs[self.type][1](newblvl, newmlvl), font = pixul_font, alignment = 'center', height_multiplier = 1.25},
    {text = "[fg]"..lateup_descs[self.type][2](newblvl, newmlvl), font = pixul_font, alignment = 'center', height_multiplier = 1.25},
    {text = "[yellow]Click to buy for 200 gold", font = pixul_font, alignment = 'center', height_multiplier = 1.25},
  }, nil, nil, nil, nil, 16, 4, nil, 2)
  self.info_text.x, self.info_text.y = gw/2, gh/2 + gh/4 - 6
end


function LateUpgradeButton:on_mouse_exit()
  self.selected = false
  if self.info_text then
    self.info_text:deactivate()
    self.info_text.dead = true
    self.info_text = nil
  end
end


function LateUpgradeButton:die()
  self.dead = true
  if self.info_text then
    self.info_text:deactivate()
    self.info_text.dead = true
    self.info_text = nil
  end
end


ItemCard = Object:extend()
ItemCard:implement(GameObject)
function ItemCard:init(args)
  self:init_game_object(args)
  self.shape = Rectangle(self.x, self.y, self.w, self.h)
  self.interact_with_mouse = true
  self.max_xp = (self.level == 0 and 0) or (self.level == 1 and 2) or (self.level == 2 and 3) or (self.level == 3 and 0)
  self.unlevellable = table.any(unlevellable_items, function(v) return v == self.passive end)
end


function ItemCard:update(dt)
  self:update_game_object(dt)

  if self.parent:is(Arena) then return end

  if self.selected and input.m1.released and not self.unlevellable then
    if self.level >= 3 then return end
    if gold < 5 then
      self.spring:pull(0.2, 200, 10)
      self.selected = true
      error1:play{pitch = random:float(0.95, 1.05), volume = 0.5}
      if not self.info_text_2 then
        self.info_text_2 = InfoText{group = main.current.ui}
        self.info_text_2:activate({
          {text = '[fg]not enough gold', font = pixul_font, alignment = 'center'},
        }, nil, nil, nil, nil, 16, 4, nil, 2)
        self.info_text_2.x, self.info_text_2.y = gw/2, gh/2 + 30
      end
      self.t:after(2, function() self.info_text_2:deactivate(); self.info_text_2.dead = true; self.info_text_2 = nil end, 'info_text_2')
    else
      ui_switch2:play{pitch = random:float(0.95, 1.05), volume = 0.5}
      self.xp = self.xp + 1
      if self.xp >= self.max_xp then
        self.xp = 0
        self.level = self.level + 1
        self.max_xp = (self.level == 0 and 0) or (self.level == 1 and 2) or (self.level == 2 and 3) or (self.level == 3 and 0)
        if self.level == 2 then spawn_mark1:play{pitch = 1, volume = 0.6} end
        if self.level == 3 then
          spawn_mark1:play{pitch = 1.2, volume = 0.6}
          level_up1:play{pitch = 1, volume = 0.5}
        end
      end
      self:create_info_text()
      self.selected = true
      self.spring:pull(0.2, 200, 10)
      gold = gold - 5
      for _, passive in ipairs(self.parent.passives) do
        if passive.passive == self.passive then
          passive.level = self.level
          passive.xp = self.xp
        end
      end
      self.parent.shop_text:set_text{{text = '[wavy_mid, fg]shop [fg]- [fg, nudge_down]gold: [yellow, nudge_down]' .. gold, font = pixul_font, alignment = 'center'}}
      self.text = Text({{text = '[bg10]' .. tostring(self.parent.shop_level), font = pixul_font, alignment = 'center'}}, global_text_tags)
      save_run_by_ref(self.parent)
    end
  end

  if self.selected and input.m2.pressed then
    _G[random:table{'coins1', 'coins2', 'coins3'}]:play{pitch = random:float(0.95, 1.05), volume = 0.5}
    self.parent:gain_gold((self.level == 1 and 10) or (self.level == 2 and 20) or (self.level == 3 and 30))
    table.insert(run_passive_pool, self.passive)
    table.remove(self.parent.passives, self.i)
    input.m2.pressed = false
    self.parent:set_items()
    save_run_by_ref(self.parent)
  end
end


function ItemCard:draw()
  graphics.push(self.x, self.y, 0, self.sx*self.spring.x, self.sy*self.spring.x)
    if self.selected then
      graphics.rectangle(self.x, self.y, self.w, self.h, 6, 6, bg[-1])
    end
    _G[self.passive]:draw(self.x, self.y, 0, 0.8, 0.7, 0, 0, fg[0])
    if not self.unlevellable and not self.parent:is(Arena) then
      local x, y = self.x + self.w/2.5, self.y - self.h/2.5
      if self.level == 1 then
        graphics.rectangle(x - 2, y, 2, 2, nil, nil, self.xp >= 1 and fg[0] or bg[5])
        graphics.rectangle(x + 2, y, 2, 2, nil, nil, bg[5])
      elseif self.level == 2 then
        graphics.rectangle(x - 4, y, 2, 2, nil, nil, self.xp >= 1 and fg[0] or bg[5])
        graphics.rectangle(x, y, 2, 2, nil, nil, self.xp >= 2 and fg[0] or bg[5])
        graphics.rectangle(x + 4, y, 2, 2, nil, nil, bg[5])
      end
    end
  graphics.pop()
end


function ItemCard:create_info_text()
  if self.info_text then
    self.info_text:deactivate()
    self.info_text.dead = true
  end
  self.info_text = nil
  if self.level == 3 or self.unlevellable then
    self.info_text = InfoText{group = main.current.ui, force_update = true}
    self.info_text:activate({
      {text = '[fg]' .. passive_names[self.passive] .. ', [yellow]Lv.' .. self.level, font = pixul_font, alignment = 'center',
        height_multiplier = 1.25},
      {text = passive_descriptions_level[self.passive](self.level), font = pixul_font, alignment = 'center', height_multiplier = 1.25},
    }, nil, nil, nil, nil, 16, 4, nil, 2)
    self.info_text.x, self.info_text.y = gw/2, gh/2 + 10
  else
    self.info_text = InfoText{group = main.current.ui, force_update = true}
    self.info_text:activate({
      {text = '[fg]' .. passive_names[self.passive] .. ', [yellow]Lv.' .. self.level .. '[fg], XP: [yellow]' .. self.xp .. '/' .. self.max_xp .. '[fg], +1 XP cost: [yellow]5[fg], sells for: [yellow]' .. 
        tostring((self.level == 1 and 10) or (self.level == 2 and 20) or (self.level == 3 and 30)), font = pixul_font, alignment = 'center', height_multiplier = 1.25},
      {text = passive_descriptions_level[self.passive](self.level), font = pixul_font, alignment = 'center', height_multiplier = 1.25},
    }, nil, nil, nil, nil, 16, 4, nil, 2)
    self.info_text.x, self.info_text.y = gw/2, gh/2 + 10
  end
end


function ItemCard:on_mouse_enter()
  self.selected = true
  ui_hover1:play{pitch = random:float(1.3, 1.5), volume = 0.5}
  self.spring:pull(0.2, 200, 10)
  self:create_info_text()
end


function ItemCard:on_mouse_exit()
  self.selected = false
  self.info_text:deactivate()
  self.info_text.dead = true
  self.info_text = nil
end


function ItemCard:die()
  self.dead = true
  if self.info_text then
    self.info_text:deactivate()
    self.info_text.dead = true
    self.info_text = nil
  end
end


function BuyScreen:refresh_cards()
  for i = 1, 3 do
    if self.cards[i] then
      self.cards[i]:refresh()
    end
  end
end



ShopCard = Object:extend()
ShopCard:implement(GameObject)
function ShopCard:init(args)
  self:init_game_object(args)
  self.shape = Rectangle(self.x, self.y, self.w, self.h)
  self.interact_with_mouse = true
  self.character_icon = CharacterIcon{group = main.current.effects, x = self.x, y = self.y - 26, character = self.unit, parent = self}
  self.class_icons = {}
  for i, class in ipairs(character_classes[self.unit]) do
    local x = self.x
    if #character_classes[self.unit] == 2 then x = self.x - 10
    elseif #character_classes[self.unit] == 3 then x = self.x - 20
    elseif #character_classes[self.unit] == 4 then x = self.x - 30 end
    table.insert(self.class_icons, ClassIcon{group = main.current.effects, x = x + (i-1)*20, y = self.y + 6, class = class, character = self.unit, units = self.parent.units, parent = self})
  end
  self.cost = character_tiers[self.unit]
  self.spring:pull(0.2, 200, 10)
  self:refresh()
end


function ShopCard:refresh()
  self.owned = table.any(self.parent.units, function(v) return v.character == self.unit end)
  if self.owned then
    self.owned_n = 0
    for _, unit in ipairs(self.parent.units) do
      if unit.character == self.unit then
        self.owned_n = self.owned_n + ((unit.level == 1 and 1) or (unit.level == 2 and 3) or (unit.level == 3 and 9))
        if unit.reserve then
          self.owned_n = self.owned_n + (unit.reserve[2] or 0)*3
          self.owned_n = self.owned_n + (unit.reserve[1] or 0)
        end
      end
    end
  end
end


function ShopCard:update(dt)
  self:update_game_object(dt)

  if (self.selected and input.m1.released) or input[tostring(self.i)].pressed then
    if self.parent:buy(self.unit, self.i) then
      ui_switch1:play{pitch = random:float(0.95, 1.05), volume = 0.5}
      _G[random:table{'coins1', 'coins2', 'coins3'}]:play{pitch = random:float(0.95, 1.05), volume = 0.5}
      self:die()
      self.parent.cards[self.i] = nil
      self.parent:refresh_cards()
      self.parent.party_text:set_text({{text = '[wavy_mid, fg]party ' .. tostring(#self.parent.units) .. '/' .. tostring(max_units), font = pixul_font, alignment = 'center'}})
      locked_state = {locked = self.parent.locked, cards = {self.parent.cards[1] and self.parent.cards[1].unit, self.parent.cards[2] and self.parent.cards[2].unit, self.parent.cards[3] and self.parent.cards[3].unit}} 
      save_run_by_ref(self.parent)
    else
      error1:play{pitch = random:float(0.95, 1.05), volume = 0.5}
      self.spring:pull(0.2, 200, 10)
      self.character_icon.spring:pull(0.2, 200, 10)
      for _, ci in ipairs(self.class_icons) do ci.spring:pull(0.2, 200, 10) end
    end
  end
end


function ShopCard:select()
  self.selected = true
  self.spring:pull(0.2, 200, 10)
  self.t:every_immediate(1.4, function()
    if self.selected then
      self.t:tween(0.7, self, {sx = 0.97, sy = 0.97, plus_r = -math.pi/32}, math.linear, function()
        self.t:tween(0.7, self, {sx = 1.03, sy = 1.03, plus_r = math.pi/32}, math.linear, nil, 'pulse_1')
      end, 'pulse_2')
    end
  end, nil, nil, 'pulse')
end


function ShopCard:unselect()
  self.selected = false
  self.t:cancel'pulse'
  self.t:cancel'pulse_1'
  self.t:cancel'pulse_2'
  self.t:tween(0.1, self, {sx = 1, sy = 1, plus_r = 0}, math.linear, function() self.sx, self.sy, self.plus_r = 1, 1, 0 end, 'pulse')
end


function ShopCard:draw()
  graphics.push(self.x, self.y, 0, self.sx*self.spring.x, self.sy*self.spring.x)
    if self.selected then
      graphics.rectangle(self.x, self.y, self.w, self.h, 6, 6, bg[-1])
    end
    if self.owned then
      local x, y = self.x + self.w/5, self.y - self.h/2 + 12
      if self.owned_n == 1 then
        graphics.rectangle(x, y, 2, 2, nil, nil, character_colors[self.unit])
      elseif self.owned_n == 2 then
        graphics.rectangle(x, y, 2, 2, nil, nil, character_colors[self.unit])
        graphics.rectangle(x + 4, y, 2, 2, nil, nil, character_colors[self.unit])
      elseif self.owned_n == 3 then
        graphics.rectangle(x, y, 4, 4, nil, nil, character_colors[self.unit])
      elseif self.owned_n == 4 then
        graphics.rectangle(x, y, 4, 4, nil, nil, character_colors[self.unit])
        graphics.rectangle(x + 5, y, 2, 2, nil, nil, character_colors[self.unit])
      elseif self.owned_n == 5 then
        graphics.rectangle(x, y, 4, 4, nil, nil, character_colors[self.unit])
        graphics.rectangle(x + 5, y, 2, 2, nil, nil, character_colors[self.unit])
        graphics.rectangle(x + 9, y, 2, 2, nil, nil, character_colors[self.unit])
      elseif self.owned_n == 6 then
        graphics.rectangle(x, y, 4, 4, nil, nil, character_colors[self.unit])
        graphics.rectangle(x + 6, y, 4, 4, nil, nil, character_colors[self.unit])
      elseif self.owned_n == 7 then
        graphics.rectangle(x, y, 4, 4, nil, nil, character_colors[self.unit])
        graphics.rectangle(x + 6, y, 4, 4, nil, nil, character_colors[self.unit])
        graphics.rectangle(x + 11, y, 2, 2, nil, nil, character_colors[self.unit])
      elseif self.owned_n == 8 then
        graphics.rectangle(x, y, 4, 4, nil, nil, character_colors[self.unit])
        graphics.rectangle(x + 6, y, 4, 4, nil, nil, character_colors[self.unit])
        graphics.rectangle(x + 11, y, 2, 2, nil, nil, character_colors[self.unit])
        graphics.rectangle(x + 15, y, 2, 2, nil, nil, character_colors[self.unit])
      end
    end
  graphics.pop()
end


function ShopCard:on_mouse_enter()
  ui_hover1:play{pitch = random:float(1.3, 1.5), volume = 0.5}
  pop2:play{pitch = random:float(0.95, 1.05), volume = 0.5}
  self.selected = true
  self.spring:pull(0.1)
  self.character_icon.spring:pull(0.1, 200, 10)
  for _, class_icon in ipairs(self.class_icons) do
    class_icon.selected = true
    class_icon.spring:pull(0.1, 200, 10)
  end
end


function ShopCard:on_mouse_exit()
  self.selected = false
  for _, class_icon in ipairs(self.class_icons) do class_icon.selected = false end
end


function ShopCard:die(dont_spawn_effect)
  self.dead = true
  self.character_icon:die(dont_spawn_effect)
  for _, class_icon in ipairs(self.class_icons) do class_icon:die(dont_spawn_effect) end
  if self.info_text then
    self.info_text:deactivate()
    self.info_text.dead = true
    self.info_text = nil
  end
end




CharacterIcon = Object:extend()
CharacterIcon:implement(GameObject)
function CharacterIcon:init(args)
  self:init_game_object(args)
  self.shape = Rectangle(self.x, self.y, 40, 20)
  self.interact_with_mouse = true
  self.character_text = Text({{text = '[' .. character_color_strings[self.character] .. ']' .. string.lower(character_names[self.character]), font = pixul_font, alignment = 'center'}}, global_text_tags)
end


function CharacterIcon:update(dt)
  self:update_game_object(dt)
  self.character_text:update(dt)
end


function CharacterIcon:draw()
  graphics.push(self.x, self.y, 0, self.sx*self.spring.x, self.sy*self.spring.x)
    graphics.rectangle(self.x, self.y - 7, 14, 14, 3, 3, character_colors[self.character])
    graphics.print_centered(self.parent.cost, pixul_font, self.x + 0.5, self.y - 5, 0, 1, 1, 0, 0, _G[character_color_strings[self.character]][-10])
    self.character_text:draw(self.x, self.y + 10)
  graphics.pop()
end


function CharacterIcon:on_mouse_enter()
  ui_hover1:play{pitch = random:float(1.3, 1.5), volume = 0.5}
  self.spring:pull(0.2, 200, 10)
  self.info_text = InfoText{group = main.current.ui}
  self.info_text:activate({
    {text = '[' .. character_color_strings[self.character] .. ']' .. self.character:capitalize() .. '[fg] - cost: [yellow]' .. self.parent.cost, font = pixul_font, alignment = 'center', height_multiplier = 1.25},
    {text = '[fg]Classes: ' .. character_class_strings[self.character], font = pixul_font, alignment = 'center', height_multiplier = 1.25},
    {text = character_descriptions[self.character](1), font = pixul_font, alignment = 'center', height_multiplier = 2},
    {text = '[' .. (self.level == 3 and 'yellow' or 'light_bg') .. ']Lv.3 [' .. (self.level == 3 and 'fg' or 'light_bg') .. ']Effect - ' .. 
      (self.level == 3 and character_effect_names[self.character] or character_effect_names_gray[self.character]), font = pixul_font, alignment = 'center', height_multiplier = 1.25},
    {text = (self.level == 3 and character_effect_descriptions[self.character]() or character_effect_descriptions_gray[self.character]()), font = pixul_font, alignment = 'center'},
    -- {text = character_stats[self.character](1), font = pixul_font, alignment = 'center'},
  }, nil, nil, nil, nil, 16, 4, nil, 2)
  self.info_text.x, self.info_text.y = gw/2, gh/2 + 10
end


function CharacterIcon:on_mouse_exit()
  if self.info_text then
    self.info_text:deactivate()
    self.info_text.dead = true
  end
  self.info_text = nil
end


function CharacterIcon:die(dont_spawn_effect)
  self.dead = true
  if not dont_spawn_effect then SpawnEffect{group = main.current.effects, x = self.x, y = self.y + 4, color = character_colors[self.character]} end
  if self.info_text then
    self.info_text:deactivate()
    self.info_text.dead = true
    self.info_text = nil
  end
end



TutorialClassIcon = Object:extend()
TutorialClassIcon:implement(GameObject)
function TutorialClassIcon:init(args)
  self:init_game_object(args)
  self.shape = Rectangle(self.x, self.y + 11, 20, 40)
  self.interact_with_mouse = true
  self.spring:pull(0.2, 200, 10)
end


function TutorialClassIcon:update(dt)
  self:update_game_object(dt)
end


function TutorialClassIcon:draw()
  graphics.push(self.x, self.y, 0, self.sx*self.spring.x, self.sy*self.spring.x)
    local i, j, k, l, n = class_set_numbers[self.class](self.units)

    graphics.rectangle(self.x, self.y, 16, 24, 4, 4, self.highlighted and fg[0] or ((n >= i) and class_colors[self.class] or bg[3]))
    _G[self.class]:draw(self.x, self.y, 0, 0.3, 0.3, 0, 0, self.highlighted and fg[-5] or ((n >= i) and _G[class_color_strings[self.class]][-5] or bg[10]))
    graphics.rectangle(self.x, self.y + 26, 16, 16, 3, 3, self.highlighted and fg[0] or bg[3])
    if i == 2 and not k then
      if self.highlighted then
        graphics.line(self.x - 3, self.y + 20, self.x - 3, self.y + 25, (n >= 1) and fg[-5] or fg[-10], 3)
        graphics.line(self.x - 3, self.y + 27, self.x - 3, self.y + 32, (n >= 2) and fg[-5] or fg[-10], 3)
        graphics.line(self.x + 4, self.y + 20, self.x + 4, self.y + 25, (n >= 3) and fg[-5] or fg[-10], 3)
        graphics.line(self.x + 4, self.y + 27, self.x + 4, self.y + 32, (n >= 4) and fg[-5] or fg[-10], 3)
      else
        graphics.line(self.x - 3, self.y + 20, self.x - 3, self.y + 25, (n >= 1) and class_colors[self.class] or bg[10], 3)
        graphics.line(self.x - 3, self.y + 27, self.x - 3, self.y + 32, (n >= 2) and class_colors[self.class] or bg[10], 3)
        graphics.line(self.x + 4, self.y + 20, self.x + 4, self.y + 25, (n >= 3) and class_colors[self.class] or bg[10], 3)
        graphics.line(self.x + 4, self.y + 27, self.x + 4, self.y + 32, (n >= 4) and class_colors[self.class] or bg[10], 3)
      end
    elseif i == 3 then
      if self.highlighted then
        graphics.line(self.x - 3, self.y + 19, self.x - 3, self.y + 22, (n >= 1) and fg[-5] or fg[-10], 3)
        graphics.line(self.x - 3, self.y + 24, self.x - 3, self.y + 27, (n >= 2) and fg[-5] or fg[-10], 3)
        graphics.line(self.x - 3, self.y + 29, self.x - 3, self.y + 32, (n >= 3) and fg[-5] or fg[-10], 3)
        graphics.line(self.x + 4, self.y + 19, self.x + 4, self.y + 22, (n >= 4) and fg[-5] or fg[-10], 3)
        graphics.line(self.x + 4, self.y + 24, self.x + 4, self.y + 27, (n >= 5) and fg[-5] or fg[-10], 3)
        graphics.line(self.x + 4, self.y + 29, self.x + 4, self.y + 32, (n >= 6) and fg[-5] or fg[-10], 3)
      else
        graphics.line(self.x - 3, self.y + 19, self.x - 3, self.y + 22, (n >= 1) and class_colors[self.class] or bg[10], 3)
        graphics.line(self.x - 3, self.y + 24, self.x - 3, self.y + 27, (n >= 2) and class_colors[self.class] or bg[10], 3)
        graphics.line(self.x - 3, self.y + 29, self.x - 3, self.y + 32, (n >= 3) and class_colors[self.class] or bg[10], 3)
        graphics.line(self.x + 4, self.y + 19, self.x + 4, self.y + 22, (n >= 4) and class_colors[self.class] or bg[10], 3)
        graphics.line(self.x + 4, self.y + 24, self.x + 4, self.y + 27, (n >= 5) and class_colors[self.class] or bg[10], 3)
        graphics.line(self.x + 4, self.y + 29, self.x + 4, self.y + 32, (n >= 6) and class_colors[self.class] or bg[10], 3)
      end
    end
  graphics.pop()
end


function TutorialClassIcon:on_mouse_enter()
  ui_hover1:play{pitch = random:float(1.3, 1.5), volume = 0.5}
  self.spring:pull(0.2, 200, 10)
  local i, j, k, l, owned = class_set_numbers[self.class](self.units)
  self.info_text = InfoText{group = main.current.tutorial}
  self.info_text:activate({
    {text = '[' .. class_color_strings[self.class] .. ']' .. self.class:capitalize() .. '[fg] - owned: [yellow]' .. owned, font = pixul_font, alignment = 'center', height_multiplier = 1.25},
    {text = class_descriptions[self.class]((owned >= j and 2) or (owned >= i and 1) or 0), font = pixul_font, alignment = 'center'},
  }, nil, nil, nil, nil, 16, 4, nil, 2)
  self.info_text.x, self.info_text.y = gw/2 - 25, gh/2 + 25
end


function TutorialClassIcon:on_mouse_exit()
  if self.info_text then
    self.info_text:deactivate()
    self.info_text.dead = true
  end
  self.info_text = nil
end




ClassIcon = Object:extend()
ClassIcon:implement(GameObject)
function ClassIcon:init(args)
  self:init_game_object(args)
  self.shape = Rectangle(self.x, self.y + 11, 20, 40)
  self.interact_with_mouse = true
  self.t:every(0.5, function() self.flash = not self.flash end)
  self.spring:pull(0.2, 200, 10)
end


function ClassIcon:update(dt)
  self:update_game_object(dt)
  local synboost = true if self.parent.cost then synboost = false end
  if synboost then
    if self.selected and input.m1.released then
      if gold >= 300 and (syn_pow[self.class] < sp_max[self.class] or sp_max[self.class] == 0) then
        ui_switch1:play{pitch = random:float(0.95, 1.05), volume = 0.5}
        _G[random:table{'coins1', 'coins2', 'coins3'}]:play{pitch = random:float(0.95, 1.05), volume = 0.5}
        syn_pow[self.class] = syn_pow[self.class] + 1
        gold = gold - 300
        self.parent.shop_text:set_text{{text = '[wavy_mid, fg]shop [fg]- [fg, nudge_down]gold: [yellow, nudge_down]' .. gold, font = pixul_font, alignment = 'center'}}
        syn_calcs[self.class]()
        self:on_mouse_exit()
        self:on_mouse_enter()
        save_run_by_ref(self.parent)
      else
        error1:play{pitch = random:float(0.95, 1.05), volume = 0.5}
        self.spring:pull(0.2, 200, 10)
      end
    end
  end
end


function ClassIcon:draw()
  graphics.push(self.x, self.y, 0, self.sx*self.spring.x, self.sy*self.spring.x)
    local i, j, k, l, n = class_set_numbers[self.class](self.units)
    local next_n
    if self.parent:is(ShopCard) then
      next_n = n+1
      if l then
        if next_n > l then next_n = nil end
      elseif k then
        if next_n > k then next_n = nil end
      else
        if next_n > j then next_n = nil end
      end
      if table.any(self.units, function(v) return v.character == self.character end) then next_n = nil end
    end

    graphics.rectangle(self.x, self.y, 16, 24, 4, 4, self.highlighted and fg[0] or ((n >= i) and class_colors[self.class] or bg[3]))
    _G[self.class]:draw(self.x, self.y, 0, 0.3, 0.3, 0, 0, self.highlighted and fg[-5] or ((n >= i) and _G[class_color_strings[self.class]][-5] or bg[10]))
    self.y = self.y - 4
    graphics.rectangle(self.x, self.y + 26, 16, 16, 3, 3, self.highlighted and fg[0] or bg[3])
    if i == 1 then
      if self.highlighted then
        graphics.rectangle(self.x, self.y + 26, 3, 9, nil, nil, (n >= 1) and fg[-5] or fg[-10])
      else
        graphics.rectangle(self.x, self.y + 26, 3, 9, nil, nil, (n >= 1) and class_colors[self.class] or bg[10])
      end
      if next_n then
        if next_n == 1 then
          graphics.rectangle(self.x, self.y + 26, 3, 9, nil, nil, self.flash and class_colors[self.class] or bg[10])
        end
      end

    elseif i == 2 and not k then
      if self.highlighted then
        graphics.line(self.x - 3, self.y + 20, self.x - 3, self.y + 25, (n >= 1) and fg[-5] or fg[-10], 3)
        graphics.line(self.x - 3, self.y + 27, self.x - 3, self.y + 32, (n >= 2) and fg[-5] or fg[-10], 3)
        graphics.line(self.x + 4, self.y + 20, self.x + 4, self.y + 25, (n >= 3) and fg[-5] or fg[-10], 3)
        graphics.line(self.x + 4, self.y + 27, self.x + 4, self.y + 32, (n >= 4) and fg[-5] or fg[-10], 3)
      else
        graphics.line(self.x - 3, self.y + 20, self.x - 3, self.y + 25, (n >= 1) and class_colors[self.class] or bg[10], 3)
        graphics.line(self.x - 3, self.y + 27, self.x - 3, self.y + 32, (n >= 2) and class_colors[self.class] or bg[10], 3)
        graphics.line(self.x + 4, self.y + 20, self.x + 4, self.y + 25, (n >= 3) and class_colors[self.class] or bg[10], 3)
        graphics.line(self.x + 4, self.y + 27, self.x + 4, self.y + 32, (n >= 4) and class_colors[self.class] or bg[10], 3)
      end
      if next_n then
        if next_n == 1 then
          graphics.line(self.x - 3, self.y + 20, self.x - 3, self.y + 25, self.flash and class_colors[self.class] or bg[10], 3)
        elseif next_n == 2 then
          graphics.line(self.x - 3, self.y + 27, self.x - 3, self.y + 32, self.flash and class_colors[self.class] or bg[10], 3)
        elseif next_n == 3 then
          graphics.line(self.x + 4, self.y + 20, self.x + 4, self.y + 25, self.flash and class_colors[self.class] or bg[10], 3)
        elseif next_n == 4 then
          graphics.line(self.x + 4, self.y + 27, self.x + 4, self.y + 32, self.flash and class_colors[self.class] or bg[10], 3)
        end
      end
    elseif i == 2 and k == 6 and not l then
      if self.highlighted then
        graphics.line(self.x - 5, self.y + 21, self.x - 5, self.y + 24, (n >= 1) and fg[-5] or fg[-10], 3)
        graphics.line(self.x - 5, self.y + 28, self.x - 5, self.y + 31, (n >= 2) and fg[-5] or fg[-10], 3)
        graphics.line(self.x + 0, self.y + 21, self.x + 0, self.y + 24, (n >= 3) and fg[-5] or fg[-10], 3)
        graphics.line(self.x + 0, self.y + 28, self.x + 0, self.y + 31, (n >= 4) and fg[-5] or fg[-10], 3)
        graphics.line(self.x + 5, self.y + 21, self.x + 5, self.y + 24, (n >= 5) and fg[-5] or fg[-10], 3)
        graphics.line(self.x + 5, self.y + 28, self.x + 5, self.y + 31, (n >= 6) and fg[-5] or fg[-10], 3)
      else
        graphics.line(self.x - 5, self.y + 21, self.x - 5, self.y + 24, (n >= 1) and class_colors[self.class] or bg[10], 3)
        graphics.line(self.x - 5, self.y + 28, self.x - 5, self.y + 31, (n >= 2) and class_colors[self.class] or bg[10], 3)
        graphics.line(self.x + 0, self.y + 21, self.x + 0, self.y + 24, (n >= 3) and class_colors[self.class] or bg[10], 3)
        graphics.line(self.x + 0, self.y + 28, self.x + 0, self.y + 31, (n >= 4) and class_colors[self.class] or bg[10], 3)
        graphics.line(self.x + 5, self.y + 21, self.x + 5, self.y + 24, (n >= 5) and class_colors[self.class] or bg[10], 3)
        graphics.line(self.x + 5, self.y + 28, self.x + 5, self.y + 31, (n >= 6) and class_colors[self.class] or bg[10], 3)
      end
      if next_n then
        if next_n == 1 then
          graphics.line(self.x - 5, self.y + 21, self.x - 5, self.y + 24, self.flash and class_colors[self.class] or bg[10], 3)
        elseif next_n == 2 then
          graphics.line(self.x - 5, self.y + 28, self.x - 5, self.y + 31, self.flash and class_colors[self.class] or bg[10], 3)
        elseif next_n == 3 then
          graphics.line(self.x + 0, self.y + 21, self.x + 0, self.y + 24, self.flash and class_colors[self.class] or bg[10], 3)
        elseif next_n == 4 then
          graphics.line(self.x + 0, self.y + 28, self.x + 0, self.y + 31, self.flash and class_colors[self.class] or bg[10], 3)
        elseif next_n == 5 then
          graphics.line(self.x + 5, self.y + 21, self.x + 5, self.y + 24, self.flash and class_colors[self.class] or bg[10], 3)
        elseif next_n == 6 then
          graphics.line(self.x + 5, self.y + 28, self.x + 5, self.y + 31, self.flash and class_colors[self.class] or bg[10], 3)
        end
      end

      
    elseif i == 2 and l == 8 then
      if self.highlighted then
        graphics.line(self.x - 6, self.y + 21, self.x - 6, self.y + 24, (n >= 1) and fg[-5] or fg[-10], 3)
        graphics.line(self.x - 6, self.y + 28, self.x - 6, self.y + 31, (n >= 2) and fg[-5] or fg[-10], 3)
        graphics.line(self.x - 2, self.y + 21, self.x - 2, self.y + 24, (n >= 3) and fg[-5] or fg[-10], 3)
        graphics.line(self.x - 2, self.y + 28, self.x - 2, self.y + 31, (n >= 4) and fg[-5] or fg[-10], 3)
        graphics.line(self.x + 2, self.y + 21, self.x + 2, self.y + 24, (n >= 5) and fg[-5] or fg[-10], 3)
        graphics.line(self.x + 2, self.y + 28, self.x + 2, self.y + 31, (n >= 6) and fg[-5] or fg[-10], 3)
        graphics.line(self.x + 6, self.y + 21, self.x + 6, self.y + 24, (n >= 7) and fg[-5] or fg[-10], 3)
        graphics.line(self.x + 6, self.y + 28, self.x + 6, self.y + 31, (n >= 8) and fg[-5] or fg[-10], 3)
      else
        graphics.line(self.x - 6, self.y + 21, self.x - 6, self.y + 24, (n >= 1) and class_colors[self.class] or bg[10], 3)
        graphics.line(self.x - 6, self.y + 28, self.x - 6, self.y + 31, (n >= 2) and class_colors[self.class] or bg[10], 3)
        graphics.line(self.x - 2, self.y + 21, self.x - 2, self.y + 24, (n >= 3) and class_colors[self.class] or bg[10], 3)
        graphics.line(self.x - 2, self.y + 28, self.x - 2, self.y + 31, (n >= 4) and class_colors[self.class] or bg[10], 3)
        graphics.line(self.x + 2, self.y + 21, self.x + 2, self.y + 24, (n >= 5) and class_colors[self.class] or bg[10], 3)
        graphics.line(self.x + 2, self.y + 28, self.x + 2, self.y + 31, (n >= 6) and class_colors[self.class] or bg[10], 3)
        graphics.line(self.x + 6, self.y + 21, self.x + 6, self.y + 24, (n >= 7) and class_colors[self.class] or bg[10], 3)
        graphics.line(self.x + 6, self.y + 28, self.x + 6, self.y + 31, (n >= 8) and class_colors[self.class] or bg[10], 3)
      end
      if next_n then
        if next_n == 1 then
          graphics.line(self.x - 6, self.y + 21, self.x - 6, self.y + 24, self.flash and class_colors[self.class] or bg[10], 3)
        elseif next_n == 2 then
          graphics.line(self.x - 6, self.y + 28, self.x - 6, self.y + 31, self.flash and class_colors[self.class] or bg[10], 3)
        elseif next_n == 3 then
          graphics.line(self.x - 2, self.y + 21, self.x - 2, self.y + 24, self.flash and class_colors[self.class] or bg[10], 3)
        elseif next_n == 4 then
          graphics.line(self.x - 2, self.y + 28, self.x - 2, self.y + 31, self.flash and class_colors[self.class] or bg[10], 3)
        elseif next_n == 5 then
          graphics.line(self.x + 2, self.y + 21, self.x + 2, self.y + 24, self.flash and class_colors[self.class] or bg[10], 3)
        elseif next_n == 6 then
          graphics.line(self.x + 2, self.y + 28, self.x + 2, self.y + 31, self.flash and class_colors[self.class] or bg[10], 3)
        elseif next_n == 7 then
          graphics.line(self.x + 6, self.y + 21, self.x + 6, self.y + 24, self.flash and class_colors[self.class] or bg[10], 3)
        elseif next_n == 8 then
          graphics.line(self.x + 6, self.y + 28, self.x + 6, self.y + 31, self.flash and class_colors[self.class] or bg[10], 3)
        end
      end

    elseif i == 3 and not k then
      if self.highlighted then
        graphics.line(self.x - 3, self.y + 19, self.x - 3, self.y + 22, (n >= 1) and fg[-5] or fg[-10], 3)
        graphics.line(self.x - 3, self.y + 24, self.x - 3, self.y + 27, (n >= 2) and fg[-5] or fg[-10], 3)
        graphics.line(self.x - 3, self.y + 29, self.x - 3, self.y + 32, (n >= 3) and fg[-5] or fg[-10], 3)
        graphics.line(self.x + 4, self.y + 19, self.x + 4, self.y + 22, (n >= 4) and fg[-5] or fg[-10], 3)
        graphics.line(self.x + 4, self.y + 24, self.x + 4, self.y + 27, (n >= 5) and fg[-5] or fg[-10], 3)
        graphics.line(self.x + 4, self.y + 29, self.x + 4, self.y + 32, (n >= 6) and fg[-5] or fg[-10], 3)
      else
        graphics.line(self.x - 3, self.y + 19, self.x - 3, self.y + 22, (n >= 1) and class_colors[self.class] or bg[10], 3)
        graphics.line(self.x - 3, self.y + 24, self.x - 3, self.y + 27, (n >= 2) and class_colors[self.class] or bg[10], 3)
        graphics.line(self.x - 3, self.y + 29, self.x - 3, self.y + 32, (n >= 3) and class_colors[self.class] or bg[10], 3)
        graphics.line(self.x + 4, self.y + 19, self.x + 4, self.y + 22, (n >= 4) and class_colors[self.class] or bg[10], 3)
        graphics.line(self.x + 4, self.y + 24, self.x + 4, self.y + 27, (n >= 5) and class_colors[self.class] or bg[10], 3)
        graphics.line(self.x + 4, self.y + 29, self.x + 4, self.y + 32, (n >= 6) and class_colors[self.class] or bg[10], 3)
      end
      if next_n then
        if next_n == 1 then
          graphics.line(self.x - 3, self.y + 19, self.x - 3, self.y + 22, self.flash and class_colors[self.class] or bg[10], 3)
        elseif next_n == 2 then
          graphics.line(self.x - 3, self.y + 24, self.x - 3, self.y + 27, self.flash and class_colors[self.class] or bg[10], 3)
        elseif next_n == 3 then
          graphics.line(self.x - 3, self.y + 29, self.x - 3, self.y + 32, self.flash and class_colors[self.class] or bg[10], 3)
        elseif next_n == 4 then
          graphics.line(self.x + 4, self.y + 19, self.x + 4, self.y + 22, self.flash and class_colors[self.class] or bg[10], 3)
        elseif next_n == 5 then
          graphics.line(self.x + 4, self.y + 24, self.x + 4, self.y + 27, self.flash and class_colors[self.class] or bg[10], 3)
        elseif next_n == 6 then
          graphics.line(self.x + 4, self.y + 29, self.x + 4, self.y + 32, self.flash and class_colors[self.class] or bg[10], 3)
        end
      end
    elseif i == 3 and k == 9 then
      if self.highlighted then
        graphics.line(self.x - 5, self.y + 19, self.x - 5, self.y + 22, (n >= 1) and fg[-5] or fg[-10], 3)
        graphics.line(self.x - 5, self.y + 24, self.x - 5, self.y + 27, (n >= 2) and fg[-5] or fg[-10], 3)
        graphics.line(self.x - 5, self.y + 29, self.x - 5, self.y + 32, (n >= 3) and fg[-5] or fg[-10], 3)
        graphics.line(self.x + 0, self.y + 19, self.x + 0, self.y + 22, (n >= 4) and fg[-5] or fg[-10], 3)
        graphics.line(self.x + 0, self.y + 24, self.x + 0, self.y + 27, (n >= 5) and fg[-5] or fg[-10], 3)
        graphics.line(self.x + 0, self.y + 29, self.x + 0, self.y + 32, (n >= 6) and fg[-5] or fg[-10], 3)
        graphics.line(self.x + 5, self.y + 19, self.x + 5, self.y + 22, (n >= 7) and fg[-5] or fg[-10], 3)
        graphics.line(self.x + 5, self.y + 24, self.x + 5, self.y + 27, (n >= 8) and fg[-5] or fg[-10], 3)
        graphics.line(self.x + 5, self.y + 29, self.x + 5, self.y + 32, (n >= 9) and fg[-5] or fg[-10], 3)
      else
        graphics.line(self.x - 5, self.y + 19, self.x - 5, self.y + 22, (n >= 1) and class_colors[self.class] or bg[10], 3)
        graphics.line(self.x - 5, self.y + 24, self.x - 5, self.y + 27, (n >= 2) and class_colors[self.class] or bg[10], 3)
        graphics.line(self.x - 5, self.y + 29, self.x - 5, self.y + 32, (n >= 3) and class_colors[self.class] or bg[10], 3)
        graphics.line(self.x + 0, self.y + 19, self.x + 0, self.y + 22, (n >= 4) and class_colors[self.class] or bg[10], 3)
        graphics.line(self.x + 0, self.y + 24, self.x + 0, self.y + 27, (n >= 5) and class_colors[self.class] or bg[10], 3)
        graphics.line(self.x + 0, self.y + 29, self.x + 0, self.y + 32, (n >= 6) and class_colors[self.class] or bg[10], 3)
        graphics.line(self.x + 5, self.y + 19, self.x + 5, self.y + 22, (n >= 7) and class_colors[self.class] or bg[10], 3)
        graphics.line(self.x + 5, self.y + 24, self.x + 5, self.y + 27, (n >= 8) and class_colors[self.class] or bg[10], 3)
        graphics.line(self.x + 5, self.y + 29, self.x + 5, self.y + 32, (n >= 9) and class_colors[self.class] or bg[10], 3)
      end
      if next_n then
        if next_n == 1 then
          graphics.line(self.x - 5, self.y + 19, self.x - 5, self.y + 22, self.flash and class_colors[self.class] or bg[10], 3)
        elseif next_n == 2 then
          graphics.line(self.x - 5, self.y + 24, self.x - 5, self.y + 27, self.flash and class_colors[self.class] or bg[10], 3)
        elseif next_n == 3 then
          graphics.line(self.x - 5, self.y + 29, self.x - 5, self.y + 32, self.flash and class_colors[self.class] or bg[10], 3)
        elseif next_n == 4 then
          graphics.line(self.x + 0, self.y + 19, self.x + 0, self.y + 22, self.flash and class_colors[self.class] or bg[10], 3)
        elseif next_n == 5 then
          graphics.line(self.x + 0, self.y + 24, self.x + 0, self.y + 27, self.flash and class_colors[self.class] or bg[10], 3)
        elseif next_n == 6 then
          graphics.line(self.x + 0, self.y + 29, self.x + 0, self.y + 32, self.flash and class_colors[self.class] or bg[10], 3)
        elseif next_n == 7 then
          graphics.line(self.x + 5, self.y + 19, self.x + 5, self.y + 22, self.flash and class_colors[self.class] or bg[10], 3)
        elseif next_n == 8 then
          graphics.line(self.x + 5, self.y + 24, self.x + 5, self.y + 27, self.flash and class_colors[self.class] or bg[10], 3)
        elseif next_n == 9 then
          graphics.line(self.x + 5, self.y + 29, self.x + 5, self.y + 32, self.flash and class_colors[self.class] or bg[10], 3)
        end
      end
    end
    self.y = self.y + 4
  graphics.pop()
end


function ClassIcon:on_mouse_enter()
  self.selected = true
  ui_hover1:play{pitch = random:float(1.3, 1.5), volume = 0.5}
  self.spring:pull(0.2, 200, 10)
  local synboost = true if self.parent.cost then synboost = false end
  local i, j, k, l, owned = class_set_numbers[self.class](self.units)
  self.info_text = InfoText{group = main.current.ui}
  self.info_text:activate({
    {text = '[' .. class_color_strings[self.class] .. ']' .. 
    (self.class == 'conjurer' and 'Builder' or self.class:capitalize()) .. 
    '[fg] - owned: [yellow]' .. owned, font = pixul_font, alignment = 'center', height_multiplier = 1.25},
    {text = class_descriptions[self.class](
      (l and (owned >= l and 4)) or 
      (k and (owned >= k and 3)) or 
      (j and (owned >= j and 2)) or 
      (owned >= i and 1) or 0),
       font = pixul_font, alignment = 'center'}, synboost and
     {text = (syn_pow[self.class] < sp_max[self.class] or sp_max[self.class] == 0) and 
     '[yellow]Click to boost the synergy for 300 Gold, [fg]current level: [red]'..tostring(syn_pow[self.class])
     or '[red] Max synergy boost level for this set reached: '.. tostring(syn_pow[self.class]),
        font = pixul_font, alignment = 'center'} or 
        {text =  
     '[fg]Synergy boost level: [red]'..tostring(syn_pow[self.class]),
        font = pixul_font, alignment = 'center'},
  }, nil, nil, nil, nil, 16, 4, nil, 2)
  self.info_text.x, self.info_text.y = gw/2, gh/2 + 10

  if not self.parent:is(ShopCard) then
    for _, character in ipairs(self.parent.characters) do
      if table.any(character_classes[character.character], function(v) return v == self.class end) then
        character:highlight()
        for _, c in ipairs(character.parts) do
          c:highlight()
        end
      end
    end
  end
end


function ClassIcon:on_mouse_exit()
  self.selected = false
  if self.info_text then
    self.info_text:deactivate()
    self.info_text.dead = true
  end
  self.info_text = nil

  if not self.parent:is(ShopCard) then
    for _, character in ipairs(self.parent.characters) do
      if table.any(character_classes[character.character], function(v) return v == self.class end) then
        character:unhighlight()
        for _, c in ipairs(character.parts) do
          c:unhighlight()
        end
      end
    end
  end
end


function ClassIcon:die(dont_spawn_effect)
  self.dead = true
  local i, j, k, l, n = class_set_numbers[self.class](self.units)
  if not dont_spawn_effect then SpawnEffect{group = main.current.effects, x = self.x, y = self.y + 4, color = (n >= i) and class_colors[self.class] or bg[3]} end
  if self.info_text then
    self.info_text:deactivate()
    self.info_text.dead = true
    self.info_text = nil
  end

  if self.selected and not self.parent:is(ShopCard) then
    for _, character in ipairs(self.parent.characters) do
      if table.any(character.classes, function(v) return v == self.class end) then
        character:highlight()
      end
    end
  end
end


function ClassIcon:highlight()
  self.highlighted = true
  self.spring:pull(0.2, 200, 10)
end


function ClassIcon:unhighlight()
  self.highlighted = false
  self.spring:pull(0.05, 200, 10)
end
