import Signal (map2)
import Mouse
import Text (asText)

mouseInfo y down = if down then asText y else plainText ""

main = map2 (mouseInfo) Mouse.position Mouse.isDown
