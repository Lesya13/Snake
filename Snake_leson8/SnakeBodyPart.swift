//
//  SnakeBodyPart.swift
//  Snake_leson8
//
//  Created by Lesya Os on 29/09/2019.
//  Copyright © 2019 Lesya Os. All rights reserved.
//

import Foundation
import UIKit
import SpriteKit

class snakeBodyPart: SKShapeNode {
    
    let diametr = 10
    
    init (atPoint point: CGPoint) {
        
        super.init()
        
        path = UIBezierPath(ovalIn: CGRect(x: 0, y: 0, width: CGFloat(diametr), height: CGFloat(diametr))).cgPath
        
        fillColor = UIColor.green
        strokeColor = UIColor.green
        
        lineWidth = 5
        
        self.position = point
        
        self.physicsBody = SKPhysicsBody(circleOfRadius: CGFloat(diametr - 4), center: CGPoint(x:5, y:5))
        self.physicsBody?.categoryBitMask = collisionCategory.Snake
        self.physicsBody?.contactTestBitMask = collisionCategory.EdgeBody | collisionCategory.Apple
        
        self.physicsBody?.isDynamic = true
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
