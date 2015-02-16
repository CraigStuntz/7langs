import Graphics.Element (..)
import Signal
import Text (asText)
import Time (fps)

addSecond _ oldSeconds = oldSeconds + 1

main : Signal Element
main =
      Signal.map asText (Signal.foldp (addSecond) 0 (fps 1))
