import Graphics.Element exposing (..)
import Signal exposing (Signal, map2, sampleOn)
import Mouse

mouseInfo pos down = show (pos, down)

main : Signal Element
main =
      map2 (mouseInfo) Mouse.position Mouse.isDown
