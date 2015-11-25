import Graphics.Element exposing (..)
import Signal
import Time exposing (fps)

addSecond _ oldSeconds = oldSeconds + 1

main : Signal Element
main =
      Signal.map show (Signal.foldp (addSecond) 0 (fps 1))
