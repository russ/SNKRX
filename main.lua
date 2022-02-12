require 'engine'
require 'shared'
require 'arena'
require 'mainmenu'
require 'buy_screen'
require 'objects'
require 'player'
require 'enemies'
require 'media'


function init()
  shared_init()

  strc = table.concat

  input:bind('move_left', {'a', 'left', 'dpleft', 'm1'})
  input:bind('move_right', {'d', 'e', 's', 'right', 'dpright', 'm2'})
  input:bind('enter', {'space', 'return', 'fleft', 'fdown', 'fright'})

  local s = {tags = {sfx}}
  artificer1 = Sound('458586__inspectorj__ui-mechanical-notification-01-fx.ogg', s)
  explosion1 = Sound('Explosion Grenade_04.ogg', s)
  mine1 = Sound('Weapon Swap 2.ogg', s)
  level_up1 = Sound('Buff 4.ogg', s)
  unlock1 = Sound('Unlock 3.ogg', s)
  gambler1 = Sound('Collect 5.ogg', s)
  usurer1 = Sound('Shadow Punch 2.ogg', s)
  orb1 = Sound('Collect 2.ogg', s)
  gold1 = Sound('Collect 5.ogg', s)
  gold2 = Sound('Coins - Gears - Slot.ogg', s)
  psychic1 = Sound('Magical Impact 13.ogg', s)
  fire1 = Sound('Fire bolt 3.ogg', s)
  fire2 = Sound('Fire bolt 5.ogg', s)
  fire3 = Sound('Fire bolt 10.ogg', s)
  earth1 = Sound('Earth Bolt 1.ogg', s)
  earth2 = Sound('Earth Bolt 14.ogg', s)
  earth3 = Sound('Earth Bolt 20.ogg', s)
  illusion1 = Sound('Buff 5.ogg', s)
  thunder1 = Sound('399656__bajko__sfx-thunder-blast.ogg', s)
  flagellant1 = Sound('Whipping Horse 3.ogg', s)
  bard2 = Sound('376532__womb-affliction__flute-trill.ogg', s)
  arcane2 = Sound('Magical Impact 12.ogg', s)
  frost1 = Sound('Frost Bolt 20.ogg', s)
  arcane1 = Sound('Magical Impact 26.ogg', s)
  pyro1 = Sound('Fire bolt 5.ogg', s)
  pyro2 = Sound('Explosion Fireworks_01.ogg', s)
  dot1 = Sound('Magical Swoosh 18.ogg', s)
  gun_kata1 = Sound('Pistol Shot_07.ogg', s)
  gun_kata2 = Sound('Pistol Shot_08.ogg', s)
  dual_gunner1 = Sound('Revolver Shot_07.ogg', s)
  dual_gunner2 = Sound('Revolver Shot_08.ogg', s)
  ui_hover1 = Sound('bamboo_hit_by_lord.ogg', s)
  ui_switch1 = Sound('Switch.ogg', s)
  ui_switch2 = Sound('Switch 3.ogg', s)
  ui_transition1 = Sound('Wind Bolt 8.ogg', s)
  ui_transition2 = Sound('Wind Bolt 12.ogg', s)
  headbutt1 = Sound('Wind Bolt 14.ogg', s)
  critter1 = Sound('Critters eating 2.ogg', s)
  critter2 = Sound('Crickets Chirping 4.ogg', s)
  critter3 = Sound('Popping bloody Sac 1.ogg', s)
  force1 = Sound('Magical Impact 18.ogg', s)
  error1 = Sound('Error 2.ogg', s)
  coins1 = Sound('Coins 7.ogg', s)
  coins2 = Sound('Coins 8.ogg', s)
  coins3 = Sound('Coins 9.ogg', s)
  shoot1 = Sound('Shooting Projectile (Classic) 11.ogg', s)
  archer1 = Sound('Releasing Bow String 1.ogg', s)
  wizard1 = Sound('Wind Bolt 20.ogg', s)
  swordsman1 = Sound('Heavy sword woosh 1.ogg', s)
  swordsman2 = Sound('Heavy sword woosh 19.ogg', s)
  scout1 = Sound('Throwing Knife (Thrown) 3.ogg', s)
  scout2 = Sound('Throwing Knife (Thrown) 4.ogg', s)
  arrow_hit_wall1 = Sound('Arrow Impact wood 3.ogg', s)
  arrow_hit_wall2 = Sound('Arrow Impact wood 1.ogg', s)
  hit1 = Sound('Player Takes Damage 17.ogg', s)
  hit2 = Sound('Body Head (Headshot) 1.ogg', s)
  hit3 = Sound('Kick 16_1.ogg', s)
  hit4 = Sound('Kick 16_2.ogg', s)
  proj_hit_wall1 = Sound('Player Takes Damage 2.ogg', s)
  enemy_die1 = Sound('Bloody punches 7.ogg', s)
  enemy_die2 = Sound('Bloody punches 10.ogg', s)
  magic_area1 = Sound('Fire bolt 10.ogg', s)
  magic_hit1 = Sound('Shadow Punch 1.ogg', s)
  magic_die1 = Sound('Magical Impact 27.ogg', s)
  knife_hit_wall1 = Sound('Shield Impacts Sword 1.ogg', s)
  blade_hit1 = Sound('Sword impact (Flesh) 2.ogg', s)
  player_hit1 = Sound('Body Fall 2.ogg', s)
  player_hit2 = Sound('Body Fall 18.ogg', s)
  player_hit_wall1 = Sound('Wood Heavy 5.ogg', s)
  pop1 = Sound('Pop sounds 10.ogg', s)
  pop2 = Sound('467951__benzix2__ui-button-click.ogg', s)
  pop3 = Sound('258269__jcallison__mouth-pop.ogg', s)
  confirm1 = Sound('80921__justinbw__buttonchime02up.ogg', s)
  heal1 = Sound('Buff 3.ogg', s)
  spawn1 = Sound('Buff 13.ogg', s)
  buff1 = Sound('Buff 14.ogg', s)
  spawn_mark1 = Sound('Bonus 2.ogg', s)
  spawn_mark2 = Sound('Bonus.ogg', s)
  alert1 = Sound('Click.ogg', s)
  elementor1 = Sound('Wind Bolt 18.ogg', s)
  saboteur_hit1 = Sound('Explosion Flesh_01.ogg', s)
  saboteur_hit2 = Sound('Explosion Flesh_02.ogg', s)
  saboteur1 = Sound('Male Jump 1.ogg', s)
  saboteur2 = Sound('Male Jump 2.ogg', s)
  saboteur3 = Sound('Male Jump 3.ogg', s)
  spark1 = Sound('Spark 1.ogg', s)
  spark2 = Sound('Spark 2.ogg', s)
  spark3 = Sound('Spark 3.ogg', s)
  stormweaver1 = Sound('Buff 8.ogg', s)
  cannoneer1 = Sound('Cannon shots 1.ogg', s)
  cannoneer2 = Sound('Cannon shots 7.ogg', s)
  cannon_hit_wall1 = Sound('Cannon impact sounds (Hitting ship) 4.ogg', s)
  pet1 = Sound('Wolf barks 5.ogg', s)
  turret1 = Sound('Sci Fi Machine Gun 7.ogg', s)
  turret2 = Sound('Sniper Shot_09.ogg', s)
  turret_hit_wall1 = Sound('Concrete 6.ogg', s)
  turret_hit_wall2 = Sound('Concrete 7.ogg', s)
  turret_deploy = Sound('321215__hybrid-v__sci-fi-weapons-deploy.ogg', s)
  rogue_crit1 = Sound('Dagger Stab (Flesh) 4.ogg', s)
  rogue_crit2 = Sound('Sword hits another sword 6.ogg', s)

  song1 = Sound('Kubbi - Ember - 01 Pathfinder.ogg', {tags = {music}})
  song2 = Sound('Kubbi - Ember - 02 Ember.ogg', {tags = {music}})
  song3 = Sound('Kubbi - Ember - 03 Firelight.ogg', {tags = {music}})
  song4 = Sound('Kubbi - Ember - 04 Cascade.ogg', {tags = {music}})
  song5 = Sound('Kubbi - Ember - 05 Compass.ogg', {tags = {music}})
  death_song = Sound('Kubbi - Ember - 09 Formed by Glaciers.ogg', {tags = {music}})

  lock_image = Image('lock')
  speed_booster_elite = Image('speed_booster_elite')
  exploder_elite = Image('exploder_elite')
  swarmer_elite = Image('swarmer_elite')
  forcer_elite = Image('forcer_elite')
  cluster_elite = Image('cluster_elite')
  warrior = Image('warrior')
  ranger = Image('ranger')
  healer = Image('healer')
  mage = Image('mage')
  rogue = Image('rogue')
  nuker = Image('nuker')
  conjurer = Image('conjurer')
  enchanter = Image('enchanter')
  psyker = Image('psyker')
  curser = Image('curser')
  forcer = Image('forcer')
  swarmer = Image('swarmer')
  voider = Image('voider')
  sorcerer = Image('sorcerer')
  mercenary = Image('mercenary')
  explorer = Image('explorer')
  chaolyst = Image('chaolyst')
  star = Image('star')
  arrow = Image('arrow')
  centipede = Image('centipede')
  ouroboros_technique_r = Image('ouroboros_technique_r')
  ouroboros_technique_l = Image('ouroboros_technique_l')
  amplify = Image('amplify')
  resonance = Image('resonance')
  ballista = Image('ballista')
  call_of_the_void = Image('call_of_the_void')
  crucio = Image('crucio')
  speed_3 = Image('speed_3')
  damage_4 = Image('damage_4')
  shoot_5 = Image('shoot_5')
  death_6 = Image('death_6')
  lasting_7 = Image('lasting_7')
  defensive_stance = Image('defensive_stance')
  offensive_stance = Image('offensive_stance')
  kinetic_bomb = Image('kinetic_bomb')
  porcupine_technique = Image('porcupine_technique')
  last_stand = Image('last_stand')
  seeping = Image('seeping')
  deceleration = Image('deceleration')
  annihilation = Image('annihilation')
  malediction = Image('malediction')
  hextouch = Image('hextouch')
  whispers_of_doom = Image('whispers_of_doom')
  tremor = Image('tremor')
  heavy_impact = Image('heavy_impact')
  fracture = Image('fracture')
  meat_shield = Image('meat_shield')
  hive = Image('hive')
  baneling_burst = Image('baneling_burst')
  blunt_arrow = Image('blunt_arrow')
  explosive_arrow = Image('explosive_arrow')
  divine_machine_arrow = Image('divine_machine_arrow')
  chronomancy = Image('chronomancy')
  awakening = Image('awakening')
  divine_punishment = Image('divine_punishment')
  assassination = Image('assassination')
  flying_daggers = Image('flying_daggers')
  ultimatum = Image('ultimatum')
  magnify = Image('magnify')
  echo_barrage = Image('echo_barrage')
  unleash = Image('unleash')
  reinforce = Image('reinforce')
  payback = Image('payback')
  enchanted = Image('enchanted')
  freezing_field = Image('freezing_field')
  burning_field = Image('burning_field')
  gravity_field = Image('gravity_field')
  magnetism = Image('magnetism')
  insurance = Image('insurance')
  dividends = Image('dividends')
  berserking = Image('berserking')
  unwavering_stance = Image('unwavering_stance')
  unrelenting_stance = Image('unrelenting_stance')
  blessing = Image('blessing')
  haste = Image('haste')
  divine_barrage = Image('divine_barrage')
  orbitism = Image('orbitism')
  psyker_orbs = Image('psyker_orbs')
  psychosense = Image('psychosense')
  psychosink = Image('psychosink')
  rearm = Image('rearm')
  taunt = Image('taunt')
  construct_instability = Image('construct_instability')
  intimidation = Image('intimidation')
  vulnerability = Image('vulnerability')
  temporal_chains = Image('temporal_chains')
  ceremonial_dagger = Image('ceremonial_dagger')
  homing_barrage = Image('homing_barrage')
  critical_strike = Image('critical_strike')
  noxious_strike = Image('noxious_strike')
  infesting_strike = Image('infesting_strike')
  kinetic_strike = Image('kinetic_strike')
  burning_strike = Image('burning_strike')
  lucky_strike = Image('lucky_strike')
  healing_strike = Image('healing_strike')
  stunning_strike = Image('stunning_strike')
  silencing_strike = Image('silencing_strike')
  warping_shots = Image('warping_shots')
  culling_strike = Image('culling_strike')
  lightning_strike = Image('lightning_strike')
  psycholeak = Image('psycholeak')
  divine_blessing = Image('divine_blessing')
  hardening = Image('hardening')

  body_img = Image('body')
  mouths_img = Image('mouths')

  class_colors = {
    ['warrior'] = yellow[0],
    ['ranger'] = green[0],
    ['healer'] = greenheal[0],
    ['conjurer'] = orangebuil[0],
    ['mage'] = blue[0],
    ['nuker'] = red[0],
    ['rogue'] = reddark[0],
    ['enchanter'] = blueench[0],
    ['psyker'] = fgpsyk[0],
    ['curser'] = purplecurs[0],
    ['forcer'] = yellowforc[0],
    ['swarmer'] = orange[0],
    ['voider'] = purple[0],
    ['sorcerer'] = blue2[0],
    ['mercenary'] = yellow2[0],
    ['explorer'] = fg[0],
    ['chaolyst'] = carmine[0],
  }

  class_color_strings = {
    ['warrior'] = 'yellow',
    ['ranger'] = 'green',
    ['healer'] = 'greenheal',
    ['conjurer'] = 'orangebuil',
    ['mage'] = 'blue',
    ['nuker'] = 'red',
    ['rogue'] = 'reddark',
    ['enchanter'] = 'blueench',
    ['psyker'] = 'fgpsyk',
    ['curser'] = 'purplecurs',
    ['forcer'] = 'yellowforc',
    ['swarmer'] = 'orange',
    ['voider'] = 'purple',
    ['sorcerer'] = 'blue2',
    ['mercenary'] = 'yellow2',
    ['explorer'] = 'fg',
    ['chaolyst'] = 'carmine',
  }

  character_names = {
    ['vagrant'] = 'Vagrant',
    ['swordsman'] = 'Swordsman',
    ['wizard'] = 'Wizard',
    ['magician'] = 'Magician',
    ['archer'] = 'Archer',
    ['scout'] = 'Scout',
    ['cleric'] = 'Cleric',
    ['outlaw'] = 'Outlaw',
    ['blade'] = 'Blade',
    ['elementor'] = 'Elementor',
    ['saboteur'] = 'Saboteur',
    ['bomber'] = 'Bomber',
    ['stormweaver'] = 'Stormweaver',
    ['sage'] = 'Sage',
    ['squire'] = 'Squire',
    ['cannoneer'] = 'Cannoneer',
    ['dual_gunner'] = 'Dual Gunner',
    ['hunter'] = 'Hunter',
    ['sentry'] = 'Sentry',
    ['chronomancer'] = 'Chronomancer',
    ['spellblade'] = 'Spellblade',
    ['psykeeper'] = 'Psykeeper',
    ['engineer'] = 'Engineer',
    ['plague_doctor'] = 'Plague Doctor',
    ['barbarian'] = 'Barbarian',
    ['juggernaut'] = 'Juggernaut',
    ['lich'] = 'Lich',
    ['cryomancer'] = 'Cryomancer',
    ['pyromancer'] = 'Pyromancer',
    ['corruptor'] = 'Corruptor',
    ['beastmaster'] = 'Beastmaster',
    ['launcher'] = 'Launcher',
    ['jester'] = 'Jester',
    ['assassin'] = 'Assassin',
    ['host'] = 'Host',
    ['carver'] = 'Carver',
    ['bane'] = 'Bane',
    ['psykino'] = 'Psykino',
    ['barrager'] = 'Barrager',
    ['highlander'] = 'Highlander',
    ['fairy'] = 'Fairy',
    ['priest'] = 'Priest',
    ['infestor'] = 'Infestor',
    ['flagellant'] = 'Flagellant',
    ['arcanist'] = 'Arcanist',
    ['illusionist'] = 'Illusionist',
    ['artificer'] = 'Artificer',
    ['witch'] = 'Witch',
    ['silencer'] = 'Silencer',
    ['vulcanist'] = 'Vulcanist',
    ['warden'] = 'Warden',
    ['psychic'] = 'Psychic',
    ['miner'] = 'Miner',
    ['merchant'] = 'Merchant',
    ['usurer'] = 'Usurer',
    ['gambler'] = 'Gambler',
    ['thief'] = 'Thief',
    ['warper'] = 'Warper',
    ['nexus'] = 'Nexus',
  }

  damage_counters = {}
  reset_counters = function()
    for i, _ in pairs(character_names) do
      damage_counters[i] = 0
    end
    damage_counters['body'] = 0
    damage_counters['kinetic'] = 0
    damage_counters['other'] = 0
  end

  reset_counters()

  character_colors = {
    ['vagrant'] = fg[0],
    ['swordsman'] = yellow[0],
    ['wizard'] = blue[0],
    ['magician'] = blue[0],
    ['archer'] = green[0],
    ['scout'] = reddark[0],
    ['cleric'] = greenheal[0],
    ['outlaw'] = reddark[0],
    ['blade'] = yellow[0],
    ['elementor'] = blue[0],
    ['saboteur'] = orangebuil[0],
    ['bomber'] = orangebuil[0],
    ['stormweaver'] = blueench[0],
    ['sage'] = purple[0],
    ['squire'] = yellow[0],
    ['cannoneer'] = orangebuil[0],
    ['dual_gunner'] = green[0],
    ['hunter'] = green[0],
    ['sentry'] = green[0],
    ['chronomancer'] = blueench[0],
    ['spellblade'] = carmine[0],
    ['psykeeper'] = fgpsyk[0],
    ['engineer'] = orangebuil[0],
    ['plague_doctor'] = purple[0],
    ['barbarian'] = yellow[0],
    ['juggernaut'] = yellowforc[0],
    ['lich'] = blue[0],
    ['cryomancer'] = blue[0],
    ['pyromancer'] = red[0],
    ['corruptor'] = orange[0],
    ['beastmaster'] = reddark[0],
    ['launcher'] = yellow[0],
    ['jester'] = reddark[0],
    ['assassin'] = purple[0],
    ['host'] = orange[0],
    ['carver'] = greenheal[0],
    ['bane'] = purplecurs[0],
    ['psykino'] = fgpsyk[0],
    ['barrager'] = green[0],
    ['highlander'] = yellow[0],
    ['fairy'] = greenheal[0],
    ['priest'] = greenheal[0],
    ['infestor'] = orange[0],
    ['flagellant'] = fgpsyk[0],
    ['arcanist'] = blue2[0],
    ['illusionist'] = blue2[0],
    ['artificer'] = blue2[0],
    ['witch'] = purple[0],
    ['silencer'] = purplecurs[0],
    ['vulcanist'] = red[0],
    ['warden'] = yellowforc[0],
    ['psychic'] = fgpsyk[0],
    ['miner'] = yellow2[0],
    ['merchant'] = yellow2[0],
    ['usurer'] = purplecurs[0],
    ['gambler'] = yellow2[0],
    ['thief'] = reddark[0],
    ['warper'] = carmine[0],
    ['nexus'] = fg[0],
    ['carmine_queen'] = carmine_acalamity_queen[0],
  }

  character_color_strings = {
    ['vagrant'] = 'fg',
    ['swordsman'] = 'yellow',
    ['wizard'] = 'blue',
    ['magician'] = 'blue',
    ['archer'] = 'green',
    ['scout'] = 'reddark',
    ['cleric'] = 'greenheal',
    ['outlaw'] = 'reddark',
    ['blade'] = 'yellow',
    ['elementor'] = 'blue',
    ['saboteur'] = 'orangebuil',
    ['bomber'] = 'orangebuil',
    ['stormweaver'] = 'blueench',
    ['sage'] = 'purple',
    ['squire'] = 'yellow',
    ['cannoneer'] = 'orangebuil',
    ['dual_gunner'] = 'green',
    ['hunter'] = 'green',
    ['sentry'] = 'green',
    ['chronomancer'] = 'blueench',
    ['spellblade'] = 'carmine',
    ['psykeeper'] = 'fgpsyk',
    ['engineer'] = 'orangebuil',
    ['plague_doctor'] = 'purple',
    ['barbarian'] = 'yellow',
    ['juggernaut'] = 'yellowforc',
    ['lich'] = 'blue',
    ['cryomancer'] = 'blue',
    ['pyromancer'] = 'red',
    ['corruptor'] = 'orange',
    ['beastmaster'] = 'reddark',
    ['launcher'] = 'yellowforc',
    ['jester'] = 'reddark',
    ['assassin'] = 'purple',
    ['host'] = 'orange',
    ['carver'] = 'greenheal',
    ['bane'] = 'purplecurs',
    ['psykino'] = 'fgpsyk',
    ['barrager'] = 'green',
    ['highlander'] = 'yellow',
    ['fairy'] = 'greenheal',
    ['priest'] = 'greenheal',
    ['infestor'] = 'orange',
    ['flagellant'] = 'fgpsyk',
    ['arcanist'] = 'blue2',
    ['illusionist'] = 'blue2',
    ['artificer'] = 'blue2',
    ['witch'] = 'purple',
    ['silencer'] = 'purplecurs',
    ['vulcanist'] = 'red',
    ['warden'] = 'yellowforc',
    ['psychic'] = 'fgpsyk',
    ['miner'] = 'yellow2',
    ['merchant'] = 'yellow2',
    ['usurer'] = 'purplecurs',
    ['gambler'] = 'yellow2',
    ['thief'] = 'reddark',
    ['warper'] = 'carmine',
    ['nexus'] = 'fg',
  }

  character_classes = {
    ['vagrant'] = {'explorer', 'psyker', 'forcer'},
    ['swordsman'] = {'warrior'},
    ['wizard'] = {'mage', 'nuker'},
    ['magician'] = {'mage'},
    ['archer'] = {'ranger'},
    ['scout'] = {'rogue'},
    ['cleric'] = {'healer'},
    ['outlaw'] = {'warrior', 'rogue'},
    ['blade'] = {'warrior', 'nuker'},
    ['elementor'] = {'mage', 'nuker'},
    -- ['saboteur'] = {'rogue', 'conjurer', 'nuker'},
    ['bomber'] = {'nuker', 'conjurer'},
    ['stormweaver'] = {'enchanter'},
    ['sage'] = {'voider', 'forcer', 'explorer'},
    ['squire'] = {'enchanter'},
    ['cannoneer'] = {'ranger', 'nuker', 'chaolyst'},
    ['dual_gunner'] = {'ranger', 'rogue'},
    -- ['hunter'] = {'ranger', 'conjurer', 'forcer'},
    ['sentry'] = {'ranger', 'conjurer'},
    ['chronomancer'] = {'mage', 'enchanter'},
    ['spellblade'] = {'mage', 'rogue', 'chaolyst'},
    ['psykeeper'] = {'healer', 'psyker', 'chaolyst', 'warrior'},
    ['engineer'] = {'conjurer'},
    ['plague_doctor'] = {'nuker', 'voider', 'swarmer'},
    ['barbarian'] = {'forcer', 'warrior', 'mage'},
    ['juggernaut'] = {'forcer', 'warrior'},
    ['lich'] = {'mage'},
    ['cryomancer'] = {'mage', 'voider'},
    ['pyromancer'] = {'mage', 'nuker', 'voider'},
    ['corruptor'] = {'ranger', 'swarmer'},
    ['beastmaster'] = {'rogue', 'swarmer'},
    ['launcher'] = {'curser', 'forcer'},
    ['jester'] = {'curser', 'rogue'},
    ['assassin'] = {'rogue', 'voider'},
    ['host'] = {'swarmer'},
    ['carver'] = {'conjurer', 'healer'},
    ['bane'] = {'curser', 'voider', 'chaolyst'},
    ['psykino'] = {'mage', 'psyker', 'forcer'},
    ['barrager'] = {'ranger', 'forcer', 'chaolyst'},
    ['highlander'] = {'warrior', 'chaolyst', 'ranger'},
    ['fairy'] = {'enchanter', 'healer'},
    ['priest'] = {'healer', 'warrior', 'mage'},
    ['infestor'] = {'curser', 'swarmer'},
    ['flagellant'] = {'psyker', 'enchanter'},
    ['arcanist'] = {'sorcerer'},
    -- ['illusionist'] = {'sorcerer', 'conjurer'},
    ['artificer'] = {'sorcerer', 'conjurer'},
    ['witch'] = {'sorcerer', 'voider'},
    ['silencer'] = {'sorcerer', 'curser', 'explorer'},
    ['vulcanist'] = {'sorcerer', 'nuker', 'voider', 'conjurer'},
    ['warden'] = {'sorcerer', 'forcer'},
    ['psychic'] = {'sorcerer', 'psyker'},
    ['miner'] = {'mercenary', 'explorer', 'nuker'},
    ['merchant'] = {'mercenary', 'explorer'},
    ['usurer'] = {'curser', 'mercenary', 'voider'},
    ['gambler'] = {'mercenary', 'sorcerer', 'chaolyst'},
    ['thief'] = {'rogue', 'mercenary'},
    ['warper'] = {'chaolyst', 'curser', 'forcer', 'enchanter'},
    ['nexus'] = {'explorer', 'chaolyst', 'healer', 'psyker'},
    ['carmine_queen'] = {'chaolyst', 'forcer', 'enchanter', 'healer'}
  }

  character_class_strings = {
    ['vagrant'] = '[fg]Explorer, [fgpsyk]Psyker, [yellowforc]Forcer',
    ['swordsman'] = '[yellow]Warrior',
    ['wizard'] = '[blue]Mage, [red]Nuker',
    ['magician'] = '[blue]Mage',
    ['archer'] = '[green]Ranger',
    ['scout'] = '[reddark]Rogue',
    ['cleric'] = '[greenheal]Healer',
    ['outlaw'] = '[yellow]Warrior, [reddark]Rogue',
    ['blade'] = '[yellow]Warrior, [red]Nuker',
    ['elementor'] = '[blue]Mage, [red]Nuker',
    -- ['saboteur'] = '[red]Rogue, [orangebuil]Conjurer, [red]Nuker',
    ['bomber'] = '[red]Nuker, [orangebuil]Builder',
    ['stormweaver'] = '[blueench]Enchanter',
    ['sage'] = '[purple]Voider, [yellowforc]Forcer, [fg]Explorer',
    ['squire'] = '[blueench]Enchanter',
    ['cannoneer'] = '[green]Ranger, [red]Nuker, [carmine]Chaolyst',
    ['dual_gunner'] = '[green]Ranger, [reddark]Rogue',
    -- ['hunter'] = '[green]Ranger, [orange]Conjurer, [yellowforc]Forcer',
    ['sentry'] = '[green]Ranger, [orangebuil]Builder',
    ['chronomancer'] = '[blue]Mage, [blueench]Enchanter',
    ['spellblade'] = '[blue]Mage, [reddark]Rogue, [carmine]Chaolyst',
    ['psykeeper'] = '[greenheal]Healer, [fgpsyk]Psyker, [carmine]Chaolyst, [yellow]Warrior',
    ['engineer'] = '[orangebuil]Builder',
    ['plague_doctor'] = '[red]Nuker, [purple]Voider, [orange]Swarmer',
    ['barbarian'] = '[purplecurs]Curser, [yellow]Warrior',
    ['juggernaut'] = '[yellowforc]Forcer, [yellow]Warrior',
    ['lich'] = '[blue]Mage',
    ['cryomancer'] = '[blue]Mage, [purple]Voider',
    ['pyromancer'] = '[blue]Mage, [red]Nuker, [purple]Voider',
    ['corruptor'] = '[green]Ranger, [orange]Swarmer, [carmine]Chaolyst',
    ['beastmaster'] = '[reddark]Rogue, [orange]Swarmer',
    ['launcher'] = '[yellowforc]Forcer, [purple]Curser',
    ['jester'] = '[purplecurs]Curser, [reddark]Rogue',
    ['assassin'] = '[reddark]Rogue, [purple]Voider',
    ['host'] = '[orange]Swarmer',
    ['carver'] = '[orangebuil]Builder, [greenheal]Healer',
    ['bane'] = '[purplecurs]Curser, [purple]Voider, [carmine]Chaolyst',
    ['psykino'] = '[blue]Mage, [fgpsyk]Psyker, [yellowforc]Forcer',
    ['barrager'] = '[green]Ranger, [yellowforc]Forcer, [carmine]Chaolyst',
    ['highlander'] = '[yellow]Warrior, [carmine]Chaolyst, [green]Ranger',
    ['fairy'] = '[blueench]Enchanter, [greenheal]Healer',
    ['priest'] = '[greenheal]Healer, [yellow]Warrior, [blue]Mage',
    ['infestor'] = '[purplecurs]Curser, [orange]Swarmer',
    ['flagellant'] = '[fgpsyk]Psyker, [blueench]Enchanter',
    ['arcanist'] = '[blue2]Sorcerer',
    -- ['illusionist'] = '[blue2]Sorcerer, [orangebuil]Conjurer',
    ['artificer'] = '[blue2]Sorcerer, [orangebuil]Builder',
    ['witch'] = '[blue2]Sorcerer, [purple]Voider',
    ['silencer'] = '[blue2]Sorcerer, [purplecurs]Curser, [fg]Explorer',
    ['vulcanist'] = '[blue2]Sorcerer, [red]Nuker, [purple]Voider, [orangebuil]Builder',
    ['warden'] = '[blue2]Sorcerer, [yellowforc]Forcer',
    ['psychic'] = '[blue2]Sorcerer, [fgpsyk]Psyker',
    ['miner'] = '[yellow2]Mercenary, [fg]Explorer, [red]Nuker',
    ['merchant'] = '[yellow2]Mercenary, [fg]Explorer',
    ['usurer'] = '[purplecurs]Curser, [yellow2]Mercenary, [purple]Voider',
    ['gambler'] = '[yellow2]Mercenary, [blue2]Sorcerer, [carmine]Chaolyst',
    ['thief'] = '[reddark]Rogue, [yellow2]Mercenary',
    ['warper'] = '[carmine]Chaolyst, [purplecurs]Curser, [yellowforc]Forcer, [blueench]Enchanter',
    ['nexus'] = '[fg]Explorer, [carmine]Chaolyst, [greenheal]Healer, [fgpsyk]Psyker',
  }

  get_character_stat_string = function(character, level)
    local group = Group():set_as_physics_world(32, 0, 0, {'player', 'enemy', 'projectile', 'enemy_projectile'})
    local player = Player{group = group, leader = true, character = character, level = level, follower_index = 1}
    player:update(0)
    return '[red]HP: [red]' .. player.max_hp .. '[fg], [red]DMG: [red]' .. player.dmg .. '[fg], [green]ASPD: [green]' .. math.round(player.aspd_m, 2) .. 'x[fg], [blue]AREA: [blue]' ..
    math.round(player.area_dmg_m*player.area_size_m, 2) ..  'x[fg], [yellow]DEF: [yellow]' .. math.round(player.def, 2) .. '[fg], [green]MVSPD: [green]' .. math.round(player.v, 2) .. '[fg]'
  end

  get_character_stat = function(character, level, stat)
    local group = Group():set_as_physics_world(32, 0, 0, {'player', 'enemy', 'projectile', 'enemy_projectile'})
    local player = Player{group = group, leader = true, character = character, level = level, follower_index = 1}
    player:update(0)
    return math.round(player[stat], 2)
  end

  character_descriptions = {
    ['vagrant'] = function(lvl) return '[fg]shoots a projectile that deals [yellow]' .. get_character_stat('vagrant', lvl, 'dmg') .. '[fg] dmg, dmg to knockback and weak stun' end,
    ['swordsman'] = function(lvl) return '[fg]deals [yellow]' .. get_character_stat('swordsman', lvl, 'dmg') .. '[fg] damage in an area, deals extra [yellow]' ..
      math.round(get_character_stat('swordsman', lvl, 'dmg')*0.15, 2) .. '[fg] damage per unit hit' end,
    ['wizard'] = function(lvl) return '[fg]shoots a projectile that deals [yellow]' .. get_character_stat('wizard', lvl, 'dmg') .. ' AoE[fg] damage' end,
    ['magician'] = function(lvl) return '[fg]creates a small area that deals [yellow]' .. get_character_stat('magician', lvl, 'dmg') .. ' AoE[fg] damage' end,
    ['archer'] = function(lvl) return '[fg]shoots an arrow that deals [yellow]' .. get_character_stat('archer', lvl, 'dmg') .. '[fg] damage and pierces' end,
    ['scout'] = function(lvl) return '[fg]throws a knife that deals [yellow]' .. get_character_stat('scout', lvl, 'dmg') .. '[fg] damage and chains [yellow]3[fg] times' end,
    ['cleric'] = function(lvl) return '[fg]creates [yellow]1[fg] healing orb every [yellow]8[fg] seconds' end,
    ['outlaw'] = function(lvl) return '[fg]throws a fan of [yellow]5[fg] knives, each dealing [yellow]' .. get_character_stat('outlaw', lvl, 'dmg') .. '[fg] damage' end,
    ['blade'] = function(lvl) return '[fg]throws multiple blades that deal [yellow]' .. get_character_stat('blade', lvl, 'dmg') .. ' AoE[fg] damage' end,
    ['elementor'] = function(lvl) return '[fg]deals [yellow]' .. get_character_stat('elementor', lvl, 'dmg') .. ' AoE[fg] damage in a large area centered on a random target' end,
    ['saboteur'] = function(lvl) return '[fg]calls [yellow]2[fg] saboteurs to seek targets and deal [yellow]' .. get_character_stat('saboteur', lvl, 'dmg') .. ' AoE[fg] damage' end,
    ['bomber'] = function(lvl) return '[fg]plants a bomb, when it explodes it deals [yellow]' .. 2*get_character_stat('bomber', lvl, 'dmg') .. ' AoE[fg] damage' end,
    ['stormweaver'] = function(lvl) return '[fg]infuses projectiles with chain lightning that deals [yellow]20%[fg] damage to [yellow]2[fg] enemies' end,
    ['sage'] = function(lvl) return '[fg]emits a singularity that draws enemies in and deals [purple]' .. 0.5*get_character_stat('sage', lvl, 'dmg') .. 'dps' end,
    ['squire'] = function(lvl) return '[yellow]+12%[fg] damage and defense to all allies' end, 
    ['cannoneer'] = function(lvl) return '[fg]shoots a projectile that deals [yellow]' .. 2*get_character_stat('cannoneer', lvl, 'dmg') .. ' AoE[fg] damage' end,
    ['dual_gunner'] = function(lvl) return '[fg]shoots two parallel projectiles, each dealing [yellow]' .. get_character_stat('dual_gunner', lvl, 'dmg') .. '[fg] damage' end,
    ['hunter'] = function(lvl) return '[fg]shoots an arrow that deals [yellow]' .. get_character_stat('hunter', lvl, 'dmg') .. '[fg] damage and has a [yellow]20%[fg] chance to summon a pet' end,
    ['sentry'] = function(lvl) return '[fg]spawns a rotating turret that shoots [yellow]4[fg] projectiles, each dealing [yellow]' .. get_character_stat('sentry', lvl, 'dmg') .. '[fg] damage' end,
    ['chronomancer'] = function(lvl) return '[yellow]+15%[fg] attack speed to all allies' end,
    ['spellblade'] = function(lvl) return '[fg]knives deal [yellow]' .. get_character_stat('spellblade', lvl, 'dmg') .. '[fg] dmg in a random spiral, in-dmg: +1-31%' end,
    ['psykeeper'] = function(lvl) return '[fg][yellow]3[fg] healing orbs when the psykeeper takes [yellow]25%[fg] of its max HP in damage' end,
    ['engineer'] = function(lvl) return '[fg]drops turrets that shoot bursts of projectiles, each dealing [yellow]' .. get_character_stat('engineer', lvl, 'dmg') .. '[fg] damage' end,
    ['plague_doctor'] = function(lvl) return '[fg]spawns a DoTAoE of [yellow]' .. get_character_stat('plague_doctor', lvl, 'dmg') .. '[fg] DPS and spawns decaying critters on enemy death' end,
    ['barbarian'] = function(lvl) return '[fg]deals [yellow]' .. get_character_stat('barbarian', lvl, 'dmg') .. '[fg] AoE damage and stuns enemies hit for [yellow]4[fg] seconds' end,
    ['juggernaut'] = function(lvl) return '[fg]deals [yellow]' .. get_character_stat('juggernaut', lvl, 'dmg') .. '[fg] AoE damage and strong knockback/stun' end,
    ['lich'] = function(lvl) return '[fg]launches a slow projectile that jumps [yellow]7[fg] times, dealing [yellow]' ..  2*get_character_stat('lich', lvl, 'dmg') .. '[fg] damage per hit' end,
    ['cryomancer'] = function(lvl) return '[fg]nearby enemies take [yellow]' .. 0.8*get_character_stat('cryomancer', lvl, 'dmg') .. '[fg] dps and are slowed for ' .. math.max(1, lvl)*0.2 .. '%' end,
    ['pyromancer'] = function(lvl) return '[fg]nearby enemies take [yellow]' .. get_character_stat('pyromancer', lvl, 'dmg') .. '[fg] damage per second' end,
    ['corruptor'] = function(lvl) return '[fg]an arrow deals [yellow]' .. get_character_stat('corruptor', lvl, 'dmg') .. '[fg]dmg, spawns [carmine]3[fg] def reducing critters if it kills' end,
    ['beastmaster'] = function(lvl) return '[fg]throws a knife that deals [yellow]' .. get_character_stat('beastmaster', lvl, 'dmg') .. '[fg] damage, spawn [yellow]2[fg] critters if it crits' end,
    ['launcher'] = function(lvl) return '[fg]all nearby enemies are pushed after [yellow]4[fg] seconds, taking [yellow]' .. 2*get_character_stat('launcher', lvl, 'dmg') .. '[fg] damage on wall hit' end,
    ['jester'] = function(lvl) return "[fg]curses [yellow]6[fg] nearby enemies for [yellow]6[fg] seconds, they will explode into [yellow]4[fg] knives on death" end,
    ['assassin'] = function(lvl) return '[fg]throws a piercing knife that deals [yellow]' .. get_character_stat('assassin', lvl, 'dmg') .. '[fg] damage + [yellow]' ..
      get_character_stat('assassin', lvl, 'dmg')/2 .. '[fg] damage per second' end,
    ['host'] = function(lvl) return '[fg]periodically spawn [yellow]1[fg] small critter' end,
    ['carver'] = function(lvl) return '[fg]carves a statue that creates [yellow]1[fg] healing orb every [yellow]6[fg] seconds' end,
    ['bane'] = function(lvl) return '[fg]curses [yellow]6[fg] close enemies for [yellow]6[fg]sec: +10% in-dmg, [purplecurs]cursing ' .. get_character_stat('bane', lvl, 'dmg') .. 'dmg void rifts [fg]on death' end,
    ['psykino'] = function(lvl) return '[fg]pulls enemies together for [yellow]2[fg] seconds' end,
    ['barrager'] = function(lvl) return '[fg]shoots a barrage of [yellow]3[fg] arrows, each dealing [yellow]' .. get_character_stat('barrager', lvl, 'dmg') .. '[fg] dmg and tiny knockback/stun' end,
    ['highlander'] = function(lvl) return '[fg]deals [yellow]' .. 6*get_character_stat('highlander', lvl, 'dmg') .. '[fg] AoE exploding into arrows dmg' end,
    ['fairy'] = function(lvl) return '[fg]creates [yellow]1[fg] healing orb and grants [yellow]1[fg] unit [yellow]+100%[fg] attack speed for [yellow]6[fg] seconds' end,
    ['priest'] = function(lvl) return '[fg]deals [yellow]' .. 0.5*get_character_stat('priest', lvl, 'dmg') .. '[fg] AoE damage and heals+def boosts for 25% of all dmg' end,
    ['infestor'] = function(lvl) return '[fg]curses [yellow]8[fg] nearby enemies for [yellow]6[fg] seconds, they will release [yellow]2[fg] critters on death' end,
    ['flagellant'] = function(lvl) return '[fg]deals [yellow]' .. 2*get_character_stat('flagellant', lvl, 'dmg') .. '[fg] damage to self and grants [yellow]+4%[fg] damage to all allies per cast' end,
    ['arcanist'] = function(lvl) return '[fg]launches a slow moving orb that launches projectiles, each dealing [yellow]' .. get_character_stat('arcanist', lvl, 'dmg') .. '[fg] damage' end,
    ['illusionist'] = function(lvl) return '[fg]launches a projectile that deals [yellow]' .. get_character_stat('illusionist', lvl, 'dmg') .. '[fg] damage and creates copies that do the same' end,
    ['artificer'] = function(lvl) return '[fg]spawns an automaton that shoots a projectile that deals [yellow]' .. get_character_stat('artificer', lvl, 'dmg') .. '[fg] damage' end,
    ['witch'] = function(lvl) return '[fg]creates an area that ricochets and deals [yellow]' .. get_character_stat('witch', lvl, 'dmg') .. '[fg] damage per second' end,
    ['silencer'] = function(lvl) return '[fg]curses [yellow]5[fg] nearby enemies for [yellow]6[fg] seconds, preventing them from using special attacks' end,
    ['vulcanist'] = function(lvl) return '[fg]volcano deals AoE [red]' .. get_character_stat('vulcanist', lvl, 'dmg') .. 'dmg [yellow]4[fg] times, afterburn: [red]' .. 0.2*get_character_stat('vulcanist', lvl, 'dmg') .. 'dps[fg] 5sec' end,
    ['warden'] = function(lvl) return '[fg]creates a force field around a random unit that prevents enemies from entering' end,
    ['psychic'] = function(lvl) return '[fg]creates a small area that deals [yellow]' .. get_character_stat('psychic', lvl, 'dmg') .. ' AoE[fg] damage' end,
    ['miner'] = function(lvl) return '[yellow2]' .. 0.5*get_character_stat('miner', lvl, 'dmg') .. 'dmg [fg]in a line, gold pickup: large AoE hit of [yellow2]' .. 6*get_character_stat('miner', lvl, 'dmg') .. 'dmg' end,
    ['merchant'] = function(lvl) return '[fg]gain [yellow]+1[fg] interest for every [yellow]10[fg] gold, up to a max of [yellow]+10[fg] from the merchant' end,
    ['usurer'] = function(lvl) return '[fg]curses [yellow]3[fg] nearby enemies indefinitely with debt, dealing [yellow]' .. get_character_stat('usurer', lvl, 'dmg') .. '[fg] damage per second' end,
    ['gambler'] = function(lvl) return '[fg]deal [yellow]4xGold (max 1K)[fg] base dmg to a single random enemy' end,
    ['thief'] = function(lvl) return '[fg]throws a knife that deals [yellow]' .. 2*get_character_stat('thief', lvl, 'dmg') .. '[fg] damage and chains [yellow]5[fg] times' end,
    ['warper'] = function(lvl) return '[fg]curses [yellow]6[fg] close enemies: +0-20% in-dmg, random: stun/push/silence' end,
    ['nexus'] = function(lvl) return '[fg]heals units for maxhp and deals that as base dmg to an enemy' end,
  }

  character_effect_names = {
    ['vagrant'] = '[fg]Experience',
    ['swordsman'] = '[yellow]Cleave',
    ['wizard'] = '[blue]Magic Missile',
    ['magician'] = '[blue]Quick Cast',
    ['archer'] = '[green]Bounce Shot',
    ['scout'] = '[reddark]Dagger Resonance',
    ['cleric'] = '[greenheal]Mass Heal',
    ['outlaw'] = '[reddark]Flying Daggers',
    ['blade'] = '[yellow]Blade Resonance',
    ['elementor'] = '[blue]Windfield',
    ['saboteur'] = '[orangebuil]Demoman',
    ['bomber'] = '[orangebuil]Demoman',
    ['stormweaver'] = '[blueench]Wide Lightning',
    ['sage'] = '[purple]Accretion',
    ['squire'] = '[yellow]Shiny Gear',
    ['cannoneer'] = '[orangebuil]Nuclear Blast',
    ['dual_gunner'] = '[green]Gun Kata',
    ['hunter'] = '[green]Feral Pack',
    ['sentry'] = '[green]Sentry Barrage',
    ['chronomancer'] = '[blueench]Quicken',
    ['spellblade'] = '[blue]Spiralism',
    ['psykeeper'] = '[fgpsyk]Crucio',
    ['engineer'] = '[orangebuil]Upgrade!!!',
    ['plague_doctor'] = '[purple]Virulence',
    ['barbarian'] = '[yellow]Crusher',
    ['juggernaut'] = '[yellowforc]Brutal Impact',
    ['lich'] = '[blue]Chain Frost',
    ['cryomancer'] = '[blue]Lich',
    ['pyromancer'] = '[red]Ignite',
    ['corruptor'] = '[orange]Corruption',
    ['beastmaster'] = '[reddark]Call of the Wild',
    ['launcher'] = '[orangebuio]Kineticism',
    ['jester'] = "[reddark]Pandemonium",
    ['assassin'] = '[purple]Toxic Delivery',
    ['host'] = '[orange]Invasion',
    ['carver'] = '[greenheal]World Tree',
    ['bane'] = '[purple]Nightmare',
    ['psykino'] = '[fgpsyk]Magnetic Force',
    ['barrager'] = '[green]Chaos Barrage',
    ['highlander'] = '[yellow]Overconfidence',
    ['fairy'] = '[green]Whimsy',
    ['priest'] = '[greenheal]Divine Intervention',
    ['infestor'] = '[orange]Infestation',
    ['flagellant'] = '[red]Zealotry',
    ['arcanist'] = '[blue2]Arcane Orb',
    ['illusionist'] = '[blue2]Mirror Image',
    ['artificer'] = '[blue2]Spell Formula Efficiency',
    ['witch'] = '[purple]Death Pool',
    ['silencer'] = '[purplecurs]Arcane Curse',
    ['vulcanist'] = '[red]Cataclysm',
    ['warden'] = '[yellowforc]Magnetic Field',
    ['psychic'] = '[fgpsyk]Mental Strike',
    ['miner'] = '[yellow2]Ore Bomb',
    ['merchant'] = '[yellow2]Item Shop',
    ['usurer'] = '[purple]Bankruptcy',
    ['gambler'] = '[yellow2]Chancer',
    ['thief'] = '[reddark]Ultrakill',
    ['warper'] = '[carmine]Temporal Distortion',
    ['nexus'] = '[carmine]Chaotic Creation',
  }

  character_effect_names_gray = {
    ['vagrant'] = '[light_bg]Experience',
    ['swordsman'] = '[light_bg]Cleave',
    ['wizard'] = '[light_bg]Magic Missile',
    ['magician'] = '[light_bg]Quick Cast',
    ['archer'] = '[light_bg]Bounce Shot',
    ['scout'] = '[light_bg]Dagger Resonance',
    ['cleric'] = '[light_bg]Mass Heal ',
    ['outlaw'] = '[light_bg]Flying Daggers',
    ['blade'] = '[light_bg]Blade Resonance',
    ['elementor'] = '[light_bg]Windfield',
    ['saboteur'] = '[light_bg]Demoman',
    ['bomber'] = '[light_bg]Demoman',
    ['stormweaver'] = '[light_bg]Wide Lightning',
    ['sage'] = '[light_bg]Accretion',
    ['squire'] = '[light_bg]Shiny Gear',
    ['cannoneer'] = '[light_bg]Nuclear Blast',
    ['dual_gunner'] = '[light_bg]Gun Kata',
    ['hunter'] = '[light_bg]Feral Pack',
    ['sentry'] = '[light_bg]Sentry Barrage',
    ['chronomancer'] = '[light_bg]Quicken',
    ['spellblade'] = '[light_bg]Spiralism',
    ['psykeeper'] = '[light_bg]Crucio',
    ['engineer'] = '[light_bg]Upgrade!!!',
    ['plague_doctor'] = '[light_bg]Virulence',
    ['barbarian'] = '[light_bg]Crusher',
    ['juggernaut'] = '[light_bg]Brutal Impact',
    ['lich'] = '[light_bg]Chain Frost',
    ['cryomancer'] = '[light_bg]Lich',
    ['pyromancer'] = '[light_bg]Ignite',
    ['corruptor'] = '[light_bg]Corruption',
    ['beastmaster'] = '[light_bg]Call of the Wild',
    ['launcher'] = '[light_bg]Kineticism',
    ['jester'] = "[light_bg]Pandemonium",
    ['assassin'] = '[light_bg]Toxic Delivery',
    ['host'] = '[light_bg]Invasion',
    ['carver'] = '[light_bg]World Tree',
    ['bane'] = '[light_bg]Nightmare',
    ['psykino'] = '[light_bg]Magnetic Force',
    ['barrager'] = '[light_bg]Chaos Barrage',
    ['highlander'] = '[light_bg]Overconfidence',
    ['fairy'] = '[light_bg]Whimsy',
    ['priest'] = '[light_bg]Divine Intervention',
    ['infestor'] = '[light_bg]Infestation',
    ['flagellant'] = '[light_bg]Zealotry',
    ['arcanist'] = '[light_bg]Arcane Orb',
    ['illusionist'] = '[light_bg]Mirror Image',
    ['artificer'] = '[light_bg]Spell Formula Efficiency',
    ['witch'] = '[light_bg]Death Pool',
    ['silencer'] = '[light_bg]Arcane Curse',
    ['vulcanist'] = '[light_bg]Cataclysm',
    ['warden'] = '[light_bg]Magnetic Field',
    ['psychic'] = '[light_bg]Mental Strike',
    ['miner'] = '[light_bg]Ore Bomb',
    ['merchant'] = '[light_bg]Item Shop',
    ['usurer'] = '[light_bg]Bankruptcy',
    ['gambler'] = '[light_bg]Chancer',
    ['thief'] = '[light_bg]Ultrakill',
    ['warper'] = '[light_bg]Temporal Distortion',
    ['nexus'] = '[light_bg]Chaotic Creation',
  }

  character_effect_descriptions = {
    ['vagrant'] = function() return '[yellow]+15%[fg] attack speed and damage per active class' end,
    ['swordsman'] = function() return "[fg]the swordsman's damage is [yellow]doubled" end,
    ['wizard'] = function() return '[fg]the projectile chains [yellow]2[fg] times' end,
    ['magician'] = function() return '[yellow]+50%[[fg] attack speed every [yellow]12[fg] seconds for [yellow]6[fg] seconds' end,
    ['archer'] = function() return '[fg]the arrow ricochets off walls [yellow]3[fg] times' end,
    ['scout'] = function() return '[yellow]+25%[fg] damage per chain and [yellow]+3[fg] chains' end,
    ['cleric'] = function() return '[fg]creates [yellow]4[fg] healing orbs every [yellow]8[fg] seconds' end,
    ['outlaw'] = function() return "[yellow]+50%[fg] outlaw attack speed and his knives seek enemies" end,
    ['blade'] = function() return '[fg]deal additional [yellow]' .. math.round(get_character_stat('blade', 3, 'dmg')/3, 2) .. '[fg] damage per enemy hit' end,
    ['elementor'] = function() return '[fg]slows enemies by [yellow]60%[fg] for [yellow]6[fg] seconds on hit' end,
    ['saboteur'] = function() return '[fg]the explosion has [yellow]50%[fg] chance to crit, increasing in size and dealing [yellow]2x[fg] damage' end,
    ['bomber'] = function() return '[yellow]+100%[fg] bomb area and damage' end,
    ['stormweaver'] = function() return "[fg]chain lightning's trigger area of effect and number of units hit is [yellow]doubled" end,
    ['sage'] = function() return '[fg]34% of all enemy hp lost is added to the damage of the projectile' end,
    ['squire'] = function() return '[yellow]+12%[fg] damage, attack speed, movement speed and defense to all allies' end,
    ['cannoneer'] = function() return '[fg]40-100 defence reduction to hit enemies, resets on hit' end,
    ['dual_gunner'] = function() return '[fg]every 5th attack shoot in rapid succession for [yellow]2[fg] seconds' end,
    ['hunter'] = function() return '[fg]summons [yellow]3[fg] pets and the pets ricochet off walls once' end,
    ['sentry'] = function() return '[yellow]+50%[fg] sentry turret attack speed and the projectiles ricochet [yellow]twice[fg]' end,
    ['chronomancer'] = function() return '[fg]enemies take damage over time [yellow]50%[fg] faster' end,
    ['spellblade'] = function() return '[fg]faster projectile speed and tighter turns' end,
    ['psykeeper'] = function() return '[fg]40% chance to deal 1-4 enemies their maxHP dmg on any enemy collision' end,
    ['engineer'] = function() return '[fg]drops [yellow]2[fg] additional turrets and grants all turrets [yellow]+50%[fg] damage and attack speed' end,
    ['plague_doctor'] = function() return '[fg]decaying critters carry copies of the original DoTAoE when alive' end,
    ['barbarian'] = function() return '[fg]stunned enemies also take [yellow]100%[fg] increased damage' end,
    ['juggernaut'] = function() return '[fg]enemies pushed by the juggernaut take [yellow]' .. 4*get_character_stat('juggernaut', 3, 'dmg') .. '[fg] damage if they hit a wall' end,
    ['lich'] = function() return '[fg]chain frost slows enemies hit by [yellow]80%[fg] for [yellow]2[fg] seconds and chains [yellow]+7[fg] times' end,
    ['cryomancer'] = function() return '[fg]slowed enemies turn into 3-chain [blue]' .. 0.1*get_character_stat('cryomancer', 3, 'dmg') .. 'dmg 70% slow orbs'  end,
    ['pyromancer'] = function() return '[fg]enemies killed by the pyromancer explode, dealing [yellow]' .. get_character_stat('pyromancer', 3, 'dmg') .. '[fg] AoE damage' end,
    ['corruptor'] = function() return '[fg]spawn [carmine]2[fg] small defence reducing critters if the corruptor hits an enemy' end,
    ['beastmaster'] = function() return '[fg]spawn [yellow]4[fg] small critters if the beastmaster gets hit' end,
    ['launcher'] = function() return '[fg]enemies launched take [yellow]300%[fg] more damage when they hit walls' end,
    ['jester'] = function() return '[fg]all knives seek enemies and pierce [yellow]2[fg] times' end,
    ['assassin'] = function() return '[fg]poison inflicted from crits deals [yellow]8x[fg] damage' end,
    ['host'] = function() return '[fg][yellow]+100%[fg] critter spawn rate and spawn [yellow]2[fg] critters instead' end,
    ['carver'] = function() return '[fg]carves a tree that creates healing orbs [yellow]twice[fg] as fast' end,
    ['bane'] = function() return "[yellow]100%[fg] increased area for bane's void rifts" end,
    ['psykino'] = function() return '[fg]enemies take [yellow]' .. 4*get_character_stat('psykino', 3, 'dmg') .. '[fg] damage and get strong knockback/stun on expiration' end,
    ['barrager'] = function() return '[fg]every 3rd attack - [carmine]15[fg] projectiles that push 10%-1000% harder' end,
    ['highlander'] = function() return '[fg]deal 10x damage or receive 10% max_hp dmg every attack' end,
    ['fairy'] = function() return '[fg]creates [yellow]2[fg] healing orbs and grants [yellow]2[fg] units [yellow]+100%[fg] attack speed' end,
    ['priest'] = function() return '[fg]picks [yellow]3[fg] units at random and grants them a buff that prevents death once' end,
    ['infestor'] = function() return '[fg][yellow]triples[fg] the number of critters released' end,
    ['flagellant'] = function() return '[yellow]2X[fg] flagellant max HP and grants [yellow]+12%[fg] damage to all allies per cast instead' end,
    ['arcanist'] = function() return '[yellow]+50%[fg] attack speed for the orb and [yellow]2[fg] projectiles are released per cast' end,
    ['illusionist'] = function() return '[yellow]doubles[fg] the number of copies created and they release [yellow]12[fg] projectiles on death' end,
    ['artificer'] = function() return '[fg]automatons shoot and move 50% faster and release [yellow]12[fg] projectiles on death' end,
    ['witch'] = function() return '[fg]the area releases projectiles, each dealing [yellow]' .. get_character_stat('witch', 3, 'dmg') .. '[fg] damage and chaining once' end,
    ['silencer'] = function() return '[fg]the curse also deals [yellow]' .. get_character_stat('silencer', 3, 'dmg') .. '[fg] damage per second' end,
    ['vulcanist'] = function() return '[fg]casts DoTAreas that cause short afterburn' end,
    ['warden'] = function() return '[fg]creates the force field around [yellow]2[fg] units' end,
    ['psychic'] = function() return '[fg]the attack can happen from any distance and repeats once' end,
    ['miner'] = function() return '[fg]gold pickup: large AoE hit of [yellow2]' .. 12*get_character_stat('miner', 3, 'dmg') .. 'dmg [fg]instead' end,
    ['merchant'] = function() return '[fg]your first item reroll is always free' end,
    ['usurer'] = function() return '[fg]if the same enemy is cursed [yellow]3[fg] times it takes [yellow]' .. 10*get_character_stat('usurer', 3, 'dmg') .. '[fg] damage' end,
    ['gambler'] = function() return '[fg]51%-60% chance - get 10% gold or 50%-59% - lose 10% gold, each second' end,
    ['thief'] = function() return '[fg]if the knife crits it deals [yellow]' .. 10*get_character_stat('thief', 3, 'dmg') .. '[fg] damage, chains [yellow]10[fg] times and grants [yellow]1[fg] gold' end,
    ['warper'] = function(lvl) return '[fg]0-100% aspd to a random ally every half a second' end,
    ['nexus'] = function(lvl) return '[fg]Psyker orbs get random effects and become unstable' end,
  }

  character_effect_descriptions_gray = {
    ['vagrant'] = function() return '[light_bg]+15% attack speed and damage per active class' end,
    ['swordsman'] = function() return "[light_bg]the swordsman's damage is doubled" end,
    ['wizard'] = function() return '[light_bg]the projectile chains 3 times' end,
    ['magician'] = function() return '[light_bg]+50% attack speed every 12 seconds for 6 seconds' end,
    ['archer'] = function() return '[light_bg]the arrow ricochets off walls 3 times' end,
    ['scout'] = function() return '[light_bg]+25% damage per chain and +3 chains' end,
    ['cleric'] = function() return '[light_bg]creates 4 healing orbs' end,
    ['outlaw'] = function() return "[light_bg]+50% outlaw attack speed and his knives seek enemies" end,
    ['blade'] = function() return '[light_bg]deal additional ' .. math.round(get_character_stat('blade', 3, 'dmg')/2, 2) .. ' damage per enemy hit' end,
    ['elementor'] = function() return '[light_bg]slows enemies by 60% for 6 seconds on hit' end,
    ['saboteur'] = function() return '[light_bg]the explosion has 50% chance to crit, increasing in size and dealing 2x damage' end,
    ['bomber'] = function() return '[light_bg]+100% bomb area and damage' end,
    ['stormweaver'] = function() return "[light_bg]chain lightning's trigger area of effect and number of units hit is doubled" end,
    ['sage'] = function() return '[light_bg]34% of all enemy hp lost is added to the damage of the projectile' end,
    ['squire'] = function() return '[light_bg]+12% damage, attack speed, movement speed and defense to all allies' end,
    ['cannoneer'] = function() return '[light_bg]40-100 defence reduction to hit enemies, resets on hit' end,
    ['dual_gunner'] = function() return '[light_bg]every 5th attack shoot in rapid succession for 2 seconds' end,
    ['hunter'] = function() return '[light_bg]summons 3 pets and the pets ricochet off walls once' end,
    ['sentry'] = function() return '[light_bg]+50% sentry turret attack speed and the projectiles ricochet twice' end,
    ['chronomancer'] = function() return '[light_bg]enemies take damage over time 50% faster' end,
    ['spellblade'] = function() return '[light_bg]faster projectile speed and tighter turns' end,
    ['psykeeper'] = function() return '[light_bg]40% chance to deal 1-4 enemies their maxHP dmg on any enemy collision' end,
    ['engineer'] = function() return '[light_bg]drops 2 additional turrets and grants all turrets +50% damage and attack speed' end,
    ['plague_doctor'] = function() return '[light_bg]decaying critters carry copies of the original DoTAoE when alive' end,
    ['barbarian'] = function() return '[light_bg]stunned enemies also take 100% increased damage' end,
    ['juggernaut'] = function() return '[light_bg]enemies pushed by the juggernaut take ' .. 4*get_character_stat('juggernaut', 3, 'dmg') .. ' damage if they hit a wall' end,
    ['lich'] = function() return '[light_bg]chain frost slows enemies hit by 80% for 2 seconds and chains +7 times' end,
    ['cryomancer'] = function() return '[light_bg]slowed enemies turn into 3-chain ' .. 0.1*get_character_stat('cryomancer', 3, 'dmg') .. 'dmg 70% slow orbs' end,
    ['pyromancer'] = function() return '[light_bg]enemies killed by the pyromancer explode, dealing ' .. get_character_stat('pyromancer', 3, 'dmg') .. ' AoE damage' end,
    ['corruptor'] = function() return '[light_bg]spawn 2 defence reducing small critters if the corruptor hits an enemy' end,
    ['beastmaster'] = function() return '[light_bg]spawn 4 small critters if the beastmaster gets hit' end,
    ['launcher'] = function() return '[light_bg]enemies launched take 300% more damage when they hit walls' end,
    ['jester'] = function() return '[light_bg]curses 6 enemies and all knives seek enemies and pierce 2 times' end,
    ['assassin'] = function() return '[light_bg]poison inflicted from crits deals 8x damage' end,
    ['host'] = function() return '[light_bg]+100% critter spawn rate and spawn 2 critters instead' end,
    ['carver'] = function() return '[light_bg]carves a tree that creates healing orbs twice as fast' end,
    ['bane'] = function() return "[light_bg]100% increased area for bane's void rifts" end,
    ['psykino'] = function() return '[light_bg]enemies take ' .. 4*get_character_stat('psykino', 3, 'dmg') .. ' damage and get strong knockback/stun on expiration' end,
    ['barrager'] = function() return '[light_bg]every 3rd attack - 15 projectiles that push 10%-1000% harder' end,
    ['highlander'] = function() return '[light_bg]50% chance to deal 10x damage, 50% chance to receive 10% max_hp damage every attack' end,
    ['fairy'] = function() return '[light_bg]creates 2 healing orbs and grants 2 units +100% attack speed' end,
    ['priest'] = function() return '[light_bg]picks 3 units at random and grants them a buff that prevents death once' end,
    ['infestor'] = function() return '[light_bg]triples the number of critters released' end,
    ['flagellant'] = function() return '[light_bg]2X flagellant max HP and grants +12% damage to all allies per cast instead' end,
    ['arcanist'] = function() return '[light_bg]+50% attack speed for the orb and 2 projectiles are released per cast' end,
    ['illusionist'] = function() return '[light_bg]doubles the number of copies created and they release 12 projectiles on death' end,
    ['artificer'] = function() return '[light_bg]automatons shoot and move 50% faster and release 12 projectiles on death' end,
    ['witch'] = function() return '[light_bg]the area periodically releases projectiles, each dealing ' .. get_character_stat('witch', 3, 'dmg') .. ' damage and chaining once' end,
    ['silencer'] = function() return '[light_bg]the curse also deals ' .. get_character_stat('silencer', 3, 'dmg') .. ' damage per second' end,
    ['vulcanist'] = function() return '[light_bg]casts DoTAreas that cause short afterburn' end,
    ['warden'] = function() return '[light_bg]creates the force field around 2 units' end,
    ['psychic'] = function() return '[light_bg]the attack can happen from any distance and repeats once' end,
    ['miner'] = function() return '[light_bg]gold pickup: large AoE hit of ' .. 12*get_character_stat('miner', 3, 'dmg') .. 'dmg instead' end,
    ['merchant'] = function() return '[light_bg]your first item reroll is always free' end,
    ['usurer'] = function() return '[light_bg]if the same enemy is cursed 3 times it takes ' .. 10*get_character_stat('usurer', 3, 'dmg') .. ' damage' end,
    ['gambler'] = function() return '[light_bg]51%-60% chance - get 10% gold or 48%-58% - lose 10% gold, each second' end,
    ['thief'] = function() return '[light_bg]if the knife crits it deals ' .. 10*get_character_stat('thief', 3, 'dmg') .. ' damage, chains 10 times and grants 1 gold' end,
    ['warper'] = function(lvl) return '[light_bg]0-100% aspd to a random ally every half a second' end,
    ['nexus'] = function(lvl) return '[light_bg]Psyker orbs get random effects and become unstable' end,
  }

  character_stats = {
    ['vagrant'] = function(lvl) return get_character_stat_string('vagrant', lvl) end,
    ['swordsman'] = function(lvl) return get_character_stat_string('swordsman', lvl) end, 
    ['wizard'] = function(lvl) return get_character_stat_string('wizard', lvl) end, 
    ['magician'] = function(lvl) return get_character_stat_string('magician', lvl) end, 
    ['archer'] = function(lvl) return get_character_stat_string('archer', lvl) end, 
    ['scout'] = function(lvl) return get_character_stat_string('scout', lvl) end, 
    ['cleric'] = function(lvl) return get_character_stat_string('cleric', lvl) end, 
    ['outlaw'] = function(lvl) return get_character_stat_string('outlaw', lvl) end, 
    ['blade'] = function(lvl) return get_character_stat_string('blade', lvl) end, 
    ['elementor'] = function(lvl) return get_character_stat_string('elementor', lvl) end, 
    ['saboteur'] = function(lvl) return get_character_stat_string('saboteur', lvl) end, 
    ['bomber'] = function(lvl) return get_character_stat_string('bomber', lvl) end, 
    ['stormweaver'] = function(lvl) return get_character_stat_string('stormweaver', lvl) end, 
    ['sage'] = function(lvl) return get_character_stat_string('sage', lvl) end, 
    ['squire'] = function(lvl) return get_character_stat_string('squire', lvl) end, 
    ['cannoneer'] = function(lvl) return get_character_stat_string('cannoneer', lvl) end, 
    ['dual_gunner'] = function(lvl) return get_character_stat_string('dual_gunner', lvl) end, 
    ['hunter'] = function(lvl) return get_character_stat_string('hunter', lvl) end, 
    ['sentry'] = function(lvl) return get_character_stat_string('sentry', lvl) end, 
    ['chronomancer'] = function(lvl) return get_character_stat_string('chronomancer', lvl) end, 
    ['spellblade'] = function(lvl) return get_character_stat_string('spellblade', lvl) end, 
    ['psykeeper'] = function(lvl) return get_character_stat_string('psykeeper', lvl) end, 
    ['engineer'] = function(lvl) return get_character_stat_string('engineer', lvl) end, 
    ['plague_doctor'] = function(lvl) return get_character_stat_string('plague_doctor', lvl) end,
    ['barbarian'] = function(lvl) return get_character_stat_string('barbarian', lvl) end,
    ['juggernaut'] = function(lvl) return get_character_stat_string('juggernaut', lvl) end,
    ['lich'] = function(lvl) return get_character_stat_string('lich', lvl) end,
    ['cryomancer'] = function(lvl) return get_character_stat_string('cryomancer', lvl) end,
    ['pyromancer'] = function(lvl) return get_character_stat_string('pyromancer', lvl) end,
    ['corruptor'] = function(lvl) return get_character_stat_string('corruptor', lvl) end,
    ['beastmaster'] = function(lvl) return get_character_stat_string('beastmaster', lvl) end,
    ['launcher'] = function(lvl) return get_character_stat_string('launcher', lvl) end,
    ['jester'] = function(lvl) return get_character_stat_string('jester', lvl) end,
    ['assassin'] = function(lvl) return get_character_stat_string('assassin', lvl) end,
    ['host'] = function(lvl) return get_character_stat_string('host', lvl) end,
    ['carver'] = function(lvl) return get_character_stat_string('carver', lvl) end,
    ['bane'] = function(lvl) return get_character_stat_string('bane', lvl) end,
    ['psykino'] = function(lvl) return get_character_stat_string('psykino', lvl) end,
    ['barrager'] = function(lvl) return get_character_stat_string('barrager', lvl) end,
    ['highlander'] = function(lvl) return get_character_stat_string('highlander', lvl) end,
    ['fairy'] = function(lvl) return get_character_stat_string('fairy', lvl) end,
    ['priest'] = function(lvl) return get_character_stat_string('priest', lvl) end,
    ['infestor'] = function(lvl) return get_character_stat_string('infestor', lvl) end,
    ['flagellant'] = function(lvl) return get_character_stat_string('flagellant', lvl) end,
    ['arcanist'] = function(lvl) return get_character_stat_string('arcanist', lvl) end,
    ['illusionist'] = function(lvl) return get_character_stat_string('illusionist', lvl) end,
    ['artificer'] = function(lvl) return get_character_stat_string('artificer', lvl) end,
    ['witch'] = function(lvl) return get_character_stat_string('witch', lvl) end,
    ['silencer'] = function(lvl) return get_character_stat_string('silencer', lvl) end,
    ['vulcanist'] = function(lvl) return get_character_stat_string('vulcanist', lvl) end,
    ['warden'] = function(lvl) return get_character_stat_string('warden', lvl) end,
    ['psychic'] = function(lvl) return get_character_stat_string('psychic', lvl) end,
    ['miner'] = function(lvl) return get_character_stat_string('miner', lvl) end,
    ['merchant'] = function(lvl) return get_character_stat_string('merchant', lvl) end,
    ['usurer'] = function(lvl) return get_character_stat_string('usurer', lvl) end,
    ['gambler'] = function(lvl) return get_character_stat_string('gambler', lvl) end,
    ['thief'] = function(lvl) return get_character_stat_string('thief', lvl) end,
    ['warper'] = function(lvl) return get_character_stat_string('warper', lvl) end,
    ['nexus'] = function(lvl) return get_character_stat_string('nexus', lvl) end,
  }

  class_stat_multipliers = {
    ['ranger'] = {hp = 1, dmg = 1.2, aspd = 1.5, area_dmg = 1, area_size = 1, def = 0.9, mvspd = 1.2},
    ['warrior'] = {hp = 1.4, dmg = 1.1, aspd = 0.9, area_dmg = 1, area_size = 1, def = 1.25, mvspd = 0.9},
    ['mage'] = {hp = 0.6, dmg = 1.4, aspd = 1, area_dmg = 1.25, area_size = 1.2, def = 0.75, mvspd = 1},
    ['rogue'] = {hp = 0.8, dmg = 1.3, aspd = 1.1, area_dmg = 0.6, area_size = 0.6, def = 0.8, mvspd = 1.4},
    ['healer'] = {hp = 1.2, dmg = 1, aspd = 0.5, area_dmg = 1, area_size = 1, def = 1.2, mvspd = 1},
    ['enchanter'] = {hp = 1.2, dmg = 1, aspd = 1, area_dmg = 1, area_size = 1, def = 1.2, mvspd = 1.2},
    ['nuker'] = {hp = 0.9, dmg = 1, aspd = 0.75, area_dmg = 1.5, area_size = 1.5, def = 1, mvspd = 1},
    ['conjurer'] = {hp = 1, dmg = 1, aspd = 1, area_dmg = 1, area_size = 1, def = 1, mvspd = 1},
    ['psyker'] = {hp = 1.5, dmg = 1, aspd = 1, area_dmg = 1, area_size = 1, def = 0.5, mvspd = 1},
    ['curser'] = {hp = 1, dmg = 1, aspd = 1, area_dmg = 1, area_size = 1, def = 0.75, mvspd = 1},
    ['forcer'] = {hp = 1.25, dmg = 1.1, aspd = 0.9, area_dmg = 0.75, area_size = 0.75, def = 1.2, mvspd = 1},
    ['swarmer'] = {hp = 1.2, dmg = 1, aspd = 1.25, area_dmg = 1, area_size = 1, def = 0.75, mvspd = 0.75},
    ['voider'] = {hp = 0.75, dmg = 1.3, aspd = 1, area_dmg = 0.8, area_size = 0.75, def = 0.6, mvspd = 0.8},
    ['sorcerer'] = {hp = 0.8, dmg = 1.3, aspd = 1, area_dmg = 1.2, area_size = 1, def = 0.8, mvspd = 1},
    ['mercenary'] = {hp = 1, dmg = 1, aspd = 1, area_dmg = 1, area_size = 1, def = 1, mvspd = 1},
    ['explorer'] = {hp = 1, dmg = 1, aspd = 1, area_dmg = 1, area_size = 1, def = 1, mvspd = 1.25},
    ['chaolyst'] = {hp = 0.8, dmg = 1, aspd = 1.1, area_dmg = 1, area_size = 1.1, def = 0.8, mvspd = 1.5},
    ['seeker'] = {hp = 0.45, dmg = 1, aspd = 1, area_dmg = 1, area_size = 1, def = 1.2, mvspd = 0.3},
    ['mini_boss'] = {hp = 0.9, dmg = 1, aspd = 1, area_dmg = 1, area_size = 1, def = 1.2, mvspd = 0.3},
    ['enemy_critter'] = {hp = 0.9, dmg = 1, aspd = 1, area_dmg = 1, area_size = 1, def = 1.2, mvspd = 0.75},
    ['saboteur'] = {hp = 1, dmg = 1, aspd = 1, area_dmg = 1, area_size = 1, def = 1, mvspd = 1.4},
  }

  all_units_global = {}
  random_unit = nil
  critter_pool = {}

  stuns = {
    juggernaut = 1.5,
    warden = 0.5,
    barrager = 1,
    psykino = 1,
    vagrant = 0.25,
    barbarian = 4,
    launcher = 1
  }

  -- the values are in (1 - slow) * speed
  slows = {
    ['sl_st'] = 0.98, -- stun
    ['sl_cl'] = 0.7, -- cryomancer level 3 - lich
    ['sl_li'] = 0.4, -- lich
    ['sl_el'] = 0.6, -- elementor level 3
    ['sl_ff'] = 0.5, -- freezing field
    ['sl_cr'] = 0.2, -- cryomancer
  }

  orbEffectInds = {}
  orbEffects = {}

  function def_orbEffect(name, color, orbFunc)
    orbEffects[name] = {name, color, orbFunc}
    table.insert(orbEffectInds, name)
  end

  def_orbEffect('psycorrosion', orangebuil[0], function(target) target.psy_corrosion = true end)
  def_orbEffect('psybreak', carmine[0], function(target) target.psybroken = true end)
  def_orbEffect('psylence', blue2[0], function(target) target.silenced = true
    target.t:after(math.random_range({4, 7}), function() target.silenced = false end) end)
  def_orbEffect('psystun', yellow[0], function(target) stun(target, math.random_range({1, 3})) end)
  def_orbEffect('psypush', yellowforc[0], function(target)
    target:push(random:float(25,50)*(main.current.player.knockback_m or 1), main.current.player:angle_to_object(target)) end)
  def_orbEffect('psyheal', greenheal[0], function(target) healLowest(random_unit, random_unit.max_hp*math.random()*0.2) end)

  function performOrbEffect(name, target)
    orbEffects[name][3](target)
  end

  function basicForcer(target, source)
    stun(target, stuns.barrager)
    target:push(math.random_range({10, 50})*(source.knockback_m or 1), source:angle_to_object(target))
  end

  function basicChaolyst(target)
    target.corrosion = target.corrosion and (target.corrosion + math.random_range({10, 40})) or math.random_range({10, 40})
  end

  function basicVoider(target, source)
    target:apply_dot(source.dmg*(source.dot_dmg_m or 1)*(main.current.chronomancer_dot or 1), 1, purple[0], source.character)
  end

  projEffects = 
  {
    ['plague_doctor'] = function(target, source) basicVoider(target, source) end,
    ['vulcanist'] = function(target, source) basicVoider(target, source) end,
    ['pyromancer'] = function(target, source) basicVoider(target, source) end,
    ['witch'] = function(target, source) basicVoider(target, source) end,
    ['cannoneer'] = function(target, source) basicChaolyst(target) end,
    ['psykeeper'] = function(target, source) basicChaolyst(target) end,
    ['highlander'] = function(target, source) basicChaolyst(target) end,
    ['nexus'] = function(target, source) basicChaolyst(target) end,
    ['juggernaut'] = function(target, source) basicForcer(target, source) end,
    ['warden'] = function(target, source) basicForcer(target, source) end,
    ['psykino'] = function(target, source) basicForcer(target, source) end,
    ['vagrant'] = function(target, source) basicForcer(target, source) end,
    ['barrager'] = function(target, source) basicForcer(target, source) end,
    ['barbarian'] = function(target, source) basicForcer(target, source) end,
    ['launcher'] = function(target, source) basicForcer(target, source) end,
    ['warper'] = function(target, source) 
      local random_result = math.random()
      target.warped = true
      if random_result < 0.33 then 
        target:push(math.random_range({25, 75})*(source.knockback_m or 1), source:angle_to_object(target))
      elseif random_result < 0.67 then
        target:curse('silencer', math.random_range({1.5, 2.5})*(source.hex_duration_m or 1), false, source)
      else
        stun(target, math.random_range({0.5, 1.5}))
      end
    end,
    ['silencer'] = function(target, source) 
      target:curse('silencer', 6*(source.hex_duration_m or 1), source.level == 3, source)
      if source.level == 3 then
        target:apply_dot(source.dmg*(source.dot_dmg_m or 1)*(main.current.chronomancer_dot or 1), 6*(source.hex_duration_m or 1), nil, 'silencer')
      end
    end,
    ['usurer'] = function(target, source) 
      target:curse('usurer', 10000, source.level == 3, source)
      target:apply_dot(source.dmg*(source.dot_dmg_m or 1)*(main.current.chronomancer_dot or 1), 10000, nil, 'usurer')
    end,
    ['jester'] = function(target, source) 
      target:curse('jester', 6*(source.hex_duration_m or 1), source.level == 3, source)
    end,
    ['infestor'] = function(target, source) 
      target:curse('infestor', 6*(source.hex_duration_m or 1), (source.level == 3 and 6 or 2), source.dmg, source)
    end,
    ['bane'] = function(target, source) 
      target:curse('bane', 6*(source.hex_duration_m or 1), source.level == 3, source)
    end,
  }

  momentum_dmg_base = 0.5
  momentum_dmg_m = momentum_dmg_base


  local ylbn = function(lvl, n)
    if lvl > n then return 'light_bg'
    elseif lvl == n then return 'yellow'
    else return 'light_bg' end
  end

  syn_pow = {}
  function null_syn_pow()
    for i, _ in pairs(class_colors) do
      syn_pow[i] = 0
    end
  end
  null_syn_pow()
  sp_max = {}
  syn_bas = {}
  syn_vals = {}
  s_offsets = {}
  s_max_counts = {}
  syn_types = {}
  syn_calcs = {}
  class_descriptions = {}
  
  local syn_descr_basic = function (class, lvl, offset, maxcount, prefix, is_perc, postdescr)
    local res = ''
    local i = 1
    while i <= maxcount do
      res = strc({res , '[' , ylbn(lvl, i) , ']', tostring(offset * i)})
      if i < maxcount then
        res = res .. '[light_bg]/'
      end
      i = i + 1
    end
    i = 1
    local perc_m = is_perc and 100 or 1
    local postfix = is_perc and '%' or ''
    res = res .. ' [fg]- '
    while i <= maxcount do
      res = strc({res , '[' , ylbn(lvl, i) , ']', prefix , tostring(syn_vals[class][i]*perc_m) , postfix})
      if i < maxcount then
        res = res .. '[light_bg]/'
      end
      i = i + 1
    end
    res = strc({res .. ' [fg]' .. postdescr})
    return res
  end
  
  function math.random_range(input_table)
    local range_scale = input_table[2] - input_table[1]
    local range_offset = input_table[1]
    return math.random() * range_scale + range_offset
  end

  function lvl_chk(level)
    return level and level > 0
  end

  gl_chaolyst_level = 0

  function chaolyze_synp()
    if gl_chaolyst_level == 0 then
      return 1
    else
      return lvl_chk(gl_chaolyst_level) and math.random_range(syn_vals['chaolyst'][gl_chaolyst_level]) or 1
    end
  end

  local syn_p = function(syn_name, type, ind) --type 0: clamped integer, type 1: 100% limit, type 2: limitless %
  	local res = syn_bas[syn_name][ind] * (1 + syn_pow[syn_name] * 0.5) * chaolyze_synp()
  	if type == 1 then
  		res = math.floor(math.min(100, res * 100)) * 0.01
  	elseif type == 2 then
  		res = math.floor(res * 100) * 0.01
  	else
  		res = math.floor(res)
  	end
  	return res
  end

  function def_syn(name, maxlevel, base_vals, calc_types, offset, max_count, calc_func, desc_func)
    syn_pow[name] = 0
    sp_max[name] = maxlevel
    syn_bas[name] = base_vals
    syn_types[name] = calc_types
    s_offsets[name] = offset
    s_max_counts[name] = max_count
    syn_vals[name] = {}
    if calc_func == nil then
      syn_calcs[name] = function() for i = 1, #syn_bas[name] do syn_vals[name][i] = syn_p(name, syn_types[name], i) end end
    else
      syn_calcs[name] = calc_func
    end
    if type(desc_func) == 'table' then
      class_descriptions[name] = function(lvl) 
        return syn_descr_basic(name, lvl, offset, max_count, desc_func[1], desc_func[2], desc_func[3]) end
    else
      class_descriptions[name] = desc_func
    end
  end

  def_syn('chaolyst', 0, {{0.95, 1.1}, {0.94, 1.2}, {0.93, 1.3}, {0.94, 1.4}}, nil, 2, 4, 
  function()
    for i = 1, #syn_bas['chaolyst'] do
      if syn_vals['chaolyst'][i] == nil then syn_vals['chaolyst'][i] = {} end
      syn_vals['chaolyst'][i][1] = syn_bas['chaolyst'][i][1]
      syn_vals['chaolyst'][i][2] = math.floor(syn_bas['chaolyst'][i][2] * (1 + syn_pow['chaolyst'] * 0.5) * 100) * 0.01
    end
  end
  , function(lvl) return strc({
    '[' , ylbn(lvl, 1) , ']2[light_bg]/' ,
    '[' , ylbn(lvl, 2) , ']4[light_bg]/' ,
    '[' , ylbn(lvl, 3) , ']6[light_bg]/' ,
    '[' , ylbn(lvl, 4) , ']8 [fg]-' ,
    '[' , ylbn(lvl, 1) , ']',tostring(syn_vals['chaolyst'][1][1]),'-',tostring(syn_vals['chaolyst'][1][2]),'[light_bg]/',
    '[' , ylbn(lvl, 2) , ']',tostring(syn_vals['chaolyst'][2][1]),'-',tostring(syn_vals['chaolyst'][2][2]),'[light_bg]/',
    '[' , ylbn(lvl, 3) , ']',tostring(syn_vals['chaolyst'][3][1]),'-',tostring(syn_vals['chaolyst'][3][2]),'[light_bg]/',
    '[' , ylbn(lvl, 4) , ']',tostring(syn_vals['chaolyst'][4][1]),'-',tostring(syn_vals['chaolyst'][4][2]),
    'x [fg]rng power to other sets'}) end)
    syn_calcs['chaolyst']()
  def_syn('ranger', 11, {0.08, 0.16}, 1, 3, 2, nil, {'', true, 'ranger barrage on attack chance and arrow dmg growth'})
  def_syn('warrior', 0, {25, 50}, 0, 3, 2, nil, {'+', false, 'defense to warriors and 25% of that to other units'})
  def_syn('mage', 0, {-21, -43, -65}, 0, 3, 3, nil, {'', false, 'enemy defense'})
  def_syn('rogue', 5, {0.15, 0.3}, 1, 3, 2, nil, {'', true, 'chance to crit to rogues, dealing [reddark]4x[] damage'})
  def_syn('healer', 5, {0.15, 0.3}, 1, 2, 2, nil, {'', true, 'chance to create [yellow]+1[fg] healing orb on healing orb creation'})
  def_syn('enchanter', 0, {0.1, 0.2, 0.25}, 2, 2, 3, nil, {'', true, 'damage'})
  def_syn('nuker', 0, {0.15, 0.25, 0.4}, 2, 3, 3, nil, {'', true, 'area damage and size to nukers'})
  def_syn('conjurer', 0, {0.25, 0.5, 0.85}, 2, 2, 3, nil, {'', true, 'construct damage and duration'})
  def_syn('psyker', 0, {4, 8}, 2, 2, 2, nil, {'+', false, 'psyker orbs'})
  def_syn('curser', 0, {1, 3, 6}, 0, 2, 3, nil, {'+', false, 'max curse targets'})
  def_syn('forcer', 0, {0.18, 0.34, 0.58, 0.9}, 2, 2, 4, nil, {'+', true, 'dmg to stunned, knockback'})
  def_syn('swarmer', 0, {1, 3}, 0, 2, 2, nil, {'+', false, 'hits to critters'})
  def_syn('voider', 0, {0.2, 0.4, 0.66, 0.96}, 2, 2, 4, nil, {'+', true, 'damage over time to voiders'})
  def_syn('mercenary', 11, {0.08, 0.16}, 1, 2, 2, nil, {'+', true, 'chance for enemies to drop gold on death'})
  def_syn('explorer', 0, {0.15, 0.2}, 2, 2, 2, nil, {'+', true, 'aspd and dps to all explorers per active class'})
  def_syn('sorcerer', 0, {n = {4, 3, 2}, a = {0, 0, 0}}, nil, 2, 3, 
  function ()
    local sorcerer_syn_m = 1/(1 + syn_pow['sorcerer'] * 0.5  * chaolyze_synp())
    for i = 1, #(syn_bas['sorcerer'].n) do
      local res_unlim = sorcerer_syn_m * syn_bas['sorcerer'].n[i]
      local res_lim = math.max(math.ceil(res_unlim),1)
      if syn_vals['sorcerer'].n == nil then syn_vals['sorcerer'].n = {} end
      if syn_vals['sorcerer'].a == nil then syn_vals['sorcerer'].a = {} end
      syn_vals['sorcerer'].n[i] = res_lim
      syn_vals['sorcerer'].a[i] = math.floor((1/res_unlim - 1/res_lim) * 100) * 0.01
    end
  end
  , function(lvl) return strc({
    '[' , ylbn(lvl, 1) , ']2[light_bg]/' ,
    '[' , ylbn(lvl, 2) , ']4[light_bg]/' ,
    '[' , ylbn(lvl, 3) , ']6 [fg]- sorcs repeat casts after ' ,
    '[' , ylbn(lvl, 1) , ']',tostring(syn_vals['sorcerer'].n[1]),'[light_bg]/',
    '[' , ylbn(lvl, 2) , ']',tostring(syn_vals['sorcerer'].n[2]),'[light_bg]/',
    '[' , ylbn(lvl, 3) , ']',tostring(syn_vals['sorcerer'].n[3]),' [fg]casts, aspd:',
    '[' , ylbn(lvl, 1) , ']','+',tostring(syn_vals['sorcerer'].a[1]*100),'%[light_bg]/',
    '[' , ylbn(lvl, 2) , ']','+',tostring(syn_vals['sorcerer'].a[2]*100),'%[light_bg]/',
    '[' , ylbn(lvl, 3) , ']','+',tostring(syn_vals['sorcerer'].a[3]*100),'%'}) end)

  function calc_syn_power(recalculate_only_active)
    if recalculate_only_active then
      for _, v in pairs(chaolyzable_sets) do
  	    syn_calcs[v]()
      end
    else
      for i, _ in pairs(sp_max) do
  	    syn_calcs[i]()
      end
    end
  end

  function get_synp(name, level)
    return lvl_chk(level) and syn_vals[name][level] or 0
  end

  function get_synpsorcrepeat(level)
    return lvl_chk(level) and syn_vals['sorcerer'].n[level] or 0
  end

  function get_synpsorcaspd(level)
    return lvl_chk(level) and syn_vals['sorcerer'].a[level] or 0
  end

  calc_syn_power(false)

  chaolyzable_sets = {}
  get_number_of_units_per_class = function(units)
    local result = {}
    for i, _ in pairs(sp_max) do
      result[i] = 0
    end
    for _, unit in ipairs(units) do
      for _, unit_class in ipairs(character_classes[unit.character]) do
        result[unit_class] = result[unit_class] + 1
      end
    end
    return result
  end

  get_class_levels = function(units)
    local units_per_class = get_number_of_units_per_class(units)
    local units_to_class_level = function(number_of_units, class)
      return math.min(math.floor(number_of_units/s_offsets[class]), s_max_counts[class])
    end
    local result = {}
    for i, _ in pairs(sp_max) do
      result[i] = units_to_class_level(units_per_class[i], i)
    end
    gl_chaolyst_level = result['chaolyst']
    return result
  end

  get_classes = function(units)
    local classes = {}
    for _, unit in ipairs(units) do
      table.insert(classes, table.copy(character_classes[unit.character]))
    end
    return table.unify(table.flatten(classes))
  end

  class_set_numbers = {}

  for i, _ in pairs(sp_max) do
    class_set_numbers[i] = function(units) return
      1 <= s_max_counts[i] and s_offsets[i]*1 or nil,
      2 <= s_max_counts[i] and s_offsets[i]*2 or nil,
      3 <= s_max_counts[i] and s_offsets[i]*3 or nil,
      4 <= s_max_counts[i] and s_offsets[i]*4 or nil,
      get_number_of_units_per_class(units)[i]
    end
  end

  function reset_syn_pow()
    null_syn_pow()
    gl_chaolyst_level = 0
    calc_syn_power(false)
  end

  lateup_names = {}
  lateup_lvls = {}
  lateup_descs = {}
  lateup_calcs = {}
  lateup_imgs = {}
  lateup_bgcol = {}
  lateup_fgcol = {}

  function def_lateup(name, desc, calc, img, bgcol, fgcol)
    table.insert(lateup_names, name)
    table.insert(lateup_lvls, 0)
    table.insert(lateup_descs, desc)
    table.insert(lateup_calcs, calc)
    table.insert(lateup_imgs, img)
    table.insert(lateup_bgcol, bgcol)
    table.insert(lateup_fgcol, fgcol)
  end

  def_lateup('body', {},
   function() end,
    body_img, greenheal[0], greenheal[-5])
  def_lateup('mouths', {},
   function() end,
    mouths_img, red[0], red[-5])

  sup_syns = {}
  hyp_syns = {}
  oversyn_desc = {}
  oversyn_cols = {}
  oversyn_vals = {}
  oversyn_needs = {}
  oversyn_behav = {}
  oversyn_level = {}

  oversyn_chains = {}
  --Data structure: 
  --{
  --['sorcerer'] = {[1] = {chain = {'conjurer'}, res = 'Delegate'},
  --              [2] = {chain = {'enchanter', 'mage'}, res = 'Chronology'}},
  --['Delegate'] = {[1] = {chain = {'Faraway'}, res = 'Sabotage'},
  --              [2] = <second possibility>},
  --<and so on with other classes or supersynergies>
  --}


  function calc_active_osyns(source, forbidden, fills, actives)
    local acc_i = 1
    while acc_i <= #osyn_fills_temp do
      local accumulation = osyn_fills_temp[acc_i]
      for _, accu_member in ipairs(accumulation) do
        if source == accu_member then
          return
        end
      end
      for _, accu_member in ipairs(accumulation) do
        if forbidden[accu_member] then
          goto skip_accumulation
        end
      end
      do -- keeping all local variables outside of the while loop's scope
        local chain_collection = oversyn_chains[accumulation[1]]
        for _, possibility in ipairs(chain_collection) do
          local chain_members = possibility.chain
          for _, chain_member in ipairs(chain_members) do
            if chain_member == source then
              if #chain_members == 1 then
                table.insert(actives, possibility.res)
                for _, v in ipairs(oversyn_needs[possibility.res]) do
                  forbidden[v] = true
                end
                return
              elseif #chain_members == 2 then --because it is always 1 or 2, we can specify here
                if accumulation[2] == nil then
                  table.insert(accumulation, source)
                  acc_i = acc_i + 1
                  local new_accumulation = {} --to allow for other 2-member synergies while the 3-member one is incomplete
                  table.insert(new_accumulation, accumulation[1])
                  table.insert(fills, acc_i, new_accumulation)
                else
                  table.insert(actives, possibility.res)
                  for _, v in ipairs(oversyn_needs[possibility.res]) do
                    forbidden[v] = true
                  end
                  return
                end
              end
            end
          end
        end
      end
      ::skip_accumulation::
      acc_i = acc_i + 1
    end
    --this is only reached if nothing is found before or if an incomplete 3-chain is found (without the last member)
    local new_accumulation = {}
    table.insert(new_accumulation, source)
    table.insert(fills, new_accumulation)
  end

  function calc_osyn_level(osyn_name)
    local min_source_count = 99
    for _, need in ipairs(oversyn_needs[osyn_name]) do
      min_source_count = math.min(min_source_count, syn_source_counts[need])
    end
    print(strc({osyn_name, ' ', min_source_count}))
    oversyn_level[osyn_name] = min_source_count
  end

  function see_oversyns(in_units)
    osyn_fills_temp = {}
    oversyn_forbidden = {}
    syn_source_counts = {}
    sup_syn_active = {}
    for i, _ in pairs(oversyn_level) do
      oversyn_level[i] = 0
    end
    for _, v in ipairs(in_units) do
      for _, syn_source in ipairs(character_classes[v.character]) do
        if syn_source_counts[syn_source] then
          syn_source_counts[syn_source] = syn_source_counts[syn_source] + 1
        else
          syn_source_counts[syn_source] = 1
          calc_active_osyns(syn_source, oversyn_forbidden, osyn_fills_temp, sup_syn_active)
        end
      end
    end
    osyn_fills_temp = {}
    hyp_syn_active = {}
    for _, sup_syns in ipairs(sup_syn_active) do
      if syn_source_counts[sup_syns] then
        syn_source_counts[sup_syns] = syn_source_counts[sup_syns] + 1
      else
        syn_source_counts[sup_syns] = 1
        calc_active_osyns(sup_syns, oversyn_forbidden, osyn_fills_temp, hyp_syn_active)
      end
    end
    print("--------")
    for _, v in ipairs(sup_syn_active) do
      calc_osyn_level(v)
    end
    for _, v in ipairs(hyp_syn_active) do
      calc_osyn_level(v)
    end
  end


  --define supersynergies first, then hypersynergies
  --because supersynergies can be of length 2 or 3, there are slight differences
  --because all oversynergies are cyclical in some way, there is a way to simplify to algorithms
  local def_oversyn = function(name, type, needs, base_val, color, desc, behaviour) --type 1 is supersynergy, 2 is hypersynergy
    if type == 1 then
      table.insert(sup_syns, name)
    elseif type == 2 then
      table.insert(hyp_syns, name)
    end
    for i = 1, #needs do
      if oversyn_chains[needs[i]] == nil then
        oversyn_chains[needs[i]] = {}
      end
      local nextchain = {}
      for j = 1, #needs do
        if i ~= j then
          table.insert(nextchain, needs[j])
        end
      end
      local chain_props = {}
      chain_props.chain = nextchain
      chain_props.res = name
      table.insert(oversyn_chains[needs[i]], chain_props)
    end
    oversyn_behav[name] = behaviour
    oversyn_cols[name] = color
    oversyn_needs[name] = needs
    oversyn_vals[name] = base_val
    oversyn_level[name] = 0
    oversyn_desc[name] = function() return strc({
      desc[1] ,
      tostring(oversyn_vals[name] * oversyn_level[name]) ,
      desc[2]})
    end
  end


  function osyn_v(name)
    return oversyn_vals[name] * oversyn_level[name]
  end

  function do_osyn(name, args)
    
  end

  
  def_oversyn('Delegate', 1, {'conjurer', 'sorcerer'}, 3, 'orangebuil', 
  {'Spawning non-boss enemies: ' ,'% chance to turn into a random unit building'},
  function(unit)
    if random:bool(osyn_v('Delegate')) then
      local borrowX = unit.x
      local borrowY = unit.y
      unit:die();
      spawnRandomBuilding(unit.x, unit.y)
    end
  end
  )

  def_oversyn('Chronology', 1, {'sorcerer', 'enchanter', 'mage'}, 1, 'blue2', 
  {'Mage and Sorcerer casts: ' ,'% chance to increase global aspd by 100% for 1 sec'},
  function()
    if random:bool(osyn_v('Chronology')) then
      for _, v in all_units_global do
        main.current.player.chronology = true 
        main.current.player:after(1, function() main.current.player.chronology = false end, 'nochronology') end 
    end
  end
  )

  def_oversyn('Armorforge', 1, {'mage', 'warrior'}, 0.2, 'yellow', 
  {'Mage and Warrior attack hits grant ',' armor, round resets'},
  function()
     main.current.player.armorforge = main.current.player.armorforge or 0
     main.current.player.armorforge = main.current.player.armorforge + osyn_v('Armorforge')
  end
  )

  def_oversyn('Cultivation', 1, {'warrior', 'healer'}, 5, 'greenheal', 
  {'Passively regenerate/generate ','% health/armor value every second, round resets'},
  function()
    if random:bool(osyn_v('Cultivation')) then
      local cultivation_val = osyn_v('Cultivation')
      healLowest(random_unit, random_unit.max_hp*cultivation_val)
      main.current.player.cultivation = main.current.player.cultivation or 0
     main.current.player.cultivation = main.current.player.cultivation + cultivation_val
    end
  end
  )

  def_oversyn('Collector', 1, {'healer', 'mercenary'}, 10, 'yellow2', 
  {'Picking up health/gold has ','% chance to give double'},
  function(unit)
    if random:bool(osyn_v('Collector')) then
      local borrowX = unit.x
      local borrowY = unit.y
      unit:die();
      --work
    end
  end
  )

  def_oversyn('Focus', 1, {'mercenary', 'explorer', 'chaolyst'}, 20, 'fg', 
  {'??? ','% ???'},
  function(unit)
    if random:bool(osyn_v('Focus')) then
      local borrowX = unit.x
      local borrowY = unit.y
      unit:die();
      --work
    end
  end
  )

  def_oversyn('Catalyst', 1, {'chaolyst', 'forcer'}, 5, 'yellow', 
  {'Damage against living enemies grows by ','% every second they live'},
  function(unit)
    if random:bool(osyn_v('Catalyst')) then
      local borrowX = unit.x
      local borrowY = unit.y
      unit:die();
      --work
    end
  end
  )

  def_oversyn('Suppression', 1, {'forcer', 'curser'}, 0.2, 'yellowforc', 
  {'Curses stun for ',' seconds'},
  function(unit)
    if random:bool(osyn_v('Suppression')) then
      local borrowX = unit.x
      local borrowY = unit.y
      unit:die();
      --work
    end
  end
  )

  def_oversyn('Corruptor', 1, {'curser', 'voider'}, 10, 'purplecurs', 
  {'All damage over time has ','% chance to apply a random equipped unit curse'},
  function(unit)
    if random:bool(osyn_v('Corruptor')) then
      local borrowX = unit.x
      local borrowY = unit.y
      unit:die();
      --work
    end
  end
  )

  def_oversyn('Overwhelm', 1, {'voider', 'nuker'}, 1, 'red', 
  {'Damage over time has ','% chance to cause 10x damage in an AoE explosion'},
  function(unit)
    if random:bool(osyn_v('Overwhelm')) then
      local borrowX = unit.x
      local borrowY = unit.y
      unit:die();
      --work
    end
  end
  )

  def_oversyn('Faraway', 1, {'nuker', 'ranger'}, 20, 'green', 
  {'All damage is ','% higher with high distance'},
  function(unit)
    if random:bool(osyn_v('Faraway')) then
      local borrowX = unit.x
      local borrowY = unit.y
      unit:die();
      --work
    end
  end
  )

  def_oversyn('Bulletzone', 1, {'ranger', 'rogue', 'psyker'}, 10, 'reddark', 
  {'A random psyker orb has ','% chance to duplicate a projectile on its cast'},
  function(unit)
    if random:bool(osyn_v('Bulletzone')) then
      local borrowX = unit.x
      local borrowY = unit.y
      unit:die();
      --work
    end
  end
  )

  def_oversyn('Mindswarm', 1, {'psyker', 'swarmer'}, 10, 'fgpsyk', 
  {'Critters have ','% chance to borrow a supercharged psyker orb on spawn'},
  function(unit)
    if random:bool(osyn_v('Mindswarm')) then
      local borrowX = unit.x
      local borrowY = unit.y
      unit:die();
      --work
    end
  end
  )

  def_oversyn('Incubation', 1, {'swarmer', 'conjurer'}, 10, 'orange', 
  {'Buildings have ','% chance to spawn a critter every second'},
  function(unit)
    if random:bool(osyn_v('Incubation')) then
      local borrowX = unit.x
      local borrowY = unit.y
      unit:die();
      --work
    end
  end
  )

  def_oversyn('Centralization', 2, {'Focus', 'Mindswarm'}, 20, 'fg', 
  {'Critters have ','% chance to encircle the snake like psyker orbs on spawn'},
  function(unit)
    if random:bool(osyn_v('Centralization')) then
      local borrowX = unit.x
      local borrowY = unit.y
      unit:die();
      --work
    end
  end
  )

  def_oversyn('Vampirism', 2, {'Cultivation', 'Suppression'}, 10, 'reddark', 
  {'Heal ','% of damage dealt to cursed enemies'},
  function(unit)
    if random:bool(osyn_v('Vampirism')) then
      local borrowX = unit.x
      local borrowY = unit.y
      unit:die();
      --work
    end
  end
  )

  def_oversyn('Defiance', 2, {'Armorforge', 'Catalyst'}, 2, 'yellow', 
  {'Gain ',' armor for each enemy alive'},
  function(unit)
    if random:bool(osyn_v('Defiance')) then
      local borrowX = unit.x
      local borrowY = unit.y
      unit:die();
      --work
    end
  end
  )

  def_oversyn('Devourer', 2, {'Collector', 'Corruptor'}, 10, 'carmine', 
  {'Enemies have ','% chance to spawn dps boost orbs on death'},
  function(unit)
    if random:bool(osyn_v('Devourer')) then
      local borrowX = unit.x
      local borrowY = unit.y
      unit:die();
      --work
    end
  end
  )

  def_oversyn('Pestilence', 2, {'Overwhelm', 'Incubation'}, 10, 'purple', 
  {'Critters have ','% chance to spawn with a DoTArea around them'},
  function(unit)
    if random:bool(osyn_v('Pestilence')) then
      local borrowX = unit.x
      local borrowY = unit.y
      unit:die();
      --work
    end
  end
  )
  
  def_oversyn('Sabotage', 2, {'Faraway', 'Delegate'}, 10, 'blue2', 
  {'Enemies have ','% chance per second to suddenly combust into 12 projectiles'},
  function(unit)
    if random:bool(osyn_v('Sabotage')) then
      local borrowX = unit.x
      local borrowY = unit.y
      unit:die();
      --work
    end
  end
  )

  def_oversyn('Obsidian', 2, {'Armorforge', 'Corruptor'}, 1, 'purple', 
  {'Snake hit: ','% chance to ignore damage and instead transfer that to all DoTs'},
  function(unit)
    if random:bool(osyn_v('Obsidian')) then
      local borrowX = unit.x
      local borrowY = unit.y
      unit:die();
      --work
    end
  end
  )
  
  def_oversyn('Titan', 2, {'Cultivation', 'Overwhelm'}, 20, 'yellow', 
  {'Deal ','% more damage at maxhp if no units were lost'},
  function(unit)
    if random:bool(osyn_v('Titan')) then
      local borrowX = unit.x
      local borrowY = unit.y
      unit:die();
      --work
    end
  end
  )
  
  def_oversyn('Telekinesis', 2, {'Collector', 'Faraway'}, 20, 'yellow2', 
  {'Drops: ','% chance/sec to rush towards you, 50% maxhp microstun dmg to enemies'},
  function(unit)
    if random:bool(osyn_v('Telekinesis')) then
      local borrowX = unit.x
      local borrowY = unit.y
      unit:die();
      --work
    end
  end
  )
  
  def_oversyn('Frenzy', 2, {'Catalyst', 'Incubation'}, 0.1, 'carmine', 
  {'Chaolyst/Forcer cast: ','% aspd and movement to critters/buildings, round reset'},
  function(unit)
    if random:bool(osyn_v('Frenzy')) then
      local borrowX = unit.x
      local borrowY = unit.y
      unit:die();
      --work
    end
  end
  )
  
  def_oversyn('Horror', 2, {'Suppression', 'Delegate'}, 20, 'purplecurs', 
  {'Enemies: ','% chance per second to become feared: silenced and running away'},
  function(unit)
    if random:bool(osyn_v('Horror')) then
      local borrowX = unit.x
      local borrowY = unit.y
      unit:die();
      --work
    end
  end
  )

  --This was to test the oversynergy data structure. Works.
  --for chain_start, chain_possibilities in pairs(oversyn_chains) do
  --  for _, possibility in ipairs(chain_possibilities) do
  --    local possibilitystr = chain_start
  --    for _, chain_member in ipairs(possibility.chain) do
  --      possibilitystr = strc({possibilitystr, ' + ', chain_member})
  --    end
  --    possibilitystr = strc({possibilitystr, ' -> ', possibility.res})
  --    print(possibilitystr)
  --  end
  --end

  tier_to_characters = {
    [1] = {'vagrant', 'swordsman', 'magician', 'archer', 'scout', 'cleric', 'arcanist', 'merchant', 'host', 'bomber'},
    [2] = {'wizard', 'squire', 'dual_gunner', 'sentry', 'stormweaver', 'chronomancer', 'juggernaut', 'cryomancer', 'beastmaster', 'jester', 'carver', 'psychic', 'witch', 'silencer', 'outlaw'},
    [3] = {'elementor', 'psykino', 'spellblade', 'psykeeper', 'engineer', 'pyromancer', 'barbarian', 'assassin', 'bane', 'barrager', 'infestor', 'flagellant', 'artificer', 'usurer', 'gambler', 'miner'},
    [4] = {'priest', 'highlander', 'fairy', 'sage', 'blade', 'plague_doctor', 'cannoneer', 'vulcanist', 'warden', 'corruptor', 'thief', 'warper', 'nexus'},
  }

  non_attacking_characters = {'cleric', 'stormweaver', 'squire', 'chronomancer', 'sage', 'psykeeper', 'bane', 'carver', 'fairy', 'priest', 'flagellant', 'merchant', 'miner'}
  non_cooldown_characters = {'squire', 'chronomancer', 'psykeeper', 'merchant', 'miner'}

  character_tiers = {
    ['vagrant'] = 1,
    ['swordsman'] = 1,
    ['magician'] = 1,
    ['archer'] = 1,
    ['scout'] = 1,
    ['cleric'] = 1,
    ['outlaw'] = 2,
    ['blade'] = 4,
    ['elementor'] = 3,
    -- ['saboteur'] = 2,
    ['bomber'] = 1,
    ['wizard'] = 2,
    ['stormweaver'] = 2,
    ['sage'] = 4,
    ['squire'] = 2,
    ['cannoneer'] = 4,
    ['dual_gunner'] = 2,
    -- ['hunter'] = 2,
    ['sentry'] = 2,
    ['chronomancer'] = 2,
    ['spellblade'] = 3,
    ['psykeeper'] = 3,
    ['engineer'] = 3,
    ['plague_doctor'] = 4,
    ['barbarian'] = 3,
    ['juggernaut'] = 2,
    -- ['lich'] = 4,
    ['cryomancer'] = 3,
    ['pyromancer'] = 3,
    ['corruptor'] = 4,
    ['beastmaster'] = 2,
    -- ['launcher'] = 2,
    ['jester'] = 2,
    ['assassin'] = 3,
    ['host'] = 1,
    ['carver'] = 2,
    ['bane'] = 3,
    ['psykino'] = 3,
    ['barrager'] = 3,
    ['highlander'] = 4,
    ['fairy'] = 4,
    ['priest'] = 4,
    ['infestor'] = 3,
    ['flagellant'] = 3,
    ['arcanist'] = 1,
    -- ['illusionist'] = 3,
    ['artificer'] = 3,
    ['witch'] = 2,
    ['silencer'] = 2,
    ['vulcanist'] = 4,
    ['warden'] = 4,
    ['psychic'] = 2,
    ['miner'] = 3,
    ['merchant'] = 1,
    ['usurer'] = 3,
    ['gambler'] = 3,
    ['thief'] = 4,
    ['warper'] = 4,
    ['nexus'] = 4,
  }

  launches_projectiles = function(character)
    local unit_types = {'vagrant', 'archer', 'scout', 'outlaw', 'blade', 'wizard', 'cannoneer', 'dual_gunner', 'hunter', 'spellblade', 'engineer', 'corruptor', 'beastmaster', 'jester', 'assassin', 'barrager', 
      'arcanist', 'illusionist', 'artificer', 'miner', 'thief', 'sentry'}
    return table.any(unit_types, function(v) return v == character end)
  end

  passive_names = {
    ['centipede'] = 'Centipede',
    ['ouroboros_technique_r'] = 'Ouroboros Technique R',
    ['ouroboros_technique_l'] = 'Ouroboros Technique L',
    ['amplify'] = 'Amplify',
    ['resonance'] = 'Resonance',
    ['ballista'] = 'Ballista',
    ['call_of_the_void'] = 'Call of the Void',
    ['crucio'] = 'Crucio',
    ['speed_3'] = 'Speed 3',
    ['damage_4'] = 'Damage 4',
    ['shoot_5'] = 'Shoot 5',
    ['death_6'] = 'Death 6',
    ['lasting_7'] = 'Lasting 7',
    ['defensive_stance'] = 'Defensive Stance',
    ['offensive_stance'] = 'Offensive Stance',
    ['kinetic_bomb'] = 'Kinetic Bomb',
    ['porcupine_technique'] = 'Porcupine Technique',
    ['last_stand'] = 'Last Stand',
    ['seeping'] = 'Seeping',
    ['deceleration'] = 'Deceleration',
    ['annihilation'] = 'Annihilation',
    ['malediction'] = 'Malediction',
    ['hextouch'] = 'Hextouch',
    ['whispers_of_doom'] = 'Whispers of Doom',
    ['tremor'] = 'Tremor',
    ['heavy_impact'] = 'Heavy Impact',
    ['fracture'] = 'Fracture',
    ['meat_shield'] = 'Meat Shield',
    ['hive'] = 'Hive',
    ['baneling_burst'] = 'Baneling Burst',
    ['blunt_arrow'] = 'Blunt Arrow',
    ['explosive_arrow'] = 'Explosive Arrow',
    ['divine_machine_arrow'] = 'Divine Machine Arrow',
    ['chronomancy'] = 'Chronomancy',
    ['awakening'] = 'Awakening',
    ['divine_punishment'] = 'Divine Punishment',
    ['assassination'] = 'Assassination',
    ['flying_daggers'] = 'Flying Daggers',
    ['ultimatum'] = 'Ultimatum',
    ['magnify'] = 'Magnify',
    ['echo_barrage'] = 'Echo Barrage',
    ['unleash'] = 'Unleash',
    ['reinforce'] = 'Reinforce',
    ['payback'] = 'Payback',
    ['enchanted'] = 'Enchanted',
    ['freezing_field'] = 'Freezing Field',
    ['burning_field'] = 'Burning Field',
    ['gravity_field'] = 'Gravity Field',
    ['magnetism'] = 'Magnetism',
    ['insurance'] = 'Insurance',
    ['dividends'] = 'Dividends',
    ['berserking'] = 'Berserking',
    ['unwavering_stance'] = 'Unwavering Stance',
    ['unrelenting_stance'] = 'Unrelenting Stance',
    ['blessing'] = 'Blessing',
    ['haste'] = 'Haste',
    ['divine_barrage'] = 'Divine Barrage',
    ['orbitism'] = 'Orbitism',
    ['psyker_orbs'] = 'Psyker Orbs',
    ['psychosense'] = 'Psychosense',
    ['psychosink'] = 'Psychosink',
    ['rearm'] = 'Rearm',
    ['taunt'] = 'Taunt',
    ['construct_instability'] = 'Construct Instability',
    ['intimidation'] = 'Intimidation',
    ['vulnerability'] = 'Vulnerability',
    ['temporal_chains'] = 'Temporal Chains',
    ['ceremonial_dagger'] = 'Ceremonial Dagger',
    ['homing_barrage'] = 'Homing Barrage',
    ['critical_strike'] = 'Critical Strike',
    ['noxious_strike'] = 'Noxious Strike',
    ['infesting_strike'] = 'Infesting Strike',
    ['kinetic_strike'] = 'Kinetic Strike',
    ['burning_strike'] = 'Burning Strike',
    ['lucky_strike'] = 'Lucky Strike',
    ['healing_strike'] = 'Healing Strike',
    ['stunning_strike'] = 'Stunning Strike',
    ['silencing_strike'] = 'Silencing Strike',
    ['warping_shots'] = 'Warping Shots',
    ['culling_strike'] = 'Culling Strike',
    ['lightning_strike'] = 'Lightning Strike',
    ['psycholeak'] = 'Psycholeak',
    ['divine_blessing'] = 'Divine Blessing',
    ['hardening'] = 'Hardening',
  }

  passive_descriptions = {
    ['centipede'] = '[yellow]+10/20/30%[fg] movement speed',
    ['ouroboros_technique_r'] = '[fg]rotating around yourself to the right releases [yellow]2/3/4[fg] projectiles per second',
    ['ouroboros_technique_l'] = '[fg]rotating around yourself to the left grants [yellow]+15/25/35%[fg] defense to all units',
    ['amplify'] = '[yellow]+20/35/50%[fg] AoE damage',
    ['resonance'] = '[fg]all AoE attacks deal [yellow]+3/5/7%[fg] damage per unit hit',
    ['ballista'] = '[yellow]+20/35/50%[fg] projectile damage',
    ['call_of_the_void'] = '[yellow]+30/60/90%[fg] DoT damage',
    ['crucio'] = '[fg]taking damage also shares that across all enemies at [yellow]20/30/40%[fg] its value',
    ['speed_3'] = '[fg]position [yellow]3[fg] has [yellow]+50%[fg] attack speed',
    ['damage_4'] = '[fg]position [yellow]4[fg] has [yellow]+30%[fg] damage',
    ['shoot_5'] = '[fg]position [yellow]5[fg] shoots [yellow]3[fg] projectiles per second',
    ['death_6'] = '[fg]position [yellow]6[fg] takes [yellow]10%[fg] of its health as damage every [yellow]3[fg] seconds',
    ['lasting_7'] = '[fg]position [yellow]7[fg] will stay alive for [yellow]10[fg] seconds after dying',
    ['defensive_stance'] = '[fg]first and last positions have [yellow]+10/20/30%[fg] defense',
    ['offensive_stance'] = '[fg]first and last positions have [yellow]+10/20/30%[fg] damage',
    ['kinetic_bomb'] = '[fg]when an ally dies it explodes, launching enemies away',
    ['porcupine_technique'] = '[fg]when an ally dies it explodes, releasing piercing and ricocheting projectiles',
    ['last_stand'] = '[fg]the last unit alive is fully healed and receives a [yellow]+20%[fg] bonus to all stats',
    ['seeping'] = '[fg]enemies taking DoT damage have [yellow]-15/25/35%[fg] defense',
    ['deceleration'] = '[fg]enemies taking DoT damage have [yellow]-15/25/35%[fg] movement speed',
    ['annihilation'] = '[fg]when a voider dies deal its DoT damage to all enemies for [yellow]3[fg] seconds',
    ['malediction'] = '[yellow]+1/3/5[fg] max curse targets to all allied cursers',
    ['hextouch'] = '[fg]enemies take [yellow]10/15/20[fg] damage per second for [yellow]3[fg] seconds when cursed',
    ['whispers_of_doom'] = '[fg]curses apply doom, deal [yellow]100/150/200[fg] damage every [yellow]4/3/2[fg] doom instances',
    ['tremor'] = '[fg]when enemies hit walls they create an area based on the hit momentum',
    ['heavy_impact'] = '[fg]when enemies hit walls they take double damage based on the hit momentum',
    ['fracture'] = '[fg]stunned enemies have halved defence',
    ['meat_shield'] = '[fg]critters [yellow]block[fg] enemy projectiles',
    ['hive'] = '[fg]critters have [yellow]+1/2/3[fg] HP',
    ['baneling_burst'] = '[fg]critters die immediately on contact but also deal [yellow]50/100/150[fg] AoE damage',
    ['blunt_arrow'] = '[fg]ranger arrows have [yellow]+10/20/30%[fg] chance to knockback',
    ['explosive_arrow'] = '[fg]ranger arrows have [yellow]+10/20/30%[fg] chance to deal [yellow]10/20/30%[fg] AoE damage',
    ['divine_machine_arrow'] = '[fg]ranger arrows have a [yellow]10/20/30%[fg] chance to seek and pierce [yellow]1/2/3[fg] times',
    ['chronomancy'] = '[fg]mages cast their spells [yellow]15/25/35%[fg] faster',
    ['awakening'] = '[yellow]+50/75/100%[fg] attack speed and damage to [yellow]1[fg] mage every round for that round',
    ['divine_punishment'] = '[fg]deal damage to all enemies based on how many mages you have',
    ['assassination'] = '[fg]crits from rogues deal [yellow]8/10/12x[fg] damage but normal attacks deal [yellow]half[fg] damage',
    ['flying_daggers'] = '[fg]all projectiles thrown by rogues chain [yellow]+2/3/4[fg] times',
    ['ultimatum'] = '[fg]projectiles that chain gain [yellow]+10/20/30%[fg] damage with each chain',
    ['magnify'] = '[yellow]+20/35/50%[fg] area size',
    ['echo_barrage'] = '[yellow]10/20/30%[fg] chance to create [yellow]1/2/3[fg] secondary AoEs on AoE hit',
    ['unleash'] = '[fg]all nukers gain [yellow]+1%[fg] area size and damage every second',
    ['reinforce'] = '[yellow]+10/20/30%[fg] global damage, defense and aspd if you have one or more enchanters',
    ['payback'] = '[yellow]+2/5/8%[fg] damage to all allies whenever an enchanter is hit',
    ['enchanted'] = '[yellow]+33/66/99%[fg] attack speed to a random unit if you have two or more enchanters',
    ['freezing_field'] = '[fg]creates an area that slows enemies by [yellow]50%[fg] for [yellow]2[fg] seconds on sorcerer spell repeat',
    ['burning_field'] = '[fg]creates an area that deals [yellow]30[fg] dps for [yellow]2[fg] seconds on sorcerer spell repeat',
    ['gravity_field'] = '[fg]creates an area that pulls enemies in for [yellow]1[fg] seconds on sorcerer spell repeat',
    ['magnetism'] = '[fg]gold coins and healing orbs are attracted to the snake from a longer range',
    ['insurance'] = "[fg]heroes have [yellow]4[fg] times the chance of mercenary's bonus to drop [yellow]2[fg] gold on death",
    ['dividends'] = '[fg]mercenaries deal [yellow]+X%/20[fg], up to 1.5x dmg, where X is how much gold (max 1K) you have',
    ['berserking'] = '[fg]all warriors have up to [yellow]+50/75/100%[fg] attack speed based on missing HP',
    ['unwavering_stance'] = '[fg]all warriors gain [yellow]+4/8/12%[fg] defense every [yellow]5[fg] seconds',
    ['unrelenting_stance'] = '[yellow]+2/5/8%[fg] defense to all allies whenever a warrior is hit',
    ['blessing'] = '[yellow]+10/20/30%[fg] healing effectiveness',
    ['haste'] = '[yellow]+50%[fg] movement speed that decays over [yellow]4[fg] seconds on healing orb pick up',
    ['divine_barrage'] = '[yellow]20/40/60%[fg] chance to release a ricocheting barrage on healing orb pick up',
    ['orbitism'] = '[yellow]+25/50/75%[fg] psyker orb movement speed',
    ['psyker_orbs'] = '[yellow]+1/2/4[fg] total psyker orbs',
    ['psychosense'] = '[yellow]+33/66/99%[fg] orb range',
    ['psychosink'] = '[fg]psyker orbs deal [yellow]+40/80/120%[fg] damage',
    ['rearm'] = '[fg]constructs repeat their attacks once',
    ['taunt'] = '[yellow]10/20/30%[fg] chance for constructs to taunt nearby enemies on attack',
    ['construct_instability'] = '[fg]constructs explode when disappearing, dealing [yellow]100/150/200%[fg] damage',
    ['intimidation'] = '[fg]enemies spawn with [yellow]-10/20/30%[fg] max HP',
    ['vulnerability'] = '[fg]enemies take [yellow]+10/20/30%[fg] damage',
    ['temporal_chains'] = '[fg]enemies are [yellow]10/20/30%[fg] slower',
    ['ceremonial_dagger'] = '[fg]killing an enemy fires a homing dagger',
    ['homing_barrage'] = '[yellow]8/16/24%[fg] chance to release a homing barrage on enemy kill',
    ['critical_strike'] = '[yellow]5/10/15%[fg] chance for attacks to critically strike, dealing [yellow]2x[fg] damage',
    ['noxious_strike'] = '[yellow]8/16/24%[fg] chance for attacks to poison, dealing [yellow]20%[fg] dps for [yellow]3[fg] seconds',
    ['infesting_strike'] = '[yellow]10/20/30%[fg] chance for attacks to spawn [yellow]2[fg] critters on kill',
    ['kinetic_strike'] = '[yellow]10/20/30%[fg] chance for attacks to push enemies away with high force',
    ['burning_strike'] = '[yellow]15%[fg] chance for attacks to burn, dealing [yellow]20%[fg] dps for [yellow]3[fg] seconds',
    ['lucky_strike'] = '[yellow]8%[fg] chance for attacks to cause enemies to drop gold on death',
    ['healing_strike'] = '[yellow]8%[fg] chance for attacks to spawn a healing orb on kill',
    ['stunning_strike'] = '[yellow]8/16/24%[fg] chance for attacks to stun for [yellow]2[fg] seconds',
    ['silencing_strike'] = '[yellow]8/16/24%[fg] chance for attacks to silence for [yellow]2[fg] seconds on hit',
    ['warping_shots'] = 'projectiles ignore wall collisions and warp around the screen [yellow]1/2/3[fg] times',
    ['culling_strike'] = '[fg]instantly kill elites below [yellow]10/20/30%[fg] max HP',
    ['lightning_strike'] = '[yellow]5/10/15%[fg] chance for projectiles to create chain lightning, dealing [yellow]60/80/100%[fg] damage',
    ['psycholeak'] = '[fg]position [yellow]1[fg] generates [yellow]1[fg] psyker orb every [yellow]10[fg] seconds',
    ['divine_blessing'] = '[fg]generate [yellow]1[fg] healing orb every [yellow]8[fg] seconds',
    ['hardening'] = '[yellow]+150%[fg] defense to all allies for [yellow]3[fg] seconds after an ally dies',
  }

  local ts = function(lvl, a, b, c) return '[' .. ylbn(lvl, 1) .. ']' .. tostring(a) .. '[light_bg]/[' .. ylbn(lvl, 2) .. ']' .. tostring(b) .. '[light_bg]/[' .. ylbn(lvl, 3) .. ']' .. tostring(c) .. '[fg]' end
  passive_descriptions_level = {
    ['centipede'] = function(lvl) return ts(lvl, '+10%', '20%', '30%') .. ' movement speed' end,
    ['ouroboros_technique_r'] = function(lvl) return '[fg]rotating around yourself to the right releases ' .. ts(lvl, '2', '3', '4') .. ' projectiles per second' end,
    ['ouroboros_technique_l'] = function(lvl) return '[fg]rotating around yourself to the left grants ' .. ts(lvl, '+15%', '25%', '35%') .. ' defense to all units' end,
    ['amplify'] = function(lvl) return ts(lvl, '+20%', '35%', '50%') .. ' AoE damage' end,
    ['resonance'] = function(lvl) return '[fg]all AoE attacks deal ' .. ts(lvl, '+3%', '5%', '7%') .. ' damage per unit hit' end,
    ['ballista'] = function(lvl) return ts(lvl, '+20%', '35%', '50%') .. ' projectile damage' end,
    ['call_of_the_void'] = function(lvl) return ts(lvl, '+30%', '60%', '90%') .. ' DoT damage' end,
    ['crucio'] = function(lvl) return '[fg]taking damage also shares that across all enemies at ' .. ts(lvl, '20%', '30%', '40%') .. ' its value' end,
    ['speed_3'] = function(lvl) return '[fg]position [yellow]3[fg] has [yellow]+50%[fg] attack speed' end,
    ['damage_4'] = function(lvl) return '[fg]position [yellow]4[fg] has [yellow]+30%[fg] damage' end,
    ['shoot_5'] = function(lvl) return '[fg]position [yellow]5[fg] shoots [yellow]3[fg] projectiles per second' end,
    ['death_6'] = function(lvl) return '[fg]position [yellow]6[fg] takes [yellow]10%[fg] of its health as damage every [yellow]3[fg] seconds' end,
    ['lasting_7'] = function(lvl) return '[fg]position [yellow]7[fg] will stay alive for [yellow]10[fg] seconds after dying' end,
    ['defensive_stance'] = function(lvl) return '[fg]first and last positions have ' .. ts(lvl, '+10%', '20%', '30%') .. ' defense' end,
    ['offensive_stance'] = function(lvl) return '[fg]first and last positions have ' .. ts(lvl, '+10%', '20%', '30%') .. ' damage' end,
    ['kinetic_bomb'] = function(lvl) return '[fg]when an ally dies it explodes, launching enemies away' end,
    ['porcupine_technique'] = function(lvl) return '[fg]when an ally dies it explodes, releasing piercing projectiles' end,
    ['last_stand'] = function(lvl) return '[fg]the last unit alive is fully healed and receives a [yellow]+20%[fg] bonus to all stats' end,
    ['seeping'] = function(lvl) return '[fg]enemies taking DoT damage have ' .. ts(lvl, '-15%', '25%', '35%') .. ' defense' end,
    ['deceleration'] = function(lvl) return '[fg]enemies taking DoT damage have ' .. ts(lvl, '-15%', '25%', '35%') .. ' movement speed' end,
    ['annihilation'] = function(lvl) return '[fg]when a voider dies deal its DoT damage to all enemies for [yellow]3[fg] seconds' end,
    ['malediction'] = function(lvl) return ts(lvl, '+1', '3', '5') .. ' max curse targets to all allied cursers' end,
    ['hextouch'] = function(lvl) return '[fg]enemies take ' .. ts(lvl, '10', '15', '20') .. 'damage per second for [yellow]3[fg] seconds when cursed' end,
    ['whispers_of_doom'] = function(lvl) return '[fg]curses apply doom, deal ' .. ts(lvl, '100', '150', '200') .. ' every ' .. ts(lvl, '4', '3', '2') .. ' doom instances' end,
    ['tremor'] = function(lvl) return '[fg]when enemies hit walls they create an area based to the knockback force' end,
    ['heavy_impact'] = function(lvl) return '[fg]when enemies hit walls they take damage based on the knockback force' end,
    ['fracture'] = function(lvl) return '[fg]stunned enemies have halved defence' end,
    ['meat_shield'] = function(lvl) return '[fg]critters [yellow]block[fg] enemy projectiles' end,
    ['hive'] = function(lvl) return '[fg]critters have ' .. ts(lvl, '+1', '2', '3') .. ' HP' end,
    ['baneling_burst'] = function(lvl) return '[fg]critters die immediately on contact but also deal ' .. ts(lvl, '50', '100', '150') .. ' AoE damage' end,
    ['blunt_arrow'] = function(lvl) return '[fg]ranger arrows have ' .. ts(lvl, '+10%', '20%', '30%') .. ' chance to knockback' end,
    ['explosive_arrow'] = function(lvl) return '[fg]ranger arrows have ' .. ts(lvl, '+10%', '20%', '30%') .. ' chance to deal ' .. ts(lvl, '10%', '20%', '30%') .. ' AoE damage' end,
    ['divine_machine_arrow'] = function(lvl) return '[fg]ranger arrows have a ' .. ts(lvl, '10%', '20%', '30%') .. ' chance to seek and pierce ' .. ts(lvl, '1', '2', '3') .. ' times' end,
    ['chronomancy'] = function(lvl) return '[fg]mages cast their spells ' .. ts(lvl, '15%', '25%', '35%') .. ' faster' end,
    ['awakening'] = function(lvl) return ts(lvl, '+50%', '75%', '100%') .. ' attack speed and damage to [yellow]1[fg] mage every round for that round' end,
    ['divine_punishment'] = function(lvl) return '[fg]deal damage to all enemies based on how many mages you have' end,
    ['assassination'] = function(lvl) return '[fg]crits from rogues deal ' .. ts(lvl, '8x', '10x', '12x') .. ' damage but normal attacks deal [yellow]half[fg] damage' end,
    ['flying_daggers'] = function(lvl) return '[fg]all projectiles thrown by rogues chain ' .. ts(lvl, '+2', '3', '4') .. ' times' end,
    ['ultimatum'] = function(lvl) return '[fg]projectiles that chain gain ' .. ts(lvl, '+10%', '20%', '30%') .. ' damage with each chain' end,
    ['magnify'] = function(lvl) return ts(lvl, '+20%', '35%', '50%') .. ' area size' end,
    ['echo_barrage'] = function(lvl) return ts(lvl, '10%', '20%', '30%') .. ' chance to create ' .. ts(lvl, '1', '2', '3') .. ' secondary AoEs on AoE hit' end,
    ['unleash'] = function(lvl) return '[fg]all nukers gain [yellow]+1%[fg] area size and damage every second' end,
    ['reinforce'] = function(lvl) return ts(lvl, '+10%', '20%', '30%') .. ' global damage, defense and aspd if you have one or more enchanters' end,
    ['payback'] = function(lvl) return ts(lvl, '+2%', '5%', '8%') .. ' damage to all allies whenever an enchanter is hit' end,
    ['enchanted'] = function(lvl) return ts(lvl, '+33%', '66%', '99%') .. ' attack speed to a random unit if you have two or more enchanters' end,
    ['freezing_field'] = function(lvl) return '[fg]creates an area that slows enemies by [yellow]50%[fg] for [yellow]2[fg] seconds on sorcerer spell repeat' end,
    ['burning_field'] = function(lvl) return '[fg]creates an area that deals [yellow]30[fg] dps for [yellow]2[fg] seconds on sorcerer spell repeat' end,
    ['gravity_field'] = function(lvl) return '[fg]creates an area that pulls enemies in for [yellow]1[fg] seconds on sorcerer spell repeat' end,
    ['magnetism'] = function(lvl) return '[fg]gold coins and healing orbs are attracted to the snake from a longer range' end,
    ['insurance'] = function(lvl) return "[fg]heroes have [yellow]4[fg] times the chance of mercenary's bonus to drop [yellow]2[fg] gold on death" end,
    ['dividends'] = function(lvl) return '[fg]mercenaries deal [yellow]+X%[fg] damage, where X is how much gold you have' end,
    ['berserking'] = function(lvl) return '[fg]all warriors have up to ' .. ts(lvl, '+50%', '75%', '100%') .. ' attack speed based on missing HP' end,
    ['unwavering_stance'] = function(lvl) return '[fg]all warriors gain ' .. ts(lvl, '+4%', '8%', '12%') .. ' defense every [yellow]5[fg] seconds' end,
    ['unrelenting_stance'] = function(lvl) return ts(lvl, '+2%', '5%', '8%') .. ' defense to all allies whenever a warrior is hit' end,
    ['blessing'] = function(lvl) return ts(lvl, '+10%', '20%', '30%') .. ' healing effectiveness' end,
    ['haste'] = function(lvl) return '[yellow]+50%[fg] movement speed that decays over [yellow]4[fg] seconds on healing orb pick up' end,
    ['divine_barrage'] = function(lvl) return ts(lvl, '20%', '40%', '60%') .. ' chance to release a ricocheting barrage on healing orb pick up' end,
    ['orbitism'] = function(lvl) return ts(lvl, '+25%', '50%', '75%') .. ' psyker orb movement speed' end,
    ['psyker_orbs'] = function(lvl) return ts(lvl, '+1', '2', '4') .. ' psyker orbs' end,
    ['psychosense'] = function(lvl) return ts(lvl, '+33%', '66%', '99%') .. ' orb range' end,
    ['psychosink'] = function(lvl) return '[fg]psyker orbs deal ' .. ts(lvl, '+40%', '80%', '120%') .. ' damage' end,
    ['rearm'] = function(lvl) return '[fg]constructs repeat their attacks once' end,
    ['taunt'] = function(lvl) return ts(lvl, '10%', '20%', '30%') .. ' chance for constructs to taunt nearby enemies on attack' end,
    ['construct_instability'] = function(lvl) return '[fg]constructs explode when disappearing, dealing ' .. ts(lvl, '100', '150', '200%') .. ' damage' end,
    ['intimidation'] = function(lvl) return '[fg]enemies spawn with ' .. ts(lvl, '-10', '20', '30%') .. ' max HP' end,
    ['vulnerability'] = function(lvl) return '[fg]enemies take ' .. ts(lvl, '+10', '20', '30%').. ' damage' end,
    ['temporal_chains'] = function(lvl) return '[fg]enemies are ' .. ts(lvl, '10', '20', '30%').. ' slower' end,
    ['ceremonial_dagger'] = function(lvl) return '[fg]killing an enemy fires a homing dagger' end,
    ['homing_barrage'] = function(lvl) return ts(lvl, '8', '16', '24%') .. ' chance to release a homing barrage on enemy kill' end,
    ['critical_strike'] = function(lvl) return ts(lvl, '5', '10', '15%') .. ' chance for attacks to critically strike, dealing [yellow]2x[fg] damage' end,
    ['noxious_strike'] = function(lvl) return ts(lvl, '8', '16', '24%') .. ' chance for attacks to poison, dealing [yellow]20%[fg] dps for [yellow]3[fg] seconds' end,
    ['infesting_strike'] = function(lvl) return ts(lvl, '10', '20', '30%') .. ' chance for attacks to spawn [yellow]2[fg] critters on kill' end,
    ['kinetic_strike'] = function(lvl) return ts(lvl, '10', '20', '30%') .. ' chance for attacks to push enemies away with high force' end,
    ['burning_strike'] = function(lvl) return '[yellow]15%[fg] chance for attacks to burn, dealing [yellow]20%[fg] dps for [yellow]3[fg] seconds' end,
    ['lucky_strike'] = function(lvl) return '[yellow]8%[fg] chance for attacks to cause enemies to drop gold on death' end,
    ['healing_strike'] = function(lvl) return '[yellow]8%[fg] chance for attacks to spawn a healing orb on kill' end,
    ['stunning_strike'] = function(lvl) return ts(lvl, '8', '16', '24%') .. ' chance for attacks to stun for [yellow]2[fg] seconds' end,
    ['silencing_strike'] = function(lvl) return ts(lvl, '8', '16', '24%') .. ' chance for attacks to silence for [yellow]2[fg] seconds on hit' end,
    ['warping_shots'] = function(lvl) return 'projectiles ignore wall collisions and warp around the screen ' .. ts(lvl, '1', '2', '3') .. ' times' end,
    ['culling_strike'] = function(lvl) return '[fg]instantly kill elites below ' .. ts(lvl, '10', '20', '30%') .. ' max HP' end,
    ['lightning_strike'] = function(lvl) return ts(lvl, '5', '10', '15%') .. ' chance for projectiles to create chain lightning, dealing ' .. ts(lvl, '60', '80', '100%') .. ' damage' end,
    ['psycholeak'] = function(lvl) return '[fg]position [yellow]1[fg] generates [yellow]1[fg] psyker orb every [yellow]10[fg] seconds' end,
    ['divine_blessing'] = function(lvl) return '[fg]generate [yellow]1[fg] healing orb every [yellow]8[fg] seconds' end,
    ['hardening'] = function(lvl) return '[yellow]+150%[fg] defense to all allies for [yellow]3[fg] seconds after an ally dies' end,
  }

  level_to_tier_weights = {
    [1] = {90, 10, 0, 0},
    [2] = {80, 15, 5, 0},
    [3] = {75, 20, 5, 0},
    [4] = {70, 20, 10, 0},
    [5] = {70, 20, 10, 0},
    [6] = {65, 25, 10, 0},
    [7] = {60, 25, 15, 0},
    [8] = {55, 25, 15, 5},
    [9] = {50, 30, 15, 5},
    [10] = {50, 30, 15, 5},
    [11] = {45, 30, 20, 5},
    [12] = {40, 30, 20, 10},
    [13] = {35, 30, 25, 10},
    [14] = {30, 30, 25, 15},
    [15] = {25, 30, 30, 15},
    [16] = {25, 25, 30, 20},
    [17] = {20, 25, 35, 20},
    [18] = {15, 25, 35, 25},
    [19] = {10, 25, 40, 25},
    [20] = {5, 25, 40, 30},
    [21] = {0, 25, 40, 35},
    [22] = {0, 20, 40, 40},
    [23] = {0, 20, 35, 45},
    [24] = {0, 10, 30, 60},
    [25] = {0, 0, 0, 100},
  }

  level_to_gold_gained = {
    [1] = {3, 3},
    [2] = {3, 3},
    [3] = {5, 6},
    [4] = {4, 5},
    [5] = {5, 8},
    [6] = {8, 10},
    [7] = {8, 10}, 
    [8] = {12, 14},
    [9] = {14, 18},
    [10] = {10, 13},
    [11] = {12, 15},
    [12] = {18, 20},
    [13] = {10, 14},
    [14] = {12, 16},
    [15] = {14, 18},
    [16] = {12, 12},
    [17] = {12, 12},
    [18] = {20, 24}, 
    [19] = {8, 12},
    [20] = {10, 14}, 
    [21] = {20, 28},
    [22] = {32, 32},
    [23] = {36, 36},
    [24] = {48, 48},
    [25] = {100, 100},
  }

  local k = 1
  for i = 26, 5000 do
    local n = i % 25
    if n == 0 then
      n = 25
      k = k + 1
    end
    level_to_gold_gained[i] = {level_to_gold_gained[n][1]*k, level_to_gold_gained[n][2]*k}
  end

  level_to_elite_spawn_weights = {
    [1] = {0},
    [2] = {4, 2},
    [3] = {10},
    [4] = {4, 4},
    [5] = {4, 3, 2},
    [6] = {12},
    [7] = {5, 3, 2},
    [8] = {6, 3, 3, 3},
    [9] = {14},
    [10] = {8, 4},
    [11] = {8, 6, 2},
    [12] = {16},
    [13] = {8, 8},
    [14] = {12, 6},
    [15] = {18},
    [16] = {10, 6, 4},
    [17] = {6, 5, 4, 3},
    [18] = {18},
    [19] = {10, 6},
    [20] = {8, 6, 2},
    [21] = {22},
    [22] = {10, 8, 4},
    [23] = {20, 5, 5},
    [24] = {30},
    [25] = {5, 5, 5, 5, 5, 5},
  }

  local k = 1
  local l = 0.2
  for i = 26, 5000 do
    local n = i % 25
    if n == 0 then
      n = 25
      k = k + 1
      l = l*2
    end
    local a, b, c, d, e, f = unpack(level_to_elite_spawn_weights[n])
    a = (a or 0) + (a or 0)*l
    b = (b or 0) + (b or 0)*l
    c = (c or 0) + (c or 0)*l
    d = (d or 0) + (d or 0)*l
    e = (e or 0) + (e or 0)*l
    f = (f or 0) + (f or 0)*l
    level_to_elite_spawn_weights[i] = {a, b, c, d, e, f}
  end

  level_to_boss = {
    [6] = 'speed_booster',
    [12] = 'exploder',
    [18] = 'swarmer',
    [24] = 'forcer',
    [25] = 'randomizer',
  }

  local bosses = {'speed_booster', 'exploder', 'swarmer', 'forcer', 'randomizer'}
  level_to_boss[31] = 'speed_booster'
  level_to_boss[37] = 'exploder'
  level_to_boss[43] = 'swarmer'
  level_to_boss[49] = 'forcer'
  level_to_boss[50] = 'randomizer'
  local i = 31
  local k = 1
  while i < 5000 do
    level_to_boss[i] = bosses[k]
    k = k + 1
    if k == 5 then i = i + 1 else i = i + 6 end
    if k == 6 then k = 1 end
  end

  level_to_elite_spawn_types = {
    [1] = {'speed_booster'},
    [2] = {'speed_booster', 'shooter'},
    [3] = {'speed_booster'},
    [4] = {'speed_booster', 'exploder'},
    [5] = {'speed_booster', 'exploder', 'shooter'},
    [6] = {'speed_booster'},
    [7] = {'speed_booster', 'exploder', 'headbutter'},
    [8] = {'speed_booster', 'exploder', 'headbutter', 'shooter'},
    [9] = {'shooter'},
    [10] = {'exploder', 'headbutter'},
    [11] = {'exploder', 'headbutter', 'tank'},
    [12] = {'exploder'},
    [13] = {'speed_booster', 'shooter'},
    [14] = {'speed_booster', 'spawner'},
    [15] = {'shooter'},
    [16] = {'speed_booster', 'exploder', 'spawner'},
    [17] = {'speed_booster', 'exploder', 'spawner', 'shooter'},
    [18] = {'spawner'},
    [19] = {'headbutter', 'tank'},
    [20] = {'speed_booster', 'tank', 'spawner'},
    [21] = {'headbutter'},
    [22] = {'speed_booster', 'headbutter', 'tank'},
    [23] = {'headbutter', 'tank', 'shooter'},
    [24] = {'tank'},
    [25] = {'speed_booster', 'exploder', 'headbutter', 'tank', 'shooter', 'spawner'},
  }

  for i = 26, 5000 do
    local n = i % 25
    if n == 0 then
      n = 25
    end
    level_to_elite_spawn_types[i] = level_to_elite_spawn_types[n]
  end

  level_to_shop_odds = {
    [1] = {70, 20, 10, 0},
    [2] = {50, 30, 15, 5},
    [3] = {25, 45, 20, 10},
    [4] = {10, 25, 45, 20},
    [5] = {5, 15, 30, 50},
  }

  get_shop_odds = function(lvl, tier)
    if lvl == 1 then
      if tier == 1 then
        return 70
      elseif tier == 2 then
        return 20
      elseif tier == 3 then
        return 10
      elseif tier == 4 then
        return 0
      end
    elseif lvl == 2 then
      if tier == 1 then
        return 50
      elseif tier == 2 then
        return 30
      elseif tier == 3 then
        return 15
      elseif tier == 4 then
        return 5
      end
    elseif lvl == 3 then
      if tier == 1 then
        return 25
      elseif tier == 2 then
        return 45
      elseif tier == 3 then
        return 20
      elseif tier == 4 then
        return 10
      end
    elseif lvl == 4 then
      if tier == 1 then
        return 10
      elseif tier == 2 then
        return 25
      elseif tier == 3 then
        return 45
      elseif tier == 4 then
        return 20
      end
    elseif lvl == 5 then
      if tier == 1 then
        return 5
      elseif tier == 2 then
        return 15
      elseif tier == 3 then
        return 30
      elseif tier == 4 then
        return 50
      end
    end
  end

  unlevellable_items = {
    'speed_3', 'damage_4', 'shoot_5', 'death_6', 'lasting_7', 'kinetic_bomb', 'porcupine_technique', 'last_stand', 'annihilation', 
    'tremor', 'heavy_impact', 'fracture', 'meat_shield', 'divine_punishment', 'unleash', 'freezing_field', 'burning_field', 'gravity_field',
    'magnetism', 'insurance', 'dividends', 'haste', 'rearm', 'ceremonial_dagger', 'burning_strike', 'lucky_strike', 'healing_strike', 'psycholeak', 'divine_blessing', 'hardening',
  }

  steam.userStats.requestCurrentStats()
  new_game_plus = state.new_game_plus or 0
  if not state.new_game_plus then state.new_game_plus = new_game_plus end
  current_new_game_plus = state.current_new_game_plus or new_game_plus
  if not state.current_new_game_plus then state.current_new_game_plus = current_new_game_plus end
  max_units = math.clamp(7 + current_new_game_plus, 7, 12)

  main_song_instance = _G[random:table{'song1', 'song2', 'song3', 'song4', 'song5'}]:play{volume = 0.5}
  main = Main()

  main:add(MainMenu'mainmenu')
  main:go_to('mainmenu')

  --[[
  main:add(BuyScreen'buy_screen')
  main:go_to('buy_screen', run.level or 1, run.units or {}, passives, run.shop_level or 1, run.shop_xp or 0)
  -- main:go_to('buy_screen', 7, run.units or {}, {'unleash'})
  ]]--
  
  --[[
  gold = 10
  run_passive_pool = {
    'centipede', 'ouroboros_technique_r', 'ouroboros_technique_l', 'amplify', 'resonance', 'ballista', 'call_of_the_void', 'crucio', 'speed_3', 'damage_4', 'shoot_5', 'death_6', 'lasting_7',
    'defensive_stance', 'offensive_stance', 'kinetic_bomb', 'porcupine_technique', 'last_stand', 'seeping', 'deceleration', 'annihilation', 'malediction', 'hextouch', 'whispers_of_doom',
    'tremor', 'heavy_impact', 'fracture', 'meat_shield', 'hive', 'baneling_burst', 'blunt_arrow', 'explosive_arrow', 'divine_machine_arrow', 'chronomancy', 'awakening', 'divine_punishment',
    'assassination', 'flying_daggers', 'ultimatum', 'magnify', 'echo_barrage', 'unleash', 'reinforce', 'payback', 'enchanted', 'freezing_field', 'burning_field', 'gravity_field', 'magnetism',
    'insurance', 'dividends', 'berserking', 'unwavering_stance', 'unrelenting_stance', 'blessing', 'haste', 'divine_barrage', 'orbitism', 'psyker_orbs', 'psychosink', 'rearm', 'taunt', 'construct_instability',
    'intimidation', 'vulnerability', 'temporal_chains', 'ceremonial_dagger', 'homing_barrage', 'critical_strike', 'noxious_strike', 'infesting_strike', 'burning_strike', 'lucky_strike', 'healing_strike', 'stunning_strike',
    'silencing_strike', 'culling_strike', 'lightning_strike', 'psycholeak', 'divine_blessing', 'hardening', 'kinetic_strike',
  }
  main:add(Arena'arena')
  main:go_to('arena', 21, 0, {
    {character = 'magician', level = 3},
  }, {
    {passive = 'awakening', level = 3},
  })
  ]]--

  --[[
  main:add(Media'media')
  main:go_to('media')
  ]]--

  trigger:every(2, function()
    if debugging_memory then
      for k, v in pairs(system.type_count()) do
        print(k, v)
      end
      print("-- " .. math.round(tonumber(collectgarbage("count"))/1024, 3) .. "MB --")
      print()
    end
  end)

  --[[
  print(table.tostring(love.graphics.getSupported()))
  print(love.graphics.getRendererInfo())
  local formats = love.graphics.getImageFormats()
  for f, s in pairs(formats) do print(f, tostring(s)) end
  local canvasformats = love.graphics.getCanvasFormats()
  for f, s in pairs(canvasformats) do print(f, tostring(s)) end
  print(table.tostring(love.graphics.getSystemLimits()))
  print(table.tostring(love.graphics.getStats()))
  ]]--
