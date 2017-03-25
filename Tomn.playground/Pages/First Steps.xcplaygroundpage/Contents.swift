//: [Previous](@previous)
/*:
 - callout(Let's Take a Look at My Projects): Here is a look at my **first projects using Apple technologies**
 */
//#-hidden-code
import UIKit
import PlaygroundSupport

//#-end-hidden-code

//: ### View parameters
/// Select an image as a background patern
let backgroundImage = /*#-editable-code Select a Background Image*/#imageLiteral(resourceName: "greyBackground.png")/*#-end-editable-code*/

/// Main title font color
let titleColor = /*#-editable-code Select Title Color*/#colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1)/*#-end-editable-code*/

/// Text font color
let textColor  = /*#-editable-code Select Text Color*/#colorLiteral(red: 0.501960814, green: 0.501960814, blue: 0.501960814, alpha: 1)/*#-end-editable-code*/

/// Change Stack View Axis
let stackViewAxis: UILayoutConstraintAxis = /*#-editable-code Change Stack View Axis*/.vertical/*#-end-editable-code*/

/*:
 - Note: If you are on an iPad, tilt your device to give a tvOS-parallax-focused style to the images
 */
/// Position
let panFact:    CGFloat = /*#-editable-code Position factor when titled*/20/*#-end-editable-code*/

/// Rotation
let tiltFact:   CGFloat = /*#-editable-code Rotation factor when titled*/0.55/*#-end-editable-code*/

/// Shadow offset
let shadowFact: CGFloat = /*#-editable-code Shadow position factor when titled*/15/*#-end-editable-code*/
//#-hidden-code


/// Main View
let view = UIView(frame: CGRect(x: 0, y: 0, width: 450, height: 600))
view.backgroundColor = UIColor(patternImage: backgroundImage)
PlaygroundPage.current.liveView = view


/// Main Title
let title = UILabel()
title.textColor = titleColor
title.font = UIFont.boldSystemFont(ofSize: stackViewAxis == .vertical ? 35 : 25)
title.numberOfLines = 0
title.adjustsFontSizeToFitWidth = true
title.textAlignment = .center
title.text = "A Look at My Projects"
title.attributedText = NSAttributedString(string: "A Look at My Projects",
                                          attributes: [NSTextEffectAttributeName : NSTextEffectLetterpressStyle])
title.addConstraints([NSLayoutConstraint(item: title,
                                              attribute: .height,
                                              relatedBy: .equal,
                                              toItem: nil,
                                              attribute: .height,
                                              multiplier: 1,
                                              constant: 42)])


/* uSurf */
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

/// uSurf Layout
let uSurfStack = UIStackView(arrangedSubviews: [uSurfImage, uSurfTitle])
uSurfStack.axis = stackViewAxis == .vertical ? .horizontal : .vertical
uSurfStack.spacing = 10


/* Music Tweet */
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

/// Music Tweet Layout
let musicTweetStack = UIStackView(arrangedSubviews: [musicTweetTitle, musicTweetImage])
musicTweetStack.axis = stackViewAxis == .vertical ? .horizontal : .vertical
musicTweetStack.spacing = 10


/// Main Layout
let vStack = UIStackView(arrangedSubviews: [title, uSurfStack, musicTweetStack])
vStack.axis = stackViewAxis
vStack.distribution = .fillProportionally
vStack.spacing = stackViewAxis == .vertical ? 50 : 10
let insets: CGFloat = stackViewAxis == .vertical ? 30 : 25
vStack.frame = UIEdgeInsetsInsetRect(view.frame, UIEdgeInsets(top: insets, left: insets, bottom: insets, right: insets))
vStack.autoresizingMask = [.flexibleWidth, .flexibleHeight]
view.addSubview(vStack)


/* Parallax configuration */
uSurfImage.setUpParallax(tiltFact: tiltFact, shadowFact: shadowFact, panFact: panFact)
musicTweetImage.setUpParallax(tiltFact: tiltFact, shadowFact: shadowFact, panFact: panFact)

//#-end-hidden-code

//#-editable-code Free code zone

//#-end-editable-code

//: [Next](@next)
