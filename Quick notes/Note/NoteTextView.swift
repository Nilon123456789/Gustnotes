//
//  NoteTextView.swift
//  Quick notes
//
//  Created by Nils Lahaye on 2022-12-30.
//

import Cocoa

class NoteTextView: NSTextView {
    
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
        if let textStorage = self.textStorage {
                let range = NSRange(location: 0, length: textStorage.length)
                textStorage.replaceCharacters(in: range, with: "")
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
}
