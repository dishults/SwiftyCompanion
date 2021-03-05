//
//  Fonts.swift
//  SwiftyCompanion
//
//  Created by Dmytro Shults on 05/03/2021.
//

import SwiftUI

func customHeadline() -> Font {
    return Font.system(size: 17, weight: Font.Weight.black, design: Font.Design.rounded)
}

func customBody() -> Font {
    return Font.system(Font.TextStyle.body, design: Font.Design.monospaced)
}
