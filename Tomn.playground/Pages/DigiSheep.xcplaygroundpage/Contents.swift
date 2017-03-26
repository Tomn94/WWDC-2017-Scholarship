//: [Previous](@previous)
/*:
 - callout(A Look at My Projects): I created an app connected to an online ticketing system for events at my school.\
     The one on the background is La Blue Moon with 2,700 students.
 */

//#-hidden-code

import PlaygroundSupport
import UIKit

/* Frame parameters */

let frame = CGRect(x: 0, y: 0, width: 430, height: 500)

let phoneSize = CGSize(width: 174, height: 350)
let phoneInitial = CGRect(origin: CGPoint(x: -phoneSize.height / 2,
                                          y: frame.height - (phoneSize.width / 2)),
                          size: phoneSize)
let phoneMid = CGRect(origin: CGPoint(x: (frame.width - phoneSize.width) / 2,
                                      y: frame.height - phoneSize.height + 50),
                      size: phoneSize)
let phoneFinal = CGRect(origin: CGPoint(x: frame.width + (phoneSize.height / 2),
                                        y: frame.height - (phoneSize.width / 2)),
                        size: phoneSize)

let ticketSize = CGSize(width: 282, height: 100)
let ticketInitial = CGRect(origin: CGPoint(x: frame.width * 2,
                                         y: phoneMid.origin.y + (phoneMid.height / 3)),
                         size: ticketSize)
let ticketMid = CGRect(origin: CGPoint(x: phoneMid.origin.x + (phoneMid.width / 4.5),
                                       y: ticketInitial.origin.y),
                       size: ticketSize)
let ticketFinal = CGRect(origin: CGPoint(x: -ticketInitial.origin.x,
                                        y: ticketInitial.origin.y),
                         size: ticketSize)

/* Main View */
let mainView = UIView(frame: frame)
PlaygroundPage.current.liveView = mainView

/* Background image */
let background = UIImageView(image: #imageLiteral(resourceName: "bluemoon.jpg"))
background.frame = mainView.frame
background.autoresizingMask = [.flexibleWidth, .flexibleHeight]
mainView.addSubview(background)
background.contentMode = .scaleAspectFill

/* Title */
let title = UILabel(frame: CGRect(x: 0, y: 0, width: frame.width, height: frame.height / 2.5))
title.numberOfLines = 0
title.textAlignment = .center
title.textColor = .white
title.layer.shadowColor = UIColor.black.cgColor
title.layer.shadowRadius = 10
title.layer.shadowOffset = CGSize(width: 0, height: 0)
title.layer.shadowOpacity = 1
let attrStr = NSMutableAttributedString(string: "DigiSheep\nSell & Check Tickets\nTested with 2,700 Students")
attrStr.addAttributes([NSFontAttributeName : UIFont.boldSystemFont(ofSize: 42)], range: NSRange(0..<9))
attrStr.addAttributes([NSFontAttributeName : UIFont.boldSystemFont(ofSize: 32)], range: NSRange(10..<31))
attrStr.addAttributes([NSFontAttributeName : UIFont.systemFont(ofSize: 24.5)], range: NSRange(31..<57))
title.attributedText = attrStr

/* Ticket to be scanned */
let ticket = UIImageView(image: #imageLiteral(resourceName: "ticket.png"))
ticket.frame = ticketInitial
mainView.addSubview(ticket)
ticket.layer.shadowColor = UIColor.black.cgColor
ticket.layer.shadowRadius = 5
ticket.layer.shadowOpacity = 1
ticket.layer.shadowOffset = CGSize(width: 0, height: 0)

/* Scanning Phone */
let phone = UIView(frame: phoneInitial)
mainView.addSubview(phone)
phone.transform = CGAffineTransform(rotationAngle: -CGFloat.pi / 2)

/* Flashing Phone Screen */
let flash = UIView(frame: UIEdgeInsetsInsetRect(phone.bounds,
                                                UIEdgeInsets(top: 30,
                                                             left: 10,
                                                             bottom: 30,
                                                             right: 10)))
flash.backgroundColor = .clear
phone.addSubview(flash)

/* Whole Phone */
let app = UIImageView(image: UIImage(named: "digisheepPhone.png"))
app.frame = phone.bounds
phone.addSubview(app)

/* Animations parameters */
//#-end-hidden-code
//: ### Adjust phone animation parameters
//: Speed up animations
let animationsSpeed = /*#-editable-code Boost animations*/1.0/*#-end-editable-code*/

//: Adjust spring effect
let phoneDamping: CGFloat = /*#-editable-code Adjust spring effect*/0.6/*#-end-editable-code*/

//: Change arriving speed
let phoneVelocity: CGFloat = /*#-editable-code Change arriving speed*/6/*#-end-editable-code*/

//#-hidden-code

/* Fire button */
let button = TicketScanButton(frame: CGRect(x: (frame.width - 290) / 2,
                                            y: frame.height * 2 / 3,
                                            width: 290, height: 42))

/* Layout */
let container = UIView(frame: frame)
mainView.addSubview(container)
container.addSubview(title)
container.addSubview(button)

title.translatesAutoresizingMaskIntoConstraints = false
container.addConstraints([NSLayoutConstraint(item: title, attribute: .centerX, relatedBy: .equal, toItem: container, attribute: .centerX, multiplier: 1, constant: 0),
                          NSLayoutConstraint(item: title, attribute: .top, relatedBy: .equal, toItem: container, attribute: .topMargin, multiplier: 1, constant: 0)])

button.translatesAutoresizingMaskIntoConstraints = false
container.addConstraints([NSLayoutConstraint(item: button, attribute: .centerX, relatedBy: .equal, toItem: container, attribute: .centerX, multiplier: 1, constant: 0),
                          NSLayoutConstraint(item: button, attribute: .centerY, relatedBy: .equal, toItem: container, attribute: .centerY, multiplier: 1, constant: 50),
                          NSLayoutConstraint(item: button, attribute: .width, relatedBy: .equal, toItem: nil, attribute: .width, multiplier: 1, constant: 290),
                          NSLayoutConstraint(item: button, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .height, multiplier: 1, constant: 42)])

container.translatesAutoresizingMaskIntoConstraints = false
mainView.addConstraints([NSLayoutConstraint(item: container, attribute: .centerX, relatedBy: .equal, toItem: mainView, attribute: .centerX, multiplier: 1, constant: 0),
                         NSLayoutConstraint(item: container, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .height, multiplier: 1, constant: 430),
                         NSLayoutConstraint(item: container, attribute: .width, relatedBy: .equal, toItem: nil, attribute: .width, multiplier: 1, constant: 400),
                         NSLayoutConstraint(item: container, attribute: .centerY, relatedBy: .equal, toItem: mainView, attribute: .centerY, multiplier: 1, constant: 0)])

mainView.bringSubview(toFront: phone)

/* Set up animations */

button.phone = phone
button.ticket = ticket
button.flash = flash

button.animationSpeed = animationsSpeed
button.phoneDamping = phoneDamping
button.phoneVelocity = phoneVelocity

button.ticketInitial = ticketInitial
button.ticketMid = ticketMid
button.ticketFinal = ticketFinal

button.phoneInitial = phoneInitial
button.phoneMid = phoneMid
button.phoneFinal = phoneFinal

button.alpha = 0
title.alpha = 0
UIView.animate(withDuration: 1.5 * animationsSpeed, delay: 0.5, options: [], animations: {
    title.alpha = 1
    title.frame.origin.y += 10
    button.alpha = 1
}, completion: nil)

//#-end-hidden-code
//: [Next](@next)
