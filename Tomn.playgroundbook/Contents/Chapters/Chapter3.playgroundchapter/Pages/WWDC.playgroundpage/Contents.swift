//#-hidden-code
import SpriteKit
import PlaygroundSupport

let mainView = SKView(frame: CGRect(x: 0, y: 0, width: 430, height: 600))
let scene = WWDCScene(size: mainView.frame.size)

//#-end-hidden-code
// Change how many people participate in WWDC
scene.participants = /*#-editable-code Change how many people participate in WWDC*/42/*#-end-editable-code*/

// Change background text lines
scene.textLine1 = /*#-editable-code Write some text for the 1st line*/"I can't wait"/*#-end-editable-code*/
scene.textLine2 = /*#-editable-code Write some text for the 2nd line*/"for WWDC17!"/*#-end-editable-code*/
//#-hidden-code

mainView.presentScene(scene)

PlaygroundPage.current.liveView = mainView
//#-end-hidden-code