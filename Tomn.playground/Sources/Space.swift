import SpriteKit
import CoreMotion
import AudioToolbox

enum NodeName {
    static let btnRetry = "btnRetry"
    static let plane = "plane"
    static let missile = "missile"
    static let bomb = "bomb"
    static let bonus = "bonus"
}

enum BitMask: UInt32 {
    case none    = 0
    case scene   = 1
    case ship    = 2
    case missile = 4
    case bomb    = 8
    case bonus   = 16
}

public class SpaceGameScene: SKScene {
    
    let startDelay: TimeInterval = 2
    let maxLives = 8
    
    public var shipMoveFact = 55.0
    public var missilesSpeed = 0.8
    public var missilesDelay: TimeInterval = 0.2
    public var bombsSpawnTime: TimeInterval = 0.5
    public var bombShowTime = 2.1
    let bonusShowTime = 3.0
    let bonusMinScore = 1
    let bonusSpawnTime: TimeInterval = 8
    
    public var lvl2MinScore = 40
    public var lvl2ProbRange: UInt32 = 1
    public var bombLvl2MaxHit = 4
    
    var score = 0
    var lives = 3
    var timeStart: TimeInterval = 0
    var isTouching = false
    var lastTouchTime: TimeInterval = 0
    var lastSpawnTime: TimeInterval = 0
    var lastBonusTime: TimeInterval = 0
    var bonusVisible = false
    
    var background: SKSpriteNode!
    var background2: SKSpriteNode!
    var plane: SKSpriteNode!
    var scoreHUD: SKLabelNode!
    var livesHUD = [SKSpriteNode]()
    
    public var deviceOrientation = UIDeviceOrientation.landscapeLeft
    
    var motionManager: CMMotionManager?
    
    var contactQueue = [SKPhysicsContact]()
    
    override public init(size: CGSize) {
        super.init(size: size)
        
        scaleMode = .aspectFit
        backgroundColor = #colorLiteral(red: 0.1176470588, green: 0.2352941176, blue: 0.5098039216, alpha: 1)
        
        physicsWorld.contactDelegate = self
        physicsBody = SKPhysicsBody(edgeLoopFrom: frame)
        physicsBody?.categoryBitMask = BitMask.scene.rawValue
        
        background = SKSpriteNode(imageNamed: "sky")
        background.zPosition = -1
        background.size = size
        background.position = CGPoint(x: size.width / 2, y: size.height / 2)
        addChild(background)
        
        background2 = SKSpriteNode(imageNamed: "sky")
        background2.zPosition = -1
        background2.size = size
        background2.position = CGPoint(x: size.width / 2, y: size.height * 3 / 2)
        addChild(background2)
        
        
        plane = SKSpriteNode(imageNamed: "spaceship")
        plane.name = NodeName.plane
        plane.zPosition = 2
        plane.setScale(0.2)
        plane.position = CGPoint(x: size.width / 2, y: 15 + plane.size.height / 2)
        let planePhysicsBody = SKPhysicsBody(circleOfRadius: plane.size.width / 2 - 5)
        planePhysicsBody.isDynamic = true
        planePhysicsBody.affectedByGravity = false
        planePhysicsBody.mass = 0.02
        planePhysicsBody.categoryBitMask = BitMask.ship.rawValue
        planePhysicsBody.contactTestBitMask = BitMask.bomb.rawValue | BitMask.bonus.rawValue
        planePhysicsBody.collisionBitMask = BitMask.scene.rawValue
        plane.physicsBody = planePhysicsBody
        addChild(plane)
        
        scoreHUD = SKLabelNode(fontNamed: "Courier")
        scoreHUD.text = "00000"
        scoreHUD.zPosition = 7
        scoreHUD.fontSize = 42
        scoreHUD.position = CGPoint(x: 8, y: size.height - scoreHUD.frame.size.height - 8)
        scoreHUD.horizontalAlignmentMode = .left
        addChild(scoreHUD)
        
        for index in 0..<maxLives {
            let life = SKSpriteNode(imageNamed: "life")
            life.setScale(0.04)
            life.zPosition = 5
            life.position = CGPoint(x: 25 + CGFloat(index) * (life.size.width + 5),
                                    y: size.height - life.size.height -
                                        scoreHUD.frame.size.height - 10)
            life.alpha = lives > index ? 1 : 0
            livesHUD.append(life)
            addChild(life)
        }
    }
    
    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public override func didMove(to view: SKView) {
        motionManager = CMMotionManager()
        motionManager?.startAccelerometerUpdates()
    }
    
