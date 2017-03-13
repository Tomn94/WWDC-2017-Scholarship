//: [Previous](@previous)

//: ### Life Points
//: Starts with 3 LP by default, but this can be played hardcore-style (0..<8)
let initialLives = 1

//: ### Flying Objects Physics
//: Speed of the missiles launched when the screen is tapped
let missilesSpeed = 0.8
//: Speed of the bombs passing along the screen height
let bombOnScreenTime = 2.1
//: Time interval between 2 bombs apparition
let bombsSpawnTime = 0.5
//: Ship ability to respond to tilting iPad event
let shipMoveForce = 55.0

//: ### Level 2 Parameters - Spaceships
//: Minimum score to unblock level 2 ships
let lvl2MinScore = 10
//: Probability a LVL1-bomb is turned into a LVL2-ship
let lvl2ProbRange = 1000
//: Number of missiles a ship needed to destroy the LVL2-ship
let lvl2BombMaxHit = 4

//#-hidden-code

import UIKit
import SpriteKit
import PlaygroundSupport

let frameSize = CGSize(width: 500, height: 500)
let scene = SpaceGameScene(size: frameSize)
scene.scaleMode = .aspectFill
scene.updateLives(with: initialLives)
scene.shipMoveFact = shipMoveForce
scene.missilesSpeed = missilesSpeed
scene.bombShowTime = bombOnScreenTime
scene.bombsSpawnTime = bombsSpawnTime
scene.lvl2MinScore = lvl2MinScore
scene.lvl2ProbRange = UInt32(lvl2ProbRange)
scene.bombLvl2MaxHit = lvl2BombMaxHit

let view = SKView(frame: CGRect(origin: CGPoint.zero, size: frameSize))
view.showsFPS = false
view.showsNodeCount = false
view.ignoresSiblingOrder = true
view.presentScene(scene)

PlaygroundPage.current.liveView = view
//#-end-hidden-code

//: [Next](@next)
