import Signal exposing (map2)
import Mouse
import Graphics.Element exposing (show, empty)

mouseInfo y down = if down then show y else empty

main = map2 (mouseInfo) Mouse.position Mouse.isDown
