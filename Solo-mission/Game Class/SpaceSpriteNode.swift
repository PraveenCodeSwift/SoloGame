//
//  SpaceSpriteNode.swift
//  solo-mission
//
//  Created by Praveen on 11/07/2016.
//  Copyright © 2016 Praveen. All rights reserved.
//

import SpriteKit

enum SpaceSpriteNodeType {
    case Unkown
    case Planet
}

class SpaceSpriteNode: SKSpriteNode {
    var speedMultiplier: TimeInterval = 1.0
    var removeOnSceneExit: Bool = true
    var type: SpaceSpriteNodeType = SpaceSpriteNodeType.Unkown
}
