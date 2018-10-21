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
        sceneInterface.presentScene(gameScene)
    }
    
    override func willActivate() {
        crownSequencer.delegate = self
        crownSequencer.focus()
        gameScene.start()
        super.willActivate()
    }
    
    override func didDeactivate() {
        gameScene.stop()
        super.didDeactivate()
    }
    
    func crownDidRotate(_ crownSequencer: WKCrownSequencer?, rotationalDelta: Double) {
        gameScene.updatePaddlePosition(by: CGFloat(rotationalDelta))
    }

}
