//: [Previous](@previous)

import SpriteKit
import PlaygroundSupport

struct Skill {
    
    /// Radius
    enum SkillSize: CGFloat {
        case small  = 25
        case medium = 30
        case big    = 42
    }
    
    var name = ""
    var size: SkillSize = .medium
    var fontSize: CGFloat = 30
    
    init(name: String, size: SkillSize = .medium, fontSize: CGFloat = 30) {
        self.name = name
        self.size = size
        self.fontSize = fontSize
    }
}

class SkillNode: SKNode {
    
    let skill: Skill
    
    init(with skill: Skill) {
        
        self.skill = skill
        
        super.init()
        
        let skillNode = SKShapeNode(circleOfRadius: skill.size.rawValue)
        skillNode.fillColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        skillNode.position = self.position
        addChild(skillNode)
        
        let skillText = SKLabelNode(text: skill.name)
        skillText.fontSize = skill.fontSize
        skillText.fontName = UIFont.systemFont(ofSize: skill.fontSize).fontName
        skillText.fontColor = #colorLiteral(red: 0.4666666667, green: 0.4666666667, blue: 0.4666666667, alpha: 1)
        skillText.horizontalAlignmentMode = .center
        skillText.verticalAlignmentMode = .center
        skillText.position = self.position
        addChild(skillText)
        
        let body = SKPhysicsBody(circleOfRadius: skill.size.rawValue)
        body.allowsRotation = false
        body.affectedByGravity = false
        body.linearDamping = 0
        body.restitution = 1.0
        let signX: CGFloat = Int(skill.fontSize) & 1 == 0 ? -1 : 1
        let signY: CGFloat = Int(skill.fontSize) & 2 == 0 ? -1 : 1
        body.velocity = CGVector(dx: signX * skill.size.rawValue,
                                 dy: signY * skill.size.rawValue)
        physicsBody = body
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

class SkillScene: SKScene {
    
    var skills = [Skill(name: "iOS",               size: .big,    fontSize: 35),
                  Skill(name: "Android",           size: .big,    fontSize: 24),
                  Skill(name: "Swift",             size: .big),
                  Skill(name: "Java",              size: .big,    fontSize: 34),
                  Skill(name: "Objective-C",       size: .big,    fontSize: 14),
                  Skill(name: "C",                 size: .big,    fontSize: 40),
                  Skill(name: "C++",               size: .big,    fontSize: 40),
                  Skill(name: "Qt",                size: .big,    fontSize: 40),
                  Skill(name: "Basic",             size: .small,  fontSize: 15),
                  Skill(name: "JavaScript",        size: .big,    fontSize: 16),
                  Skill(name: "Python",            size: .medium, fontSize: 17),
                  Skill(name: "PHP",               size: .big),
                  Skill(name: "SQL",               size: .big),
                  Skill(name: "HTML",              size: .big),
                  Skill(name: "CSS",               size: .big,    fontSize: 35),
                  Skill(name: "JSON",              size: .medium, fontSize: 23),
                  Skill(name: "REST",              size: .small,  fontSize: 16),
                  Skill(name: "XML",               size: .small,  fontSize: 21),
                  Skill(name: "UI/UX",             size: .big),
//                  Skill(name: "2D/3D Graphic Design", size: .medium),
                  Skill(name: "Photoshop",         size: .small,  fontSize: 10),
                  Skill(name: "3DS Max",           size: .small,  fontSize: 11),
                  Skill(name: "Print",             size: .small,  fontSize: 15),
                  Skill(name: "UML",               size: .medium, fontSize: 27),
                  Skill(name: "LaTeX",             size: .medium, fontSize: 22),
                  Skill(name: "Altium",            size: .small,  fontSize: 12),
//                  Skill(name: "VHDL",              size: .small,  fontSize: 17),
//                  Skill(name: "Film Editing"),
                  Skill(name: "Resolume",          size: .small,  fontSize: 10),
                  Skill(name: "macOS",             size: .medium, fontSize: 18),
                  Skill(name: "UNIX",              size: .small,  fontSize: 10),
                  Skill(name: "Raspberry",         size: .small,  fontSize: 10),
                  Skill(name: "Windows",           size: .small,  fontSize: 11),
                  Skill(name: "C#"),
                  Skill(name: "AppleScript",       size: .small,  fontSize: 9),
                  Skill(name: "Assembly",          size: .small,  fontSize: 11),
//                  Skill(name: "OpenGL"),
//                  Skill(name: "Maple"),
//                  Skill(name: "Matlab"),
                  Skill(name: "OpenData",          size: .small,  fontSize: 10),
                  Skill(name: "CAN bus",           size: .small,  fontSize: 12)
//                  Skill(name: "Networks"),
//                  Skill(name: "Management"),
//                  Skill(name: "Hardware"),
//                  Skill(name: "Maintenance"),
//                  Skill(name: "Automatics"),
//                  Skill(name: "Mechanics"),
//                  Skill(name: "Sensors"),
//                  Skill(name: "Microprocessors"),
//                  Skill(name: "Power/commutation electronics", size: .medium),
//                  Skill(name: "Signal processing", size: .medium)
    ]
    
    let field = SKFieldNode.dragField()
    
    override func didMove(to view: SKView) {
        
        field.physicsBody = SKPhysicsBody(circleOfRadius: 42)
        field.physicsBody?.contactTestBitMask = 0
        field.physicsBody?.collisionBitMask = 0
        field.isEnabled = false
        addChild(field)
        
        size = view.frame.size
        scaleMode = .aspectFit
        backgroundColor = #colorLiteral(red: 0.2196078431, green: 0.2196078431, blue: 0.2078431373, alpha: 1)
        physicsBody = SKPhysicsBody(edgeLoopFrom: frame)
        
        for skill in skills {
            let node = SkillNode(with: skill)
            var suggestedPos = CGPoint.zero
            repeat {
                suggestedPos = CGPoint(x: CGFloat(arc4random_uniform(UInt32(frame.width - skill.size.rawValue))),
                                           y: CGFloat(arc4random_uniform(UInt32(frame.height - skill.size.rawValue))))
            } while !nodes(at: suggestedPos).isEmpty
            
            node.position = suggestedPos
            addChild(node)
        }
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        if let touch = touches.first {
            field.position = touch.location(in: self)
            field.isEnabled = true
        }
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        field.isEnabled = false
    }
    
}


let view = SKView(frame: CGRect(x: 0, y: 0, width: 450, height: 600))
view.presentScene(SkillScene())

PlaygroundPage.current.liveView = view


//: [Next](@next)
