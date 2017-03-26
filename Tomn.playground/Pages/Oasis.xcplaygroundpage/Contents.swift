/*:
 - callout(Also in Students’ Union app): 1 year later, I added this other fruity game
 */

/// Starts with 3 LP by default, must be 5 maximum,
/// but this can also be played hardcore-style at 0 the minimum
let startLives: Int = /*#-editable-code Choose the initial number of lives*/3/*#-end-editable-code*/

/// Time interval probability between 2 items, decreases over time
let spawnTimeProbability: UInt32 = /*#-editable-code Decrease to play faster*/50/*#-end-editable-code*/

/// Choose Fruits that appear
let fruits: [String] = [/*#-editable-code Choose fruits that appear*/"🍏", "🍎", "🍐", "🍊", "🍋", "🍌", "🍉", "🍇", "🍓", "🍈", "🍒", "🍑", "🍍", "🍆"/*#-end-editable-code*/]

/// Customize Bonuses
let specials: [String] = [/*#-editable-code Customize your own bonuses*/"🌮", "🌯", "🍗", "🍕", "🍔", "🍟"/*#-end-editable-code*/]

/// Edit or Add different kinds of Bombs
let loseLife: [String] = [/*#-editable-code Edit or Add different kinds of Bombs*/"💣"/*#-end-editable-code*/]

//: Probability that certain types appear
let bonusProbability: UInt32 = /*#-editable-code Probability out of 100 the object that appears is a bonus*/2/*#-end-editable-code*/
let specialProbability: UInt32 = /*#-editable-code Probability out of 100 the object that appears is a special fruit*/10/*#-end-editable-code*/
let bombInitialProbability: UInt32 = /*#-editable-code Probability out of 100 the object that appears is a bomb*/15/*#-end-editable-code*/

//#-hidden-code

import PlaygroundSupport
import UIKit
import SpriteKit

let frameSize = CGSize(width: 432, height: 624)

let scene = FruitsGameScene(size: frameSize)
scene.fruits = fruits
scene.specialFruits = specials
scene.loseLife = loseLife
scene.scaleMode = .aspectFit
scene.startLives = startLives
scene.spawnTimeProbability = spawnTimeProbability
scene.bonusProbability = bonusProbability * 2
scene.specialProbability = specialProbability * 2
scene.bombInitialProbability = bombInitialProbability * 2

let view = SKView(frame: CGRect(origin: CGPoint.zero, size: frameSize))
view.showsFPS = false
view.showsNodeCount = false
view.ignoresSiblingOrder = true
view.presentScene(scene)

PlaygroundPage.current.liveView = view
//#-end-hidden-code