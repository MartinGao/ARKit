/*
See LICENSE folder for this sample’s licensing information.

Abstract:
Wrapper SceneKit node for virtual objects placed into the AR scene.
*/

import Foundation
import SceneKit
import ARKit

class VirtualObject: SCNNode {
	
	var modelName: String = ""
	var fileExtension: String = ""
	var thumbImage: UIImage!
	var title: String = ""
	var modelLoaded: Bool = false
	
	var viewController: ViewController?
	
	override init() {
		super.init()
		self.name = "Virtual object root node"
	}
	
	init(modelName: String, fileExtension: String, thumbImageFilename: String, title: String) {
		super.init()
		self.name = "Virtual object root node"
		self.modelName = modelName
		self.fileExtension = fileExtension
		self.thumbImage = UIImage(named: thumbImageFilename)
		self.title = title
	}
	
	required init?(coder aDecoder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
	func loadModel() {
		guard let virtualObjectScene = SCNScene(named: "\(modelName).\(fileExtension)", inDirectory: "Models.scnassets/\(modelName)") else {
            print("failed loading obj", modelName, fileExtension)
			return
		}
        print("[DEBUG] About to load obj \(modelName).\(fileExtension)")
		
		let wrapperNode = SCNNode()
        
//        print("[DEBUG] virtualObjectScene.rootNode \(virtualObjectScene.rootNode)")
//        print("[DEBUG] virtualObjectScene.rootNode.animationKeys \(virtualObjectScene.rootNode.animationKeys)")
        
		for child in virtualObjectScene.rootNode.childNodes {
//            print("[DEBUG] child \(child) \(child.name)")
//            print(child.animationKeys)
//            for key in child.animationKeys {
//                print("[DEBUG] key \(key)")
//                let animationPlayer = child.animationPlayer(forKey: key)
//                print("[DEBUG] animationPlayer \(animationPlayer)")
//                animationPlayer?.animation.duration = 5
//                animationPlayer?.stop()
//                print("[DEBUG] animationPlayer \(animationPlayer)")
//            }
			child.geometry?.firstMaterial?.lightingModel = .physicallyBased
			child.movabilityHint = .movable
            if (child.name == "Camera") {
                
            } else {
                wrapperNode.addChildNode(child)
                wrapperNode.removeAllAnimations()
                print("\n[DEBUG] wrapperNode addChildNode \(String(describing: child.name))")
                for child1 in child.childNodes {
//                    child1.removeAllAnimations()
                    print("==== [DEBUG] child1 \(String(describing: child1.name))")
                    print("==== [DEBUG] child1 animationKeys \(child1.animationKeys)")
                    let animationPlayer = child1.animationPlayer(forKey: child1.animationKeys[0])
                    animationPlayer?.speed = 0.824653125
                    print("==== [DEBUG] child1 animationPlayer[0] \(String(describing: animationPlayer))")
                    for child2 in child1.childNodes {
//                        child2.removeAllAnimations()
                        print("==== ==== [DEBUG] child1.child2 \(String(describing: child2.name))")
                        for child3 in child2.childNodes {
//                            child3.removeAllAnimations()
                            print("==== ==== ==== [DEBUG] child2.child3 \(String(describing: child3.name))")
                        }
                    }
                }
            }
		}
		self.addChildNode(wrapperNode)
		
		modelLoaded = true
	}
	
	func unloadModel() {
		for child in self.childNodes {
			child.removeFromParentNode()
		}
		
		modelLoaded = false
	}
	
	func translateBasedOnScreenPos(_ pos: CGPoint, instantly: Bool, infinitePlane: Bool) {
		
		guard let controller = viewController else {
			return
		}
		
		let result = controller.worldPositionFromScreenPosition(pos, objectPos: self.position, infinitePlane: infinitePlane)

		controller.moveVirtualObjectToPosition(result.position, instantly, !result.hitAPlane)
	}
}

extension VirtualObject {
	
	static func isNodePartOfVirtualObject(_ node: SCNNode) -> Bool {
		if node.name == "Virtual object root node" {
			return true
		}
		
		if node.parent != nil {
			return isNodePartOfVirtualObject(node.parent!)
		}
		
		return false
	}
	
	static let availableObjects: [VirtualObject] = [
//        Candle(),
//        Cup(),
//        Vase(),
//        Lamp(),
//        Chair(),
        Monster(title: "Monster 1"),
        Monster(title: "Monster 2"),
        Monster(title: "Monster 3"),
        Monster(title: "Monster 4"),
        Monster(title: "Monster 5"),
        Monster(title: "Monster 6"),
        Monster(title: "Monster 7"),
        Monster(title: "Monster 8"),
        Monster(title: "Monster 9"),
        Monster(title: "Monster 10"),
        Monster(title: "Monster 11"),
        Monster(title: "Monster 12")
	]
}

// MARK: - Protocols for Virtual Objects

protocol ReactsToScale {
	func reactToScale()
}

extension SCNNode {
	
	func reactsToScale() -> ReactsToScale? {
		if let canReact = self as? ReactsToScale {
			return canReact
		}
		
		if parent != nil {
			return parent!.reactsToScale()
		}
		
		return nil
	}
}
