//
//  EdgeBody.swift
//  Snake_leson8
//
//  Created by Lesya Os on 02/10/2019.
//  Copyright © 2019 Lesya Os. All rights reserved.
//

import Foundation
import UIKit
import SpriteKit

class EdgeBody: SKShapeNode {
    
    
   convenience init (position: CGPoint){
        self.init()
        
        self.physicsBody = SKPhysicsBody()
        self.physicsBody?.categoryBitMask = collisionCategory.EdgeBody
        self.physicsBody?.contactTestBitMask = collisionCategory.SnakeHead
    }
}
