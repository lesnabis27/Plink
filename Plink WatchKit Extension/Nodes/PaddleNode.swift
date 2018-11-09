//
//  PaddleNode.swift
//  Plink WatchKit Extension
//
//  Created by Sam Richardson on 10/20/18.
//  Copyright © 2018 Sam Richardson. All rights reserved.
//

import SpriteKit

class PaddleNode: SKSpriteNode {
    
    let image = SKTexture(imageNamed: "paddle")
    
    init() {
        super.init(texture: image, color: .clear, size: image.size())
        setup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }
    
    func setup() {
        name = "paddle"
        physicsBody = SKPhysicsBody(rectangleOf: size)
        physicsBody?.isDynamic = false
        physicsBody?.friction = 0.0
        physicsBody?.contactTestBitMask = physicsBody!.collisionBitMask
    }

}
