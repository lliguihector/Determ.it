//
//  AssetView.swift
//  Determit
//
//  Created by Blanca Tixi on 5/4/24.
//

import SwiftUI
import MapKit

struct AssetRow: View {

   
    var asset: APIAsset
    
    
    var body: some View {
     
//        HStack{
//            Text("AssetTag:").font(.title).fontWeight(.light)
//            Text(asset.assetTag).font(.title).bold()
//        }
      
        VStack{
            Text("Asset Tag: \(asset.assetTag)")
            Text("Device ID: \(asset.deviceID)")
            Text("Serial Number: \(asset.serialNumber)")
        }
        .padding()
        .background(Color.gray.opacity(0.1))
        .cornerRadius(10)
        .padding(.horizontal)
        
    }
}


struct AssetView_Previews: PreviewProvider {
    static var previews: some View {


     
        AssetRow(asset: assets[0])
        
        
    }
}
