//
//  InterfaceController.swift
//  Plink WatchKit Extension
//
//  Created by Sam Richardson on 10/20/18.
//  Copyright © 2018 Sam Richardson. All rights reserved.
//

import WatchKit
import Foundation


class InterfaceController: WKInterfaceController {
    
    // IBOutlets
    @IBOutlet weak var sceneInterface: WKInterfaceSKScene!
    
    let gameScene = Game(size: WKInterfaceDevice.current().screenBounds.size)

    override func awake(withContext context: Any?) {
        super.awake(withContext: context)
        
        // Configure interface objects here.
        sceneInterface.presentScene(gameScene)
    }
    
    override func willActivate() {
        // This method is called when watch view controller is about to be visible to user
        gameScene.start()
        super.willActivate()
    }
    
    override func didDeactivate() {
        // This method is called when watch view controller is no longer visible
        gameScene.stop()
        super.didDeactivate()
    }

}
