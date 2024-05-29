//
//  AdminMenuRow.swift
//  Determit
//
//  Created by Blanca Tixi on 5/25/24.
//

import SwiftUI

struct AdminMenuRow: View {
    
    let buttonTitle: String
    let buttonSubtitle: String
    let buttonImage: String
    
    var body: some View {
        
        
//                    Button(action: {
//                        // Action when button is tapped
//                        print("button was pressed . . . ")
//                        
//                    }) 
                        
                        HStack(alignment: .center){
                            Image(systemName: buttonImage )
                                .resizable()
                                .frame(width: 40, height: 40)
                                .aspectRatio(contentMode: .fit)
                                .padding(.trailing, 10)
                            
                            
                            VStack(alignment: .leading) {
                                          Text(buttonTitle)
                                              .font(.headline)
                                          
                                          Text(buttonSubtitle)
                                              .font(.subheadline)
                                              .foregroundColor(.gray)
                                      }
                                      
                                      Spacer()
                                      
                                      Image(systemName: "chevron.right")
                                          .foregroundColor(.gray)
                        }
                        .padding()
                               .background(Color.white)
//                               .cornerRadius(8)
//                               .shadow(color: .gray, radius: 2, x: 0, y: 2)
    }
}

struct AdminMenuRow_Previews: PreviewProvider {
    static var previews: some View { AdminMenuRow(buttonTitle: "Title", buttonSubtitle: "Subtitle", buttonImage: "person")
            .previewLayout(.sizeThatFits)
            .padding()
    }
}
