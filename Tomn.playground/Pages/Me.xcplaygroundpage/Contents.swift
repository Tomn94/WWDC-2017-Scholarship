//: Playground - noun: a place where people can play

import UIKit
import PlaygroundSupport

let view = UIView(frame: CGRect(x: 0, y: 0, width: 500, height: 500))
let background = UIView(frame: view.bounds)


//: ## Configure gradient layer
let gradientLayer = CAGradientLayer()
gradientLayer.frame = background.bounds
gradientLayer.anchorPoint = CGPoint.zero
gradientLayer.frame.size.width  *= 7
gradientLayer.frame.size.height *= 5
gradientLayer.startPoint = CGPoint.zero
gradientLayer.endPoint = CGPoint(x: 1, y: 1)
gradientLayer.colors = [#colorLiteral(red: 1, green: 0.2039215686, blue: 0.1921568627, alpha: 1).cgColor, #colorLiteral(red: 1, green: 0.7411764706, blue: 0.2549019608, alpha: 1).cgColor, #colorLiteral(red: 0.5607843137, green: 0.7960784314, blue: 0.2470588235, alpha: 1).cgColor, #colorLiteral(red: 0, green: 0.8980392157, blue: 1, alpha: 1).cgColor, #colorLiteral(red: 0.1960784314, green: 0.4666666667, blue: 1, alpha: 1).cgColor, #colorLiteral(red: 0.9843137255, green: 0.4039215686, blue: 1, alpha: 1).cgColor, #colorLiteral(red: 1, green: 0.2039215686, blue: 0.1921568627, alpha: 1).cgColor]
background.layer.addSublayer(gradientLayer)

//: ## Animate gradient
let gradientSize = gradientLayer.frame.size
let backgroundSize = background.frame.size
let animation = CABasicAnimation(keyPath: "position")
animation.fromValue = CGPoint.zero
animation.toValue = CGPoint(x: -gradientSize.width  + backgroundSize.width,
                            y: -gradientSize.height + backgroundSize.height)
animation.repeatCount = Float.greatestFiniteMagnitude
animation.duration = 30
animation.autoreverses = true
animation.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseInEaseOut)
background.layer.add(animation, forKey: "animateGradient")
view.addSubview(background)

//: ## Add avatar
let avatarSize: CGFloat = 200
let borderOffset = avatarSize * 0.06
let avatarSubSize = avatarSize - borderOffset

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

let avatarBack = UIView()
avatarBack.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
avatarBack.layer.opacity = 0.8
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
title.font = UIFont.boldSystemFont(ofSize: 35.3)
title.layer.opacity = 0.8

//: ## Add subtitle
let subtitle = UILabel()
subtitle.text = "Student 👨🏼‍🎓 iOS Developer"
subtitle.textColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
subtitle.textAlignment = .center
subtitle.font = UIFont.systemFont(ofSize: 22)
subtitle.layer.opacity = 0.7

let verticalStack = UIStackView(arrangedSubviews: [avatarView, title, subtitle])
verticalStack.axis = .vertical
verticalStack.alignment = .center
verticalStack.spacing = 6
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
                                        multiplier: 0.6,
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

PlaygroundPage.current.liveView = view
