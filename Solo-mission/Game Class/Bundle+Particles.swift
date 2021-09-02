//
//  Bundle+Particles.swift
//  solo-mission
//
//  Created by Praveen on 13/07/2016.
//  Copyright © 2016 Praveen. All rights reserved.
//

import SpriteKit

extension Bundle {
    
    func emitterNode(_ name: String) -> SKEmitterNode? {
        guard let path = self.path(forResource: name, ofType: "sks") else {
            return nil
        }
        if let emitter = NSKeyedUnarchiver.unarchiveObject(withFile: path) as? SKEmitterNode {
            return emitter
        }
        return nil
    }
    
}
