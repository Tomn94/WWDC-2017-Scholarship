/*:
 - callout(Also in Students’ Union app): I made this hidden game for students
 */
/*:
 - note: Tilt your device to drive the ship (or swipe)\
         Tap to launch missiles (or keep pressing)
 */
//#-hidden-code
import UIKit
//#-end-hidden-code

// Fix for CMMotionManager in Playgrounds, device orientation is not available, please enter yours
let deviceOrientation: UIDeviceOrientation = /*#-editable-code Enter your screen orientation*/.landscapeLeft/*#-end-editable-code*/

//: ### Life Points
//: Starts with 3 LP by default, but this can be played hardcore-style (0..<8)
let initialLives: Int = /*#-editable-code Life Points*/3/*#-end-editable-code*/

//: ### Flying Objects Physics
/// Speed of the Missiles launched when the screen is tapped
let missilesSpeed = /*#-editable-code Speed of the missiles you launch*/0.8/*#-end-editable-code*/

/// Time interval between 2 Missiles launch
let missilesDelay = /*#-editable-code Time interval between 2 missiles launch*/0.2/*#-end-editable-code*/

/// Speed of the Bombs passing along the screen height
let bombOnScreenTime = /*#-editable-code Speed of the flying bombs*/2.1/*#-end-editable-code*/

/// Time interval between 2 Bombs apparition
let bombsSpawnTime = /*#-editable-code Mean time between 2 bombs*/0.5/*#-end-editable-code*/

/// Ship ability to respond to tilting iPad
let shipMoveForce = /*#-editable-code Tilt factor*/55.0/*#-end-editable-code*/

//: ### Level 2 Parameters - Spaceships
/// Minimum score to unblock level 2 ships
let lvl2MinScore = /*#-editable-code Minimum score to obtain*/10/*#-end-editable-code*/

/// Probability factor a LVL1-bomb is turned into a LVL2-ship
let lvl2ProbRange = /*#-editable-code At level 2, probability factor of new ships*/1/*#-end-editable-code*/

/// Number of missiles needed to destroy the LVL2-ship
let lvl2BombMaxHit = /*#-editable-code Number of hits*/4/*#-end-editable-code*/

//#-hidden-code

import SpriteKit
import PlaygroundSupport

let frameSize = CGSize(width: 432, height: 624)

/* Scene configuration */
let scene = SpaceGameScene(size: frameSize)
scene.scaleMode = .aspectFit
scene.updateLives(with: initialLives)
scene.shipMoveFact = shipMoveForce
scene.missilesSpeed = missilesSpeed
scene.bombShowTime = bombOnScreenTime
scene.bombsSpawnTime = bombsSpawnTime
scene.lvl2MinScore = lvl2MinScore
scene.lvl2ProbRange = UInt32(lvl2ProbRange)
scene.bombLvl2MaxHit = lvl2BombMaxHit
scene.deviceOrientation = deviceOrientation
scene.missilesDelay = missilesDelay

/* View setup */
let view = SKView(frame: CGRect(origin: CGPoint.zero, size: frameSize))
view.showsFPS = false
view.showsNodeCount = false
view.ignoresSiblingOrder = true
view.presentScene(scene)

PlaygroundPage.current.liveView = view

//#-end-hidden-code