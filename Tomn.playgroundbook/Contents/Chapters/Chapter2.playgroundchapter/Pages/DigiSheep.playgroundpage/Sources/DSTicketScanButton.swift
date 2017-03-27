import UIKit

/// Button launching Phone animation
public class DSTicketScanButton: UIButton {
    
    /// Phone view to animate position/transformation
    public var phone: UIView!
    /// Flash view to animate opacity
    public var flash: UIView!
    /// Ticket view to animate position
    public var ticket: UIView!
    
    /* Animation states for Phone */
    public var phoneInitial: CGRect!
    public var phoneMid: CGRect!
    public var phoneFinal: CGRect!
    
    /* Animation states for Ticket */
    public var ticketInitial: CGRect!
    public var ticketMid: CGRect!
    public var ticketFinal: CGRect!
    
    /// Whole animation speed
    public var animationSpeed = 2.0
    /// Spring effect factor on Phone
    public var phoneDamping: CGFloat = 0.6
    /// Spring effect initial velocity on Phone
    public var phoneVelocity: CGFloat = 6
    
    public override init(frame: CGRect) {
        super.init(frame: frame)
        
        /* Basic appearance */
        backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 0.8955747003)
        setTitle("Press to Scan a Ticket", for: .normal)
        setTitleColor(#colorLiteral(red: 1, green: 0.2039215686, blue: 0.1921568627, alpha: 1), for: .normal)
        titleLabel?.font = UIFont.boldSystemFont(ofSize: 25)
        layer.cornerRadius = 21
        clipsToBounds = true
        
        /* Fire animation on touch */
        addTarget(nil, action: #selector(DSTicketScanButton.scanTicket), for: .touchUpInside)
    }
    
    public required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    /// Animates the associated Ticket, Phone & its Flash
    func scanTicket() {
        
        /* Apply Initial state */
        ticket.frame = ticketInitial
        phone.frame  = phoneInitial
        phone.transform = CGAffineTransform(rotationAngle: -CGFloat.pi / 2)
        
        let animationSpeed = TimeInterval(self.animationSpeed)
        
        // Animations in cascade instead of keyframes for better control
        UIView.animate(withDuration: 0.2 * animationSpeed,
                       delay: 0, animations: {
                        
                        /* 1) Hide button */
                        self.alpha = 0
        }, completion: { _ in
            
            UIView.animate(withDuration: 1.5 * animationSpeed,
                           delay: 0.1 * animationSpeed,
                           usingSpringWithDamping: self.phoneDamping,
                           initialSpringVelocity: self.phoneVelocity,
                           options: [],
                           animations: {
                            
                            /* 2) Show Phone in the center of the screen */
                            self.phone.transform = CGAffineTransform(rotationAngle: 0)
                            self.phone.frame = self.phoneMid
            }, completion: { _ in
                
                UIView.animate(withDuration: 0.5 * animationSpeed,
                               delay: 0, options: .curveEaseOut, animations: {
                                
                                /* 3) Show Ticket under Phone scanner */
                                self.ticket.frame = self.ticketMid
                }, completion: { _ in
                    
                    UIView.animate(withDuration: 0.1 * animationSpeed,
                                   delay: 0.2 * animationSpeed, options: .curveEaseIn, animations: {
                                    
                                    /* 4) Scan Ticket */
                                    self.flash.backgroundColor = .white
                    }, completion: { _ in
                        
                        UIView.animate(withDuration: 0.1 * animationSpeed,
                                       delay: 0, options: .curveEaseOut, animations: {
                                        
                                        /* 5) Stop ticket scanning (flash) */
                                        self.flash.backgroundColor = .clear
                        }, completion: { _ in
                            
                            UIView.animate(withDuration: 0.5 * animationSpeed,
                                           delay: 0.7 * animationSpeed,
                                           options: .curveEaseIn,
                                           animations: {
                                            
                                            /* 6) Apply Final state */
                                            self.ticket.frame = self.ticketFinal
                                            self.phone.transform = CGAffineTransform(rotationAngle: CGFloat.pi * 2 / 3)
                                            self.phone.frame = self.phoneFinal
                            }, completion: { _ in
                                
                                UIView.animate(withDuration: 0.2 * animationSpeed,
                                               delay: 0.5 * animationSpeed, animations: {
                                                
                                                /* 7) Bring the button back */
                                                self.alpha = 1
                                })
                            })
                        })
                    })
                })
            })
        })
    }
    
}
