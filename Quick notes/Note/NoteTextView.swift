//
//  NoteTextView.swift
//  Quick notes
//
//  Created by Nils Lahaye on 2022-12-30.
//

import Cocoa

class NoteTextView: NSTextView {
    
    @IBInspectable var defaultTextColor: NSColor = NSColor()
    @IBInspectable var defaultBackroundColor: NSColor = NSColor()
    
    @IBAction func Bold(_ sender: NSButton) {
        // Get the current font for the selected text or the typingAttributes font if there is no selection
        var currentFont: NSFont
        if self.selectedRange.length > 0 {
            let currentAttributes = self.textStorage?.attributes(at: self.selectedRange.location, effectiveRange: nil)
            currentFont = currentAttributes?[.font] as! NSFont
            
            
        } else {
            if let typingAttributesFont = self.typingAttributes[.font] as? NSFont {
                currentFont = typingAttributesFont
            } else {
                currentFont = NSFont.systemFont(ofSize: NSFont.systemFontSize)
            }
        }

        // Create a new font with the same attributes as the current font, but with the bold version of the font name
        let fontDescriptor = currentFont.fontDescriptor
        let symbolicTraits = fontDescriptor.symbolicTraits
        let newFont: NSFont
        if symbolicTraits.contains(.bold) {
            // Safely unwrap the result of withSymbolicTraits
            let newFontDescriptor = fontDescriptor.withSymbolicTraits(symbolicTraits.subtracting(.bold))
            newFont = NSFont(descriptor: newFontDescriptor, size: currentFont.pointSize)!
        } else {
            // Safely unwrap the result of withSymbolicTraits
            let newFontDescriptor = fontDescriptor.withSymbolicTraits(symbolicTraits.union(.bold))
            newFont = NSFont(descriptor: newFontDescriptor, size: currentFont.pointSize)!
        }
        
        if self.selectedRange.length > 0 {
            if let textStorage = self.textStorage {
                // Modify the text storage to set the new font for the selected text or the entire text view if there is no selection
                textStorage.beginEditing()
                let range = self.selectedRange.length > 0 ? self.selectedRange : NSRange(location: 0, length: textStorage.length)
                textStorage.addAttribute(.font, value: newFont, range: range)
                textStorage.endEditing()
            }
        } else {
            // Modify the typingAttributes to set the new font
            var newTypingAttributes = self.typingAttributes
            newTypingAttributes[.font] = newFont
            self.typingAttributes = newTypingAttributes
        }
    }
    @IBAction func  Italic(_ sender: NSButton) {
        // Get the current font for the selected text or the typingAttributes font if there is no selection
        var currentFont: NSFont
        if self.selectedRange.length > 0 {
            let currentAttributes = self.textStorage?.attributes(at: self.selectedRange.location, effectiveRange: nil)
            currentFont = currentAttributes?[.font] as! NSFont
            
            
        } else {
            if let typingAttributesFont = self.typingAttributes[.font] as? NSFont {
                currentFont = typingAttributesFont
            } else {
                currentFont = NSFont.systemFont(ofSize: NSFont.systemFontSize)
            }
        }

        // Create a new font with the same attributes as the current font, but with the italic version of the font name
        let fontDescriptor = currentFont.fontDescriptor
        let symbolicTraits = fontDescriptor.symbolicTraits
        let newFont: NSFont
        if symbolicTraits.contains(.italic) {
            // Safely unwrap the result of withSymbolicTraits
            let newFontDescriptor = fontDescriptor.withSymbolicTraits(symbolicTraits.subtracting(.italic))
            newFont = NSFont(descriptor: newFontDescriptor, size: currentFont.pointSize)!
        } else {
            // Safely unwrap the result of withSymbolicTraits
            let newFontDescriptor = fontDescriptor.withSymbolicTraits(symbolicTraits.union(.italic))
            newFont = NSFont(descriptor: newFontDescriptor, size: currentFont.pointSize)!
        }
        
        if self.selectedRange.length > 0 {
            if let textStorage = self.textStorage {
                // Modify the text storage to set the new font for the selected text or the entire text view if there is no selection
                textStorage.beginEditing()
                let range = self.selectedRange.length > 0 ? self.selectedRange : NSRange(location: 0, length: textStorage.length)
                textStorage.addAttribute(.font, value: newFont, range: range)
                textStorage.endEditing()
            }
        } else {
            // Modify the typingAttributes to set the new font
            var newTypingAttributes = self.typingAttributes
            newTypingAttributes[.font] = newFont
            self.typingAttributes = newTypingAttributes
        }
    }
    @IBAction func FontUp(_ sender: NSButton) {
        
        if let textStorage = self.textStorage {
            // Get the current font for the selected text or the entire text view if there is no selection
            let range = self.selectedRange.length > 0 ? self.selectedRange : NSRange(location: 0, length: textStorage.length)
            let currentFont = textStorage.attribute(.font, at: range.location, effectiveRange: nil) as! NSFont

            // Create a new font with the same attributes as the current font, but with a larger size
            let newFont = NSFontManager.shared.convert(currentFont, toSize: currentFont.pointSize + 4)

            // Modify the text storage to set the new font for the selected text or the entire text view if there is no selection
            textStorage.beginEditing()
            textStorage.addAttribute(.font, value: newFont, range: range)
            textStorage.endEditing()
        }
    }
    @IBAction func  FontDown(_ sender: NSButton) {
        
        if let textStorage = self.textStorage {
            // Get the current font for the selected text or the entire text view if there is no selection
            let range = self.selectedRange.length > 0 ? self.selectedRange : NSRange(location: 0, length: textStorage.length)
            let currentFont = textStorage.attribute(.font, at: range.location, effectiveRange: nil) as! NSFont

            // Create a new font with the same attributes as the current font, but with a smaller size
            if currentFont.pointSize <= 4 {
                return
            }
            
            let newFont = NSFontManager.shared.convert(currentFont, toSize: currentFont.pointSize - 4)

            // Modify the text storage to set the new font for the selected text or the entire text view if there is no selection
            textStorage.beginEditing()
            textStorage.addAttribute(.font, value: newFont, range: range)
            textStorage.endEditing()
        }
    }
    @IBAction func  Clear(_ sender: NSButton) {
        
        //Delete the save file
        let fileManager = FileManager.default
        let fileName = Constant.fileName
        let savePath = Constant.savePath
        
        let fileURL = savePath.appendingPathComponent(fileName)
        
        if fileManager.fileExists(atPath: fileURL.path) {
            Util.deleteFiles(fileURL)
        }
        
        // Empty the text view
        if let textStorage = self.textStorage {
            let textView = self
            let range = NSRange(location: 0, length: textView.string.count)
            textStorage.replaceCharacters(in: range, with: "")
            self.textColor = defaultTextColor
            
            //Remove italic, bold, underline
            var currentFont: NSFont
            if let typingAttributesFont = self.typingAttributes[.font] as? NSFont {
                currentFont = typingAttributesFont
            } else {
                currentFont = NSFont.systemFont(ofSize: NSFont.systemFontSize)
            }
            let fontDescriptor = currentFont.fontDescriptor
            let symbolicTraits = fontDescriptor.symbolicTraits
            let newFont: NSFont
            
            var newFontDescriptor = NSFontDescriptor()
            if (symbolicTraits.contains(.italic)) {
                newFontDescriptor = fontDescriptor.withSymbolicTraits(symbolicTraits.subtracting(.italic))
            }
            if (symbolicTraits.contains(.bold)) {
                newFontDescriptor = fontDescriptor.withSymbolicTraits(symbolicTraits.subtracting(.bold))
            }
            newFont = NSFont(descriptor: newFontDescriptor, size: currentFont.pointSize)!
            var newTypingAttributes = self.typingAttributes
            newTypingAttributes[.font] = newFont
            self.typingAttributes = newTypingAttributes
            
            // Remove backround
            self.backgroundColor = defaultBackroundColor
        }
    }
    @IBAction func TextColor(_ sender: NSColorWell) {
        let color = sender.color
        if self.selectedRange.length > 0 {
            // Change the color of the selected text
            if let textStorage = self.textStorage {
                textStorage.beginEditing()
                textStorage.addAttribute(.foregroundColor, value: color, range: self.selectedRange)
                textStorage.endEditing()
            }
        } else {
            // Set the color for the next character
            var newTypingAttributes = self.typingAttributes
            newTypingAttributes[.foregroundColor] = color
            self.typingAttributes = newTypingAttributes
        }
    }

