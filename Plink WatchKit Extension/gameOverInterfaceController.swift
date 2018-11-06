//
//  gameOverInterfaceController.swift
//  Plink WatchKit Extension
//
//  Created by Sam Richardson on 10/25/18.
//  Copyright © 2018 Sam Richardson. All rights reserved.
//

import WatchKit
import Foundation


class gameOverInterfaceController: WKInterfaceController {

    @IBOutlet weak var scoreLabel: WKInterfaceLabel!
    
    override func awake(withContext context: Any?) {
        super.awake(withContext: context)
        setTitle("Play Again")
        if context != nil {
            let contextInt = context as! Int
            scoreLabel.setText(String(contextInt))
        } else {
            scoreLabel.setText("Error")
        }
    }

    override func willActivate() {
        super.willActivate()
    }

    override func didDeactivate() {
        super.didDeactivate()
    }

}
