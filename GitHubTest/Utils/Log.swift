//
//  Log.swift
//  SkyApp
//
//  Created by Bruno Lopes on 31/08/20.
//  Copyright © 2020 Bruno. All rights reserved.
//

import Foundation

/// Print
///
/// - Parameter items: print items in environment development & homologation.
func debug(_ items: Any, file: String = #file, function: String = #function, line: Int = #line) {
    let className = file.components(separatedBy: "/").last
    #if DEVELOPMENT || HOMOLOGATION
    print("----------------------------------------")
    print("\nDEBUG: File: \(className ?? ""), Function: \(function), Line: \(line)\n--->>> \(items)\n")
    print("----------------------------------------")
    #else
    debugPrint("----------------------------------------")
    debugPrint("DEBUG: File: \(className ?? "")")
    debugPrint("Function: \(function)")
    debugPrint("Line: \(line)")
    debugPrint("\(items)")
    debugPrint("----------------------------------------")
    #endif
}
