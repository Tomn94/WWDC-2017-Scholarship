import UIKit

public extension UIView {
    
    public func setUpParallax(tiltFact: CGFloat = 0.5, shadowFact: CGFloat = 15, panFact: CGFloat = 20) {
        
        self.motionEffects.removeAll()
        
        let tiltX = UIInterpolatingMotionEffect(keyPath: "layer.transform.rotation.x", type: .tiltAlongHorizontalAxis)
        tiltX.minimumRelativeValue = -tiltFact
        tiltX.maximumRelativeValue = tiltFact
        
        let tiltY = UIInterpolatingMotionEffect(keyPath: "layer.transform.rotation.y", type: .tiltAlongVerticalAxis)
        tiltY.minimumRelativeValue = -tiltFact
        tiltY.maximumRelativeValue = tiltFact
        
        let shadowX = UIInterpolatingMotionEffect(keyPath: "layer.shadowOffset.width", type: .tiltAlongHorizontalAxis)
        shadowX.minimumRelativeValue = -shadowFact
        shadowX.maximumRelativeValue = shadowFact
        
        let shadowY = UIInterpolatingMotionEffect(keyPath: "layer.shadowOffset.height", type: .tiltAlongVerticalAxis)
        shadowY.minimumRelativeValue = -shadowFact
        shadowY.maximumRelativeValue = shadowFact
        
        let panX = UIInterpolatingMotionEffect(keyPath: "center.x", type: .tiltAlongHorizontalAxis)
        panX.minimumRelativeValue = -panFact
        panX.maximumRelativeValue = panFact
        
        let panY = UIInterpolatingMotionEffect(keyPath: "center.y", type: .tiltAlongVerticalAxis)
        panY.minimumRelativeValue = -panFact
        panY.maximumRelativeValue = panFact
        
        let alpha = UIInterpolatingMotionEffect(keyPath: "alpha", type: .tiltAlongVerticalAxis)
        alpha.minimumRelativeValue = -0.9
        alpha.maximumRelativeValue = 1
        
        let motionGroup = UIMotionEffectGroup()
        motionGroup.motionEffects = [tiltX, tiltY, shadowX, shadowY, panX, panY, alpha]
        self.addMotionEffect(motionGroup)
    }
    
}
