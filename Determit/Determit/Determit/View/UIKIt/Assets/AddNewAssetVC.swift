//
//  AddNewAssetVC.swift
//  Determit
//
//  Created by Hector Lliguichuzca on 5/26/23.
//

import UIKit
import CoreData

 
//Delegate Protocal
protocol AddNewAccetVCDelegate{
    func shouldDisplayButton(_ shouldDisplay:  Bool)
}

class AddNewAssetVC:  UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var deviceIDTextField: UITextField!
    
    var item: Device?
    var modelID: String = ""
    var devices: [Device] = []
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    var delegate: AddNewAccetVCDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Register the custom cell class for the table view
        tableView.register(UINib(nibName: "deviceTableViewCell", bundle: nil), forCellReuseIdentifier: "deviceCell")
    }
    
    // MARK: - Table view data source
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return devices.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "deviceCell", for: indexPath) as! deviceTableViewCell
        
        let device = devices[indexPath.row]
        
        
        cell.deviceNameLabel.text = device.model
        
        return cell
    }
    
    //MARK: - Table View Delegate
    
    //
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "Select Device"
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        
        // Create a custom view for the header section
        let headerView = UIView(frame: CGRect(x: 0, y: 0, width: tableView.bounds.width, height: 20))
        headerView.backgroundColor = UIColor.darkText
        
        // Create a label for the title
        let titleLabel = UILabel(frame: headerView.bounds)
        titleLabel.text = "Select from Available Devices"
        titleLabel.textAlignment = .center
        titleLabel.textColor = UIColor.white
        titleLabel.font = UIFont.boldSystemFont(ofSize: 12)
        headerView.addSubview(titleLabel)
        
        //
        // Customize the header view as needed
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(headerTapped))
        headerView.addGestureRecognizer(tapGesture)
        //
        return headerView
        
        
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //when selected row
        let selectedDevice = devices[indexPath.row]
        
        deviceIDTextField.placeholder = selectedDevice.model
        let modelID = selectedDevice.model
        
        item = selectedDevice
//        print("model ID \(modelID)... Was selected ")
    }
    @objc func headerTapped() {
        // Perform the action when the header section is tapped
        print("Header section tapped!")
        loadData()
        // Add your custom logic here
    }
    
    func loadData(){
        print("loading Data from Core data")
        DispatchQueue.main.async {
            
            let request: NSFetchRequest<Device> = Device.fetchRequest()
            
            do{
                self.devices = try self.context.fetch(request)
            }catch{
                print("Error fetching data from context \(error)")
            }
            self.tableView.reloadData()
        }
    }
    @IBAction func saveData(_ sender: Any) {
        
        //        Alert.showBasicAlert(on: self, with: "", message: "Is the following data ok to save")
     
        //Action
    }
    
    
}
