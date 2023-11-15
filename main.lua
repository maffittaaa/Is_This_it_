require "/MainCharacter/mainCharacter"
require "/Ghosts/ghosts"
require "/Death/death"
require "/Valkyries/valkyries"
require "/InGameMenu/inGameMenu"
require "/MainMenu/mainMenu"

local world

function love.load()
  world = love.physics.newWorld(0, 0, true)
  world:setCallbacks(BeginContact,EndContact, nil, nil)
  love.window.setMode(1600, 800)
  --Call "load" function of every script
  CreatePlayer(world)
  LoadValquiria(world)
end

function BeginContact(fixtureA, fixtureB)
  print(fixtureA:getUserData(), fixtureB:getUserData())

  if fixtureA:getUserData() == "player" and fixtureB:getUserData() == "MelleAttack" then
    enemy.playerInSight = true
    enemy.patroling = false
    enemy.isRanging = true
    print("es burra mafalda")
  elseif fixtureA:getUserData() == "player" and fixtureB:getUserData() == "RangedAttack" then
    enemy.playerInSight = true
    enemy.isRanging = true
    enemy.patroling = false
    print("es burra mafalda")
  end

  if fixtureA:getUserData() == "MelleAttack" and fixtureB:getUserData() == "player" then
    enemy.playerInSight = true
    enemy.patroling = false
    enemy.isRanging = true
    print("es burra mafalda")
  elseif fixtureA:getUserData() == "RangedAttack" and fixtureB:getUserData() == "player" then
    enemy.playerInSight = true
    enemy.patroling = true
    enemy.isRanging = false
    print("es burra mafalda")
  end
end

function EndContact(fixtureA, fixtureB)   
  if fixtureA:getUserData() == "player" and fixtureB:getUserData() == "MelleAttack" then
    enemy.isRanging = false
  end
end

function love.update(dt)
  world:update(dt)

  GetWorld()

  UpdatePlayer(dt)
  UpdateValquiria(dt, GetPlayerPosition())
  --Call update function of every script
end



function love.draw()
  --Call draw function of every script
  DrawPlayer()
  DrawValquiria()
end

function GetWorld()
  return world
end