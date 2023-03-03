//
//  Constant.swift
//  Gustnotes
//
//  Created by Nils Lahaye on 2022-12-15.
//

import Foundation

enum Constant {
    static let appName = "Gustnotes"
    static let launcherAppId = "com.nilon123456789.Gustnotes"
    static let fileName = "savedText.rtfd"
    static let savePath = FileManager.default.homeDirectoryForCurrentUser.appendingPathComponent(".Gustnotes/")
}

struct GlobalKeybindPreferences: Codable, CustomStringConvertible {
    let function : Bool
    let control : Bool
    let command : Bool
    let shift : Bool
    let option : Bool
    let capsLock : Bool
    let carbonFlags : UInt32
    let characters : String?
    let keyCode : UInt32

    var description: String {
//        print(keyCode)
        var stringBuilder = ""
        if self.function {
            stringBuilder += "Fn"
        }
        if self.control {
            stringBuilder += "⌃"
        }
        if self.option {
            stringBuilder += "⌥"
        }
        if self.command {
            stringBuilder += "⌘"
        }
        if self.shift {
            stringBuilder += "⇧"
        }
        if self.capsLock {
            stringBuilder += "⇪"
        }
        if keyCode == 36 { // return
            stringBuilder += "⏎"
            return stringBuilder
        }
        
        if keyCode == 51 { // delete
            stringBuilder += "⌫"
            return stringBuilder
        }
        
        if keyCode == 49 { // spacer
            stringBuilder += "⎵"
            return stringBuilder
        }
        
        let keyMap: [UInt32: String] = [
            0x00: "a",
            0x01: "s",
            0x02: "d",
            0x03: "f",
            0x04: "h",
            0x05: "g",
            0x06: "z",
            0x07: "x",
            0x08: "c",
            0x09: "v",
            0x0B: "b",
            0x0C: "q",
            0x0D: "w",
            0x0E: "e",
            0x0F: "r",
            0x10: "y",
            0x11: "t",
            0x12: "1",
            0x13: "2",
            0x14: "3",
            0x15: "4",
            0x16: "6",
            0x17: "5",
            0x18: "=",
            0x19: "9",
            0x1A: "7",
            0x1B: "-",
            0x1C: "8",
            0x1D: "0",
            0x1E: "]",
            0x1F: "o",
            0x20: "u",
            0x21: "[",
            0x22: "i",
            0x23: "p",
            0x25: "l",
            0x26: "j",
            0x27: "'",
            0x28: "k",
            0x29: ";",
            0x2A: "\\",
            0x2B: ",",
            0x2C: "/",
            0x2D: "n",
            0x2E: "m",
            0x2F: "."
        ]
        
        if let char = keyMap[keyCode] {
            stringBuilder += char.uppercased()
        }
        else if let characters = self.characters {
            stringBuilder += characters.uppercased()
        }
        
        return "\(stringBuilder)"
    }
}

extension GlobalKeybindPreferences {
    func save() {
        
    }
}