    override public func update(_ currentTime: TimeInterval) {
        
        if lives < 0 {
            return
        }
        
        processContacts(currentTime)
        processUserMotion(currentTime)
        updateBackground()
        
        if timeStart == 0 {
            timeStart = currentTime
        }
        if currentTime - timeStart > startDelay && timeStart != currentTime {
            /* Bonus */
            if score >= bonusMinScore && !bonusVisible &&
                currentTime - lastBonusTime > bonusSpawnTime {
                dropBonus()
                lastBonusTime = currentTime
            }
            
            /* Bomb */
            if currentTime - lastSpawnTime > bombsSpawnTime {
                let bombLevel = score >= lvl2MinScore && Int(arc4random_uniform(lvl2ProbRange * 1000)) < score ? 1 : 0
                dropBomb(level: bombLevel)
                lastSpawnTime = currentTime
            }
        }
        
        if isTouching && currentTime - lastTouchTime > missilesDelay {
            /* Missile */
            launchMissile()
            lastTouchTime = currentTime
        }
    }
    
    override public func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        isTouching = true
    }
    
    public override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        if let touch = touches.first,
           let planeBody = plane.physicsBody {
            let location = touch.location(in: view)
            let previousLocation = touch.previousLocation(in: view)
            let dx = location.x - previousLocation.x
            let dy = location.y - previousLocation.y
            let dist = Double(sqrt(dx * dx + dy * dy)) * 0.03
            let sign = Double(dx == 0 ? dx : (dx / abs(dx)))
            
            planeBody.applyForce(CGVector(dx: sign * dist * shipMoveFact, dy: 0))
        }
    }
    
    override public func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        isTouching = false
    }
    
    func processUserMotion(_ currentTime: TimeInterval) {
        
        if let manager = motionManager,
           let data = manager.accelerometerData,
           let planeBody = plane.physicsBody,
           fabs(data.acceleration.x) > 0.2 {
            
            var acceleration = data.acceleration.x
            
            switch deviceOrientation {
            case .portraitUpsideDown:
                acceleration = -data.acceleration.x
                
            case .landscapeLeft:
                acceleration = -data.acceleration.y
                
            case .landscapeRight:
                acceleration =  data.acceleration.y
                
            default:
                break
            }
            
            planeBody.applyForce(CGVector(dx: shipMoveFact * acceleration, dy: 0))
        }
    }
    
    func launchMissile() {
        
        let missile = SKSpriteNode(imageNamed: "missile")
        missile.name = NodeName.missile
        missile.setScale(0.1)
        missile.zPosition = 0
        missile.position = plane.position
        
        let missilePhysicsBody = SKPhysicsBody(rectangleOf: missile.size)
        missilePhysicsBody.isDynamic = true
        missilePhysicsBody.affectedByGravity = false
        missilePhysicsBody.categoryBitMask = BitMask.missile.rawValue
        missilePhysicsBody.contactTestBitMask = BitMask.none.rawValue
        missilePhysicsBody.collisionBitMask = BitMask.none.rawValue
        missile.physicsBody = missilePhysicsBody
        addChild(missile)
        
        let actionMove = SKAction.move(to: CGPoint(x: missile.position.x,
                                                   y: self.size.height),
                                       duration: missilesSpeed)
        let actionDone = SKAction.removeFromParent()
        missile.run(SKAction.sequence([actionMove, actionDone]))
    }
    
    func dropBomb(level: Int) {
        
        let bomb = SKSpriteNode(imageNamed: level == 1 ? "starpatrol" : "bomb")
        bomb.name = NodeName.bomb
        bomb.setScale(level == 1 ? 0.195 : 0.165)
        bomb.zPosition = 1
        bomb.position = CGPoint(x: bomb.size.width + CGFloat(arc4random_uniform(UInt32(self.size.width - (2 * bomb.size.width)))),
                                y: self.size.height)
        
        bomb.userData = ["level"  : level,
                         "nbrHit" : 0]
        
        let bombPhysicsBody = SKPhysicsBody(circleOfRadius: bomb.size.width / 2)
        
        bombPhysicsBody.isDynamic = false
        bombPhysicsBody.categoryBitMask = BitMask.bomb.rawValue
        bombPhysicsBody.contactTestBitMask = BitMask.missile.rawValue
        bombPhysicsBody.collisionBitMask = BitMask.missile.rawValue
        bomb.physicsBody = bombPhysicsBody
        addChild(bomb)
        
        let actionMove = SKAction.move(to: CGPoint(x: bomb.position.x,
                                                   y: -self.size.height),
                                       duration: bombShowTime)
        let actionDone = SKAction.removeFromParent()
        bomb.run(SKAction.sequence([actionMove, actionDone]))
    }
    
    func dropBonus() {
        
        bonusVisible = true
        
        let bonus = SKSpriteNode(imageNamed: "bonus")
        bonus.name = NodeName.bonus
        bonus.setScale(0.25)
        bonus.zPosition = 1
        bonus.position = CGPoint(x: bonus.size.width + CGFloat(arc4random_uniform(UInt32(self.size.width - (2 * bonus.size.width)))),
                                 y: self.size.height)
        
        let bonusPhysicsBody = SKPhysicsBody(circleOfRadius: bonus.size.width / 2)
        bonusPhysicsBody.isDynamic = false
        bonusPhysicsBody.affectedByGravity = false
        bonusPhysicsBody.categoryBitMask = BitMask.bonus.rawValue
        bonusPhysicsBody.contactTestBitMask = BitMask.missile.rawValue
        bonusPhysicsBody.collisionBitMask = BitMask.missile.rawValue
        bonus.physicsBody = bonusPhysicsBody
        addChild(bonus)
        
        let actionMove = SKAction.move(to: CGPoint(x: bonus.position.x,
                                                   y: -self.size.height),
                                       duration: bonusShowTime)
        let actionDone = SKAction.removeFromParent()
        let actionAway = SKAction.run {
            self.bonusVisible = false
        }
        bonus.run(SKAction.sequence([actionMove, actionDone, actionAway]))
    }
    
    func updateScore(by diff: Int) {
        
        score += diff
        
        scoreHUD.text = String(format: "%05d", score)
    }
    
    func updateLives(by diff: Int) {
        
        if lives >= maxLives && diff > 0 {
            return
        }
        lives += diff
        
        for (index, HUD) in livesHUD.enumerated() {
            HUD.alpha = lives > index ? 1 : 0
        }
        
        if lives == -1 {
            let loseScene = LoseScene(size: self.size, score: score)
            let reveal = SKTransition.crossFade(withDuration: 1)
            self.view?.presentScene(loseScene, transition: reveal)
        }
    }
    
    public func updateLives(with lifePoints: Int) {
        
        if lifePoints > maxLives && lifePoints < 0 {
            lives = 3
        } else {
            lives = lifePoints
        }
        
        for (index, HUD) in livesHUD.enumerated() {
            HUD.alpha = lives > index ? 1 : 0
        }
        
        if lives < 0 {
            let loseScene = LoseScene(size: self.size, score: score)
            let reveal = SKTransition.crossFade(withDuration: 1)
            self.view?.presentScene(loseScene, transition: reveal)
        }
    }
    
    func updateBackground() {
        
        if background.position.y - 1 == -size.height / 2 {
            background.position = CGPoint(x: background.position.x,
                                          y: size.height * 3 / 2)
        } else {
            background.position = CGPoint(x: background.position.x,
                                          y: background.position.y - 1)
        }
        
        if background2.position.y - 1 == -size.height / 2 {
            background2.position = CGPoint(x: background2.position.x,
                                           y: size.height * 3 / 2)
        } else {
            background2.position = CGPoint(x: background2.position.x,
                                           y: background2.position.y - 1)
        }
    }
    
}

