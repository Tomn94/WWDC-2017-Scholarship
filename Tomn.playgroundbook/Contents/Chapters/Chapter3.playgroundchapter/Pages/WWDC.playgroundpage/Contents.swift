import SpriteKit
import PlaygroundSupport

class Person: SKSpriteNode {
    
    static let nbrAppearances: UInt32 = 10
    
    convenience init() {
        let randomIndex = 1 + Int(arc4random_uniform(Person.nbrAppearances))
        
        self.init(imageNamed: "person\(randomIndex)")
        
        name = "person"
        
        setScale(0.7)
        
        let body = SKPhysicsBody(circleOfRadius: 30)
        body.allowsRotation = false
        body.affectedByGravity = false
        body.linearDamping = 0   // friction
        body.restitution = 1     // don't lose velocity when colliding
        let randomDest = Int(arc4random_uniform(100))
        let signX: CGFloat = randomDest & 1 == 0 ? -1 : 1
        let signY: CGFloat = (randomDest & 2) >> 1 == 0 ? -1 : 1
        /// Initial speed of the person
        let velocityX = CGFloat(randomDest)
        let velocityY = CGFloat(arc4random_uniform(100))
        body.velocity = CGVector(dx: signX * velocityX,
                                 dy: signY * velocityY)
        body.contactTestBitMask = 1  // handle contacts
        self.physicsBody = body
        
        let angle = atan2(body.velocity.dy, body.velocity.dx)
        
        zRotation = angle
    }
    
}

class WWDCScene: SKScene {
    
    let title = SKLabelNode(text: "Rejoice for WWDC17!")
    
    var contactQueue = Array<SKPhysicsContact>()
    
    override func didMove(to view: SKView) {
        
        name = "scene"
        backgroundColor = #colorLiteral(red: 0.9725490196, green: 0.9725490196, blue: 0.9725490196, alpha: 1)
        scaleMode = .resizeFill
        
        title.position = self.view?.center ?? .zero
        title.fontName = UIFont.boldSystemFont(ofSize: 22).fontName
        title.fontColor = #colorLiteral(red: 0.2352941176, green: 0.2352941176, blue: 0.2352941176, alpha: 1)
        addChild(title)
        
        physicsBody = SKPhysicsBody(edgeLoopFrom: frame)
        physicsWorld.contactDelegate = self
        
        let person = Person()
        person.position = view.center
        addChild(person)
        
        let person2 = Person()
        person2.position = CGPoint(x: 100, y: 100)
        addChild(person2)
    }
    
    override func didChangeSize(_ oldSize: CGSize) {
        super.didChangeSize(oldSize)
        
        title.position = self.view?.center ?? .zero
    }
}

extension WWDCScene: SKPhysicsContactDelegate {
    
    override func update(_ currentTime: TimeInterval) {
        super.update(currentTime)
        processContactForUpdate(currentTime)
    }
    
    func didBegin(_ contact: SKPhysicsContact) {
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
                
                if nodeNames.contains(where: { $0 == "scene" }) {
                    
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
        
        person.run(.rotate(toAngle: angle, duration: 0.25))
    }
    
}

let mainView = SKView(frame: CGRect(x: 0, y: 0, width: 400, height: 400))

let scene = WWDCScene(size: mainView.frame.size)
mainView.presentScene(scene)

PlaygroundPage.current.liveView = mainView
