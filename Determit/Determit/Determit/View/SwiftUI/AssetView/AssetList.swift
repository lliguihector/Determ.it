//
//  AssetList.swift
//  Determit
//
//  Created by Hector Lliguichuzca on 5/7/24.
//

import SwiftUI

struct AssetList: View {
    var body: some View {
        List(assets) { asset in
            AssetRow(asset: asset)
            
        }
    }
}

struct AssetList_Previews: PreviewProvider {
    static var previews: some View {
        AssetList()
    }
}
