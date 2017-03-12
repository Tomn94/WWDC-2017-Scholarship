//: Playground - noun: a place where I like to prototype my new iOS/macOS/watchOS/tvOS apps

//#-hidden-code
import UIKit
import PlaygroundSupport
//#-end-hidden-code

/// Modify the size of the avatar
let avatarSize: CGFloat = /*#-editable-code Modify the size of the avatar*/200/*#-end-editable-code*/

/// Choose the avatar border color
let avatarBorderColor = /*#-editable-code Choose the avatar border color*/#colorLiteral(red: 1, green: 1, blue: 1, alpha: 0.6)/*#-end-editable-code*/

/// Edit the avatar border size
let avatarBorderSize: CGFloat = /*#-editable-code Edit the avatar border size*/1/*#-end-editable-code*/

/// Choose the gradient colors of the background
let backgroundColors = [/*#-editable-code Choose the gradient colors of the background*/#colorLiteral(red: 1, green: 0.2039215686, blue: 0.1921568627, alpha: 1).cgColor, #colorLiteral(red: 1, green: 0.7411764706, blue: 0.2549019608, alpha: 1).cgColor, #colorLiteral(red: 0.5607843137, green: 0.7960784314, blue: 0.2470588235, alpha: 1).cgColor, #colorLiteral(red: 0, green: 0.8980392157, blue: 1, alpha: 1).cgColor, #colorLiteral(red: 0.1960784314, green: 0.4666666667, blue: 1, alpha: 1).cgColor, #colorLiteral(red: 0.9843137255, green: 0.4039215686, blue: 1, alpha: 1).cgColor, #colorLiteral(red: 1, green: 0.2039215686, blue: 0.1921568627, alpha: 1).cgColor/*#-end-editable-code*/]

/// Accelerate the color rotation
let backgroundAnimationSpeed: CFTimeInterval = /*#-editable-code */20/*#-end-editable-code*/

/// Adjust the rotating speed of the avatar after releasing your finger
let rotatingInertiaFactor: CGFloat = /*#-editable-code Adjust the rotating speed of the avatar after releasing your finger*/1/*#-end-editable-code*/

//#-hidden-code

/// View supporting a drag gesture, to rotate the same or another view
class RotatingResponder: UIView {
    
    /// View to be rotated
    var rotatingView: UIView?
    /// Previous rotation angle
    var rotationY: CGFloat = 0
    
    /// Rotate `rotatingView`
    ///
    /// - Parameter recognizer: According to a pan gesture
    func rotate(recognizer: UIPanGestureRecognizer) {
        
        if let avatarView = rotatingView {
            /* Convert finger translation into rotation */
            let translation = recognizer.translation(in: self)
            let range = translation.x / (avatarSize * 0.8)
            rotationY += range * CGFloat.pi
            
            /* Apply rotation and reset gesture recognizer */
            avatarView.layer.transform = CATransform3DMakeRotation(rotationY, 0, 1, 0)
            recognizer.setTranslation(CGPoint.zero, in: self)
            
            /* Animate some kind of inertia */
            if recognizer.state == .ended {
                let velocity = recognizer.velocity(in: self)
                let speedRange = velocity.x / (avatarSize * 0.8) * rotatingInertiaFactor
                
                let animation = CABasicAnimation(keyPath: "transform.rotation.y")
                animation.fromValue = rotationY
                animation.toValue = CGFloat.pi * speedRange
                animation.duration = 5
                animation.timingFunction = CAMediaTimingFunction(controlPoints: 0, 0, 0.2, 1)
                animation.fillMode = kCAFillModeBoth
                animation.isRemovedOnCompletion = false
                animation.isCumulative = true
                avatarView.layer.add(animation, forKey: "animateRotation")
            }
        }
    }
    
}

/// Main View
let view = RotatingResponder(frame: CGRect(x: 0, y: 0, width: 500, height: 500))
/// Gradient background of the main view
let background = UIView(frame: view.bounds)

//: ## Configure gradient layer
/// Configure gradient layer of the background
let gradientLayer = CAGradientLayer()
gradientLayer.frame = background.bounds
gradientLayer.anchorPoint = CGPoint.zero
gradientLayer.frame.size.width  *= 7
gradientLayer.frame.size.height *= 5
gradientLayer.startPoint = CGPoint.zero
gradientLayer.endPoint = CGPoint(x: 1, y: 1)
gradientLayer.colors = backgroundColors
background.layer.addSublayer(gradientLayer)

//: ## Animate gradient
let gradientSize = gradientLayer.frame.size
let backgroundSize = background.frame.size
let animation = CABasicAnimation(keyPath: "position")
animation.fromValue = CGPoint.zero
animation.toValue = CGPoint(x: -gradientSize.width  + backgroundSize.width,
                            y: -gradientSize.height + backgroundSize.height)
animation.repeatCount = Float.greatestFiniteMagnitude
animation.duration = backgroundAnimationSpeed
animation.autoreverses = true
animation.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseInEaseOut)
background.layer.add(animation, forKey: "animateGradient")
view.addSubview(background)