end


function update(dt)
  main:update(dt)

  --[[
  if input.b.pressed then
    -- debugging_memory = not debugging_memory
    for k, v in pairs(system.type_count()) do
      print(k, v)
    end
    print("-- " .. math.round(tonumber(collectgarbage("count"))/1024, 3) .. "MB --")
    print()
  end
  ]]--

  --[[
  if input.n.pressed then
    if main.current.sfx_button then
      main.current.sfx_button:action()
      main.current.sfx_button.selected = false
    else
      if sfx.volume == 0.5 then
        sfx.volume = 0
        state.volume_muted = true
      elseif sfx.volume == 0 then
        sfx.volume = 0.5
        state.volume_muted = false
      end
    end
  end

  if input.m.pressed then
    if main.current.music_button then
      main.current.music_button:action()
      main.current.music_button.selected = false
    else
      if music.volume == 0.5 then
        state.music_muted = true
        music.volume = 0
      elseif music.volume == 0 then
        music.volume = 0.5
        state.music_muted = false
      end
    end
  end
  ]]--

  if input.k.pressed then
    if sx > 1 and sy > 1 then
      sx, sy = sx - 0.5, sy - 0.5
      love.window.setMode(480*sx, 270*sy)
      state.sx, state.sy = sx, sy
      state.fullscreen = false
    end
  end

  if input.l.pressed then
    sx, sy = sx + 0.5, sy + 0.5
    love.window.setMode(480*sx, 270*sy)
    state.sx, state.sy = sx, sy
    state.fullscreen = false
  end

  --[[
  if input.f11.pressed then
    steam.userStats.resetAllStats(true)
    steam.userStats.storeStats()
  end
  ]]--
