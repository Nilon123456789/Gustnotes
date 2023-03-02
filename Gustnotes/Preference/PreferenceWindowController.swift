//
//  PreferenceWindowController.swift
//  Gustnotes
//
//  Created by Nils Lahaye on 2022-12-14.
//

import Cocoa


class PreferenceWindowController: NSWindowController {

    override func windowDidLoad() {
        super.windowDidLoad()
    
        
    }
    
    static let shared: PreferenceWindowController = {
        let wc = NSStoryboard(name:"Main", bundle: nil).instantiateController(withIdentifier: "pref-win") as! PreferenceWindowController
        return wc
    }()
    
    override func keyDown(with event: NSEvent) {
        super.keyDown(with: event)
        if let vc = self.contentViewController as? PreferenceViewController, vc.listening {
            vc.updateGlobalShortcut(event)
        }
    }
    
    
}
