//: [Previous](@previous)

//#-hidden-code
import UIKit
import PlaygroundSupport

//: Parameters

var elapsedTime: TimeInterval = 0

//#-end-hidden-code

//: Text to be displayed like captions
let script = [/*#-editable-code Provide some strings*/"Subtle Subtitles",
              "A Subtitles Search Engine & Player,\nfor TV Shows & Movies",
              "Used all around the World,\nespecially in Russia 🇷🇺",
              "Helps learning a foreign langage",
              "Customizable",
              "Subtitles File Parser",
              "Supports AirDrop & iCloud Drive\n\nto transfer subtitles to friends\nor between iOS/macOS devices"/*#-end-editable-code*/]

//: Time interval between 2 script lines
let repeatTime: TimeInterval = /*#-editable-code Enter script line on-screen time*/2.5/*#-end-editable-code*/

//: Time interval between 2 updates of the slider and text
let refreshRate: TimeInterval = /*#-editable-code Change refresh rate*/0.1/*#-end-editable-code*/

//#-hidden-code
//: Resources
/// Just a standard UILabel, but with some insets
class PaddedLabel: UILabel {
    
    var padding = UIEdgeInsets.zero {
        didSet {
            invalidateIntrinsicContentSize()
        }
    }
    
    override func textRect(forBounds bounds: CGRect,
                           limitedToNumberOfLines numberOfLines: Int) -> CGRect {
        let paddedRect = UIEdgeInsetsInsetRect(bounds, padding)
        let superRect = super.textRect(forBounds: paddedRect,
                                       limitedToNumberOfLines: numberOfLines)
        let invertedInsets = UIEdgeInsets(top: -padding.top,
                                          left: -padding.left,
                                          bottom: -padding.bottom,
                                          right: -padding.right)
        return UIEdgeInsetsInsetRect(superRect, invertedInsets)
    }
    
    override func drawText(in rect: CGRect) {
        super.drawText(in: UIEdgeInsetsInsetRect(rect, padding))
    }
    
}

/// Slider used to scrub and time-travel
class ScrubSlider: UISlider {
    
