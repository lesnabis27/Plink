//
//  StartInterfaceController.swift
//  Plink WatchKit Extension
//
//  Created by Sam Richardson on 11/8/18.
//  Copyright © 2018 Sam Richardson. All rights reserved.
//

import WatchKit
import Foundation

class StartInterfaceController: WKInterfaceController {

    @IBAction func singlesButtonPressed() {
        startSinglesGame()
    }
    
    @IBAction func doublesButtonPressed() {
        startDoublesGame()
    }
    
    override func awake(withContext context: Any?) {
        super.awake(withContext: context)
    }

    override func willActivate() {
        super.willActivate()
    }

    override func didDeactivate() {
        super.didDeactivate()
    }
    
    func startSinglesGame() {
        pushController(withName: "game", context: GameType.singles)
    }
    
    func startDoublesGame() {
        pushController(withName: "game", context: GameType.doubles)
    }

}
