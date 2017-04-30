//
// main.swift
//
// This source file is part of the SMUD open source project
//
// Copyright (c) 2016 SMUD project authors
// Licensed under Apache License v2.0 with Runtime Library Exception
//
// See LICENSE.txt for license information
// See AUTHORS.txt for the list of SMUD project authors
//

import Commander


Group {
    $0.command("print",
               Argument<String>("players",
                                description: "Player name pattern"),
               Argument<String>("fields",
                                description: "Field names")
    ){ namePattern, fieldNamesString in
        var fieldNames = getFieldNames(from: fieldNamesString)
        guard !fieldNames.isEmpty else {
            print("No field names specified")
            return
        }
        try enumeratePlayerFiles(matching: namePattern) { playerName, configFile, stop in
            print(playerName, "|",
                  fieldNames.map { configFile.get($0) ?? "" }
                    .joined(separator: "|"),
                  separator: "")
        }
    }
}.run()