extension SpaceGameScene: SKPhysicsContactDelegate {
    
    public func didBegin(_ contact: SKPhysicsContact) {
        contactQueue.append(contact)
    }
    
    func processContacts(_ currentTime: TimeInterval) {
        for (index, contact) in contactQueue.enumerated() {
            handle(contact)
            contactQueue.remove(at: index)
        }
    }
    
    func handle(_ contact: SKPhysicsContact) {
        
        guard contact.bodyA.node != nil,
              contact.bodyB.node != nil,
              contact.bodyA.node?.parent != nil,
              contact.bodyB.node?.parent != nil else {
                return
        }
        
        let nodes = [contact.bodyA.node, contact.bodyB.node]
        let nodeNames = [contact.bodyA.node?.name,
                         contact.bodyB.node?.name]
        
        if nodeNames.contains(where: { $0 == NodeName.plane }) &&
           nodeNames.contains(where: { $0 == NodeName.bomb }) {
            
            /* Plane crash */
            AudioServicesPlaySystemSound(kSystemSoundID_Vibrate)
            updateLives(by: -1)
            
            if let planeIndex = nodes.index(where: { $0?.name == NodeName.plane }),
                let bombIndex = nodes.index(where: { $0?.name == NodeName.bomb }) {
                
                if lives < 0 {
                    nodes[planeIndex]?.removeFromParent()
                }
                nodes[bombIndex]?.removeFromParent()
            }
        } else if nodeNames.contains(where: { $0 == NodeName.bomb }) &&
            nodeNames.contains(where: { $0 == NodeName.missile }) {
            
            /* Destroyed bomb */
            if let bombIndex = nodes.index(where: { $0?.name == NodeName.bomb }),
                let missileIndex = nodes.index(where: { $0?.name == NodeName.missile }) {
                
                let bomb = nodes[bombIndex]
                let bombLvl = bomb?.userData?.value(forKey: "level") as? Int
                if let nbrHit = bomb?.userData?.value(forKey: "nbrHit") as? Int {
                    bomb?.userData?.setValue(nbrHit + 1, forKey: "nbrHit")
                    
                    if nbrHit == bombLvl2MaxHit || bombLvl == 0 {
                        bomb?.removeFromParent()
                        updateScore(by: bombLvl == 0 ? 1 : bombLvl2MaxHit)
                    }
                }
                nodes[missileIndex]?.removeFromParent()
            }
        } else if nodeNames.contains(where: { $0 == NodeName.bonus }) &&
            nodeNames.contains(where: { $0 == NodeName.missile }) {
            
            /* Missile got bonus */
            updateLives(by: 1)
            contact.bodyA.node?.removeFromParent()
            contact.bodyB.node?.removeFromParent()
            
        } else if nodeNames.contains(where: { $0 == NodeName.plane }) &&
            nodeNames.contains(where: { $0 == NodeName.bonus }) {
            
            /* Plane got bonus */
            updateLives(by: 1)
            
            if let bonusIndex = nodes.index(where: { $0?.name == NodeName.bonus }) {
                nodes[bonusIndex]?.removeFromParent()
            }
        }
    }
}

