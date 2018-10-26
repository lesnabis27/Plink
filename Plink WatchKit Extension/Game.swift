//
//  Game.swift
//  Plink WatchKit Extension
//
//  Created by Sam Richardson on 10/20/18.
//  Copyright © 2018 Sam Richardson. All rights reserved.
//

import SpriteKit

class Game: SKScene, SKPhysicsContactDelegate {

    var interfaceDelegate: InterfaceController?
    
    var paddle = PaddleNode()
    var ball = BallNode()
    var scoreLabel = ScoreNode()
    var score: Int = 0
    
    // Paddle behavior
    var paddlePosition = CGPoint(x: 0.0, y: 0.0)
    
    // Ball behavior
    var ballPosition = CGPoint(x: 0.0, y: 0.0)
    
    // Insets
    var layoutMargins = NSDirectionalEdgeInsets() {
        didSet {
            scoreLabel.position = CGPoint(x: layoutMargins.leading,
                                          y: frame.maxY - layoutMargins.leading)
        }
    }
    
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
        physicsWorld.gravity = CGVector(dx: 0.0, dy: 0.0)
        physicsBody = SKPhysicsBody(edgeChainFrom: makeOpenEdgePath())
        physicsWorld.contactDelegate = self
        // Set up paddle and ball nodes
        paddlePosition = CGPoint(x: size.width - paddle.size.width * 0.5, y: size.height * 0.5)
        paddle.position = paddlePosition
        centerBall()
        addChild(paddle)
        addChild(ball)
        // Set up the score node
        addChild(scoreLabel)
    }
    
    func makeOpenEdgePath() -> CGPath {
        let path = UIBezierPath()
        path.move(to: CGPoint(x: frame.maxX, y: frame.minY))
        path.addLine(to: CGPoint(x: frame.minX, y: frame.minY))
        path.addLine(to: CGPoint(x: frame.minX, y: frame.maxY))
        path.addLine(to: CGPoint(x: frame.maxX, y: frame.maxY))
        return path.cgPath
    }
    
    func centerBall() {
        ballPosition = CGPoint(x: size.width * 0.5, y: size.height * 0.5)
        ball.position = ballPosition
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
    
    func start() {
        centerBall()
        ball.beginMove()
    }
    
    func stop() {
        interfaceDelegate!.pushController(withName: "gameOver", context: score)
    }
    
    override func update(_ currentTime: TimeInterval) {
        if ball.frame.minX > frame.maxX {
            stop()
        }
    }
    
    // Collisions
    
    func didBegin(_ contact: SKPhysicsContact) {
        if contact.bodyA.node?.name == "ball" {
            collisionBetween(ball: contact.bodyA.node!, object: contact.bodyB.node!)
        } else if contact.bodyB.node?.name == "ball" {
            collisionBetween(ball: contact.bodyB.node!, object: contact.bodyA.node!)
        }
    }
    
    func collisionBetween(ball: SKNode, object: SKNode) {
        if object.name == "paddle" {
            score += 1
            scoreLabel.text = String(score)
        }
    }
    
}
