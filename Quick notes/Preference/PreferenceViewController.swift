//
//  PreferenceViewController.swift
//  Quick notes
//
//  Created by Nils Lahaye on 2022-12-14.
//

import Cocoa
import HotKey
import LaunchAtLogin

class PreferenceViewController: NSViewController {
    
    @IBOutlet weak var btnAutoStart: NSButton!
    @IBOutlet weak var btnsaveOnClose: NSButton!
    @IBOutlet weak var btnfloatingNote: NSButton!
    @IBOutlet weak var btnClear: NSButton!
    @IBOutlet weak var btnShortcut: NSButton!
    @IBOutlet weak var btnShowSave: NSButton!
    @IBOutlet weak var btnRichTextPast: NSButton!
    
    public var listening = false {
        didSet {
            let isHighlight = listening
            
            DispatchQueue.main.async { [weak self] in
                self?.btnShortcut.highlight(isHighlight)
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        btnAutoStart.state = Settings.autoStart ? .on : .off
        btnsaveOnClose.state = Settings.saveOnClose ? .on : .off
        btnfloatingNote.state = Settings.floatingNote ? .on : .off
        btnRichTextPast.state = Settings.richTextPast ? .on : .off
        
        let fileManager = FileManager.default
        let folderURL = Constant.savePath
        if !fileManager.fileExists(atPath: folderURL.path) {
            btnShowSave.isEnabled = false
        }
        
        loadHotkey()
    }
    
    @IBAction func autoStartChanged(_ sender: NSButton) {
        Settings.autoStart = sender.state == .on
        btnAutoStart.state = Settings.autoStart ? .on : .off
    }
    
    @IBAction func SaveOnCloseChanged(_ sender: NSButton) {
        Settings.saveOnClose = sender.state == .on
        btnsaveOnClose.state = Settings.saveOnClose ? .on : .off
    }
    
    @IBAction func FloatingWindowChanged(_ sender: NSButton) {
        Settings.floatingNote = sender.state == .on
        btnfloatingNote.state = Settings.floatingNote ? .on : .off
    }
    
    @IBAction func RichTextPast(_ sender: NSButton) {
        Settings.richTextPast = sender.state == .on
        btnRichTextPast.state = Settings.richTextPast ? .on : .off
    }
    
    // When the set shortcut button is pressed start listening for the new shortcut
    @IBAction func register(_ sender: Any) {
        listening = true
        view.window?.makeFirstResponder(nil)
    }
    
    // If the shortcut is cleared, clear the UI and tell AppDelegate to stop listening to the previous keybind.
    @IBAction func unregister(_ sender: Any?) {
        let appDelegate = NSApplication.shared.delegate as! AppDelegate
        appDelegate.hotKey = nil
        btnShortcut.title = "Set Shortcut"
        listening = false
        btnClear.isEnabled = false
        Settings.globalKey = nil
    }
    
    @IBAction func showSave(_ sender: NSButton) {
        let fileManager = FileManager.default
        let folderURL = Constant.savePath
        if fileManager.fileExists(atPath: folderURL.path) {
            NSWorkspace.shared.activateFileViewerSelecting([folderURL])
            NSWorkspace.shared.open(folderURL)
        }
    }
    
    public func updateGlobalShortcut(_ event: NSEvent) {
        self.listening = false
        
        guard let characters = event.charactersIgnoringModifiers else {return}
        
        let newGlobalKeybind = GlobalKeybindPreferences(
            function: event.modifierFlags.contains(.function),
            control: event.modifierFlags.contains(.control),
            command: event.modifierFlags.contains(.command),
            shift: event.modifierFlags.contains(.shift),
            option: event.modifierFlags.contains(.option),
            capsLock: event.modifierFlags.contains(.capsLock),
            carbonFlags: event.modifierFlags.carbonFlags,
            characters: characters,
            keyCode: uint32(event.keyCode))
        
        Settings.globalKey = newGlobalKeybind
        
        updateKeybindButton(newGlobalKeybind)
        btnClear.isEnabled = true
        
        let appDelegate = NSApplication.shared.delegate as! AppDelegate
        appDelegate.hotKey = HotKey(keyCombo: KeyCombo(carbonKeyCode: UInt32(event.keyCode), carbonModifiers: event.modifierFlags.carbonFlags))
    }
    
    // Set the shortcut button to show the keys to press
    private func updateKeybindButton(_ globalKeybindPreference : GlobalKeybindPreferences) {
        btnShortcut.title = globalKeybindPreference.description
        
        if globalKeybindPreference.description.count <= 1 {
            unregister(nil)
        }
    }
    
    private func loadHotkey() {
        if let globalKey = Settings.globalKey {
            btnShortcut.title = globalKey.description
            btnClear.isEnabled = true
            
            if globalKey.description.count <= 1 {
                unregister(nil)
                btnClear.isEnabled = false
            }
            
        }
    }
}
