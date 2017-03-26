//: [Previous](@previous)
/*:
 - callout(A Look at My Projects): I created an app connected to an online ticketing system for events at my school.\
     The one on the background is La Blue Moon with 2,700 students.
 */
//#-hidden-code
import PlaygroundSupport
import UIKit

//#-end-hidden-code
//: ### Adjust phone animation parameters
/// Speed up animations
let animationsSpeed = /*#-end-editable-code Speed up animations*/1.0/*#-end-editable-code*/

/// Adjust Phone spring effect
let phoneDamping: CGFloat = /*#-end-editable-code Adjust Phone spring effect*/0.6/*#-end-editable-code*/

/// Change Phone arriving speed
let phoneVelocity: CGFloat = /*#-end-editable-code Change Phone arriving speed*/6/*#-end-editable-code*/

//#-hidden-code
/* Main View */
let mainView = DSView(frame: DSView.contentFrame)
mainView.animationsSpeed = animationsSpeed
mainView.phoneDamping    = phoneDamping
mainView.phoneVelocity   = phoneVelocity
PlaygroundPage.current.liveView = mainView

mainView.showContent()

//#-end-hidden-code
//: [Next](@next)