end


function draw()
  shared_draw(function()
    main:draw()
  end)
end

saveLoad_tars = {}
curr_run_save_tar = "run_v4"
run_tars = {
  "run_v4",
  "run_v4_2",
  "run_v4_3"
}

function setSaveOpts()
  saveLoad_tars = {}
  local against_n = state.save_num
  local i = 1
  while i <= 3 do
    if i ~= against_n then
      table.insert(saveLoad_tars, i)
    end
    i = i + 1
  end
  curr_run_save_tar = run_tars[against_n]
end


function open_options(self)
  input:set_mouse_visible(true)
  trigger:tween(0.25, _G, {slow_amount = 0}, math.linear, function()
    slow_amount = 0
    self.paused = true

    if self:is(Arena) then
      self.paused_t1 = Text2{group = self.ui, x = gw/2, y = gh/2 - 108, sx = 0.6, sy = 0.6, lines = {{text = '[bg10]<-, a or m1       ->, d or m2', font = fat_font, alignment = 'center'}}}
      self.paused_t2 = Text2{group = self.ui, x = gw/2, y = gh/2 - 92, lines = {{text = '[bg10]turn left                                            turn right', font = pixul_font, alignment = 'center'}}}
    end

    if self:is(MainMenu) then
      self.run_t = Text2{group = self.ui, x = gw/2 - 176, y = gh - 200, lines = {{text = '[bg10]Run: ' .. state.save_num, font = pixul_font, alignment = 'center'}}}
      self.ng_t = Text2{group = self.ui, x = gw/2 + 63, y = gh - 50, lines = {{text = '[bg10]current: ' .. current_new_game_plus, font = pixul_font, alignment = 'center'}}}
    end

    self.resume_button = Button{group = self.ui, x = gw/2, y = gh - 225, force_update = true, button_text = self:is(MainMenu) and 'main menu (esc)' or 'resume game (esc)', fg_color = 'bg10', bg_color = 'bg', action = function(b)
      trigger:tween(0.25, _G, {slow_amount = 1}, math.linear, function()
        slow_amount = 1
        self.paused = false
        if self.paused_t1 then self.paused_t1.dead = true; self.paused_t1 = nil end
        if self.paused_t2 then self.paused_t2.dead = true; self.paused_t2 = nil end
        if self.ng_t then self.ng_t.dead = true; self.ng_t = nil end
        if self.run_t then self.run_t.dead = true; self.run_t = nil end
        if self.resume_button then self.resume_button.dead = true; self.resume_button = nil end
        if self.restart_button then self.restart_button.dead = true; self.restart_button = nil end
        if self.mouse_button then self.mouse_button.dead = true; self.mouse_button = nil end
        if self.dark_transition_button then self.dark_transition_button.dead = true; self.dark_transition_button = nil end
        if self.run_timer_button then self.run_timer_button.dead = true; self.run_timer_button = nil end
        if self.sfx_button then self.sfx_button.dead = true; self.sfx_button = nil end
        if self.music_button then self.music_button.dead = true; self.music_button = nil end
        if self.video_button_1 then self.video_button_1.dead = true; self.video_button_1 = nil end
        if self.video_button_2 then self.video_button_2.dead = true; self.video_button_2 = nil end
        if self.video_button_3 then self.video_button_3.dead = true; self.video_button_3 = nil end
        if self.video_button_4 then self.video_button_4.dead = true; self.video_button_4 = nil end
        if self.quit_button then self.quit_button.dead = true; self.quit_button = nil end
        if self.screen_shake_button then self.screen_shake_button.dead = true; self.screen_shake_button = nil end
        if self.screen_movement_button then self.screen_movement_button.dead = true; self.screen_movement_button = nil end
        if self.cooldown_snake_button then self.cooldown_snake_button.dead = true; self.cooldown_snake_button = nil end
        if self.arrow_snake_button then self.arrow_snake_button.dead = true; self.arrow_snake_button = nil end
        if self.ng_plus_plus_button then self.ng_plus_plus_button.dead = true; self.ng_plus_plus_button = nil end
        if self.ng_plus_minus_button then self.ng_plus_minus_button.dead = true; self.ng_plus_minus_button = nil end
        if self.hide_aoes_button then self.hide_aoes_button.dead = true; self.hide_aoes_button = nil end
        if self.save_button_1 then self.save_button_1.dead = true; self.save_button_1 = nil end
        if self.save_button_2 then self.save_button_2.dead = true; self.save_button_2 = nil end
        if self.load_button_1 then self.load_button_1.dead = true; self.load_button_1 = nil end
        if self.load_button_2 then self.load_button_2.dead = true; self.load_button_2 = nil end
        if self.main_menu_button then self.main_menu_button.dead = true; self.main_menu_button = nil end
        system.save_state()
        if self:is(MainMenu) or self:is(BuyScreen) then input:set_mouse_visible(true)
        elseif self:is(Arena) then input:set_mouse_visible(state.mouse_control or false) end
      end, 'pause')
    end}

    if not self:is(MainMenu) then
      self.restart_button = Button{group = self.ui, x = gw/2, y = gh - 200, force_update = true, button_text = 'restart run (r)', fg_color = 'bg10', bg_color = 'bg', action = function(b)
        self.transitioning = true
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
          max_units = math.clamp(7 + current_new_game_plus, 7, 12)
          main:add(BuyScreen'buy_screen')
          locked_state = nil
          reset_syn_pow()
          system.save_run()
          main:go_to('buy_screen', 1, 0, {}, passives, 1, 0)
        end, text = Text({{text = '[wavy, ' .. tostring(state.dark_transitions and 'fg' or 'bg') .. ']restarting...', font = pixul_font, alignment = 'center'}}, global_text_tags)}
      end}
    else

      local function resetSaveLoadButtons()
        self.load_button_1:set_text('Load run '..saveLoad_tars[1])
        self.load_button_2:set_text('Load run '..saveLoad_tars[2])
        self.save_button_1:set_text(strc({'Copy ', state.save_num, ' to ', saveLoad_tars[1]}))
        self.save_button_2:set_text(strc({'Copy ', state.save_num, ' to ', saveLoad_tars[2]}))
        self.run_t.text:set_text({{text = '[bg10]Run: ' .. state.save_num, font = pixul_font, alignment = 'center'}})
      end

      self.load_button_1 = Button{group = self.ui, x = gw/2 - 116, y = gh - 200, force_update = true, button_text = 'Load run '..saveLoad_tars[1], fg_color = 'bg10', bg_color = 'bg',
      action = function(b)
        ui_switch1:play{pitch = random:float(0.95, 1.05), volume = 0.5}
        state.save_num = saveLoad_tars[1]
        setSaveOpts()
        resetSaveLoadButtons()
      end}

      self.load_button_2 = Button{group = self.ui, x = gw/2 - 40, y = gh - 200, force_update = true, button_text = 'Load run '..saveLoad_tars[2], fg_color = 'bg10', bg_color = 'bg',
      action = function(b)
        ui_switch1:play{pitch = random:float(0.95, 1.05), volume = 0.5}
        state.save_num = saveLoad_tars[2]
        setSaveOpts()
        resetSaveLoadButtons()
      end}

      print(state.save_num)

      self.save_button_1 = Button{group = self.ui, x = gw/2 + 40, y = gh - 200, force_update = true, button_text = strc({'Save ', state.save_num, ' to ', saveLoad_tars[1]}), fg_color = 'bg10', bg_color = 'bg',
      action = function(b)
        ui_switch1:play{pitch = random:float(0.95, 1.05), volume = 0.5}
        system.copy_run_to(run_tars[saveLoad_tars[1]])
      end}

      self.save_button_2 = Button{group = self.ui, x = gw/2 + 120, y = gh - 200, force_update = true, button_text = strc({'Save ', state.save_num, ' to ', saveLoad_tars[2]}), fg_color = 'bg10', bg_color = 'bg',
      action = function(b)
        ui_switch1:play{pitch = random:float(0.95, 1.05), volume = 0.5}
        system.copy_run_to(run_tars[saveLoad_tars[2]])
      end}
      
    end

    self.mouse_button = Button{group = self.ui, x = gw/2 - 113, y = gh - 150, force_update = true, button_text = 'mouse control: ' .. tostring(state.mouse_control and 'yes' or 'no'), fg_color = 'bg10', bg_color = 'bg',
    action = function(b)
      ui_switch1:play{pitch = random:float(0.95, 1.05), volume = 0.5}
      state.mouse_control = not state.mouse_control
      b:set_text('mouse control: ' .. tostring(state.mouse_control and 'yes' or 'no'))
    end}

    self.dark_transition_button = Button{group = self.ui, x = gw/2 + 13, y = gh - 150, force_update = true, button_text = 'dark transitions: ' .. tostring(state.dark_transitions and 'yes' or 'no'),
    fg_color = 'bg10', bg_color = 'bg', action = function(b)
      ui_switch1:play{pitch = random:float(0.95, 1.05), volume = 0.5}
      state.dark_transitions = not state.dark_transitions
      b:set_text('dark transitions: ' .. tostring(state.dark_transitions and 'yes' or 'no'))
    end}

    self.run_timer_button = Button{group = self.ui, x = gw/2 + 121, y = gh - 150, force_update = true, button_text = 'run timer: ' .. tostring(state.run_timer and 'yes' or 'no'), fg_color = 'bg10', bg_color = 'bg',
    action = function(b)
      ui_switch1:play{pitch = random:float(0.95, 1.05), volume = 0.5}
      state.run_timer = not state.run_timer
      b:set_text('run timer: ' .. tostring(state.run_timer and 'yes' or 'no'))
    end}

    self.sfx_button = Button{group = self.ui, x = gw/2 - 46, y = gh - 175, force_update = true, button_text = 'sfx volume: ' .. tostring((state.sfx_volume or 0.5)*10), fg_color = 'bg10', bg_color = 'bg',
    action = function(b)
      ui_switch2:play{pitch = random:float(0.95, 1.05), volume = 0.5}
      b.spring:pull(0.2, 200, 10)
      b.selected = true
      ui_switch1:play{pitch = random:float(0.95, 1.05), volume = 0.5}
      sfx.volume = sfx.volume + 0.1
      if sfx.volume > 1 then sfx.volume = 0 end
      state.sfx_volume = sfx.volume
      b:set_text('sfx volume: ' .. tostring((state.sfx_volume or 0.5)*10))
    end,
    action_2 = function(b)
      ui_switch2:play{pitch = random:float(0.95, 1.05), volume = 0.5}
      b.spring:pull(0.2, 200, 10)
      b.selected = true
      ui_switch1:play{pitch = random:float(0.95, 1.05), volume = 0.5}
      sfx.volume = sfx.volume - 0.1
      if math.abs(sfx.volume) < 0.001 and sfx.volume > 0 then sfx.volume = 0 end
      if sfx.volume < 0 then sfx.volume = 1 end
      state.sfx_volume = sfx.volume
      b:set_text('sfx volume: ' .. tostring((state.sfx_volume or 0.5)*10))
    end}

    self.music_button = Button{group = self.ui, x = gw/2 + 48, y = gh - 175, force_update = true, button_text = 'music volume: ' .. tostring((state.music_volume or 0.5)*10), fg_color = 'bg10', bg_color = 'bg',
    action = function(b)
      ui_switch2:play{pitch = random:float(0.95, 1.05), volume = 0.5}
      b.spring:pull(0.2, 200, 10)
      b.selected = true
      ui_switch1:play{pitch = random:float(0.95, 1.05), volume = 0.5}
      music.volume = music.volume + 0.1
      if music.volume > 1 then music.volume = 0 end
      state.music_volume = music.volume
      b:set_text('music volume: ' .. tostring((state.music_volume or 0.5)*10))
    end,
    action_2 = function(b)
      ui_switch2:play{pitch = random:float(0.95, 1.05), volume = 0.5}
      b.spring:pull(0.2, 200, 10)
      b.selected = true
      ui_switch1:play{pitch = random:float(0.95, 1.05), volume = 0.5}
      music.volume = music.volume - 0.1
      if math.abs(music.volume) < 0.001 and music.volume > 0 then music.volume = 0 end
      if music.volume < 0 then music.volume = 1 end
      state.music_volume = music.volume
      b:set_text('music volume: ' .. tostring((state.music_volume or 0.5)*10))
    end}

    self.video_button_1 = Button{group = self.ui, x = gw/2 - 136, y = gh - 125, force_update = true, button_text = 'window size-', fg_color = 'bg10', bg_color = 'bg', action = function()
      if sx > 1 and sy > 1 then
        ui_switch1:play{pitch = random:float(0.95, 1.05), volume = 0.5}
        sx, sy = sx - 0.5, sy - 0.5
        love.window.setMode(480*sx, 270*sy)
        state.sx, state.sy = sx, sy
        state.fullscreen = false
      end
    end}

    self.video_button_2 = Button{group = self.ui, x = gw/2 - 50, y = gh - 125, force_update = true, button_text = 'window size+', fg_color = 'bg10', bg_color = 'bg', action = function()
      ui_switch1:play{pitch = random:float(0.95, 1.05), volume = 0.5}
      sx, sy = sx + 0.5, sy + 0.5
      love.window.setMode(480*sx, 270*sy)
      state.sx, state.sy = sx, sy
      state.fullscreen = false
    end}

    self.video_button_3 = Button{group = self.ui, x = gw/2 + 29, y = gh - 125, force_update = true, button_text = 'fullscreen', fg_color = 'bg10', bg_color = 'bg', action = function()
      ui_switch1:play{pitch = random:float(0.95, 1.05), volume = 0.5}
      local _, _, flags = love.window.getMode()
      local window_width, window_height = love.window.getDesktopDimensions(flags.display)
      sx, sy = window_width/480, window_height/270
      state.sx, state.sy = sx, sy
      ww, wh = window_width, window_height
      love.window.setMode(window_width, window_height)
    end}

    self.video_button_4 = Button{group = self.ui, x = gw/2 + 129, y = gh - 125, force_update = true, button_text = 'reset video settings', fg_color = 'bg10', bg_color = 'bg', action = function()
      local _, _, flags = love.window.getMode()
      local window_width, window_height = love.window.getDesktopDimensions(flags.display)
      sx, sy = window_width/480, window_height/270
      ww, wh = window_width, window_height
      state.sx, state.sy = sx, sy
      state.fullscreen = false
      ww, wh = window_width, window_height
      love.window.setMode(window_width, window_height)
    end}

    self.hide_aoes_button = Button{group = self.ui, x = gw/2 - 160, y = gh - 100, w = 88, force_update = true, button_text = '[bg10]hide AoEs: ' .. tostring(state.hide_aoes and 'yes' or 'no'), 
    fg_color = 'bg10', bg_color = 'bg', action = function(b)
      ui_switch1:play{pitch = random:float(0.95, 1.05), volume = 0.5}
      if state.hide_aoes == nil then
        state.hide_aoes = true
      else
        state.hide_aoes = not state.hide_aoes
      end
      b:set_text('hide AoEs: ' .. tostring(state.hide_aoes and 'yes' or 'no'))
    end}

    self.screen_shake_button = Button{group = self.ui, x = gw/2 - 57, y = gh - 100, w = 110, force_update = true, button_text = '[bg10]screen shake: ' .. tostring(state.no_screen_shake and 'no' or 'yes'), 
    fg_color = 'bg10', bg_color = 'bg', action = function(b)
      ui_switch1:play{pitch = random:float(0.95, 1.05), volume = 0.5}
      state.no_screen_shake = not state.no_screen_shake
      b:set_text('screen shake: ' .. tostring(state.no_screen_shake and 'no' or 'yes'))
    end}

    self.cooldown_snake_button = Button{group = self.ui, x = gw/2 + 75, y = gh - 100, w = 145, force_update = true, button_text = '[bg10]cooldowns on snake: ' .. tostring(state.cooldown_snake and 'yes' or 'no'), 
    fg_color = 'bg10', bg_color = 'bg', action = function(b)
      ui_switch1:play{pitch = random:float(0.95, 1.05), volume = 0.5}
      state.cooldown_snake = not state.cooldown_snake
      b:set_text('cooldowns on snake: ' .. tostring(state.cooldown_snake and 'yes' or 'no'))
    end}

    self.arrow_snake_button = Button{group = self.ui, x = gw/2 + 65, y = gh - 75, w = 125, force_update = true, button_text = '[bg10]arrow on snake: ' .. tostring(state.arrow_snake and 'yes' or 'no'),
    fg_color = 'bg10', bg_color = 'bg', action = function(b)
      ui_switch1:play{pitch = random:float(0.95, 1.05), volume = 0.5}
      state.arrow_snake = not state.arrow_snake
      b:set_text('arrow on snake: ' .. tostring(state.arrow_snake and 'yes' or 'no'))
    end}

    self.screen_movement_button = Button{group = self.ui, x = gw/2 - 69, y = gh - 75, w = 135, force_update = true, button_text = '[bg10]screen movement: ' .. tostring(state.no_screen_movement and 'no' or 'yes'), 
    fg_color = 'bg10', bg_color = 'bg', action = function(b)
      ui_switch1:play{pitch = random:float(0.95, 1.05), volume = 0.5}
      state.no_screen_movement = not state.no_screen_movement
      if state.no_screen_movement then
        camera.x, camera.y = gw/2, gh/2
        camera.r = 0
      end
      b:set_text('screen movement: ' .. tostring(state.no_screen_movement and 'no' or 'yes'))
    end}

    if self:is(MainMenu) then
      self.ng_plus_minus_button = Button{group = self.ui, x = gw/2 - 58, y = gh - 50, force_update = true, button_text = 'NG+ down', fg_color = 'bg10', bg_color = 'bg', action = function(b)
        ui_switch1:play{pitch = random:float(0.95, 1.05), volume = 0.5}
        b.spring:pull(0.2, 200, 10)
        b.selected = true
        current_new_game_plus = math.clamp(current_new_game_plus - 1, 0, 5)
        state.current_new_game_plus = current_new_game_plus
        self.ng_t.text:set_text({{text = '[bg10]current: ' .. current_new_game_plus, font = pixul_font, alignment = 'center'}})
        max_units = 7 + current_new_game_plus
        system.save_run()
      end}

      self.ng_plus_plus_button = Button{group = self.ui, x = gw/2 + 5, y = gh - 50, force_update = true, button_text = 'NG+ up', fg_color = 'bg10', bg_color = 'bg', action = function(b)
        ui_switch1:play{pitch = random:float(0.95, 1.05), volume = 0.5}
        b.spring:pull(0.2, 200, 10)
        b.selected = true
        current_new_game_plus = math.clamp(current_new_game_plus + 1, 0, new_game_plus)
        state.current_new_game_plus = current_new_game_plus
        self.ng_t.text:set_text({{text = '[bg10]current: ' .. current_new_game_plus, font = pixul_font, alignment = 'center'}})
        max_units = 7 + current_new_game_plus
        system.save_run()
      end}
    end

    if not self:is(MainMenu) then
      self.main_menu_button = Button{group = self.ui, x = gw/2, y = gh - 50, force_update = true, button_text = 'main menu', fg_color = 'bg10', bg_color = 'bg', action = function(b)
        self.transitioning = true
        ui_transition2:play{pitch = random:float(0.95, 1.05), volume = 0.5}
        ui_switch2:play{pitch = random:float(0.95, 1.05), volume = 0.5}
        ui_switch1:play{pitch = random:float(0.95, 1.05), volume = 0.5}
        TransitionEffect{group = main.transitions, x = gw/2, y = gh/2, color = state.dark_transitions and bg[-2] or fg[0], transition_action = function()
          main:add(MainMenu'main_menu')
          main:go_to('main_menu')
        end, text = Text({{text = '[wavy, ' .. tostring(state.dark_transitions and 'fg' or 'bg') .. ']..', font = pixul_font, alignment = 'center'}}, global_text_tags)}
      end}
    end

    self.quit_button = Button{group = self.ui, x = gw/2, y = gh - 25, force_update = true, button_text = 'quit', fg_color = 'bg10', bg_color = 'bg', action = function()
      system.save_state()
      steam.shutdown()
      love.event.quit()
    end}
  end, 'pause')
