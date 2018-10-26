//
//  InterfaceController.swift
//  Plink WatchKit Extension
//
//  Created by Sam Richardson on 10/20/18.
//  Copyright © 2018 Sam Richardson. All rights reserved.
//

import WatchKit
import Foundation

class InterfaceController: WKInterfaceController, WKCrownDelegate {
    
    @IBOutlet weak var sceneInterface: WKInterfaceSKScene!
    
    let gameScene = Game(size: WKInterfaceDevice.current().screenBounds.size)

    override func awake(withContext context: Any?) {
        super.awake(withContext: context)
        gameScene.interfaceDelegate = self
        sceneInterface.presentScene(gameScene)
        gameScene.start()
    }
    
    override func willActivate() {
        crownSequencer.delegate = self
        crownSequencer.focus()
        gameScene.scaleMode = .aspectFit
        gameScene.isPaused = false
        super.willActivate()
    }
    
    override func didAppear() {
        // This is the first place this will work
        gameScene.layoutMargins = systemMinimumLayoutMargins
    }
    
    override func didDeactivate() {
        gameScene.stop()
        gameScene.isPaused = true
        super.didDeactivate()
    }
    
    func crownDidRotate(_ crownSequencer: WKCrownSequencer?, rotationalDelta: Double) {
        gameScene.updatePaddlePosition(by: CGFloat(rotationalDelta))
    }

}
