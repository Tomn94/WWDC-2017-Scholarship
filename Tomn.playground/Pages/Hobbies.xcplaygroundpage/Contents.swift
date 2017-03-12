//: [Previous](@previous)

//#-hidden-code
import UIKit
import PlaygroundSupport

/// Main view
let view = UIView(frame: CGRect(x: 0, y: 0, width: 500, height: 500))

//#-end-hidden-code
let imageShapeType: UIDynamicItemCollisionBoundsType = /*#-editable-code Select a picture shape*/.ellipse/*#-end-editable-code*/
//#-hidden-code

/// Handles physics-related animations
let animator = UIDynamicAnimator(referenceView: view)

var gravityBehavior: UIGravityBehavior?

/* Collides with superview (reference) */
func addDynamics() {
    animator.removeAllBehaviors()
    
    let collisionBehavior = UICollisionBehavior(items: view.subviews)
    collisionBehavior.translatesReferenceBoundsIntoBoundary = true
    animator.addBehavior(collisionBehavior)
    
    let elasticityBehavior = UIDynamicItemBehavior(items: view.subviews)
    elasticityBehavior.elasticity = 0.7
    elasticityBehavior.friction = 1.0
    animator.addBehavior(elasticityBehavior)
    
    gravityBehavior = UIGravityBehavior(items: view.subviews)
    gravityBehavior!.magnitude = 5
    animator.addBehavior(gravityBehavior!)
}


func ballParty(with number: Int, size ballSize: CGSize) {
    
    for _ in 0..<number {
        
        let randomOrigin = CGPoint(x: CGFloat(arc4random_uniform(UInt32(view.bounds.size.width - ballSize.width))),
                                   y: CGFloat(arc4random_uniform(UInt32(view.bounds.size.height - ballSize.height))))
        
        let tennisBall = BouncingImageView(image: tennisImage)
        tennisBall.frame = CGRect(origin: randomOrigin, size: ballSize)
        view.addSubview(tennisBall)
    }
}

/// An UIImageView, but one that can dance
class BouncingImageView: UIImageView {
    
    /// Overrides image shape for better collisions on circular shapes
    @available(iOS 9.0, *)
    override var collisionBoundsType: UIDynamicItemCollisionBoundsType {
        return imageShapeType
    }
    
    override init(image: UIImage?) {
        super.init(image: image)
        
        /* Handle user taps */
        self.isUserInteractionEnabled = true
        let tap = UITapGestureRecognizer(target: self,
                                         action: #selector(BouncingImageView.bounce))
        self.addGestureRecognizer(tap)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    /// Squashes the view
    func bounce() {
        if let gravity = gravityBehavior {
            animator.removeBehavior(gravity)
        }
        
        let pusher = UIPushBehavior(items: [self], mode: .instantaneous)
        pusher.pushDirection = CGVector(dx: 20, dy: 10)
        pusher.active = true
        animator.addBehavior(pusher)
    }
}
//#-end-hidden-code

/// Falling and bouncing images
let tennisImage = /*#-editable-code Choose a picture*/#imageLiteral(resourceName: "tennis.png")/*#-end-editable-code*/

/// Size of the images
let ballSize = CGSize(width: /*#-editable-code Enter Width*/75/*#-end-editable-code*/, height: /*#-editable-code Enter Height*/75/*#-end-editable-code*/)

//: Add colliding objects
//#-editable-code
let tennisBall = BouncingImageView(image: tennisImage)
tennisBall.frame = CGRect(origin: CGPoint(x: 95, y: 0), size: ballSize)
view.addSubview(tennisBall)

let tennisBall2 = BouncingImageView(image: tennisImage)
tennisBall2.frame = CGRect(origin: CGPoint(x: 342, y: 142), size: ballSize)
view.addSubview(tennisBall2)
//#-editable-code

//: Make it pop
//#-editable-code
//#-code-completion(everything, hide)
//#-code-completion(identifier, show, ballParty(with: 30, size: ballSize))
//#-code-completion(keyword, for)
//ballParty(with: 30, size: ballSize)
/*#-end-editable-code*/

addDynamics()

//#-hidden-code

//: ## Configure playground
PlaygroundPage.current.liveView = view
//#-end-hidden-code

//: [Next](@next)
