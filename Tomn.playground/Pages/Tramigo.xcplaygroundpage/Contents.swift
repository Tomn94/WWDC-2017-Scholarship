//: [Previous](@previous)

import UIKit
import PlaygroundSupport

let view = UIView(frame: CGRect(x: 0, y: 0, width: 450, height: 600))
PlaygroundPage.current.liveView = view

let backImage = UIImageView(image: #imageLiteral(resourceName: "TramigoBack.jpg"))
backImage.frame = view.frame
backImage.contentMode = .scaleAspectFill
view.addSubview(backImage)

let hand = UIImageView(image: #imageLiteral(resourceName: "TramigoHand.png"))
let handHeight = view.frame.height / 1.5
hand.frame = CGRect(x: 0, y: view.frame.height - handHeight, width: handHeight * 2579 / 3487, height: handHeight)
view.addSubview(hand)

//: [Next](@next)
