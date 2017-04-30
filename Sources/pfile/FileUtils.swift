//
// FileUtils.swift
//
// This source file is part of the SMUD open source project
//
// Copyright (c) 2016 SMUD project authors
// Licensed under Apache License v2.0 with Runtime Library Exception
//
// See LICENSE.txt for license information
// See AUTHORS.txt for the list of SMUD project authors
//

import Foundation
import ConfigFile

#if os(OSX)
    typealias RegularExpression = NSRegularExpression
#endif

typealias FileEnumerationHandler = (_ filename: String, _ stop: inout Bool) throws -> ()
typealias PlayerFileEnumerationHandler = (_ playerName: String, _ configFile: ConfigFile, _ stop: inout Bool) -> ()

func enumerateFiles(atPath path: String, withExtension ext: String, handler: FileEnumerationHandler) rethrows {
    let fileManager = FileManager.default
    let enumerator = fileManager.enumerator(atPath: path)
    let dotExt = "." + ext
    
    var stop = false
    while let element = enumerator?.nextObject() as? String {
        guard element.hasSuffix(dotExt) else {
            //print("Skipping \(element)")
            continue
        }
        //print("Matched \(element)")
        try handler(element, &stop)
        if stop { break }
    }
}

func enumeratePlayerFiles(handler: PlayerFileEnumerationHandler) throws {
    try enumerateFiles(atPath: ".", withExtension: "plr") { filename, stop in
        let configFile = try ConfigFile(fromFile: filename)
        handler(getPlayerName(from: filename), configFile, &stop)
    }
}

func enumeratePlayerFiles(matching pattern: String, handler: PlayerFileEnumerationHandler) throws {
    //let regex = try RegularExpression(pattern: pattern, options: [.caseInsensitive])
    try enumerateFiles(atPath: ".", withExtension: "plr") { filename, stop in
        //guard regex.firstMatch(in: filename, options: [],
        //                       range: NSMakeRange(0, filename.utf16.count)) != nil else {
        //    return
        //}
        guard pattern == "all" ||
            getPlayerName(from: filename)
                .caseInsensitiveCompare(pattern) == .orderedSame
        else {
            return
        }
        let configFile = try ConfigFile(fromFile: filename)
        handler(getPlayerName(from: filename), configFile, &stop)
    }
}
