//
//  SnakeHead.swift
//  Snake_leson8
//
//  Created by Lesya Os on 29/09/2019.
//  Copyright © 2019 Lesya Os. All rights reserved.
//

import Foundation
import UIKit

class snakeHead: snakeBodyPart {
    
    override init(atPoint point: CGPoint) {
        super.init(atPoint: point)
        self.physicsBody?.categoryBitMask = collisionCategory.SnakeHead
        self.physicsBody?.contactTestBitMask = collisionCategory.Apple | collisionCategory.EdgeBody | collisionCategory.Snake
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
