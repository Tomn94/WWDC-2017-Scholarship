import UIKit

/// Main View for DigiSheep page
public class DSView: UIView {
    
    // MARK: Constants
    
    /// Inner frame size containing Title & Button
    public static let contentFrame = CGRect(x: 0, y: 0, width: 430, height: 304)
    
    /// Phone (app image, flash) size
    public static let phoneSize = CGSize(width: 174, height: 350)
    
    /// Ticket size
    public static let ticketSize = CGSize(width: 282, height: 100)
    
    
    // MARK: Subviews
    
    /// Animated Ticket
    let ticket = UIImageView(image: #imageLiteral(resourceName: "ticket.png"))
    
    /// Title label on top of the view
    let title = UILabel()
    
    /// Button launching Ticket & Phone animations
    var button: DSTicketScanButton?
    
    /// Animated phone container after tapping button
    let phone = UIView()
    
    /// Phone & DigiSheep app image
    let app = UIImageView(image: #imageLiteral(resourceName: "digisheepPhone.png"))
    
    /// Flashing screen of the phone
    let flash = UIView()
    
    
    // MARK: Animation variables
    
    /// Speed up animations
    public var animationsSpeed = 1.0
    
    /// Adjust Phone spring effect
    public var phoneDamping: CGFloat = 0.6
    
    /// Change Phone arriving speed
    public var phoneVelocity: CGFloat = 6
    
    // MARK: Constants
    /* Phone frames for each state during animation */
    var phoneInitial = CGRect.zero
    var phoneMid = CGRect.zero
    var phoneFinal = CGRect.zero
    
    /* Ticket frames for each state during animation */
    var ticketInitial = CGRect.zero
    var ticketMid = CGRect.zero
    var ticketFinal = CGRect.zero
    
    
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
        button = DSTicketScanButton(frame: CGRect(x: (frame.width - 290) / 2,
                                                  y: frame.height * 2 / 3,
                                                  width: 290, height: 42))
        
        /* Title & Button Layout */
        let container = UIView(frame: DSView.contentFrame)
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
                             NSLayoutConstraint(item: container, attribute: .width, relatedBy: .equal, toItem: nil, attribute: .width, multiplier: 1, constant: DSView.contentFrame.width),
                             NSLayoutConstraint(item: container, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .height, multiplier: 1, constant: DSView.contentFrame.height)])
        
        /* Ticket to be scanned */
        ticket.layer.shadowColor = UIColor.black.cgColor
        ticket.layer.shadowRadius = 5
        ticket.layer.shadowOpacity = 1
        ticket.layer.shadowOffset = CGSize(width: 0, height: 0)
        self.addSubview(ticket)
        
        /* Flashing Phone Screen */
        flash.backgroundColor = .clear
        phone.addSubview(flash)
        
        /* Phone screen */
        phone.addSubview(app)
        
        /* Scanning Phone container */
        self.addSubview(phone)
        
        /* Set up animations */
        button?.phone  = phone
        button?.ticket = ticket
        button?.flash  = flash
        
        button?.animationSpeed = animationsSpeed
        button?.phoneDamping   = phoneDamping
        button?.phoneVelocity  = phoneVelocity
        
        /* Set up layout for Phone & Ticket */
        placePhoneTicket()
    }
    
    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    /// Place views upon screen change
    override public func layoutSubviews() {
        super.layoutSubviews()
        
        placePhoneTicket()
    }
    
    /// Place Phone & Ticket according to screen size
    public func placePhoneTicket() {
        
        /* Compute variables for each animation state */
        phoneInitial = CGRect(origin: CGPoint(x: -DSView.phoneSize.height,
                                              y: frame.height + DSView.phoneSize.width),
                              size: DSView.phoneSize)
        phoneMid     = CGRect(origin: CGPoint(x: (frame.width - DSView.phoneSize.width) / 2,
                                              y: frame.height - DSView.phoneSize.height + 50),
                              size: DSView.phoneSize)
        phoneFinal   = CGRect(origin: CGPoint(x: frame.width  + DSView.phoneSize.height,
                                              y: frame.height + DSView.phoneSize.width),
                              size: DSView.phoneSize)
        
        ticketInitial = CGRect(origin: CGPoint(x: frame.width * 2.5,
                                               y: phoneMid.origin.y + (phoneMid.height / 3)),
                               size: DSView.ticketSize)
        ticketMid     = CGRect(origin: CGPoint(x: phoneMid.origin.x + (phoneMid.width / 4.5),
                                               y: ticketInitial.origin.y),
                               size: DSView.ticketSize)
        ticketFinal   = CGRect(origin: CGPoint(x: -ticketInitial.origin.x,
                                               y: ticketInitial.origin.y),
                               size: DSView.ticketSize)
        
        /* Apply computations for Initial state */
        phone.transform = .identity
        phone.frame     = phoneInitial
        app.frame       = phone.bounds
        flash.frame     = UIEdgeInsetsInsetRect(phone.bounds,
                                                UIEdgeInsets(top: 30,
                                                             left: 10,
                                                             bottom: 30,
                                                             right: 10))
        
        ticket.frame = ticketInitial
        
        /* Update computations for animation handled by button */
        button?.ticketInitial = ticketInitial
        button?.ticketMid     = ticketMid
        button?.ticketFinal   = ticketFinal
        
        button?.phoneInitial  = phoneInitial
        button?.phoneMid      = phoneMid
        button?.phoneFinal    = phoneFinal
    }
    
    /// Show Title & Button
    public func showContent() {
        
        title.alpha = 0
        button?.alpha = 0
        UIView.animate(withDuration: 1.5 * animationsSpeed, delay: 0.5, options: [], animations: {
            self.title.alpha = 1
            self.title.frame.origin.y += 10
            self.button?.alpha = 1
        })
    }
    
}
