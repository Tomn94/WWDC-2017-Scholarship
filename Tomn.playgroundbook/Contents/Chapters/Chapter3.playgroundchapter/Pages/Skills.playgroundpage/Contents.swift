/*:
 - callout(Skills): I'm **curious** and I always want to **discover** new technologies. This has helped me learn the following ones…
 */

//#-hidden-code

import SpriteKit
import PlaygroundSupport

let scene = SkillScene()
//#-end-hidden-code
//: Change physics
scene.velocityFact = /*#-editable-code Change physics*/1/*#-end-editable-code*/
/*:
 - note: Sweep the bubbles to make them move
 */

//: Edit skills bubbles, their importance, and the text size inside. Comment one to hide it from the view
//#-editable-code
scene.skills = [
      Skill(name: "iOS",               size: .big,    fontSize: 35),
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
//      Skill(name: "2D/3D Graphic Design", size: .medium),
      Skill(name: "Photoshop",         size: .small,  fontSize: 10),
      Skill(name: "3DS Max",           size: .small,  fontSize: 11),
      Skill(name: "Print",             size: .small,  fontSize: 15),
      Skill(name: "UML",               size: .medium, fontSize: 27),
      Skill(name: "LaTeX",             size: .medium, fontSize: 22),
      Skill(name: "Altium",            size: .small,  fontSize: 12),
//      Skill(name: "VHDL",              size: .small,  fontSize: 17),
//      Skill(name: "Film Editing"),
      Skill(name: "Resolume",          size: .small,  fontSize: 10),
      Skill(name: "macOS",             size: .medium, fontSize: 17),
      Skill(name: "UNIX",              size: .small,  fontSize: 14),
      Skill(name: "Raspberry",         size: .small,  fontSize: 10),
      Skill(name: "Windows",           size: .small,  fontSize: 11),
      Skill(name: "C#"),
      Skill(name: "AppleScript",       size: .small,  fontSize: 9),
      Skill(name: "Assembly",          size: .small,  fontSize: 11),
//      Skill(name: "OpenGL"),
//      Skill(name: "Maple"),
//      Skill(name: "Matlab"),
      Skill(name: "OpenData",          size: .small,  fontSize: 10),
      Skill(name: "CAN bus",           size: .small,  fontSize: 12)
//      Skill(name: "Networks"),
//      Skill(name: "Management"),
//      Skill(name: "Hardware"),
//      Skill(name: "Maintenance"),
//      Skill(name: "Automatics"),
//      Skill(name: "Mechanics"),
//      Skill(name: "Sensors"),
//      Skill(name: "Microprocessors"),
//      Skill(name: "Power/commutation electronics", size: .medium),
//      Skill(name: "Signal processing", size: .medium)
    ]

//#-end-editable-code
//#-hidden-code

let view = SKView(frame: CGRect(x: 0, y: 0, width: 450, height: 600))
view.presentScene(scene)

PlaygroundPage.current.liveView = view
//#-end-hidden-code