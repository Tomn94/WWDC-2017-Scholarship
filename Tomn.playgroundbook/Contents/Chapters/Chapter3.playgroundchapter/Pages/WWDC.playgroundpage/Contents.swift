import SpriteKit
import PlaygroundSupport

let mainView = SKView(frame: CGRect(x: 0, y: 0, width: 430, height: 600))

let scene = WWDCScene(size: mainView.frame.size)
scene.participants = 42
mainView.presentScene(scene)

PlaygroundPage.current.liveView = mainView
