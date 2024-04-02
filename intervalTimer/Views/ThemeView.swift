//
//  themeView.swift
//  intervalTimer
//
//  Created by Masato Nandate on 6/29/23.
//

import Foundation
import SwiftUI

struct themeView: View {
    var inTheme: Theme
    var body: some View{
        HStack{
            Text(inTheme.rawValue)
                .foregroundColor(Theme.white.mainColor)
                .frame(maxWidth: .infinity)
                .padding(4)
        }.background(inTheme.mainColor)
            
    }
    
}

struct ThemeView_Previews: PreviewProvider {
    static var previews: some View {
        themeView(inTheme: Theme.mint)
    }
}
