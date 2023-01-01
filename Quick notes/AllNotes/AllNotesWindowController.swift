//
//  AllNotesWindowController.swift
//  Quick notes
//
//  Created by Nils Lahaye on 2022-12-14.
//

import Cocoa

class AllNotesWindowController: NSWindowController {

    override func windowDidLoad() {
        super.windowDidLoad()
    
    }
    
    static let shared: AllNotesWindowController = {
        let wc = NSStoryboard(name:"Main", bundle: nil).instantiateController(withIdentifier: "all-notes-win") as! AllNotesWindowController
        return wc
    }()

}
