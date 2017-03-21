//: [Previous](@previous)

/*:
 - note: Compared to other pages, I let this one completely editable on purpose 🙂
 */

import UIKit
import PlaygroundSupport

//: ### Main View & Background
let view = UIView(frame: CGRect(x: 0, y: 0, width: 430, height: 600))
PlaygroundPage.current.liveView = view

/* Background */
let backImage = UIImageView(image: #imageLiteral(resourceName: "TramigoBack.jpg"))
backImage.frame = view.frame
backImage.contentMode = .scaleAspectFill
view.addSubview(backImage)

//: ### Title
let title = UILabel()
title.textColor = .white
title.numberOfLines = 0
title.textAlignment = .center
title.layer.shadowColor   = UIColor.black.cgColor
title.layer.shadowRadius  = 10
title.layer.shadowOffset  = CGSize(width: 0, height: 0)
title.layer.shadowOpacity = 1
let attrStr = NSMutableAttributedString(string: "Tramigo\nLive Times at the Nearest Stations")
attrStr.addAttributes([NSFontAttributeName : UIFont.boldSystemFont(ofSize: 42)], range: NSRange(0..<7))
attrStr.addAttributes([NSFontAttributeName : UIFont.systemFont(ofSize: 26)], range: NSRange(7..<attrStr.string.characters.count))
title.attributedText = attrStr


//: ### Content
/* App in my own hand… */
let hand = UIImageView(image: #imageLiteral(resourceName: "TramigoHand.png"))
hand.contentMode = .scaleAspectFit
hand.addConstraint(NSLayoutConstraint(item: hand,
                                      attribute: .width,
                                      relatedBy: .equal,
                                      toItem: hand,
                                      attribute: .height,
                                      multiplier: 2579 / 3487,
                                      constant: 0))

/* Side Text */
let description = UILabel()
description.textColor = .white
description.numberOfLines = 0
description.font = UIFont.systemFont(ofSize: 21)
description.layer.shadowColor   = UIColor.black.cgColor
description.layer.shadowRadius  = 5
description.layer.shadowOffset  = CGSize(width: 0, height: 0)
description.layer.shadowOpacity = 1
description.text = "• Times at launch!\n• Maps\n• Offline Timetables\n• City Detection\n• Favorite Lines\n• Favorite Stops\n\n\nTop App in Angers, France\n"


//: ### Layout
/* Content Layout */
let hStack = UIStackView(arrangedSubviews: [hand, description])
hStack.spacing = 18

/* Main Layout */
let mainStack = UIStackView(arrangedSubviews: [title, hStack])
mainStack.axis = .vertical
mainStack.frame = view.frame
mainStack.spacing = 30
view.addSubview(mainStack)


//: ### Animations
/* Title */
title.alpha = 0
UIView.animate(withDuration: 1.5, delay: 0.25, options: [], animations: {
    title.alpha = 1
    title.frame.origin.y += 10
}, completion: nil)

/* Content */
hand.alpha = 0
description.alpha = 0
description.frame.origin.y -= 10
UIView.animate(withDuration: 1.5, delay: 0.75, options: [], animations: {
    hand.alpha = 1
    description.alpha = 1
    description.frame.origin.y += 10
}, completion: nil)


//: [Next](@next)
