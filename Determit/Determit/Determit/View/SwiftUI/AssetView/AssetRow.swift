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
     
        HStack{
            Text(asset.assetTag)
            Text(asset.serialNumber)
        }
      
    }
}


struct AssetView_Previews: PreviewProvider {
    static var previews: some View {


     
        AssetRow(asset: assets[0])
        
        
    }
}
