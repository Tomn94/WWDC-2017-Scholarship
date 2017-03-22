//: [Previous](@previous)
/*:
 - callout(A Look at My Projects): Then I created an app for the Students’ Union compaign. One notable feature was Students from my Engineering School had to walk around in the city to find hidden QRcodes, and scan them with the app.\
     Once elected I further developed the app with the following features.\
     Everything can be managed from a Portal back-end I created with 20 services.
 */

import UIKit
import PlaygroundSupport

//: ### Main View & Background
let view = UIView(frame: CGRect(x: 0, y: 0, width: 450, height: 600))
view.tintColor = .white
let mainVC = UIViewController()
mainVC.preferredContentSize = view.frame.size
mainVC.view = view

/* Configure gradient layer of the background */
let gradientLayer = CAGradientLayer()
gradientLayer.frame = view.bounds
gradientLayer.colors = [#colorLiteral(red: 0.2274509804, green: 0.8431372549, blue: 1, alpha: 1).cgColor, #colorLiteral(red: 0.01176470588, green: 0.6549019608, blue: 1, alpha: 1).cgColor]
view.layer.addSublayer(gradientLayer)

PlaygroundPage.current.liveView = mainVC

//: ### Title
let title = UILabel(frame: CGRect(x: 0, y: 0, width: view.frame.width, height: 60))
title.text = "ESEO Students’ Union"
title.font = UIFont.boldSystemFont(ofSize: 40)
title.textColor = .white
title.numberOfLines = 0
title.textAlignment = .center
title.layer.shadowColor   = UIColor.black.cgColor
title.layer.shadowRadius  = 3
title.layer.shadowOffset  = CGSize(width: 0, height: 0)
title.layer.shadowOpacity = 0.4
view.addSubview(title)

//: ### Add cloud glyph in center
let cloud = UIImageView(image: #imageLiteral(resourceName: "su-cloud.png"))
cloud.frame = view.frame
cloud.center.y += title.frame.height * 2
cloud.contentMode = .center
view.addSubview(cloud)

let features: [Feature] = [
    Feature(title: "News published by Unions", icon: #imageLiteral(resourceName: "su-newsIcon.png"), screenshot: #imageLiteral(resourceName: "su-newsScreen.png")),
    
    Feature(title: "Upcoming Events", icon: #imageLiteral(resourceName: "su-eventsIcon.png"), screenshot: #imageLiteral(resourceName: "su-eventsScreen.png")),
    
    Feature(title: "List of the Unions", icon: #imageLiteral(resourceName: "su-clubsIcon.png"), screenshot: #imageLiteral(resourceName: "su-clubsScreen.png")),
    
    Feature(title: "Student Families", icon: #imageLiteral(resourceName: "su-familiesIcon.png"), screenshot: #imageLiteral(resourceName: "su-familiesScreen.png")),
    
    Feature(title: "Shared Documents", icon: #imageLiteral(resourceName: "su-docsIcon.png"), screenshot: #imageLiteral(resourceName: "su-docsScreen.png")),
    
    Feature(title: "Meal Ordering System,\nincludes paying with iOS", icon: #imageLiteral(resourceName: "su-orderIcon.png"), screenshot: #imageLiteral(resourceName: "su-orderScreen.png")),
    
    Feature(title: "Push Notifications for Events and Deliveries", icon: #imageLiteral(resourceName: "su-pushIcon.png"), screenshot: #imageLiteral(resourceName: "su-pushScreen.png")),
    
    Feature(title: "Events & Tickets Ordering,\nincludes paying with iOS", icon: #imageLiteral(resourceName: "su-ticketsIcon.png"), screenshot: #imageLiteral(resourceName: "su-ticketsScreen.png")),
    
    Feature(title: "iMessage Stickers", icon: #imageLiteral(resourceName: "su-stickersIcon.png"), screenshot: #imageLiteral(resourceName: "su-stickersScreen.png")),
    
    Feature(title: "Deals & Sponsors", icon: #imageLiteral(resourceName: "su-sponsorsIcon.png"), screenshot: #imageLiteral(resourceName: "su-sponsorsScreen.png")),
    
    Feature(title: "Buildings Plan & Rooms List", icon: #imageLiteral(resourceName: "su-roomsIcon.png"), screenshot: #imageLiteral(resourceName: "su-roomsScreen.png")),
    
    Feature(title: "User Profile & Preferences", icon: #imageLiteral(resourceName: "su-userIcon.png"), screenshot: #imageLiteral(resourceName: "su-userScreen.png"))
]

let center = view.center
let cloudSize = CGSize(width: 300, height: 200)
let titleHeight = title.frame.height
let xUpperBound = UInt32(cloudSize.width * 1.2)
let yUpperBound = UInt32(center.y - (titleHeight * 1.2))
let angleBound  = UInt32(20)    // degrees
let margins = UIEdgeInsets(top: -20, left: -20, bottom: -20, right: -20)

var buttonsFrames = [CGRect]()

extension CGRect {
    
    func intersects(_ rects: [CGRect]) -> Bool {
        
        for rect in rects {
            if self.intersects(rect) {
                return true
            }
        }
        return false
        
    }
    
}

for feature in features {
    
    var newButtonFrame = CGRect.zero
    repeat {
        let x = center.x - cloudSize.width / 1.5 + CGFloat(arc4random_uniform(xUpperBound))
        let y = titleHeight + CGFloat(arc4random_uniform(yUpperBound))
        newButtonFrame = CGRect(x: x, y: y, width: 42, height: 42)
    } while newButtonFrame.intersects(buttonsFrames)
    
    let button = PopButton(frame: newButtonFrame)
    button.feature = feature
    button.mainController = mainVC
    button.transform = CGAffineTransform(rotationAngle: (-CGFloat(angleBound) / 2 + CGFloat(arc4random_uniform(angleBound))) * CGFloat.pi / 180)

    view.addSubview(button)
    buttonsFrames.append(UIEdgeInsetsInsetRect(button.frame, margins))
}



//: [Next](@next)
