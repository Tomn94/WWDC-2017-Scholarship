import UIKit


extension CGRect {
    /// Checks whether a frame intersects with others
    ///
    /// - Parameter rects: Frames to compare with
    /// - Returns: If the frame intersects with any other
    func intersects(_ rects: [CGRect]) -> Bool {
        for rect in rects {
            if self.intersects(rect) {
                return true
            }
        }
        return false
    }
}


// MARK: -
/// Feature of Students’ Union app
public struct Feature {
    
    /// Descriptive title
    public let title: String
    
    /// Icon allowing to expand the feature
    public let icon: UIImage
    
    // Screenshot when the feature is expanded
    public let screenshot: UIImage
    
    public init(title: String, icon: UIImage, screenshot: UIImage) {
        self.title      = title
        self.icon       = icon
        self.screenshot = screenshot
    }
}


// MARK: -
/// Controller handling the display of a Feature's popover
public class PopoverController: UIViewController, UIPopoverPresentationControllerDelegate {
    
    convenience public init(feature: Feature) {
        self.init()
        
        /* Title of the feature */
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
        
        /* Screenshot of the feature */
        let screenshot = UIImageView(image: feature.screenshot)
        screenshot.contentMode = .scaleAspectFit
        screenshot.layer.shadowOpacity = 0.3
        screenshot.layer.shadowOffset = CGSize.zero
        screenshot.layer.shadowRadius = 5
        
        /* Layout */
        let stackView = UIStackView(arrangedSubviews: [description, screenshot])
        stackView.axis = .vertical
        
        self.view = stackView
        self.modalPresentationStyle = .popover
        self.preferredContentSize = CGSize(width: 383, height: 400)
        
        /* Dismiss popover on tap */
        stackView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(PopoverController.hidePopover)))
    }
    
    /// Allows popover to happen
    ///
    /// - Parameter controller: Controller managing the size
    /// - Returns: The new presentation style
    public func adaptivePresentationStyle(for controller: UIPresentationController) -> UIModalPresentationStyle {
        return .none
    }
    
    /// Dismiss popover (e.g. on tap)
    func hidePopover() {
        dismiss(animated: true)
    }
    
}


// MARK: -
/// Feature button, displaying a popover when tapped
public class PopButton: UIButton {
    
    /// Feature associated to the button
    public var feature: Feature? {
        didSet {
            /* Update button icon when changed */
            self.setImage(feature?.icon.withRenderingMode(.alwaysTemplate), for: .normal)
        }
    }
    
    /// Main view controller that can contain the popover
    public var mainController: UIViewController?
    
    override public init(frame: CGRect) {
        super.init(frame: frame)
        
        /* Responds to tap */
        addTarget(self, action: #selector(PopButton.showPopover), for: .touchUpInside)
    }
    
    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    /// Display the popover associated
    public func showPopover() {
        
        guard let feature = feature,
              let mainController = mainController else { return }
        
        /* Create the popover */
        let popover = PopoverController(feature: feature)
        
        /* Configure its position and size */
        if let popoverPresentCtrl = popover.popoverPresentationController {
            popoverPresentCtrl.sourceRect = self.frame
            popoverPresentCtrl.sourceView = mainController.view
            popoverPresentCtrl.delegate = popover
            popoverPresentCtrl.permittedArrowDirections = .up
        }
        
        /* Present & voilà */
        mainController.present(popover, animated: true)
    }
    
}


// MARK: -
/// Main View for Students’ Union page
public class FeaturesView: UIView {
    
    /// Background gradient layer
    let gradientLayer = CAGradientLayer()
    
    /// Title label on top of the view
    let title = UILabel()
    
    /// Cloud in the center
    let cloud = UIImageView()
    
    /// Displayed features
    var features = [Feature]()
    
    /// All the Features buttons
    var buttons = [UIButton]()
    
    /// Saves all the button positions
    var buttonsFrames = [CGRect]()
    
    /// Buttons are hidden before `showFeatures()`
    var areFeaturesHidden = true
    
    
    // MARK: Editable properties
    
    /// Wobble angle for icons
    public var wiggleAngle: CGFloat = 0.059
    
    /// Margin between 2 icons
    public var buttonMargins = UIEdgeInsets(top: -20, left: -20, bottom: -20, right: -20)
    
    /// Icons are randomly placed on the view,
    /// defines the maximum number of attempts to find an empty place
    public var maxButtonPlacementAttempt = 142
    
