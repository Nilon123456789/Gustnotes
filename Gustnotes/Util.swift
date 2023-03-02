//
//  Util.swift
//  Gustnotes
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
    
    static func deleteFiles(_ fileToDelete: URL) {
        
        let deleteAtURL = fileToDelete
        
        do {
            try FileManager.default.removeItem(at: deleteAtURL)
//            print("File deleted : ", deleteAtURL)
        } catch {
//            print(error)
        }
    }
    
    static func isAlmostInvisible(foregroundColor: NSColor, backgroundColor: NSColor) -> Double {
        let foregroundColorRGBA = foregroundColor.usingColorSpace(NSColorSpace.sRGB)!
        let backgroundColorRGBA = backgroundColor.usingColorSpace(NSColorSpace.sRGB)!
        var fr: CGFloat = 0
        var fg: CGFloat = 0
        var fb: CGFloat = 0
        var fa: CGFloat = 0
        foregroundColorRGBA.getRed(&fr, green: &fg, blue: &fb, alpha: &fa)
        var br: CGFloat = 0
        var bg: CGFloat = 0
        var bb: CGFloat = 0
        var ba: CGFloat = 0
        backgroundColorRGBA.getRed(&br, green: &bg, blue: &bb, alpha: &ba)
        let distance = sqrt(pow(fr - br, 2) + pow(fg - bg, 2) + pow(fb - bb, 2))
        return distance
    }

    
}
