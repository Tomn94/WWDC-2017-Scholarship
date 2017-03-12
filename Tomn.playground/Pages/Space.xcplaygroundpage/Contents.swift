//: [Previous](@previous)

import SpriteKit

class GameScene: SKScene, SKPhysicsContactDelegate {
    
}

enum NodeName {
    static let btnRetry = "btnRetry"
}

class LoseScene: SKScene {
    init(size: CGSize, score: Int) {
        super.init(size: size)
        
        scaleMode = .aspectFill
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
        if let location = touches.first?.location(in: self),
           let node = self.nodes(at: location).first {
            if node.name == NodeName.btnRetry {
                
            }
        }
    }
}

import PlaygroundSupport

let frameSize = CGSize(width: 500, height: 500)
let scene = GameScene(size: frameSize)
scene.scaleMode = .aspectFill
let view = SKView(frame: CGRect(origin: CGPoint.zero, size: frameSize))
view.presentScene(LoseScene(size: frameSize, score: 42))
PlaygroundPage.current.liveView = view

//: [Next](@next)
