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
    
    // Paddle behavior
    var paddlePosition = CGPoint(x: 0.0, y: 0.0)
    
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
        paddlePosition = CGPoint(x: size.width - paddle.size.width * 0.5, y: size.height * 0.5)
        ballPosition = CGPoint(x: size.width * 0.5, y: size.height * 0.5)
        addChild(paddle)
        addChild(ball)
        paddle.position = paddlePosition
        ball.position = ballPosition
        backgroundColor = .black
    }
    
    func updatePaddlePosition(by rotation: CGFloat) {
        let amount = size.height * rotation
        let upperBound = paddle.size.height * 0.5
        let lowerBound = size.height - paddle.size.height * 0.5
        paddlePosition.y += amount
        if paddlePosition.y < upperBound {
            paddlePosition.y = upperBound
        } else if paddlePosition.y > lowerBound {
            paddlePosition.y = lowerBound
        }
        paddle.position = paddlePosition
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
        ball.position = ballPosition
    }
    
    func start() {
        xVelocity = 1.0
        yVelocity = CGFloat.random(in: -0.5...0.5)
    }
    
    func stop() {
        // End the game
    }
    
}