class LoseScene: SKScene {
    
    init(size: CGSize, score: Int) {
        super.init(size: size)
        
        scaleMode = .aspectFit
        backgroundColor = #colorLiteral(red: 0.1176470588, green: 0.2352941176, blue: 0.5098039216, alpha: 1)
        
        let background = SKSpriteNode(imageNamed: "sky")
        background.zPosition = -1
        background.size = size
        background.position = CGPoint(x: size.width / 2, y: size.height / 2)
        addChild(background)
        
        let shift = size.height / 4
        
        let title = SKLabelNode(fontNamed: "Courier")
        title.text = "**** SCORE ****"
        title.fontSize = 32
        title.position = CGPoint(x: size.width / 2, y: size.height / 2 + shift)
        addChild(title)
        
        let subtitle = SKLabelNode(fontNamed: "Courier")
        subtitle.text = String(score)
        subtitle.fontSize = 100
        subtitle.position = CGPoint(x: size.width / 2, y: size.height / 2)
        addChild(subtitle)
        
        let btnRetry = SKSpriteNode(imageNamed: "btnRetry")
        btnRetry.name = NodeName.btnRetry
        btnRetry.zPosition = 2
        btnRetry.setScale(0.3)
        btnRetry.position = CGPoint(x: size.width / 2, y: size.height / 2 - shift)
        addChild(btnRetry)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        if let touch = touches.first,
           let node = self.nodes(at: touch.location(in: self)).first {
            if node.name == NodeName.btnRetry {
                let scene = SpaceGameScene(size: frame.size)
                scene.scaleMode = .aspectFit
                let reveal = SKTransition.crossFade(withDuration: 1)
                view?.presentScene(scene, transition: reveal)
            }
        }
    }
}
