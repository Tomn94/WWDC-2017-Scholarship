import SpriteKit
import PlaygroundSupport

class Person: SKSpriteNode {
    
    static let appearances = []
    
    convenience init() {
        self.init(imageNamed: "can")
        
        let body = SKPhysicsBody(circleOfRadius: 10)
        body.affectedByGravity = false
        self.physicsBody = body
    }
    
}

class WWDCScene: SKScene {
    
    let title = SKLabelNode(text: "Rejoice for WWDC17!")
    
    override func didMove(to view: SKView) {
        backgroundColor = #colorLiteral(red: 0.9725490196, green: 0.9725490196, blue: 0.9725490196, alpha: 1)
        
        scaleMode = .resizeFill
        
        title.position = self.view?.center ?? .zero
        title.fontName = UIFont.boldSystemFont(ofSize: 22).fontName
        title.fontColor = #colorLiteral(red: 0.2352941176, green: 0.2352941176, blue: 0.2352941176, alpha: 1)
        addChild(title)
        
        self.physicsBody = SKPhysicsBody(edgeLoopFrom: frame)
        
        let person = Person()
        person.position = view.center
        addChild(person)
    }
    
    override func didChangeSize(_ oldSize: CGSize) {
        super.didChangeSize(oldSize)
        
        title.position = self.view?.center ?? .zero
    }
}

let mainView = SKView(frame: CGRect(x: 0, y: 0, width: 400, height: 400))

let scene = WWDCScene(size: mainView.frame.size)
mainView.presentScene(scene)

PlaygroundPage.current.liveView = mainView