//: ## Add avatar
/// Avatar border size
let borderOffset = avatarSize * 0.06 * avatarBorderSize
/// Avatar inner size, inside the borders
let avatarSubSize = avatarSize - borderOffset

/// Avatar image view
let avatar = UIImageView(image: #imageLiteral(resourceName: "avatar.jpg"))
avatar.layer.cornerRadius = avatarSubSize / 2
avatar.clipsToBounds = true
avatar.translatesAutoresizingMaskIntoConstraints = false
avatar.addConstraints([NSLayoutConstraint(item: avatar,
                                          attribute: .width,
                                          relatedBy: .equal,
                                          toItem: nil,
                                          attribute: .width,
                                          multiplier: 1,
                                          constant: avatarSubSize),
                       NSLayoutConstraint(item: avatar,
                                          attribute: .height,
                                          relatedBy: .equal,
                                          toItem: nil,
                                          attribute: .height,
                                          multiplier: 1,
                                          constant: avatarSubSize)])

/// Avatar border view
let avatarBack = UIView()
avatarBack.backgroundColor = avatarBorderColor
avatarBack.layer.cornerRadius = avatarSize / 2
avatarBack.clipsToBounds = true
avatarBack.translatesAutoresizingMaskIntoConstraints = false
avatarBack.addConstraints([NSLayoutConstraint(item: avatarBack,
                                              attribute: .width,
                                              relatedBy: .equal,
                                              toItem: nil,
                                              attribute: .width,
                                              multiplier: 1,
                                              constant: avatarSize),
                           NSLayoutConstraint(item: avatarBack,
                                              attribute: .height,
                                              relatedBy: .equal,
                                              toItem: nil,
                                              attribute: .height,
                                              multiplier: 1,
                                              constant: avatarSize)])

/// Avatar main view: the image + the borders
let avatarView = UIView()
avatarView.addSubview(avatarBack)
avatarView.addSubview(avatar)
avatarView.translatesAutoresizingMaskIntoConstraints = false
avatarView.addConstraints([NSLayoutConstraint(item: avatarBack,
                                              attribute: .centerX,
                                              relatedBy: .equal,
                                              toItem: avatarView,
                                              attribute: .centerX,
                                              multiplier: 1,
                                              constant: 0),
                           NSLayoutConstraint(item: avatarBack,
                                              attribute: .centerY,
                                              relatedBy: .equal,
                                              toItem: avatarView,
                                              attribute: .centerY,
                                              multiplier: 1,
                                              constant: 0),
                           NSLayoutConstraint(item: avatar,
                                              attribute: .centerX,
                                              relatedBy: .equal,
                                              toItem: avatarView,
                                              attribute: .centerX,
                                              multiplier: 1,
                                              constant: 0),
                           NSLayoutConstraint(item: avatar,
                                              attribute: .centerY,
                                              relatedBy: .equal,
                                              toItem: avatarView,
                                              attribute: .centerY,
                                              multiplier: 1,
                                              constant: 0)])

//: ## Add title
let title = UILabel()
title.text = "Thomas Naudet"
title.textColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
title.textAlignment = .center
title.font = UIFont.boldSystemFont(ofSize: 40)
title.layer.opacity = 0.8

//: ## Add subtitle
let subtitle = UILabel()
subtitle.text = "Engineering Student 👨🏼‍🎓\nApple & Web Developer"
subtitle.textColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
subtitle.textAlignment = .center
subtitle.numberOfLines = 2
subtitle.font = UIFont.systemFont(ofSize: 22)
subtitle.layer.opacity = 0.75

/// Main layout
let verticalStack = UIStackView(arrangedSubviews: [avatarView, title, subtitle])
verticalStack.axis = .vertical
verticalStack.alignment = .center
verticalStack.spacing = 15
verticalStack.translatesAutoresizingMaskIntoConstraints = false

view.addSubview(verticalStack)
view.addConstraints([NSLayoutConstraint(item: verticalStack,
                                        attribute: .width,
                                        relatedBy: .equal,
                                        toItem: view,
                                        attribute: .width,
                                        multiplier: 1,
                                        constant: 0),
                     NSLayoutConstraint(item: verticalStack,
                                        attribute: .height,
                                        relatedBy: .equal,
                                        toItem: view,
                                        attribute: .height,
                                        multiplier: 0.7,
                                        constant: 0),
                     NSLayoutConstraint(item: verticalStack,
                                        attribute: .centerY,
                                        relatedBy: .equal,
                                        toItem: view,
                                        attribute: .centerY,
                                        multiplier: 1,
                                        constant: 0),
                     NSLayoutConstraint(item: verticalStack,
                                        attribute: .leading,
                                        relatedBy: .equal,
                                        toItem: view,
                                        attribute: .leading,
                                        multiplier: 1,
                                        constant: 0)])


/// Rotation gesture recognizer
let pan = UIPanGestureRecognizer(target: view, action: #selector(view.rotate(recognizer:)))
pan.cancelsTouchesInView = true
view.rotatingView = avatarView
view.addGestureRecognizer(pan)
view.isUserInteractionEnabled = true

PlaygroundPage.current.liveView = view
//#-end-hidden-code

//: [Next](@next)
