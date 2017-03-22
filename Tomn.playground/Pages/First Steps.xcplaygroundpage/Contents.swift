//: [Previous](@previous)
/*:
 - callout(Let's Take a Look at My Projects): Here is a look at my first projects using Apple technologies
 */

//#-hidden-code
import UIKit
import PlaygroundSupport

//#-end-hidden-code
//: View parameters
let backgroundImage = /*#-editable-code Select a Background Image*/#imageLiteral(resourceName: "greyBackground.png")/*#-end-editable-code*/

let titleColor = /*#-editable-code Select Title Color*/#colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1)/*#-end-editable-code*/

let textColor = /*#-editable-code Select Text Color*/#colorLiteral(red: 0.501960814, green: 0.501960814, blue: 0.501960814, alpha: 1)/*#-end-editable-code*/

let stackViewAxis: UILayoutConstraintAxis = /*#-editable-code Change Stack View Axis*/.vertical/*#-end-editable-code*/

//: If you are on an iPad, tilt your device to give a tvOS-parallax-focus style to the images

/// Rotation
let tiltFact: CGFloat = /*#-editable-code */0.5/*#-end-editable-code*/

/// Shadow position
let shadowFact: CGFloat = /*#-editable-code */15/*#-end-editable-code*/

/// Rotation
let panFact: CGFloat = /*#-editable-code */20/*#-end-editable-code*/
//#-editable-code

//#-end-editable-code
//#-hidden-code

let view = UIView(frame: CGRect(x: 0, y: 0, width: 450, height: 600))
view.backgroundColor = UIColor(patternImage: backgroundImage)
PlaygroundPage.current.liveView = view

let letterpress = [NSTextEffectAttributeName : NSTextEffectLetterpressStyle]

let title = UILabel()
title.textColor = titleColor
title.font = UIFont.boldSystemFont(ofSize: stackViewAxis == .vertical ? 35 : 25)
title.numberOfLines = 0
title.adjustsFontSizeToFitWidth = true
title.textAlignment = .center
title.text = "A Look at My Projects"
title.attributedText = NSAttributedString(string: "A Look at My Projects",
                                          attributes: letterpress)
title.addConstraints([NSLayoutConstraint(item: title,
                                              attribute: .height,
                                              relatedBy: .equal,
                                              toItem: nil,
                                              attribute: .height,
                                              multiplier: 1,
                                              constant: 42)])

let uSurfImage = UIImageView(image: #imageLiteral(resourceName: "usurf.png"))
uSurfImage.frame = CGRect(x: 0, y: 0, width: 180, height: 181)
uSurfImage.contentMode = .scaleAspectFit
uSurfImage.layer.shadowOpacity = 0.65
uSurfImage.layer.shadowOffset = CGSize(width: 0, height: 0)
uSurfImage.layer.shadowRadius = 12
uSurfImage.addConstraints([NSLayoutConstraint(item: uSurfImage,
                                              attribute: .width,
                                              relatedBy: .equal,
                                              toItem: nil,
                                              attribute: .width,
                                              multiplier: 1,
                                              constant: 180),
                           NSLayoutConstraint(item: uSurfImage,
                                              attribute: .height,
                                              relatedBy: .equal,
                                              toItem: nil,
                                              attribute: .height,
                                              multiplier: 1,
                                              constant: 181)])
let uSurfTitle = UILabel()
uSurfTitle.textColor = textColor
uSurfTitle.numberOfLines = 0
uSurfTitle.textAlignment = .center
let uSurfAttrStr = NSMutableAttributedString(string: "uSurf\n\nCreated a WebKit browser at 12 years old.\nMy 1st contact with Apple technologies.")
uSurfAttrStr.addAttribute(NSFontAttributeName,
                          value: UIFont.boldSystemFont(ofSize: 28),
                          range: NSRange(0..<5))
uSurfTitle.attributedText = uSurfAttrStr

let uSurfStack = UIStackView(arrangedSubviews: [uSurfImage, uSurfTitle])
uSurfStack.axis = stackViewAxis == .vertical ? .horizontal : .vertical
uSurfStack.spacing = 10


let musicTweetImage = UIImageView(image: #imageLiteral(resourceName: "musictweet.png"))
musicTweetImage.contentMode = .scaleAspectFit
musicTweetImage.layer.shadowOpacity = 0.65
musicTweetImage.layer.shadowOffset = CGSize(width: 0, height: 0)
musicTweetImage.layer.shadowRadius = 12
musicTweetImage.addConstraints([NSLayoutConstraint(item: musicTweetImage,
                                              attribute: .width,
                                              relatedBy: .equal,
                                              toItem: nil,
                                              attribute: .width,
                                              multiplier: 1,
                                              constant: 180),
                           NSLayoutConstraint(item: musicTweetImage,
                                              attribute: .height,
                                              relatedBy: .equal,
                                              toItem: nil,
                                              attribute: .height,
                                              multiplier: 1,
                                              constant: 180)])
let musicTweetTitle = UILabel()
musicTweetTitle.textColor = textColor
musicTweetTitle.numberOfLines = 0
musicTweetTitle.textAlignment = .center
let musicTweetAttrStr = NSMutableAttributedString(string: "Music Tweet\n\nMy very 1st iOS app in 2013")
musicTweetAttrStr.addAttribute(NSFontAttributeName,
                          value: UIFont.boldSystemFont(ofSize: 28),
                          range: NSRange(0..<11))
musicTweetTitle.attributedText = musicTweetAttrStr

let musicTweetStack = UIStackView(arrangedSubviews: [musicTweetTitle, musicTweetImage])
musicTweetStack.axis = stackViewAxis == .vertical ? .horizontal : .vertical
musicTweetStack.spacing = 10


let vStack = UIStackView(arrangedSubviews: [title, uSurfStack, musicTweetStack])
vStack.axis = stackViewAxis
vStack.distribution = .fillProportionally
vStack.spacing = stackViewAxis == .vertical ? 50 : 10
let insets: CGFloat = stackViewAxis == .vertical ? 30 : 25
vStack.frame = UIEdgeInsetsInsetRect(view.frame, UIEdgeInsets(top: insets, left: insets, bottom: insets, right: insets))
view.addSubview(vStack)

uSurfImage.setUpParallax(tiltFact: tiltFact, shadowFact: shadowFact, panFact: panFact)
musicTweetImage.setUpParallax(tiltFact: tiltFact, shadowFact: shadowFact, panFact: panFact)

//#-end-hidden-code

//: [Next](@next)