    override func draw(_ dirtyRect: NSRect) {
        super.draw(dirtyRect)

        // Drawing code here.
    }
    
    override func paste(_ sender: Any?) {
        var previousColor = NSColor() // Previous font color
        
        let textStorage = self.textStorage!
        
        // Save the current font color
        var insertionPoint = self.selectedRange().location
        
        let intIndex = insertionPoint - 1
        // Get the font color of the character before the image
        if insertionPoint > 0 {
            var effectiveRange: NSRange = NSRange(location: 0, length: 0)
            if let fontColor = textStorage.attribute(.foregroundColor, at: insertionPoint - 1, effectiveRange: &effectiveRange) as? NSColor {
                previousColor = fontColor
            } else {
                previousColor = defaultTextColor
            }
        }
        
        // Paste the contents of the clipboard
        let pasteBoard = NSPasteboard.general
        if let pastedString = pasteBoard.string(forType: .string), !pastedString.isEmpty {
            if Settings.richTextPast {
                let lastCursorPosition = self.selectedRange.location
                
                super.paste(sender)
                
                let newCursorPosition = self.selectedRange.location
                
                let range = NSRange(location: (self.textStorage!.string.count - pastedString.count), length: pastedString.count)
                var color = self.textStorage!.attribute(.foregroundColor, at: range.location, effectiveRange: nil) as! NSColor
                
                if (NSApplication.shared.effectiveAppearance == NSAppearance(named: .darkAqua)) {
                    
                    if (Util.isAlmostInvisible(foregroundColor: color, backgroundColor: self.backgroundColor) < 0.5) {
                        color = defaultTextColor
                    }
                } else {
                    if (Util.isAlmostInvisible(foregroundColor: color, backgroundColor: self.backgroundColor) > 0.5) {
                        color = defaultTextColor
                    }
                }
                self.textStorage!.beginEditing()
                self.textStorage!.addAttribute(.foregroundColor, value: color, range: range)
                self.textStorage!.endEditing()
            } else {
                super.pasteAsPlainText(sender)
            }
        } else {
            super.paste(sender)
            
            // Set the selection range to the character after the image
            let insertionPoint = self.selectedRange().upperBound
            self.setSelectedRange(NSRange(location: insertionPoint, length: 0))

            // Set the font color of the selected text
            self.typingAttributes[.foregroundColor] = previousColor
        }
        
    }
}
