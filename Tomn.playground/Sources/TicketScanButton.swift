import UIKit

public class TicketScanButton: UIButton {
    
    public var flash: UIView!
    public var ticket: UIView!
    public var phone: UIView!
    
    public var phoneInitial: CGRect!
    public var phoneMid: CGRect!
    public var phoneFinal: CGRect!
    
    public var ticketInitial: CGRect!
    public var ticketMid: CGRect!
    public var ticketFinal: CGRect!
    
    public var animationSpeed = 2.0
    public var phoneDamping: CGFloat = 0.6
    public var phoneVelocity: CGFloat = 6
    
    public override init(frame: CGRect) {
        super.init(frame: frame)
        
        backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 0.8955747003)
        setTitle("Press to Scan a Ticket", for: .normal)
        setTitleColor(#colorLiteral(red: 1, green: 0.2039215686, blue: 0.1921568627, alpha: 1), for: .normal)
        titleLabel?.font = UIFont.boldSystemFont(ofSize: 25)
        layer.cornerRadius = 21
        clipsToBounds = true
        
        addTarget(nil, action: #selector(TicketScanButton.scanTicket), for: .touchUpInside)
    }
    
    public required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func scanTicket() {
        
        ticket.frame = self.ticketInitial
        phone.frame = self.phoneInitial
        phone.transform = CGAffineTransform(rotationAngle: -CGFloat.pi / 2)
        
        let animationSpeed = TimeInterval(self.animationSpeed)
        
        UIView.animate(withDuration: 0.2 * animationSpeed,
                       delay: 0, animations: {
                        self.layer.opacity = 0
        }, completion: { _ in
            
            UIView.animate(withDuration: 1.5 * animationSpeed,
                           delay: 0.1 * animationSpeed,
                           usingSpringWithDamping: self.phoneDamping,
                           initialSpringVelocity: self.phoneVelocity,
                           options: [],
                           animations: {
                            self.phone.transform = CGAffineTransform(rotationAngle: 0)
                            self.phone.frame = self.phoneMid
            }, completion: { _ in
                
                UIView.animate(withDuration: 0.5 * animationSpeed,
                               delay: 0, options: .curveEaseOut, animations: {
                                self.ticket.frame = self.ticketMid
                }, completion: { _ in
                    
                    UIView.animate(withDuration: 0.1 * animationSpeed,
                                   delay: 0.2 * animationSpeed, options: .curveEaseIn, animations: {
                                    self.flash.backgroundColor = .white
                    }, completion: { _ in
                        
                        UIView.animate(withDuration: 0.1 * animationSpeed,
                                       delay: 0, options: .curveEaseOut, animations: {
                                        self.flash.backgroundColor = .clear
                        }, completion: { _ in
                            
                            UIView.animate(withDuration: 0.5 * animationSpeed,
                                           delay: 0.7 * animationSpeed,
                                           options: .curveEaseIn,
                                           animations: {
                                            self.ticket.frame = self.ticketFinal
                                            self.phone.transform = CGAffineTransform(rotationAngle: CGFloat.pi * 2 / 3)
                                            self.phone.frame = self.phoneFinal
                            }, completion: { _ in
                                
                                UIView.animate(withDuration: 0.2 * animationSpeed,
                                               delay: 0.5 * animationSpeed, animations: {
                                                self.layer.opacity = 1
                                })
                            })
                        })
                    })
                })
            })
        })
    }
    
}
