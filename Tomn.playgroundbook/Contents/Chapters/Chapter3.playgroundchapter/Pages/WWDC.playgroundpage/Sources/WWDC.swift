import SpriteKit
import PlaygroundSupport

public class Person: SKSpriteNode {
    
    static let nbrAppearances: UInt32 = 10
    
    public convenience init() {
        
        let randomIndex = 1 + Int(arc4random_uniform(Person.nbrAppearances))
        
        self.init(imageNamed: "person\(randomIndex)")
        
        name = "person"
        setScale(0.3)
        
        let body = SKPhysicsBody(circleOfRadius: 70 * xScale)
        body.allowsRotation = false
        body.affectedByGravity = false
        body.linearDamping = 0   // friction
        body.restitution   = 1   // don't lose velocity when colliding
        let randomDest = Int(arc4random_uniform(50))
        let signX: CGFloat = randomDest & 1 == 0 ? -1 : 1
        let signY: CGFloat = (randomDest & 2) >> 1 == 0 ? -1 : 1
        /// Initial speed of the person
        let velocityX = CGFloat(randomDest)
        let velocityY = CGFloat(arc4random_uniform(50))
        body.velocity = CGVector(dx: signX * velocityX,
                                 dy: signY * velocityY)
        body.contactTestBitMask = 1  // handle contacts
        self.physicsBody = body
        
        // Walk orientation
        zRotation = atan2(body.velocity.dy, body.velocity.dx)
    }
    
}

public class WWDCScene: SKScene {
    
    public var participants = 42
    
    public var textLine1 = "Rejoice for"
    public var textLine2 = "WWDC17!"
    
    var titleL1: SKLabelNode?
    var titleL2: SKLabelNode?
    
    let fontSize: CGFloat = 60
    
    var contactQueue = Array<SKPhysicsContact>()
    
    public override func didMove(to view: SKView) {
        
        name = "scene"
        backgroundColor = #colorLiteral(red: 0.9725490196, green: 0.9725490196, blue: 0.9725490196, alpha: 1)
        scaleMode = .resizeFill
        
        physicsBody = SKPhysicsBody(edgeLoopFrom: frame)
        physicsWorld.contactDelegate = self
        
        titleL1 = SKLabelNode(text: textLine1)
        titleL2 = SKLabelNode(text: textLine2)
        titleL1?.position  = self.view?.center ?? .zero
        titleL2?.position  = titleL1?.position ?? .zero
        titleL2?.position.y -= fontSize
        titleL1?.fontName  = UIFont.boldSystemFont(ofSize: 22).fontName
        titleL2?.fontName  = titleL1?.fontName
        titleL1?.fontSize  = fontSize
        titleL2?.fontSize  = fontSize
        titleL1?.fontColor = #colorLiteral(red: 0.2352941176, green: 0.2352941176, blue: 0.2352941176, alpha: 1)
        titleL2?.fontColor = titleL1?.fontColor
//        titleL1?.zPosition = 10
//        titleL2?.zPosition = titleL1?.zPosition ?? 10
        addChild(titleL1!)
        addChild(titleL2!)
        
        for _ in 0..<participants {
            let posX = Int(arc4random_uniform(UInt32(size.width)))
            let posY = Int(arc4random_uniform(UInt32(size.height)))
            let person = Person()
            person.position = CGPoint(x: posX, y: posY)
            addChild(person)
        }
    }
    
    public override func didChangeSize(_ oldSize: CGSize) {
        super.didChangeSize(oldSize)
        
        if let titleL1 = titleL1,
           let titleL2 = titleL2 {
            titleL1.position = self.view?.center ?? .zero
            titleL2.position = titleL1.position
            titleL2.position.y -= fontSize
        }
    }
}

extension WWDCScene: SKPhysicsContactDelegate {
    
    public override func update(_ currentTime: TimeInterval) {
        super.update(currentTime)
        processContactForUpdate(currentTime)
    }
    
    public func didBegin(_ contact: SKPhysicsContact) {
        contactQueue.append(contact)
    }
    
    func processContactForUpdate(_ currentTime: TimeInterval) {
        let contacts = contactQueue
        for contact in contacts {
            handleContact(contact)
            if let index = contactQueue.index(where: { $0 == contact }) {
                contactQueue.remove(at: index)
            }
        }
    }
    
    func handleContact(_ contact: SKPhysicsContact) {
        
        if let bodyA = contact.bodyA.node,
            let bodyB = contact.bodyB.node {
            
            let nodes = [bodyA, bodyB]
            let nodeNames = [bodyA.name, bodyB.name]
            
            if let personIndex = nodeNames.index(where: { $0 == "person" }) {
                
                if nodeNames.contains(where: { $0 == "scene" })/* || nodeNames.contains(where: { $0 == "text" })*/ {
                    
                    let person = personIndex > 0 ? bodyB : bodyA
                    reorient(person)
                } else {
                    
                    for person in nodes {
                        
                        reorient(person)
                    }
                }
            }
        }
    }
    
    func reorient(_ person: SKNode) {
        
        let velocity = person.physicsBody?.velocity ?? .zero
        let angle = atan2(velocity.dy, velocity.dx)
        
        person.run(.rotate(toAngle: angle, duration: 0.42))
    }
    
}
