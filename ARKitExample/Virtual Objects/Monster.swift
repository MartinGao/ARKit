/*
 See LICENSE folder for this sample’s licensing information.
 
 Abstract:
 The virtual vase.
 */

import Foundation
import SceneKit

class Monster: VirtualObject {
    
    override init() {
        super.init(modelName: "testOne", fileExtension: "dae", thumbImageFilename: "vase", title: "vase")
    }
    
    init(title:String) {
        super.init(modelName: "testOne", fileExtension: "dae", thumbImageFilename: "vase", title: title)
        self.scale = SCNVector3Make(0.05, 0.05, 0.05)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}


