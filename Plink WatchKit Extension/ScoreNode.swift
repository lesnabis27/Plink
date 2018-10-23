//
//  ScoreNode.swift
//  Plink WatchKit Extension
//
//  Created by Sam Richardson on 10/22/18.
//  Copyright © 2018 Sam Richardson. All rights reserved.
//

import SpriteKit

class ScoreNode: SKLabelNode {
    
    override init() {
        super.init()
        setup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }
    
    func setup() {
        text = "Plink"
        fontName = "San Francisco"
        fontSize = 16
        fontColor = UIColor.white
        horizontalAlignmentMode = .left
        verticalAlignmentMode = .top
    }

}
