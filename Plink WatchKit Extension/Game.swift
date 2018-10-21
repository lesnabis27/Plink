//
//  Game.swift
//  Plink WatchKit Extension
//
//  Created by Sam Richardson on 10/20/18.
//  Copyright © 2018 Sam Richardson. All rights reserved.
//

import SpriteKit

class Game: SKScene {

    var paddle = PaddleNode()
    var ball = BallNode()
    var score: Int = 0
    
    // Ball behavior
    var xVelocity = CGFloat(0.0)
    var yVelocity = CGFloat(0.0)
    var ballPosition = CGPoint(x: 0.0, y: 0.0)
    
    
    override init(size: CGSize) {
        super.init(size: size)
        setup()
    }
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }
    
    func setup() {
        ballPosition = CGPoint(x: size.width * 0.5, y: size.height * 0.5)
        addChild(paddle)
        addChild(ball)
    }
    
    func updateBallPosition() {
        if ballPosition.y < 0 || ballPosition.y > size.height {
            yVelocity *= -1
        }
        if ballPosition.x < 0 {
            xVelocity *= -1
        }
        ballPosition.x += xVelocity
        ballPosition.y += yVelocity
    }
    
    func start() {
        xVelocity = 1.0
        yVelocity = CGFloat.random(in: -0.5...0.5)
    }
    
    func stop() {
        // End the game
    }
    
}
