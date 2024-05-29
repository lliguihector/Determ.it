//
//  Admin Menu.swift
//  Determit
//
//  Created by Blanca Tixi on 5/25/24.
//

import SwiftUI


struct AdminMenuList: View {
    
    
    
    let customRows = [
            ("Post News", "Subtitle for Post News", "person"),
            ("Service Request", "Subtitle for Service Request", "person"),
            ("Add Employee", "Subtitle for Add Employee", "person"),
            ("Reset Password", "Subtitle for Reset Password", "person"),
            ("Other", "Subtitle for Other", "person"),
        ]
    
    var body: some View {
        
       
            List{
                
                ForEach(customRows, id: \.self.0){ row in
                    
                    Section{
                        AdminMenuRow(buttonTitle: row.0, buttonSubtitle: row.1, buttonImage: row.2)
                                            .padding(10)
                                    }
                    
                }
               
                
            }
//            .listStyle(PlainListStyle())
         
        
       
    }
}

struct Admin_Menu_Previews: PreviewProvider {
    static var previews: some View {
        AdminMenuList()
    }
}