end


function close_options(self)
  trigger:tween(0.25, _G, {slow_amount = 1}, math.linear, function()
    slow_amount = 1
    self.paused = false
    if self.paused_t1 then self.paused_t1.dead = true; self.paused_t1 = nil end
    if self.paused_t2 then self.paused_t2.dead = true; self.paused_t2 = nil end
    if self.ng_t then self.ng_t.dead = true; self.ng_t = nil end
    if self.run_t then self.run_t.dead = true; self.run_t = nil end
    if self.resume_button then self.resume_button.dead = true; self.resume_button = nil end
    if self.restart_button then self.restart_button.dead = true; self.restart_button = nil end
    if self.mouse_button then self.mouse_button.dead = true; self.mouse_button = nil end
    if self.dark_transition_button then self.dark_transition_button.dead = true; self.dark_transition_button = nil end
    if self.run_timer_button then self.run_timer_button.dead = true; self.run_timer_button = nil end
    if self.sfx_button then self.sfx_button.dead = true; self.sfx_button = nil end
    if self.music_button then self.music_button.dead = true; self.music_button = nil end
    if self.video_button_1 then self.video_button_1.dead = true; self.video_button_1 = nil end
    if self.video_button_2 then self.video_button_2.dead = true; self.video_button_2 = nil end
    if self.video_button_3 then self.video_button_3.dead = true; self.video_button_3 = nil end
    if self.video_button_4 then self.video_button_4.dead = true; self.video_button_4 = nil end
    if self.screen_shake_button then self.screen_shake_button.dead = true; self.screen_shake_button = nil end
    if self.screen_movement_button then self.screen_movement_button.dead = true; self.screen_movement_button = nil end
    if self.cooldown_snake_button then self.cooldown_snake_button.dead = true; self.cooldown_snake_button = nil end
    if self.arrow_snake_button then self.arrow_snake_button.dead = true; self.arrow_snake_button = nil end
    if self.quit_button then self.quit_button.dead = true; self.quit_button = nil end
    if self.ng_plus_plus_button then self.ng_plus_plus_button.dead = true; self.ng_plus_plus_button = nil end
    if self.ng_plus_minus_button then self.ng_plus_minus_button.dead = true; self.ng_plus_minus_button = nil end
    if self.hide_aoes_button then self.hide_aoes_button.dead = true; self.hide_aoes_button = nil end
    if self.save_button_1 then self.save_button_1.dead = true; self.save_button_1 = nil end
    if self.save_button_2 then self.save_button_2.dead = true; self.save_button_2 = nil end
    if self.load_button_1 then self.load_button_1.dead = true; self.load_button_1 = nil end
    if self.load_button_2 then self.load_button_2.dead = true; self.load_button_2 = nil end
    if self.main_menu_button then self.main_menu_button.dead = true; self.main_menu_button = nil end
    system.save_state()
    if self:is(MainMenu) or self:is(BuyScreen) then input:set_mouse_visible(true)
    elseif self:is(Arena) then input:set_mouse_visible(state.mouse_control or false) end
  end, 'pause')
end


function love.run()
  return engine_run({
    game_name = 'SNKRX',
    window_width = 'max',
    window_height = 'max',
  })
end
