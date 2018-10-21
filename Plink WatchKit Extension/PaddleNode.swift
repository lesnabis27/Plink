//
//  PaddleNode.swift
//  Plink WatchKit Extension
//
//  Created by Sam Richardson on 10/20/18.
//  Copyright © 2018 Sam Richardson. All rights reserved.
//

import SpriteKit

class PaddleNode: SKSpriteNode {
    
    let image = SKTexture(imageNamed: "paddle")
    
    init() {
        super.init(texture: image, color: .clear, size: image.size())
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }

}