    /// Features icons size
    public var buttonSize = CGSize(width: 42, height: 42)
    
    
    override public init(frame: CGRect) {
        super.init(frame: frame)
        
        self.tintColor = .white
        self.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        
        /* Configure gradient layer of the background */
        gradientLayer.colors = [#colorLiteral(red: 0.2274509804, green: 0.8431372549, blue: 1, alpha: 1).cgColor, #colorLiteral(red: 0.01176470588, green: 0.6549019608, blue: 1, alpha: 1).cgColor]
        self.layer.addSublayer(gradientLayer)
        
        
        /* Title */
        title.frame = CGRect(x: 0, y: 0, width: frame.width, height: 60)
        title.text = "ESEO Students’ Union"
        title.font = UIFont.boldSystemFont(ofSize: 40)
        title.textColor = .white
        title.numberOfLines = 0
        title.textAlignment = .center
        title.layer.shadowColor   = UIColor.black.cgColor
        title.layer.shadowRadius  = 3
        title.layer.shadowOffset  = CGSize(width: 0, height: 0)
        title.layer.shadowOpacity = 0.4
        title.autoresizingMask    = [.flexibleLeftMargin, .flexibleRightMargin]
        self.addSubview(title)
        
        /* Cloud */
        cloud.image = #imageLiteral(resourceName: "su-cloud.png")
        cloud.frame = frame
        cloud.center.y += title.frame.height * 2
        cloud.contentMode = .center
        cloud.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        self.addSubview(cloud)
    }
    
    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    /// React when screen is rotated or resized
    public override func layoutSubviews() {
        super.layoutSubviews()
        
        gradientLayer.frame = self.bounds
        
        /* Find new positions for all the buttons */
        computeRects()
        if !areFeaturesHidden {
            /* Commit only if build-in animation has happened */
            for (index, button) in buttons.enumerated() {
                button.frame = buttonsFrames[index]
            }
        }
    }
    
    
    // MARK: Features
    
    /// Populate the view with buttons and their associated feature
    ///
    /// - Parameters:
    ///   - features: Displayed features
    ///   - viewController: Main View Controller, responsible for displaying popovers
    public func set(_ features: [Feature], in viewController: UIViewController) {
        
        self.features = features
        
        /* Empty view */
        buttons.forEach { $0.removeFromSuperview() }
        buttons = []
        
        /* (Re)calculate all the the buttons frames */
        computeRects()
        
        /* Create buttons */
        for (index, feature) in features.enumerated() {
            
            let button = PopButton(frame: CGRect(origin: cloud.center, size: buttonsFrames[index].size))
            button.feature = feature
            button.mainController = viewController
            button.isHidden = true
            
            buttons.append(button)
            self.addSubview(button)
        }
        
        /* Let the cloud be in front */
        self.bringSubview(toFront: cloud)
    }
    
    /// Compute each buttons frames
    public func computeRects() {
        
        buttonsFrames = [CGRect]()
        
        /// Copy of `buttonsFrames` with insets to compute intersections
        var buttonsFramesWithInset = [CGRect]()
        
        /* Position range */
        let cloudSize   = CGSize(width: 300, height: 200)
        let titleHeight = title.frame.height
        let xUpperBound = UInt32(cloudSize.width * 1.2)
        let yUpperBound = UInt32(center.y - titleHeight)
        
        /* Let's find an available position for each feature */
        for _ in features {
            
            var newButtonFrame = CGRect.zero
            var attempts = 0
            
            /* Repeat until we've found */
            repeat {
                let x = center.x - cloudSize.width / 1.5 + CGFloat(arc4random_uniform(xUpperBound))
                let y = 10 + titleHeight + CGFloat(arc4random_uniform(yUpperBound))
                
                newButtonFrame = CGRect(origin: CGPoint(x: x, y: y), size: buttonSize)
                attempts += 1
                
                /* This will be recalculated if there is an intersection between features, up to a certain watchdog */
            } while newButtonFrame.intersects(buttonsFramesWithInset) && attempts < maxButtonPlacementAttempt
            
            /* Save result */
            buttonsFramesWithInset.append(UIEdgeInsetsInsetRect(newButtonFrame, buttonMargins))
            buttonsFrames.append(newButtonFrame)
        }
    }
    
    /// Build-in animation showing features buttons
    public func showFeatures() {
        
        areFeaturesHidden = false
        
        /* Don't animate at once, view is being set up */
        Timer.scheduledTimer(withTimeInterval: 1, repeats: false) { _ in
            
            /* Show each button */
            for (index, button) in self.buttons.enumerated() {
                
                /* From the cloud */
                button.isHidden = false
                button.center = self.cloud.center
                
                UIView.animate(withDuration: 0.6,
                               delay: TimeInterval(arc4random_uniform(10)) / 20,
                               options: [.curveEaseIn],
                               animations: {
                
                    /* To their respective position */
                    button.frame = self.buttonsFrames[index]
                    
                }, completion: { _ in
                    
                    /* Let them wiggle a bit */
                    let animation = CAKeyframeAnimation(keyPath: "transform")
                    animation.autoreverses = true
                    animation.duration = 0.13
                    animation.repeatCount = Float.greatestFiniteMagnitude
                    
                    let left  = NSValue(caTransform3D: CATransform3DMakeRotation(self.wiggleAngle, 0, 0, 1))
                    let right = NSValue(caTransform3D: CATransform3DMakeRotation(-self.wiggleAngle, 0, 0, 1))
                    animation.values = [left, right]
                    
                    button.layer.add(animation, forKey: "")
                })
            }
        }
    }

}
