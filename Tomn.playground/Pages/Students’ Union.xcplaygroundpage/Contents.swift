//: [Previous](@previous)
/*:
 - callout(A Look at My Projects): Then I created an app for the Students’ Union compaign. One notable feature was Students from my Engineering School had to walk around in the city to find hidden QRcodes, and scan them with the app.\
     Once elected I further developed the app with the following features:
 */

import UIKit
import PlaygroundSupport

struct Feature {
    let title: String
    let icon: UIImage
    let screenshot: UIImage
}

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
    Feature(title: "Unions News", icon: #imageLiteral(resourceName: "su-newsIcon.png"), screenshot: #imageLiteral(resourceName: "su-newsScreen.png")),
    
    Feature(title: "Upcoming Events", icon: #imageLiteral(resourceName: "su-eventsIcon.png"), screenshot: #imageLiteral(resourceName: "su-eventsScreen.png")),
    
    Feature(title: "List of the Unions", icon: #imageLiteral(resourceName: "su-clubsIcon.png"), screenshot: #imageLiteral(resourceName: "su-clubsScreen.png")),
    
    Feature(title: "Student Families", icon: #imageLiteral(resourceName: "su-familiesIcon.png"), screenshot: #imageLiteral(resourceName: "su-familiesScreen.png")),
    
    Feature(title: "Shared Documents", icon: #imageLiteral(resourceName: "su-docsIcon.png"), screenshot: #imageLiteral(resourceName: "su-docsScreen.png")),
    
    Feature(title: "Meal Ordering System, includes paying with iOS", icon: #imageLiteral(resourceName: "su-orderIcon.png"), screenshot: #imageLiteral(resourceName: "su-orderScreen.png")),
    
    Feature(title: "Push Notifications for Events and Deliveries", icon: #imageLiteral(resourceName: "su-pushIcon.png"), screenshot: #imageLiteral(resourceName: "su-pushScreen.png")),
    
    Feature(title: "Events & Tickets Ordering, includes paying with iOS", icon: #imageLiteral(resourceName: "su-ticketsIcon.png"), screenshot: #imageLiteral(resourceName: "su-ticketsScreen.png")),
    
    Feature(title: "iMessage Stickers", icon: #imageLiteral(resourceName: "su-stickersIcon.png"), screenshot: #imageLiteral(resourceName: "su-stickersScreen.png")),
    
    Feature(title: "Deals & Sponsors", icon: #imageLiteral(resourceName: "su-sponsorsIcon.png"), screenshot: #imageLiteral(resourceName: "su-sponsorsScreen.png")),
    
    Feature(title: "Buildings Plan & Rooms List", icon: #imageLiteral(resourceName: "su-roomsIcon.png"), screenshot: #imageLiteral(resourceName: "su-roomsScreen.png")),
    
    Feature(title: "User Profile & Preferences", icon: #imageLiteral(resourceName: "su-userIcon.png"), screenshot: #imageLiteral(resourceName: "su-userScreen.png"))
]

class PopoverController: UIViewController, UIPopoverPresentationControllerDelegate {
    
    convenience init(feature: Feature) {
        self.init()
        
        let description = UILabel()
        description.text = feature.title
        description.textColor = .gray
        description.numberOfLines = 0
        description.textAlignment = .center
        description.addConstraint(NSLayoutConstraint(item: description,
                                                     attribute: .height,
                                                     relatedBy: .greaterThanOrEqual,
                                                     toItem: nil,
                                                     attribute: .height,
                                                     multiplier: 1,
                                                     constant: 40))
        
        let screenshot = UIImageView(image: feature.screenshot)
        screenshot.contentMode = .scaleAspectFit
        
        let stackView = UIStackView(arrangedSubviews: [description, screenshot])
        stackView.axis = .vertical
        
        self.view = stackView
        self.modalPresentationStyle = .popover
        self.preferredContentSize = CGSize(width: 383, height: 400)
    }
    
    func adaptivePresentationStyle(for controller: UIPresentationController) -> UIModalPresentationStyle {
        return .none
    }
    
}

class PopButton: UIButton {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        addTarget(self, action: #selector(PopButton.showPopup), for: .touchUpInside)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func showPopup() {
        
        let popover = PopoverController(feature: features[0])
        
        if let popoverPresentCtrl = popover.popoverPresentationController {
            popoverPresentCtrl.sourceRect = self.frame
            popoverPresentCtrl.sourceView = view
            popoverPresentCtrl.delegate = popover
        }
        
        mainVC.present(popover, animated: true)
    }
    
}

let button = PopButton(frame: CGRect(x: 200, y: 200, width: 50, height: 50))
button.setImage(features[0].icon.withRenderingMode(.alwaysTemplate), for: .normal)
view.addSubview(button)


//: [Next](@next)
