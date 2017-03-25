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

public struct Feature {
    public let title: String
    public let icon: UIImage
    public let screenshot: UIImage
    
    public init(title: String, icon: UIImage, screenshot: UIImage) {
        self.title      = title
        self.icon       = icon
        self.screenshot = screenshot
    }
}

public class PopoverController: UIViewController, UIPopoverPresentationControllerDelegate {
    
    convenience public init(feature: Feature) {
        self.init()
        
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
        
        let screenshot = UIImageView(image: feature.screenshot)
        screenshot.contentMode = .scaleAspectFit
        screenshot.layer.shadowOpacity = 0.3
        screenshot.layer.shadowOffset = CGSize.zero
        screenshot.layer.shadowRadius = 5
        
        let stackView = UIStackView(arrangedSubviews: [description, screenshot])
        stackView.axis = .vertical
        
        self.view = stackView
        self.modalPresentationStyle = .popover
        self.preferredContentSize = CGSize(width: 383, height: 400)
    }
    
    public func adaptivePresentationStyle(for controller: UIPresentationController) -> UIModalPresentationStyle {
        return .none
    }
    
}

public class PopButton: UIButton {
    
    public var feature: Feature? {
        didSet {
            self.setImage(feature?.icon.withRenderingMode(.alwaysTemplate), for: .normal)
        }
    }
    public var mainController: UIViewController?
    
    override public init(frame: CGRect) {
        super.init(frame: frame)
        
        addTarget(self, action: #selector(PopButton.showPopup), for: .touchUpInside)
    }
    
    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public func showPopup() {
        
        guard let feature = feature,
              let mainController = mainController else { return }
        
        let popover = PopoverController(feature: feature)
        
        if let popoverPresentCtrl = popover.popoverPresentationController {
            popoverPresentCtrl.sourceRect = self.frame
            popoverPresentCtrl.sourceView = mainController.view
            popoverPresentCtrl.delegate = popover
            popoverPresentCtrl.permittedArrowDirections = .up
        }
        
        mainController.present(popover, animated: true)
    }
    
}

public class FeaturesView: UIView {
    
    /* Configure gradient layer of the background */
    let gradientLayer = CAGradientLayer()
    
    let title = UILabel()
    
    let cloud = UIImageView()
    
    var features = [Feature]()
    
    var viewController: UIViewController?
    
    var buttons = [UIButton]()
    
    var buttonsFrames = [CGRect]()
    
    var areFeaturesHidden = true
    
    override public init(frame: CGRect) {
        super.init(frame: frame)
        
        self.tintColor = .white
        self.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        
        gradientLayer.colors = [#colorLiteral(red: 0.2274509804, green: 0.8431372549, blue: 1, alpha: 1).cgColor, #colorLiteral(red: 0.01176470588, green: 0.6549019608, blue: 1, alpha: 1).cgColor]
        self.layer.addSublayer(gradientLayer)
        
        
        //: ### Title
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
        title.autoresizingMask    = .flexibleWidth
        self.addSubview(title)
        
        //: ### Add cloud glyph in center
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
    
    public override func layoutSubviews() {
        super.layoutSubviews()
        
        gradientLayer.frame = self.bounds
        
        computeRects()
        if !areFeaturesHidden {
            for (index, button) in buttons.enumerated() {
                button.frame = buttonsFrames[index]
            }
        }
    }
    
    public func setFeatures(_ features: [Feature], in viewController: UIViewController) {
        
        self.features = features
        self.viewController = viewController
        
        buttons.forEach { $0.removeFromSuperview() }
        buttons = []
        computeRects()
        
        for (index, feature) in features.enumerated() {
            
            let button = PopButton(frame: CGRect(origin: cloud.center, size: buttonsFrames[index].size))
            button.feature = feature
            button.mainController = viewController
            
            buttons.append(button)
            self.addSubview(button)
        }
        
        self.bringSubview(toFront: cloud)
    }
    
    public func computeRects() {
        
        buttonsFrames = [CGRect]()
        var buttonsFramesWithInset = [CGRect]()
        
        let cloudSize = CGSize(width: 300, height: 200)
        let titleHeight = title.frame.height
        let xUpperBound = UInt32(cloudSize.width * 1.2)
        let yUpperBound = UInt32(center.y - (titleHeight * 1.2))
        let margins = UIEdgeInsets(top: -20, left: -20, bottom: -20, right: -20)
        
        for _ in features {
            
            var newButtonFrame = CGRect.zero
            var attempts = 0
            repeat {
                let x = center.x - cloudSize.width / 1.5 + CGFloat(arc4random_uniform(xUpperBound))
                let y = titleHeight + CGFloat(arc4random_uniform(yUpperBound))
                
                newButtonFrame = CGRect(x: x, y: y, width: 42, height: 42)
                attempts += 1
                
            } while newButtonFrame.intersects(buttonsFramesWithInset) && attempts < 42
            
            buttonsFramesWithInset.append(UIEdgeInsetsInsetRect(newButtonFrame, margins))
            buttonsFrames.append(newButtonFrame)
        }
    }
    
    public func showFeatures() {
        
        areFeaturesHidden = false
        
        for (index, button) in self.buttons.enumerated() {
            
            button.frame = CGRect(origin: cloud.center, size: buttonsFrames[index].size)
            
            UIView.animate(withDuration: 0.6, delay: 0.2 + TimeInterval(arc4random_uniform(10)) / 20, options: [.curveEaseIn], animations: {
                button.frame = self.buttonsFrames[index]
            }, completion: { _ in
                
                let animation = CAKeyframeAnimation(keyPath: "transform")
                animation.autoreverses = true
                animation.duration = 0.13
                animation.repeatCount = Float.greatestFiniteMagnitude
                
                let wiggleAngle: CGFloat = 0.059
                let left  = NSValue(caTransform3D: CATransform3DMakeRotation(wiggleAngle, 0, 0, 1))
                let right = NSValue(caTransform3D: CATransform3DMakeRotation(-wiggleAngle, 0, 0, 1))
                animation.values = [left, right]
                
                button.layer.add(animation, forKey:"")
            })
        }
    }

}
