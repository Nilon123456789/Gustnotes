//
//  Util.swift
//  Quick notes
//
//  Created by Nils Lahaye on 2022-12-14.
//

import Foundation
import AppKit
import ServiceManagement

class Util {
    
    static func showPrefWindow() {
        let prefWindow = PreferenceWindowController.shared.window
        prefWindow?.makeKeyAndOrderFront(nil)
        NSApp.activate(ignoringOtherApps: true)
    }
    
    static func showAllNotesWindow() {
        let allnotesWindow = AllNotesWindowController.shared.window
        allnotesWindow?.makeKeyAndOrderFront(nil)
        NSApp.activate(ignoringOtherApps: true)
    }
    
    static var noteIsOpened: Bool = false
    static func showNoteWindow(closeIfOpen: Bool) {
        if (closeIfOpen && noteIsOpened) {
            NSApplication.shared.keyWindow?.close()
            noteIsOpened = false
        }
        else {
            let noteWindow = NoteWindowController.shared.window
            noteWindow?.makeKeyAndOrderFront(nil)
            NSApp.activate(ignoringOtherApps: true)
            noteIsOpened = true
        }
    }
    
}
