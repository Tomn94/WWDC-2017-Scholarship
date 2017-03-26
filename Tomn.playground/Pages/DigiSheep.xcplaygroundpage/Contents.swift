//: [Previous](@previous)
/*:
 - callout(A Look at My Projects): I created an app connected to an online ticketing system for events at my school.\
     The one on the background is La Blue Moon with 2,700 students.
 */



import PlaygroundSupport
import UIKit

/* Frame parameters */

let contentFrame = CGRect(x: 0, y: 0, width: 430, height: 500)
let phoneSize = CGSize(width: 174, height: 350)
let ticketSize = CGSize(width: 282, height: 100)


/* Animations parameters */
//#-end-hidden-code
//: ### Adjust phone animation parameters
//: Speed up animations
let animationsSpeed = 1.0/*#-end-editable-code*/
//: Adjust spring effect
let phoneDamping: CGFloat = 0.6/*#-end-editable-code*/
//: Change arriving speed
let phoneVelocity: CGFloat = 6/*#-end-editable-code*/


public class DSView: UIView {
    
    var phoneInitial = CGRect.zero
    var phoneMid = CGRect.zero
    var phoneFinal = CGRect.zero
    
    var ticketInitial = CGRect.zero
    var ticketMid = CGRect.zero
    var ticketFinal = CGRect.zero
    
    let ticket = UIImageView(image: #imageLiteral(resourceName: "ticket.png"))
    
    var button: TicketScanButton?
    
    let title = UILabel()
    
    let phone = UIView()
    
    let flash = UIView()
    
    let app = UIImageView(image: #imageLiteral(resourceName: "digisheepPhone.png"))
    
    override public init(frame: CGRect) {
        super.init(frame: frame)
        
        /* Background image */
        let background = UIImageView(image: #imageLiteral(resourceName: "bluemoon.jpg"))
        background.frame = frame
        background.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        self.addSubview(background)
        background.contentMode = .scaleAspectFill
        
        /* Title */
        title.frame = CGRect(x: 0, y: 0, width: frame.width, height: frame.height / 2.5)
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
        attrStr.addAttributes([NSFontAttributeName : UIFont.systemFont(ofSize: 24.5)],   range: NSRange(31..<57))
        title.attributedText = attrStr
        
        
        /* Fire button */
        button = TicketScanButton(frame: CGRect(x: (frame.width - 290) / 2,
                                                y: frame.height * 2 / 3,
                                                width: 290, height: 42))
        
        
        
        /* Layout */
        let container = UIView(frame: contentFrame)
        self.addSubview(container)
        container.addSubview(title)
        container.addSubview(button!)
        
        title.translatesAutoresizingMaskIntoConstraints = false
        container.addConstraints([NSLayoutConstraint(item: title, attribute: .centerX, relatedBy: .equal, toItem: container, attribute: .centerX, multiplier: 1, constant: 0),
                                  NSLayoutConstraint(item: title, attribute: .top, relatedBy: .equal, toItem: container, attribute: .topMargin, multiplier: 1, constant: 0)])
        
        button?.translatesAutoresizingMaskIntoConstraints = false
        container.addConstraints([NSLayoutConstraint(item: button!, attribute: .centerX, relatedBy: .equal, toItem: container, attribute: .centerX, multiplier: 1, constant: 0),
                                  NSLayoutConstraint(item: button!, attribute: .centerY, relatedBy: .equal, toItem: container, attribute: .centerY, multiplier: 1, constant: 50),
                                  NSLayoutConstraint(item: button!, attribute: .width, relatedBy: .equal, toItem: nil, attribute: .width, multiplier: 1, constant: 290),
                                  NSLayoutConstraint(item: button!, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .height, multiplier: 1, constant: 42)])
        
        container.translatesAutoresizingMaskIntoConstraints = false
        self.addConstraints([NSLayoutConstraint(item: container, attribute: .centerX, relatedBy: .equal, toItem: self, attribute: .centerX, multiplier: 1, constant: 0),
                                 NSLayoutConstraint(item: container, attribute: .centerY, relatedBy: .equal, toItem: self, attribute: .centerY, multiplier: 1, constant: 0),
                                 NSLayoutConstraint(item: container, attribute: .width, relatedBy: .equal, toItem: nil, attribute: .width, multiplier: 1, constant: 400),
                                 NSLayoutConstraint(item: container, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .height, multiplier: 1, constant: 430)])
        
        
        /* Ticket to be scanned */
        self.addSubview(ticket)
        ticket.layer.shadowColor = UIColor.black.cgColor
        ticket.layer.shadowRadius = 5
        ticket.layer.shadowOpacity = 1
        ticket.layer.shadowOffset = CGSize(width: 0, height: 0)
        
        /* Scanning Phone */
        self.addSubview(phone)
        
        /* Flashing Phone Screen */
        flash.backgroundColor = .clear
        phone.addSubview(flash)
        
        /* Whole Phone */
        phone.addSubview(app)
        
        /* Set up animations */
        button?.phone  = phone
        button?.ticket = ticket
        button?.flash  = flash
        
        button?.animationSpeed = animationsSpeed
        button?.phoneDamping = phoneDamping
        button?.phoneVelocity = phoneVelocity
        
        placePhone()
    }
    
    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override public func layoutSubviews() {
        super.layoutSubviews()
        
        placePhone()
    }
    
    public func placePhone() {
        
        /* Variables */
        phoneInitial = CGRect(origin: CGPoint(x: -phoneSize.height,
                                              y: frame.height + phoneSize.width),
                              size: phoneSize)
        phoneMid = CGRect(origin: CGPoint(x: (frame.width - phoneSize.width) / 2,
                                          y: frame.height - phoneSize.height + 50),
                          size: phoneSize)
        phoneFinal = CGRect(origin: CGPoint(x: frame.width + phoneSize.height,
                                            y: frame.height + phoneSize.width),
                            size: phoneSize)
        
        ticketInitial = CGRect(origin: CGPoint(x: frame.width * 2.5,
                                               y: phoneMid.origin.y + (phoneMid.height / 3)),
                               size: ticketSize)
        ticketMid = CGRect(origin: CGPoint(x: phoneMid.origin.x + (phoneMid.width / 4.5),
                                           y: ticketInitial.origin.y),
                           size: ticketSize)
        ticketFinal = CGRect(origin: CGPoint(x: -ticketInitial.origin.x,
                                             y: ticketInitial.origin.y),
                             size: ticketSize)
        
        /* Apply computations */
        phone.transform = .identity
        phone.frame = phoneInitial
        
        flash.frame = UIEdgeInsetsInsetRect(phone.bounds,
                                            UIEdgeInsets(top: 30,
                                                         left: 10,
                                                         bottom: 30,
                                                         right: 10))
        
        app.frame = phone.bounds
        
        ticket.frame = ticketInitial
        
        button?.ticketInitial = ticketInitial
        button?.ticketMid = ticketMid
        button?.ticketFinal = ticketFinal
        
        button?.phoneInitial = phoneInitial
        button?.phoneMid = phoneMid
        button?.phoneFinal = phoneFinal
    }
    
    public func showContent() {
        
        button?.alpha = 0
        title.alpha = 0
        UIView.animate(withDuration: 1.5 * animationsSpeed, delay: 0.5, options: [], animations: {
            self.title.alpha = 1
            self.title.frame.origin.y += 10
            self.button?.alpha = 1
        }, completion: nil)
    }
    
}

/* Main View */
let mainView = DSView(frame: contentFrame)
PlaygroundPage.current.liveView = mainView

mainView.showContent()

//#-end-hidden-code
//: [Next](@next)
