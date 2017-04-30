//
// Utils.swift
//
// This source file is part of the SMUD open source project
//
// Copyright (c) 2016 - 2017 SMUD project authors
// Licensed under Apache License v2.0 with Runtime Library Exception
//
// See LICENSE.txt for license information
// See AUTHORS.txt for the list of SMUD project authors
//


import Foundation

func getPlayerName(from filename: String) -> String {
    let url = URL(fileURLWithPath: filename)
    return url.deletingPathExtension().lastPathComponent
}

func getFieldNames(from string: String) -> [String] {
    return string.components(separatedBy: ",").map { $0.uppercased() }
}
