//
//  GameScene.swift
//  Snake_leson8
//
//  Created by Lesya Os on 29/09/2019.
//  Copyright © 2019 Lesya Os. All rights reserved.
//

import SpriteKit
import GameplayKit

struct collisionCategory {
    static let Snake: UInt32 = 0x1 << 0
    static let SnakeHead: UInt32 = 0x1 << 1
    static let Apple: UInt32 = 0x1 << 2
    static let EdgeBody: UInt32 = 0x1 << 3
}

class GameScene: SKScene {

    var snake: Snake?
   
    override func didMove(to view: SKView) {
        
        self.physicsWorld.contactDelegate = self
        
        backgroundColor = SKColor.black
        self.physicsWorld.gravity = CGVector(dx: 0, dy: 0)
        self.physicsBody = SKPhysicsBody(edgeLoopFrom: frame)
        self.physicsBody?.allowsRotation = false
        
        view.showsPhysics = true
        
        
        let counterClockwiseButton = SKShapeNode()
        
        counterClockwiseButton.path = UIBezierPath(ovalIn: CGRect(x: 0, y: 0, width: 45, height: 45)).cgPath
        
        counterClockwiseButton.position = CGPoint(x:view.scene!.frame.minX+30, y: view.scene!.frame.minY+30)
        
        counterClockwiseButton.fillColor = UIColor.gray
        counterClockwiseButton.strokeColor = UIColor.gray
        counterClockwiseButton.lineWidth = 10
        
        counterClockwiseButton.name = "counterClockwiseButton"
        
        self.addChild(counterClockwiseButton)
        
        
        let clockWiseButton = SKShapeNode()
        clockWiseButton.path = UIBezierPath(ovalIn: CGRect(x: 0, y: 0, width: 45, height: 45)).cgPath
        
        clockWiseButton.position = CGPoint(x: view.scene!.frame.maxX-80, y: view.scene!.frame.minY+30)
        
        clockWiseButton.fillColor = UIColor.gray
        clockWiseButton.strokeColor = UIColor.gray
        
        clockWiseButton.lineWidth = 10
        
        clockWiseButton.name = "clockWiseButton"
        self.addChild(clockWiseButton)
        
        createApple()
        
        snake = Snake(atPoint: CGPoint(x: view.scene!.frame.midX, y: view.scene!.frame.midY))
        self.addChild(snake!)
        
        self.physicsBody?.categoryBitMask = collisionCategory.EdgeBody
        self.physicsBody?.collisionBitMask = collisionCategory.Snake | collisionCategory.SnakeHead
        
    }
    
    func createApple() {
        
        let randX = CGFloat(arc4random_uniform(UInt32(view!.scene!.frame.maxX-5)) + 1)
        let randY = CGFloat(arc4random_uniform(UInt32(view!.scene!.frame.maxY-5)) + 1)
        
        let apple = Apple(position: CGPoint(x: randX, y: randY))
        
        self.addChild(apple)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        for touch in touches {
            let coordinate = touch.location(in: self)
            
            guard let touchesNode = self.atPoint(coordinate) as? SKShapeNode, touchesNode.name == "counterClockwiseButton" || touchesNode.name == "clockWiseButton" else {
                return
            }
            
            touchesNode.fillColor = UIColor.red
            
            
            if touchesNode.name == "counterClockwiseButton"{
                snake!.moveCounterClockWise()
            } else if touchesNode.name == "clockWiseButton"{
                snake!.moveClockwise()
            }
            
        }
    }
    
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        
        for touch in touches {
            let coordinate = touch.location(in: self)
            
            guard let touchesNode = self.atPoint(coordinate) as? SKShapeNode, touchesNode.name == "counterClockwiseButton" || touchesNode.name == "clockWiseButton" else {
                return
            }
            
            touchesNode.fillColor = UIColor.gray
            
        }
        
        
    }
    
    override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {
        
    }
    
    
    override func update(_ currentTime: TimeInterval) {
        // Called before each frame is rendered
        snake!.move()
    }
}

extension GameScene: SKPhysicsContactDelegate {
    func didBegin(_ contact: SKPhysicsContact) {
        
        let bodyes = contact.bodyA.categoryBitMask | contact.bodyB.categoryBitMask
        
        let collisionObject = bodyes - collisionCategory.SnakeHead
        
        switch collisionObject {
        case collisionCategory.Apple:
            let apple = contact.bodyA.node is Apple ? contact.bodyA.node : contact.bodyB.node
            snake?.addBodyPart()
            apple?.removeFromParent()
            createApple()
        case collisionCategory.EdgeBody:
            let snake = contact.bodyA.node is Snake ? contact.bodyA.node : contact.bodyB.node
            snake?.removeFromParent()
            snake!.updateFocusIfNeeded()
            //home work
        default:
            break
        }
        
    }
}
