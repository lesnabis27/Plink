//
//  Game.swift
//  Plink WatchKit Extension
//
//  Created by Sam Richardson on 10/20/18.
//  Copyright © 2018 Sam Richardson. All rights reserved.
//

import SpriteKit

class Game: SKScene, SKPhysicsContactDelegate {

    // MARK: - Properties
    
    // Owning interface controller
    var interfaceDelegate: InterfaceController?
    
    // Nodes and such
    var paddle = PaddleNode()
    var ball = BallNode()
    var scoreLabel = ScoreNode()
    var score: Int = 0 {
        didSet {
            scoreLabel.text = String(score)
        }
    }
    
    // Insets
    var layoutMargins = NSDirectionalEdgeInsets() {
        didSet {
            scoreLabel.position = CGPoint(x: layoutMargins.leading,
                                          y: frame.maxY - layoutMargins.leading)
        }
    }
    
    // MARK: - Initializers
    
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
        paddle.position = CGPoint(x: size.width - paddle.size.width * 0.5, y: size.height * 0.5)
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
    
    // MARK: - Game
    
    func centerBall() {
        ball.position = CGPoint(x: size.width * 0.5, y: size.height * 0.5)
    }
    
    func updatePaddlePosition(by rotation: CGFloat) {
        let amount = size.height * rotation
        let upperBound = paddle.size.height * 0.5
        let lowerBound = size.height - paddle.size.height * 0.5
        paddle.position.y += amount
        if paddle.position.y < upperBound {
            paddle.position.y = upperBound
        } else if paddle.position.y > lowerBound {
            paddle.position.y = lowerBound
        }
    }
    
    // Countdown and launch the ball
    func start() {
        let countdown = SKAction.run {
            self.scoreLabel.countDown()
        }
        let launch = SKAction.run {
            self.ball.launch()
        }
        centerBall()
        self.run(SKAction.sequence([countdown, SKAction.wait(forDuration: 3.0), launch]))
    }
    
    // Reset the game and show the game over screen
    func stop() {
        interfaceDelegate!.pushController(withName: "gameOver", context: score)
    }
    
    // Catch each frame
    override func update(_ currentTime: TimeInterval) {
        if ball.frame.minX > frame.maxX {
            stop()
        }
    }
    
    // MARK: - Collisions

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
