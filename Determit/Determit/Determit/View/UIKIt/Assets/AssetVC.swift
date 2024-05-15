//
//  AssetVC.swift
//  Determit
//
//  Created by Hector Lliguichuzca on 5/7/24.
//

import UIKit
import SwiftUI





class AssetVC: UIViewController {

    //Properties
let SampleDate = Date()
    // Computed property to format createdAt into preferred format
    var formattedCreatedAt: Date {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss" // Your preferred date format
        let dateString = dateFormatter.string(from: SampleDate)
        return dateFormatter.date(from: dateString) ?? SampleDate
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        //Present Custome SwiftUI View in UIKit ViewController
        configureSwiftUI()
    }
    

    //MARK: -- Integrate Swift UI To UIKIt Method
    func sampleData(){
        
        
        
        
        
    }
    
    private func configureSwiftUI(){
        
        
        // Create a SwiftUI view and wrap it in a UIHostingController
        let ticketRow = TicketRow(ticket: APITicket(_id: "60a42b2fda8bc6477ff55123", organizationId: "60a42b2fda8bc6477ff55000", assetId: "60a42b2fda8bc6477ff55abc", title: "Clean installation of macOS Monterey", description: "Running slow, backup data, and clean install macOS.", priority: "Medium", status: "Open", category: "Software", assignedTo: "Hector Lliguichuzhca", createdBy: "Mrs. Figueroa", createdAt: formattedCreatedAt, updatedAt: SampleDate, dueDate: formattedCreatedAt )) // Provide appropriate asset tag
        
        
               let hostingController = UIHostingController(rootView: ticketRow)
               
               // Set up constraints if needed Constaraints
               hostingController.view.translatesAutoresizingMaskIntoConstraints = false
               view.addSubview(hostingController.view)
               NSLayoutConstraint.activate([
                   hostingController.view.topAnchor.constraint(equalTo: view.topAnchor),
                   hostingController.view.leadingAnchor.constraint(equalTo: view.leadingAnchor),
                   hostingController.view.trailingAnchor.constraint(equalTo: view.trailingAnchor),
                   hostingController.view.bottomAnchor.constraint(equalTo: view.bottomAnchor)
               ])
     
        
    }

}
