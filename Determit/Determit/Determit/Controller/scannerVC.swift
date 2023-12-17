//
//  scanner.swift
//  Determit
//
//  Created by Hector Lliguichuzca on 12/14/23.
//

import AVFoundation
import UIKit


class scannerVC: UIViewController{
    
    
    
    var captureSession: AVCaptureSession!
    var previewLayer: AVCaptureVideoPreviewLayer!
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //Set up camera
        
        setupScanner()
        
        
        
        
        
    }
    
    
    
}
    
    //MARK: - BAR CODE SCANNER METHOD
    
    extension scannerVC: AVCaptureMetadataOutputObjectsDelegate {
        
        func setupScanner() {
            captureSession = AVCaptureSession()
            
            guard let videoCaptureDevice = AVCaptureDevice.default(for: .video) else { return }
            let videoInput: AVCaptureDeviceInput
            
            do {
                videoInput = try AVCaptureDeviceInput(device: videoCaptureDevice)
            } catch {
                return
            }
            
            if (captureSession.canAddInput(videoInput)) {
                captureSession.addInput(videoInput)
            } else {
                failed()
                return
            }
            
            let metadataOutput = AVCaptureMetadataOutput()
            
            if (captureSession.canAddOutput(metadataOutput)) {
                captureSession.addOutput(metadataOutput)
                
                metadataOutput.setMetadataObjectsDelegate(self, queue: DispatchQueue.main)
                metadataOutput.metadataObjectTypes = [.qr, .ean8, .ean13, .pdf417]
            } else {
                failed()
                return
            }
            
            previewLayer = AVCaptureVideoPreviewLayer(session: captureSession)
            previewLayer.frame = view.layer.bounds
            previewLayer.videoGravity = .resizeAspectFill
            view.layer.addSublayer(previewLayer)
            
            captureSession.startRunning()
        }
        
        func failed() {
            let alert = UIAlertController(title: "Scanning not supported", message: "Your device does not support scanning a code from an item. Please use a device with a camera.", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default))
            present(alert, animated: true)
            captureSession = nil
        }
        
        override func viewWillAppear(_ animated: Bool) {
            super.viewWillAppear(animated)
            
            if (captureSession?.isRunning == false) {
                captureSession.startRunning()
            }
        }
        
        override func viewWillDisappear(_ animated: Bool) {
            super.viewWillDisappear(animated)
            
            if (captureSession?.isRunning == true) {
                captureSession.stopRunning()
            }
        }
        
        func metadataOutput(_ output: AVCaptureMetadataOutput, didOutput metadataObjects: [AVMetadataObject], from connection: AVCaptureConnection) {
            captureSession.stopRunning()
            
            if let metadataObject = metadataObjects.first {
                guard let readableObject = metadataObject as? AVMetadataMachineReadableCodeObject else { return }
                guard let stringValue = readableObject.stringValue else { return }
                
                AudioServicesPlaySystemSound(SystemSoundID(kSystemSoundID_Vibrate))
                showCapturedDataAlert(data: stringValue)
                
                
                
                
            }
        }
        
        func showCapturedDataAlert(data: String) {
            let alert = UIAlertController(title: "Captured Data", message: "Scanned data: \(data)", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default) { _ in
                // Dismiss the current view controller and pop back to the previous one
                       self.navigationController?.popViewController(animated: true)
            })
            present(alert, animated: true)
        }
        
        override var prefersStatusBarHidden: Bool {
            return true
        }
        
        override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
            return .portrait
        }
        
        
    
}
