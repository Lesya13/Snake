//
//  Apple.swift
//  Snake_leson8
//
//  Created by Lesya Os on 29/09/2019.
//  Copyright © 2019 Lesya Os. All rights reserved.
//

import Foundation
import UIKit
import SpriteKit

class Apple: SKShapeNode {
    
    
    convenience init (position: CGPoint){
        self.init()
        path = UIBezierPath(ovalIn: CGRect(x: 0, y: 0, width: 10, height: 10)).cgPath
        fillColor = UIColor.red
        strokeColor = UIColor.red
        lineWidth = 5
        self.position = position
        
        self.physicsBody = SKPhysicsBody(circleOfRadius: 10.0, center: CGPoint(x:5,y:5))
        self.physicsBody?.categoryBitMask = collisionCategory.Apple
    }
}
