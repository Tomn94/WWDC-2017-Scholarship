/*:
 - callout(Also me): Apart from being fond of **tech news** and **UI/UX design**, I also play **tennis** and **draw**.
 */

//#-hidden-code
import UIKit
import PlaygroundSupport
import AVFoundation

/// Main view
let view = UIView(frame: CGRect(x: 0, y: 0, width: 500, height: 500))
view.autoresizingMask = [.flexibleWidth, .flexibleHeight]

//#-end-hidden-code
/// Pictures to display as a slideshow
let backgroundImages: [UIImage] = [/*#-editable-code Select pictures*/#imageLiteral(resourceName: "painting1.jpg"), #imageLiteral(resourceName: "painting2.jpg"), #imageLiteral(resourceName: "painting3.jpg"), #imageLiteral(resourceName: "painting4.jpg")/*#-end-editable-code*/]

/// Time between 2 background pictures
let rotationTime: TimeInterval = /*#-editable-code Adjust time*/3/*#-end-editable-code*/

/// Picture shape of the bouncing balls for dynamics
let imageShapeType: UIDynamicItemCollisionBoundsType = /*#-editable-code Select a picture shape*/.ellipse/*#-end-editable-code*/

/// Change gravity force
let gravityMagnitude: CGFloat = /*#-editable-code Change gravity*/5/*#-end-editable-code*/

//#-hidden-code

/* Configure background */
var currentImageIndex = 0
let backgroundImage = currentImageIndex < backgroundImages.count ? backgroundImages[currentImageIndex] : nil
let imageView = UIImageView(image: backgroundImage)
imageView.frame = view.frame
imageView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
view.addSubview(imageView)
imageView.contentMode = .scaleAspectFill

/// Makes background transitions
func playSlideshow() {
    
    guard backgroundImages.count > 0 else {
        return
    }
    
    /* Animate change */
    let animation = CATransition()
    animation.duration = 1
    animation.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseInEaseOut)
    animation.type = "cube"
    animation.subtype = kCATransitionFromRight
    imageView.layer.add(animation, forKey: nil)
    
    /* Choose next picture in the stack */
    currentImageIndex = (currentImageIndex + 1) % backgroundImages.count
    imageView.image = backgroundImages[currentImageIndex]
}

/// URL to sound file played when the view is tapped
let serveSound = URL(fileURLWithPath: Bundle.main.path(forResource: "service", ofType: "mp3")!)
/// Sound player
let audioPlayer = try AVAudioPlayer(contentsOf: serveSound)

/// Handles physics-related animations
let animator = UIDynamicAnimator(referenceView: view)

var gravityBehavior: UIGravityBehavior?

/// Collides with superview (reference)
func addDynamics() {
    
    animator.removeAllBehaviors()
    
    let subviews = view.subviews.filter { subview -> Bool in
        subview.frame != view.frame
    }

    /* All views collide */
    let collisionBehavior = UICollisionBehavior(items: subviews)
    collisionBehavior.translatesReferenceBoundsIntoBoundary = true
    animator.addBehavior(collisionBehavior)
    
    /* All views have inertia and “push back” after collisions */
    let elasticityBehavior = UIDynamicItemBehavior(items: subviews)
    elasticityBehavior.elasticity = 0.7
    elasticityBehavior.friction = 0.9
    animator.addBehavior(elasticityBehavior)
    
    /* Organize view with gravity, and let them fall */
    gravityBehavior = UIGravityBehavior(items: subviews)
    gravityBehavior!.magnitude = gravityMagnitude
    animator.addBehavior(gravityBehavior!)
}


/// Adds a lot more views to the scene
///
/// - Parameters:
///   - number: Number of views to add
///   - ballSize: Size of the views
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
        
        let pusher = UIPushBehavior(items: [self], mode: .instantaneous)
        pusher.pushDirection = CGVector(dx: 20, dy: 10)
        pusher.active = true
        animator.addBehavior(pusher)
        
        audioPlayer.play()
    }
}
//#-end-hidden-code
/// Falling and bouncing images
let tennisImage = /*#-editable-code Choose a picture*/#imageLiteral(resourceName: "tennis.png")/*#-end-editable-code*/

/// Size of the images
let ballSize = CGSize(width: /*#-editable-code Enter Width*/75/*#-end-editable-code*/, height: /*#-editable-code Enter Height*/75/*#-end-editable-code*/)

//: Add colliding objects
//#-editable-code
/* First animated tennis ball */
let tennisBall = BouncingImageView(image: tennisImage)
tennisBall.frame = CGRect(origin: CGPoint(x: 95, y: 0), size: ballSize)
view.addSubview(tennisBall)

/* And another one */
let tennisBall2 = BouncingImageView(image: tennisImage)
tennisBall2.frame = CGRect(origin: CGPoint(x: 342, y: 142), size: ballSize)
view.addSubview(tennisBall2)
//#-end-editable-code
//: ## Uncomment to make it pop 😏🎾💥
//#-editable-code
//ballParty(with: 30, size: ballSize)
//#-end-editable-code

/* Add some gravity at first, then inertia, collisions… */
addDynamics()

/* Animate background */
Timer.scheduledTimer(withTimeInterval: rotationTime, repeats: true) { _ in
    playSlideshow()
}

/* Load sound */
audioPlayer.prepareToPlay()

//#-hidden-code
PlaygroundPage.current.liveView = view
//#-end-hidden-code