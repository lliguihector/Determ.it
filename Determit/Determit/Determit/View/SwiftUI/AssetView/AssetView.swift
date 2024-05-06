//
//  AssetView.swift
//  Determit
//
//  Created by Blanca Tixi on 5/4/24.
//

import SwiftUI
import MapKit

struct AssetView: View {

    let keyword: String
    let symbol: String
    
    var body: some View {
     
        Label(keyword, systemImage: symbol)
            .font(.title)
            .foregroundColor(.white)
            .padding()
            .background(.purple.opacity(0.75), in: Capsule())
    }
}


struct AssetView_Previews: PreviewProvider {
    static let keywords = ["chives", "fern-leaf lavender"]
    
    static var previews: some View {

    VStack{
            ForEach(keywords, id:\.self){ word in
                        AssetView(keyword: word, symbol: "leaf")
                
            }
        }
     

        
        
    }
}
