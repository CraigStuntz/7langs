import Color exposing (..)
import Graphics.Collage exposing (..)
import Graphics.Element exposing (..)
import Signal exposing (map3)
import Mouse
import Window exposing (dimensions)

small_circle = (filled red (circle 24))
square = filled blue (rect 48 48)

drawShape (wx, wy) (x, y) isDown = 
      let
            xPos = x - (wx // 2) |> toFloat
            yPos = -y + (wy // 2) |> toFloat
            shape = 
                  (if isDown then small_circle else square) |> move
                  (xPos, yPos)
      in 
            collage wx wy [ shape ]

main = map3 (drawShape) dimensions Mouse.position Mouse.isDown
