import UIKit

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
        }
        
        mainController.present(popover, animated: true)
    }
    
}
