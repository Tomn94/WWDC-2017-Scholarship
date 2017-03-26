import UIKit

public extension UIView {
    
    /// Add parallax animation to an UIView when moving device
    ///
    /// - Parameters:
    ///   - tiltFact: Reaction factor to tilting device
    ///   - shadowFact: Shadow move when tilting
    ///   - panFact: Distortion reaction to titling
    public func setUpParallax(tiltFact: CGFloat = 0.5, shadowFact: CGFloat = 15, panFact: CGFloat = 20) {
        
        /* Remove any previous effect */
        self.motionEffects.removeAll()
        
        /* Distortion */
        let tiltX = UIInterpolatingMotionEffect(keyPath: "layer.transform.rotation.x", type: .tiltAlongHorizontalAxis)
        tiltX.minimumRelativeValue = -tiltFact
        tiltX.maximumRelativeValue = tiltFact
        
        let tiltY = UIInterpolatingMotionEffect(keyPath: "layer.transform.rotation.y", type: .tiltAlongVerticalAxis)
        tiltY.minimumRelativeValue = -tiltFact
        tiltY.maximumRelativeValue = tiltFact
        
        /* Shadow offset */
        let shadowX = UIInterpolatingMotionEffect(keyPath: "layer.shadowOffset.width", type: .tiltAlongHorizontalAxis)
        shadowX.minimumRelativeValue = -shadowFact
        shadowX.maximumRelativeValue = shadowFact
        
        let shadowY = UIInterpolatingMotionEffect(keyPath: "layer.shadowOffset.height", type: .tiltAlongVerticalAxis)
        shadowY.minimumRelativeValue = -shadowFact
        shadowY.maximumRelativeValue = shadowFact
        
        /* Move */
        let panX = UIInterpolatingMotionEffect(keyPath: "center.x", type: .tiltAlongHorizontalAxis)
        panX.minimumRelativeValue = -panFact
        panX.maximumRelativeValue = panFact
        
        let panY = UIInterpolatingMotionEffect(keyPath: "center.y", type: .tiltAlongVerticalAxis)
        panY.minimumRelativeValue = -panFact
        panY.maximumRelativeValue = panFact
        
        /* Light Glare effect */
        let alpha = UIInterpolatingMotionEffect(keyPath: "alpha", type: .tiltAlongVerticalAxis)
        alpha.minimumRelativeValue = -0.9
        alpha.maximumRelativeValue = 1
        
        /* Add them all! */
        let motionGroup = UIMotionEffectGroup()
        motionGroup.motionEffects = [tiltX, tiltY, shadowX, shadowY, panX, panY, alpha]
        self.addMotionEffect(motionGroup)
    }
    
}
