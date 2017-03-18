import UIKit
import SceneKit

/// View supporting a drag gesture, to rotate the same or another view
public class RotatingResponder: SCNView {
    
    /// View to be rotated
    public var node: SCNNode?
    
    /// Previous rotation angle
    var rotationY: CGFloat = 0
    
    /// Rotated view size
    public var avatarSize: CGFloat = 200
    
    /// Rotating accelerator constant
    public var rotatingInertiaFactor: CGFloat = 5
    
    /// Rotate `node`
    ///
    /// - Parameter recognizer: According to a pan gesture
    public func rotate(recognizer: UIPanGestureRecognizer) {
        
        if let avatarView = node {
            
            /* Convert finger translation into rotation */
            let translation = recognizer.translation(in: self)
            let range = translation.x / avatarSize
            rotationY += range * CGFloat.pi * rotatingInertiaFactor
            
            /* Apply rotation and reset gesture recognizer */
            avatarView.eulerAngles.x = Float(rotationY)
            recognizer.setTranslation(CGPoint.zero, in: self)
            
            /* Animate some kind of inertia
             if recognizer.state == .ended {

                let velocity = recognizer.velocity(in: self)
                let speedRange = velocity.x / (avatarSize * 0.8) * rotatingInertiaFactor
                
                SCNTransaction.begin()
                SCNTransaction.animationDuration = 5
                SCNTransaction.animationTimingFunction = CAMediaTimingFunction(controlPoints: 0, 0, 0.2, 1)
                avatarView.physicsBody?.angularVelocity = SCNVector4(0, 1, 0, CGFloat.pi * speedRange)
                SCNTransaction.commit()
            }*/
        }
    }
    
    /// Rotate `node` a bit, to show the user it is animatable
    public func runSpinningHintAnimation() {
        
        if let avatarView = node {
            
            SCNTransaction.animationDuration = 5
            SCNTransaction.animationTimingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseOut)
            avatarView.physicsBody?.angularVelocity = SCNVector4(0, 1, 0, 0.15)
        }
    }
    
}

/// View with a gradient background, colors rotating
public class AnimatedGradientView: UIView {
    
    /// Configure gradient layer
    ///
    /// - Parameters:
    ///   - frame: View frame, as usual
    ///   - colors: Gradient colors
    ///   - speed: Speed of the color rotation
    public init(frame: CGRect, colors: [UIColor], speed: TimeInterval) {
        super.init(frame: frame)
        
        /* Configure gradient layer of the background */
        let gradientLayer = CAGradientLayer()
        gradientLayer.frame = self.bounds
        gradientLayer.anchorPoint = CGPoint.zero
        gradientLayer.frame.size.width  *= 7
        gradientLayer.frame.size.height *= 5
        gradientLayer.startPoint = CGPoint.zero
        gradientLayer.endPoint = CGPoint(x: 1, y: 1)
        gradientLayer.colors = colors.map { $0.cgColor }
        self.layer.addSublayer(gradientLayer)
        
        /* Animate gradient */
        let gradientSize = gradientLayer.frame.size
        let backgroundSize = frame.size
        let animation = CABasicAnimation(keyPath: "position")
        animation.fromValue = CGPoint.zero
        animation.toValue = CGPoint(x: -gradientSize.width  + backgroundSize.width,
                                    y: -gradientSize.height + backgroundSize.height)
        animation.repeatCount = Float.greatestFiniteMagnitude
        animation.duration = speed
        animation.autoreverses = true
        animation.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseInEaseOut)
        self.layer.add(animation, forKey: "animateGradient")
    }
    
    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
