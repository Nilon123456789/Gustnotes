//
//  NoteViewController.swift
//  Quick notes
//
//  Created by Nils Lahaye on 2022-12-14.
//

import Cocoa

class NoteViewController: NSViewController {
    
    @IBOutlet weak var textView: NSTextView!
    
    let fileManager = FileManager.default
    
    let fileName = Constant.fileName
    
    let savePath = Constant.savePath
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do view setup here.
        
        if(!Settings.saveOnClose) { return }
        
        NotificationCenter.default.addObserver(self, selector: #selector(textDidChange), name: NSText.didChangeNotification, object: textView)
        
        // Load the text from a file if it exists if save on close is enable
        
        let fileURL = savePath.appendingPathComponent(fileName)
        if fileManager.fileExists(atPath: fileURL.path) {
        if let attributeString = try? NSAttributedString(rtfdFileWrapper: FileWrapper(url: fileURL), documentAttributes: nil) {
                textView.textStorage?.insert(attributeString, at: textView.selectedRange.location)
            }
            print("File loaded")
        }
    }
    
    @objc func textDidChange(_ notification: Notification) {
        // Save the text to a file whenever it changes if enable
        if(!Settings.saveOnClose) { return }
            
        let fileURL = savePath.appendingPathComponent(fileName)
        
        // if the file doesn't exist make one
        if !fileManager.fileExists(atPath: fileURL.path) {
            do {
                try fileManager.createDirectory(at: savePath, withIntermediateDirectories: true, attributes: nil)
                fileManager.createFile(atPath: fileURL.path, contents: nil, attributes: nil)
                print("File created :", fileURL)
            } catch {
                print("Failed to save text to file:", error)
            }
        }
        // Backup the old file
        do {
            try fileManager.copyItem(at: fileURL, to:
                                        savePath.appendingPathComponent(fileName + ".old"))
        } catch {
            print("Error copying file: \(error)")
        }
        
        // Save the file
        
        let attributedString
        = textView.attributedString()
        let rtfdData = attributedString.rtfdFileWrapper(from: NSRange(location: 0, length: attributedString.length))
        if let rtfdData = rtfdData {
            rtfdData.filename = fileName
            do {
                try rtfdData.write(to: fileURL, options: .atomic, originalContentsURL: savePath)
            } catch {
                print("Faild to write \(error)")
            }
        }
    }
    
    override func viewDidAppear() {
        super.viewDidAppear()
        if(Settings.floatingNote) { // Set the window to floating if specified
            view.window?.level = .floating
        }
        NotificationCenter.default.addObserver(self, selector: #selector(textDidChange), name: NSText.didChangeNotification, object: textView)
    }
    
    override func viewDidDisappear() {
        NotificationCenter.default.removeObserver(self, name: NSText.didChangeNotification, object: textView)
    }
    
}
