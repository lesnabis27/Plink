//
//  Game.swift
//  Plink WatchKit Extension
//
//  Created by Sam Richardson on 10/20/18.
//  Copyright © 2018 Sam Richardson. All rights reserved.
//

import SpriteKit

class Game: SKScene, SKPhysicsContactDelegate {

    var paddle = PaddleNode()
    var ball = BallNode()
    var scoreLabel = ScoreNode()
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
        // Set up the world
        backgroundColor = .black
        physicsBody = SKPhysicsBody(edgeLoopFrom: frame)
        physicsWorld.contactDelegate = self
        physicsWorld.gravity = CGVector(dx: 0.0, dy: 0.0)
        // Set up paddle and ball nodes
        paddlePosition = CGPoint(x: size.width - paddle.size.width * 0.5, y: size.height * 0.5)
        ballPosition = CGPoint(x: size.width * 0.5, y: size.height * 0.5)
        paddle.position = paddlePosition
        ball.position = ballPosition
        addChild(paddle)
        addChild(ball)
        // Set up the score node
        scoreLabel.position = CGPoint(x: 0.0, y: size.height)
        addChild(scoreLabel)
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
        ball.physicsBody?.applyImpulse(CGVector(dx: -0.5, dy: yVelocity))
    }
    
    func stop() {
        // End the game
    }
    
    // Collisions
    
    func didBegin(_ contact: SKPhysicsContact) {
        if contact.bodyA.node?.name == "ball" {
            collisionBetween(ball: contact.bodyA.node!, object: contact.bodyB.node!)
        }
    }
    
    func collisionBetween(ball: SKNode, object: SKNode) {
        if object.name == "paddle" {
            score += 1
            scoreLabel.text = String(score)
        }
    }
    
}
