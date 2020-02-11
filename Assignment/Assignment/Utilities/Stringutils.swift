//
//  Stringutils.swift
//  Image_Loading_Library
//
//  Created by Vishnu on 01/12/19.
//  Copyright © 2019 GreedyGame. All rights reserved.
//

import Foundation

public class StringUtils {
    public static func md5(_ value: String) -> String{
        return String(describing: value.utf8.md5).lowercased()
    }
}
