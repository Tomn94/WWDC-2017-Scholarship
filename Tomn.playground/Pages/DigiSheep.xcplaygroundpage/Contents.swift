//: [Previous](@previous)

//#-hidden-code

import PlaygroundSupport
import UIKit

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

let mainView = UIView(frame: frame)
PlaygroundPage.current.liveView = mainView

let background = UIImageView(image: #imageLiteral(resourceName: "bluemoon.jpg"))
background.frame = mainView.frame
mainView.addSubview(background)
background.contentMode = .scaleAspectFill

let title = UILabel(frame: CGRect(x: 0, y: 0, width: frame.width, height: frame.height / 2.5))
mainView.addSubview(title)
title.numberOfLines = 0
title.textAlignment = .center
title.textColor = .white
title.layer.shadowColor = UIColor.black.cgColor
title.layer.shadowRadius = 10
title.layer.shadowOffset = CGSize(width: 0, height: 0)
title.layer.shadowOpacity = 1
let attrStr = NSMutableAttributedString(string: "DigiSheep\nSell & Check Tickets\nTested with 2,500 Students")
attrStr.addAttributes([NSFontAttributeName : UIFont.boldSystemFont(ofSize: 42)], range: NSRange(0..<9))
attrStr.addAttributes([NSFontAttributeName : UIFont.boldSystemFont(ofSize: 32)], range: NSRange(10..<31))
attrStr.addAttributes([NSFontAttributeName : UIFont.systemFont(ofSize: 24.5)], range: NSRange(31..<57))
title.attributedText = attrStr

let ticket = UIImageView(image: #imageLiteral(resourceName: "ticket.png"))
ticket.frame = ticketInitial
mainView.addSubview(ticket)
ticket.layer.shadowColor = UIColor.black.cgColor
ticket.layer.shadowRadius = 5
ticket.layer.shadowOpacity = 1
ticket.layer.shadowOffset = CGSize(width: 0, height: 0)

let phone = UIView(frame: phoneInitial)
mainView.addSubview(phone)
phone.transform = CGAffineTransform(rotationAngle: -CGFloat.pi / 2)

let flash = UIView(frame: UIEdgeInsetsInsetRect(phone.bounds,
                                                UIEdgeInsets(top: 30,
                                                             left: 10,
                                                             bottom: 30,
                                                             right: 10)))
phone.addSubview(flash)
flash.backgroundColor = .clear

let app = UIImageView(image: UIImage(named: "digisheepPhone.png"))
app.frame = phone.bounds
phone.addSubview(app)


let animationSpeed = 1.0
let phoneDamping: CGFloat = 0.6
let phoneVelocity: CGFloat = 6


let button = TicketScanButton(frame: CGRect(x: (frame.width - 290) / 2,
                                            y: frame.height * 2 / 3,
                                            width: 290, height: 42))
button.phone = phone
button.ticket = ticket
button.flash = flash

button.animationSpeed = animationSpeed
button.phoneDamping = phoneDamping
button.phoneVelocity = phoneVelocity

button.ticketInitial = ticketInitial
button.ticketMid = ticketMid
button.ticketFinal = ticketFinal

button.phoneInitial = phoneInitial
button.phoneMid = phoneMid
button.phoneFinal = phoneFinal

mainView.addSubview(button)


//#-end-hidden-code

//: [Next](@next)
