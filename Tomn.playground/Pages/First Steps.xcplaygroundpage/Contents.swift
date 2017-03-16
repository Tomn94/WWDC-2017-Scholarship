//: [Previous](@previous)

import UIKit
import PlaygroundSupport

let view = UIView(frame: CGRect(x: 0, y: 0, width: 450, height: 600))
PlaygroundPage.current.liveView = view

let title = UILabel()
title.text = "A Look at My Projects"
title.textColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
title.textAlignment = .center

let uSurfImage = UIImageView(image: #imageLiteral(resourceName: "usurf.jpg"))
uSurfImage.frame = CGRect(x: 0, y: 0, width: 180, height: 181)
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
uSurfTitle.text = "A Look at My Projects"
uSurfTitle.textColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
uSurfTitle.textAlignment = .center

let uSurfStack = UIStackView(arrangedSubviews: [uSurfImage, uSurfTitle])


let musicTweetImage = UIImageView(image: #imageLiteral(resourceName: "musictweet.png"))
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
musicTweetTitle.text = "A Look at My Projects"
musicTweetTitle.textColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
musicTweetTitle.textAlignment = .center

let musicTweetStack = UIStackView(arrangedSubviews: [musicTweetTitle, musicTweetImage])


let vStack = UIStackView(arrangedSubviews: [title, uSurfStack, musicTweetStack])
vStack.axis = .vertical
vStack.distribution = .equalCentering
vStack.frame = UIEdgeInsetsInsetRect(view.frame, UIEdgeInsets(top: 30, left: 30, bottom: 30, right: 30))
view.addSubview(vStack)

//: [Next](@next)
