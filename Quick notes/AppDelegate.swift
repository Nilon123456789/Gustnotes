//
//  AppDelegate.swift
//  Quick notes
//
//  Created by Nils Lahaye on 2022-12-14.
//

import Cocoa
import HotKey
import LaunchAtLogin

@main
class AppDelegate: NSObject, NSApplicationDelegate {

    
    var statusItem: NSStatusItem?
    
    @IBOutlet weak var menu: NSMenu?
    @IBAction func preference(_ sender: Any) { Util.showPrefWindow() }
    @IBAction func allNotes(_ sender: Any) { Util.showAllNotesWindow() }
    @IBAction func note(_ sender: Any) { Util.showNoteWindow(closeIfOpen: false)}

    func applicationDidFinishLaunching(_ aNotification: Notification) {
        UserDefaults.standard.register(defaults: [
            UserDefaults.Key.autoStart: false,
            UserDefaults.Key.saveOnClose: true,
            UserDefaults.Key.floatingNote: true
        ])
        
        setupHotKey()
        LaunchAtLogin.isEnabled = Settings.autoStart
    }


    func applicationSupportsSecureRestorableState(_ app: NSApplication) -> Bool {
        return true
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
     
        statusItem = NSStatusBar.system.statusItem(withLength: NSStatusItem.variableLength)
        statusItem?.button?.title = "note"
        statusItem?.menu = menu
    }
    
    var hotKey: HotKey? {
        didSet {
            guard let hotKey = hotKey else { return }
            
            hotKey.keyDownHandler = { [weak self] in
                Util.showNoteWindow(closeIfOpen: true)
            }
        }
    }
    
    func setupHotKey() {
        guard let globalKey = Settings.globalKey else {return}
        hotKey = HotKey(keyCombo: KeyCombo(carbonKeyCode: globalKey.keyCode, carbonModifiers: globalKey.carbonFlags))
    }
    
    @objc func terminate() {
        NSApp.terminate(nil)
    }


}

