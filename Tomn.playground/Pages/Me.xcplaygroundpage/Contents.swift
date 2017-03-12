//: Playground - noun: a place where people can play

import UIKit
import PlaygroundSupport

let background = UIView(frame: CGRect(x: 0, y: 0, width: 500, height: 500))

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


PlaygroundPage.current.liveView = background
