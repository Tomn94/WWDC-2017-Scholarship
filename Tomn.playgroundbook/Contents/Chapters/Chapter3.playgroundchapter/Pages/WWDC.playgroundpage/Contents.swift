//#-hidden-code
import SpriteKit
import PlaygroundSupport

let mainView = SKView(frame: CGRect(x: 0, y: 0, width: 430, height: 600))
let scene = WWDCScene(size: mainView.frame.size)

// Change how many people participate in WWDC
//#-hidden-code
scene.participants = /*#-editable-code Change how many people participate in WWDC*/42/*#-end-editable-code*/
//#-end-hidden-code

mainView.presentScene(scene)

PlaygroundPage.current.liveView = mainView
//#-end-hidden-code