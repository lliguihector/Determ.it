//
//  AssetView.swift
//  Determit
//
//  Created by Blanca Tixi on 5/4/24.
//

import SwiftUI

struct AssetView: View {
    
    var asset: APIAsset
    
    
    var body: some View {
//        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
//        Text("Apple")
        
        HStack{
            Text(asset.assetTag)
            Text(asset.serialNumber)
            Spacer()
        }
        
        
    }
}


struct AssetView_Previews: PreviewProvider {
    static var previews: some View {
        
        
        AssetView(asset: assets[2])
        
        
    }
}
