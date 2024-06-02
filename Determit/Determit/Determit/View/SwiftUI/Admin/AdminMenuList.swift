//
//  Admin Menu.swift
//  Determit
//
//  Created by Blanca Tixi on 5/25/24.
//

import SwiftUI


struct AdminMenuList: View {
    
    
    
    let customRows = [
            ("Post News", "MAY 4 2024", "newspaper.circle"),
            ("Service Request", "Pending Approval 4", "hammer.circle"),
            ("Add Employee", "Employees: 100", "person.2.circle"),
            ("Reset Password", "", "lock.circle"),
            ("No unread Messages", "", "envelope.circle"),
        ]
    
    var body: some View {
        
       
            List{
                
                ForEach(customRows, id: \.self.0){ row in
                    
                    Section{
                        AdminMenuRow(buttonTitle: row.0, buttonSubtitle: row.1, buttonImage: row.2)
                                            .padding()
                        
                                    }
                    
                }
                
            }
//            .listStyle(PlainListStyle())
            .shadow(color: .gray, radius: 2, x: 0, y: 2)
        
    
       
    }   
}

struct Admin_Menu_Previews: PreviewProvider {
    static var previews: some View {
        AdminMenuList()
    }
}
