//
//  InterfaceController.swift
//  Plink WatchKit Extension
//
//  Created by Sam Richardson on 10/20/18.
//  Copyright © 2018 Sam Richardson. All rights reserved.
//

import WatchKit
import Foundation

class GameInterfaceController: WKInterfaceController, WKCrownDelegate {
    
    @IBOutlet weak var sceneInterface: WKInterfaceSKScene!
    
    var game: Game?

    override func awake(withContext context: Any?) {
        super.awake(withContext: context)
        let mode = context as? GameType ?? GameType.singles
        game = Game(size: WKInterfaceDevice.current().screenBounds.size, type: mode)
        game!.interfaceDelegate = self
        sceneInterface.presentScene(game!)
        game!.start()
    }
    
    override func willActivate() {
        crownSequencer.delegate = self
        crownSequencer.focus()
        game!.isPaused = false
        super.willActivate()
    }
    
    override func didAppear() {
        // This is the first place this will work
        game!.layoutMargins = systemMinimumLayoutMargins
    }
    
    override func didDeactivate() {
        game!.stop()
        game!.isPaused = true
        super.didDeactivate()
    }
    
    func crownDidRotate(_ crownSequencer: WKCrownSequencer?, rotationalDelta: Double) {
        game!.updatePaddlePosition(by: CGFloat(rotationalDelta))
    }

}
