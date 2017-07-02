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
        self.scale = SCNVector3Make(0.06, 0.06, 0.06)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}