    init() {
        super.init(frame: .zero)
        
        /* Default behavior */
        minimumValue = 0
        value = 0
        isContinuous = true
        maximumValue = Float(script.count)
        setThumbImage(#imageLiteral(resourceName: "thumb.png"), for: .normal)
        
        addTarget(self, action: #selector(scrub), for: .valueChanged)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    /// Reacts to touch input (scrubbing)
    func scrub() {
        elapsedTime = TimeInterval(self.value) * repeatTime
    }
    
}

/// Button controlling the player
class PlayPauseButton: UIButton {
    
    /// Timer of the player
    var timer: Timer?
    
    /// Action called at each update of the player
    var timeBlock: (() -> ())?
    
    init() {
        super.init(frame: .zero)
        
        /* Default behavior */
        setImage(#imageLiteral(resourceName: "pause.png").withRenderingMode(.alwaysTemplate), for: .normal)
        
        addTarget(self, action: #selector(playPause), for: .touchUpInside)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    /// Resume/Pause animation
    func playPause() {
        
        guard let timer = timer, let timeBlock = timeBlock else {
            return
        }
        
        if timer.isValid {
            /* Pause */
            timer.invalidate()
            setImage(#imageLiteral(resourceName: "play.png").withRenderingMode(.alwaysTemplate), for: .normal)
            
        } else {
            /* Play */
            
            if elapsedTime >= TimeInterval(script.count) {
                /* Restart if reached the end */
                elapsedTime = 0
            }
            
            self.timer = Timer.scheduledTimer(withTimeInterval: refreshRate, repeats: true) { _ in
                timeBlock()
            }
            
            setImage(#imageLiteral(resourceName: "pause.png").withRenderingMode(.alwaysTemplate), for: .normal)
        }
    }
    
}

let mainView = UIView(frame: CGRect(x: 0, y: 0, width: 500, height: 500))
//#-end-hidden-code
//: Main View parameters
//#-editable-code
mainView.backgroundColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
mainView.tintColor = #colorLiteral(red: 1, green: 0.2039215686, blue: 0.1921568627, alpha: 1)

/*#-end-editable-code*/
//#-hidden-code
let label = PaddedLabel(frame: CGRect(x: 0, y: 0, width: 100, height: 100))
label.text = ""
label.isHidden = true
label.numberOfLines = 0
//#-end-hidden-code
//: Text View parameters
//#-editable-code
label.textAlignment = .center
label.backgroundColor = #colorLiteral(red: 0.1568627451, green: 0.1764705882, blue: 0.1960784314, alpha: 1)
label.padding = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
label.layer.cornerRadius = 5

/*#-end-editable-code*/
//#-hidden-code
label.clipsToBounds = true
mainView.addSubview(label)

//: Controls
let playBtn = PlayPauseButton()
let slider = ScrubSlider()
let controls = UIStackView(arrangedSubviews: [playBtn, slider])
controls.spacing = 10
mainView.addSubview(controls)

//: Layout
let playButtonSize: CGFloat = 42
let margins: CGFloat = 10
label.translatesAutoresizingMaskIntoConstraints = false
controls.translatesAutoresizingMaskIntoConstraints = false
mainView.addConstraints([NSLayoutConstraint(item: label,
                                        attribute: .centerX,
                                        relatedBy: .equal,
                                        toItem: mainView,
                                        attribute: .centerX,
                                        multiplier: 1,
                                        constant: 0),
                     NSLayoutConstraint(item: label,
                                        attribute: .centerY,
                                        relatedBy: .equal,
                                        toItem: mainView,
                                        attribute: .centerY,
                                        multiplier: 1,
                                        constant: 0),
                     NSLayoutConstraint(item: controls,
                                        attribute: .bottom,
                                        relatedBy: .equal,
                                        toItem: mainView,
                                        attribute: .bottomMargin,
                                        multiplier: 1,
                                        constant: -margins),
                     NSLayoutConstraint(item: controls,
                                        attribute: .height,
                                        relatedBy: .equal,
                                        toItem: nil,
                                        attribute: .height,
                                        multiplier: 1,
                                        constant: 30),
                     NSLayoutConstraint(item: controls,
                                        attribute: .leading,
                                        relatedBy: .equal,
                                        toItem: mainView,
                                        attribute: .leadingMargin,
                                        multiplier: 1,
                                        constant: margins),
                     NSLayoutConstraint(item: controls,
                                        attribute: .trailing,
                                        relatedBy: .equal,
                                        toItem: mainView,
                                        attribute: .trailingMargin,
                                        multiplier: 1,
                                        constant: -margins),
                     NSLayoutConstraint(item: playBtn,
                                        attribute: .width,
                                        relatedBy: .equal,
                                        toItem: nil,
                                        attribute: .width,
                                        multiplier: 1,
                                        constant: playButtonSize),
                     NSLayoutConstraint(item: playBtn,
                                        attribute: .height,
                                        relatedBy: .equal,
                                        toItem: nil,
                                        attribute: .height,
                                        multiplier: 1,
                                        constant: playButtonSize)])

//: Time
var timer: Timer!

/// Updates text and slider when playing
///
/// - Parameters:
///   - label: Label containing text
///   - slider: Slider displaying current time
func playScript(text label: UILabel, slider: UISlider) {
    
    let index = Int(elapsedTime / repeatTime)
    if index >= script.count {
        slider.setValue(slider.maximumValue, animated: true)
        playBtn.playPause()
        return
    }
    
    let text = script[index]
    label.text = text
    
    label.textColor = .white
    if text.lowercased().contains("customizable") {
        label.textColor = slider.tintColor
        label.font = UIFont(name: "GillSans-BoldItalic", size: 42)
    } else if text.lowercased().contains("parse") {
        label.font = UIFont(name: "Courier", size: 30)
    } else {
        label.font = UIFont.systemFont(ofSize: 30)
    }
    
    label.isHidden = label.text?.isEmpty ?? false
    
    slider.setValue(Float(elapsedTime / repeatTime), animated: true)
}

/// Called at each update
var timeBlock = {
    elapsedTime += refreshRate
    playScript(text: label, slider: slider)
}

/// Launch animations
func play() {
    timer = Timer.scheduledTimer(withTimeInterval: refreshRate, repeats: true) { _ in
        timeBlock()
    }
    
    playBtn.timer = timer
    playBtn.timeBlock = timeBlock
    
    playScript(text: label, slider: slider)
    timer.fire()
}

//#-end-hidden-code
//: Auto-start
//#-editable-code
//#-code-completion(everything, hide)
//#-code-completion(identifier, show, play())
play()
/*#-end-editable-code*/
//#hidden-code

PlaygroundPage.current.liveView = mainView
//#-end-hidden-code

//: [Next](@next)
