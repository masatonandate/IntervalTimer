//
//  themePicker.swift
//  intervalTimer
//
//  Created by Masato Nandate on 6/30/23.
//

import Foundation
import SwiftUI

struct themePickerView: View{
    @Binding var selection: Theme
    
    var body: some View{
        Picker("Theme", selection: $selection){
            ForEach(Theme.allCases) { theme in
                themeView(inTheme: theme)
                    .tag(theme)
            }
        }
        .pickerStyle(.navigationLink)
    }
}

struct themePickerPreview : PreviewProvider{
    static var previews: some View{
        themePickerView(selection: .constant(Theme.mint))
    }
}
