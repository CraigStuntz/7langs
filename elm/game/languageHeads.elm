module LanguageHead where

import Color exposing (..)
import Graphics.Collage exposing (..)
import Graphics.Element exposing (Element, image, leftAligned)
import Keyboard
import List
import List exposing ((::), all, filter, length)
import Mouse
import Random exposing (Seed, generate, initialSeed, int)
import Signal exposing (Signal, (<~), (~), foldp, map, sampleOn)
import Text exposing (color, fromString, height, monospace)
import Time exposing (Time, every, fps, inSeconds)

type State = Play | Pause | GameOver

type alias Input = { space:Bool, x:Int, delta:Time }
type alias Head = { x:Float, y:Float, vx:Float, vy:Float, img:String }
type alias Player = { x:Float, score:Int }
type alias Game = { state:State, heads: List Head, player:Player, seed: Seed }

defaultHead : Int -> Head
defaultHead n = {x=100.0, y=75, vx=60, vy=0.0, img=headImage n }

defaultGame : Game
defaultGame = { state   = Pause,
                heads   = [],
                player  = {x=0.0, score=0},
                seed    = initialSeed 1234 }

headImage : Int -> String
headImage n =
  if | n == 0 -> "/img/brucetate.png"
     | n == 1 -> "/img/davethomas.png"
     | n == 2 -> "/img/evanczaplicki.png"
     | n == 3 -> "/img/joearmstrong.png"
     | n == 4 -> "/img/josevalim.png"
     | otherwise -> ""

bottom = 550

secsPerFrame = 1.0 / 50.0

delta : Signal Float
delta = inSeconds <~ fps 50


input : Signal Input
input =
    sampleOn delta (Input <~ Keyboard.space
                               ~ Mouse.x
                               ~ delta)

main : Signal Element
main = map display (gameState)

gameState : Signal Game
gameState = foldp stepGame defaultGame input

stepGame : Input -> Game -> Game
stepGame input game =
  case game.state of
    Play -> stepGamePlay input game
    Pause -> stepGamePaused input game
    GameOver -> stepGameFinished input game

stepGamePlay : Input -> Game -> Game
stepGamePlay {space, x, delta} ({state, heads, player, seed} as game) =
    let (rand, seed') =
        generate (int 0 4) seed
    in
        { game | state <-  stepGameOver x heads
               , heads <-  stepHeads heads delta x player.score rand
               , player <- stepPlayer player x heads
               , seed  <-  seed' }

stepGameOver : Int -> List Head -> State
stepGameOver x heads =
  if allHeadsSafe (toFloat x) heads then Play else GameOver

allHeadsSafe : Float -> List Head -> Bool
allHeadsSafe x heads =
    all (headSafe x) heads

headSafe : Float -> Head -> Bool
headSafe x head =
    head.y < bottom || abs (head.x - x) < 50

stepHeads : List Head -> Time -> Int -> Int -> Int -> List Head
stepHeads heads delta x score rand =    -- (5)
  spawnHead score heads rand
  |> bounceHeads
  |> removeComplete
  |> moveHeads delta

spawnHead : Int -> List Head -> Int -> List Head
spawnHead score heads rand =   -- (6)
  let addHead = length heads < (score // 5000 + 1)
    && all (\head -> head.x > 107.0) heads in
  if addHead then defaultHead rand :: heads else heads

bounceHeads : List Head -> List Head
bounceHeads heads = List.map bounce heads      -- (7)

bounce : Head -> Head
bounce head =
  { head | vy <- if head.y > bottom && head.vy > 0
                 then -head.vy * 0.95
                 else head.vy }

removeComplete heads = filter (\x -> not (complete x)) heads  -- (8)

complete {x} = x > 750

moveHeads : Time -> List Head -> List Head
moveHeads delta heads = List.map moveHead heads     -- (9)

moveHead : Head -> Head
moveHead ({x, y, vx, vy} as head) =
  { head | x <- x + vx * secsPerFrame
         , y <- y + vy * secsPerFrame
         , vy <- vy + secsPerFrame * 400 }

stepPlayer : Player -> Int -> List Head -> Player
stepPlayer player mouseX heads =     -- (10)
  { player | score <- stepScore player heads
           , x <- toFloat mouseX }

stepScore : Player -> List Head -> Int
stepScore player heads =   -- (11)
  player.score +
  1 +
  1000 * (length (filter complete heads))

stepGamePaused : Input -> Game -> Game
stepGamePaused {space, x, delta} ({state, heads, player, seed} as game) =    -- (12)
  { game | state <- stepState space state
         , player <- { player |  x <- toFloat x } }

stepGameFinished : Input -> Game -> Game
stepGameFinished {space, x, delta} ({state, heads, player, seed} as game) =   -- (13)
  if space then defaultGame
  else { game | state <- GameOver
              , player <- { player |  x <- toFloat x } }

stepState : Bool -> State -> State
stepState space state = if space then Play else state   -- (14)

display : Game -> Element
display ({state, heads, player, seed} as game) =   -- (15)
  let (w, h) = (800, 600)
  in collage w h
       ([ drawRoad w h
       , drawBuilding w h
       , drawPaddle w h player.x
       , drawScore w h player
       , drawMessage w h state] ++
       (drawHeads w h heads))

drawRoad w h =   -- (16)
  filled gray (rect (toFloat w) 100)
  |> moveY (-(half h) + 50)

drawBuilding w h =
  filled red (rect 100 (toFloat h))
  |> moveX (-(half w) + 50)

drawHeads : Int -> Int -> List Head -> List Form
drawHeads w h heads = List.map (drawHead w h) heads   -- (17)

drawHead : Int -> Int -> Head -> Form
drawHead w h head =
  let x = half w - head.x
      y = half h - head.y
      src = head.img
  in toForm (image 75 75 src)
     |> move (-x, y)
     |> rotate (degrees (x * 2 - 100))

drawPaddle w h x =   -- (18)
  filled black (rect 80 10)
  |> moveX (x +  10 -  half w)
  |> moveY (-(half h - 30))

half : Int -> Float
half x = toFloat x / 2

drawScore w h player =     -- (19)
  toForm (fullScore player)
  |> move (half w - 150, half h - 40)

fullScore player = txt (height 50) (toString player.score)

txt f = leftAligned << f << monospace << color blue << fromString

drawMessage : Int -> Int -> State -> Form
drawMessage w h state =    -- (20)
  toForm (txt (height 50) (stateMessage state))
  |> move (50, 50)

stateMessage : State -> String
stateMessage state =
  if state == GameOver then "Game Over" else "Language Head"
