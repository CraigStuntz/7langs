import Graphics.Element (..)
import Signal (Signal, map2, sampleOn)
import Mouse
import Text (asText)

mouseInfo pos down = asText (pos, down)

main : Signal Element
main =
      map2 (mouseInfo) Mouse.position Mouse.isDown
