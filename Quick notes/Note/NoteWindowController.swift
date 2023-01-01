//
//  NoteWindowController.swift
//  Quick notes
//
//  Created by Nils Lahaye on 2022-12-14.
//

import Cocoa

class NoteWindowController: NSWindowController {

    override func windowDidLoad() {
        super.windowDidLoad()
    
        // Implement this method to handle any initialization after your window controller's window has been loaded from its nib file.
    }
    
    static let shared: NoteWindowController = {
        let wc = NSStoryboard(name:"Main", bundle: nil).instantiateController(withIdentifier: "note-win") as! NoteWindowController
        return wc
    }()

}
