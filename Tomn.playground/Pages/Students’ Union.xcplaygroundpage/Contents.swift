//: [Previous](@previous)
/*:
 - callout(A Look at My Projects): **Then I created an app for the Students’ Union compaign**.\
     One notable feature was Students from my Engineering School had to walk around in the city to find hidden QRcodes, and scan them with the app.\
     \
     **Once elected** I further developed the app with the following features.\
     Everything can be managed from a Portal **back-end** I created with 20 services.
 */
//#-hidden-code
import UIKit
import PlaygroundSupport

//: ### Main View & Background
let view = FeaturesView(frame: CGRect(x: 0, y: 0, width: 450, height: 600))
let mainVC = UIViewController()
mainVC.view = view

PlaygroundPage.current.liveView = mainVC
//#-end-hidden-code

/// Resize Features icons
view.buttonSize = CGSize(width: 42, height: 42)

/// Wobble angle for icons
view.wiggleAngle = 0.059

/// Icons are randomly placed on the view,
/// defines the maximum number of attempts (watchdog) to find an empty place
view.maxButtonPlacementAttempt = 142

/// Margin between 2 icons
view.buttonMargins = UIEdgeInsets(top: -20, left: -20, bottom: -20, right: -20)

/// Features of Students’ Union app to display
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
view.set(features, in: mainVC)

/// Animate features apparition
view.showFeatures()

//: [Next](@next)
