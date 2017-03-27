//: Playground - noun: a place where I like to prototype my iOS/macOS/watchOS/tvOS apps

/*:
 - callout(Hello world): Welcome to my Swift Playground, feel free to edit my code and interact with the preview
 */
//#-hidden-code
import UIKit
import SceneKit
import AVFoundation
import PlaygroundSupport
//#-end-hidden-code

/// Modify the size of the avatar
let avatarSize: CGFloat = /*#-editable-code Modify the size of the avatar*/230/*#-end-editable-code*/

/// Choose the gradient colors of the background
let backgroundColors = [/*#-editable-code Choose the gradient colors of the background*/#colorLiteral(red: 1, green: 0.2039215686, blue: 0.1921568627, alpha: 1), #colorLiteral(red: 1, green: 0.7411764706, blue: 0.2549019608, alpha: 1), #colorLiteral(red: 0.5607843137, green: 0.7960784314, blue: 0.2470588235, alpha: 1), #colorLiteral(red: 0, green: 0.8980392157, blue: 1, alpha: 1), #colorLiteral(red: 0.1960784314, green: 0.4666666667, blue: 1, alpha: 1), #colorLiteral(red: 0.9843137255, green: 0.4039215686, blue: 1, alpha: 1), #colorLiteral(red: 1, green: 0.2039215686, blue: 0.1921568627, alpha: 1)/*#-end-editable-code*/]

/// Accelerate color rotation
let backgroundAnimationSpeed: TimeInterval = /*#-editable-code */20/*#-end-editable-code*/

/// Adjust the rotating speed of the avatar
let rotatingInertiaFactor: CGFloat = /*#-editable-code Adjust the rotating speed of the avatar after releasing your finger*/5/*#-end-editable-code*/

//#-hidden-code

//: ## Add avatar
let scene = SCNScene(named: "Avatar.scn")
let sceneView = SCNView()
sceneView.antialiasingMode = .multisampling2X
sceneView.backgroundColor = .clear
sceneView.scene = scene
sceneView.addConstraints([NSLayoutConstraint(item: sceneView,
                                             attribute: .width,
                                             relatedBy: .lessThanOrEqual,
                                             toItem: nil,
                                             attribute: .width,
                                             multiplier: 1,
                                             constant: avatarSize),
                          NSLayoutConstraint(item: sceneView,
                                             attribute: .height,
                                             relatedBy: .greaterThanOrEqual,
                                             toItem: nil,
                                             attribute: .height,
                                             multiplier: 1,
                                             constant: 70),
                          NSLayoutConstraint(item: sceneView,
                                             attribute: .width,
                                             relatedBy: .equal,
                                             toItem: sceneView,
                                             attribute: .height,
                                             multiplier: 1,
                                             constant: 0)])

/// Main View
let view = RotatingResponder(frame: CGRect(x: 0, y: 0, width: 450, height: 600))
view.avatarSize = avatarSize
view.rotatingInertiaFactor = rotatingInertiaFactor
view.node = scene?.rootNode.childNode(withName: "cylinder", recursively: false)

/// Gradient background of the main view
let background = AnimatedGradientView(frame: view.bounds,
                                      colors: backgroundColors,
                                      speed: backgroundAnimationSpeed)
view.addSubview(background)

/// Add title
let title = UILabel()
title.text = "Thomas Naudet"
title.textColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
title.textAlignment = .center
title.font = UIFont.boldSystemFont(ofSize: 40)
title.alpha = 0.7

/// Add subtitle
let subtitle = UILabel()
subtitle.text = "Engineering Student 👨🏼‍🎓\nApple & Web Developer"
subtitle.textColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
subtitle.textAlignment = .center
subtitle.numberOfLines = 2
subtitle.font = UIFont.systemFont(ofSize: 22)
subtitle.alpha = 0.6

/// Main layout
let verticalStack = UIStackView(arrangedSubviews: [sceneView, title, subtitle])
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
                                        multiplier: 0.75,
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


/// Gesture recognizer for rotation
let pan = UIPanGestureRecognizer(target: view, action: #selector(RotatingResponder.rotate(recognizer:)))
pan.cancelsTouchesInView = true
view.addGestureRecognizer(pan)
view.isUserInteractionEnabled = true

/// Background sound file URL
let music = URL(fileURLWithPath: Bundle.main.path(forResource: "Intro", ofType: "m4a")!)
/// Sound player
let audioPlayer = try AVAudioPlayer(contentsOf: music)

PlaygroundPage.current.liveView = view
//#-end-hidden-code
//: Play background music
audioPlayer.play()

//: At launch, rotates the avatar a bit, indicating it can be further spinned by the user
view.runSpinningHintAnimation()