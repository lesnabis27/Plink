//
//  BallNode.swift
//  Plink WatchKit Extension
//
//  Created by Sam Richardson on 10/20/18.
//  Copyright © 2018 Sam Richardson. All rights reserved.
//

import SpriteKit

class BallNode: SKSpriteNode {
    
    let image = SKTexture(imageNamed: "ball")
    
    init() {
        super.init(texture: image, color: .clear, size: image.size())
        setup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }
    
    func setup() {
        name = "ball"
        physicsBody = SKPhysicsBody(circleOfRadius: size.width * 0.5)
        physicsBody?.usesPreciseCollisionDetection = true
        physicsBody?.isDynamic = true
        physicsBody?.restitution = 1.0
        physicsBody?.friction = 0.0
        physicsBody?.linearDamping = 0.0
        physicsBody?.allowsRotation = false
        physicsBody?.contactTestBitMask = physicsBody!.collisionBitMask
    }
    
    func beginMove() {
        let wait = SKAction.wait(forDuration: 1.0)
        let move = SKAction.applyImpulse(CGVector(dx: 0.5, dy: CGFloat.random(in: -0.5...0.5)), duration: 0.1)
        let sequence = SKAction.sequence([wait, move])
        run(sequence)
    }

}
