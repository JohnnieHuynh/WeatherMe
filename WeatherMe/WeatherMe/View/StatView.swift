//
//  StatView.swift
//  WeatherMe
//
//  Created by Johnny Huynh on 3/27/23.
//

import SwiftUI

struct StatView: View {
    let title: String
    let stat: Int
    let unit: String
    
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 25)
                .fill(Color("background"))
                .frame(width: 150, height: 150)
            VStack {
                Text("\(title):")
                    .font(.system(size: 20))
                    .padding([.bottom], 5)
                HStack {
                    Text("\(stat)")
                        .font(.system(size: 32))
                    Text("\(unit)")
                        .font(.system(size: 20))
                }
            }
            .frame(alignment: .trailing)
            .foregroundColor(.white)
        }
    }
}

struct StatView_Previews: PreviewProvider {
    static var previews: some View {
        StatView(title: "test", stat: 8900, unit: "inHg")
    }
}
