//: [Previous](@previous)
/*:
 - callout(A Look at My Projects): Then I created an app for the Students’ Union compaign. One notable feature was Students from my Engineering School had to walk around in the city to find hidden QRcodes, and scan them with the app.\
     Once elected I further developed the app with the following features:
 */

import UIKit
import PlaygroundSupport

//: ### Main View & Background
let view = UIView(frame: CGRect(x: 0, y: 0, width: 450, height: 600))

/* Configure gradient layer of the background */
let gradientLayer = CAGradientLayer()
gradientLayer.frame = view.bounds
gradientLayer.colors = [#colorLiteral(red: 0.2274509804, green: 0.8431372549, blue: 1, alpha: 1).cgColor, #colorLiteral(red: 0.01176470588, green: 0.6549019608, blue: 1, alpha: 1).cgColor]
view.layer.addSublayer(gradientLayer)

PlaygroundPage.current.liveView = view

//: ### Title
let title = UILabel(frame: CGRect(x: 0, y: 0, width: view.frame.width, height: 60))
title.text = "ESEO Students’ Union"
title.font = UIFont.boldSystemFont(ofSize: 42)
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

//: [Next](@next)
