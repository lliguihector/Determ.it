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
                                .foregroundColor(Color.black)
                                
//                                .scaleEffect(x: 0.5, y: 0.5) //
                                
                            
                            
                            VStack(alignment: .leading) {
                                
                                Text(buttonTitle)
                                    .font(.subheadline)
                                    .foregroundColor(.gray)
                                
                                
                                Text(buttonSubtitle)
                                              .font(.headline)
                                              .foregroundColor(Color.black)
                                          
                                       
                                      }
                                      
                                      Spacer()
                                      
                                      Image(systemName: "chevron.right")
                                          .foregroundColor(.gray)
                        }
//                        .padding()
                               .background(Color.white)
//                               .cornerRadius(8)

    }
}

struct AdminMenuRow_Previews: PreviewProvider {
    static var previews: some View { AdminMenuRow(buttonTitle: "Title", buttonSubtitle: "Subtitle", buttonImage: "person")
            .previewLayout(.sizeThatFits)
            .padding()
    }
}
