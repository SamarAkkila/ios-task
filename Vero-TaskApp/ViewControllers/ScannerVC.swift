//
//  ScannerVC.swift
//  Vero-TaskApp
//
//  Created by MacBook on 29/03/2023.
//  Copyright © 2023 SamarAkkila. All rights reserved.
//

import AVFoundation
import UIKit

class ScannerVC: UIViewController, AVCaptureMetadataOutputObjectsDelegate {
    
    
    @IBOutlet weak var btnSearch : UIButton!
    @IBOutlet weak var lblWord : UILabel!
    
    @IBOutlet weak var viewHeader : UIView!
    @IBOutlet weak var viewDetails : UIView!
    
    var qrCodeFrameView: UIView?
    
    var strSearch :String = ""
    var captureSession: AVCaptureSession!
    var previewLayer: AVCaptureVideoPreviewLayer!

    var delegate : ( (String) -> Void)?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.setupSession()
        view.backgroundColor = UIColor.black
       
    }

    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        if (captureSession?.isRunning == false) {
            DispatchQueue.main.async {
                self.captureSession.startRunning()
            }
        }
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)

        if (captureSession?.isRunning == true) {
            captureSession.stopRunning()
        }
    }
    
    
    func setupSession(){
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
            metadataOutput.metadataObjectTypes = [.qr]
            
           
        } else {
            failed()
            return
        }

        previewLayer = AVCaptureVideoPreviewLayer(session: captureSession)
        previewLayer.frame = view.layer.bounds
        previewLayer.videoGravity = .resizeAspectFill
        view.layer.addSublayer(previewLayer)

        DispatchQueue.main.async {
            self.captureSession.startRunning()
        }
        
        // Initialize QR Code Frame to highlight the QR code
        qrCodeFrameView = UIView()

        if let qrCodeFrameView = qrCodeFrameView {
            qrCodeFrameView.layer.borderColor = UIColor.green.cgColor
            qrCodeFrameView.layer.borderWidth = 3
            view.addSubview(qrCodeFrameView)
            view.bringSubviewToFront(qrCodeFrameView)
        }
        
        view.bringSubviewToFront(viewHeader)
        view.bringSubviewToFront(viewDetails)
    }
    
    func failed() {
        let ac = UIAlertController(title: "Scanning not supported", message: "Your device does not support scanning a code from an item. Please use a device with a camera.", preferredStyle: .alert)
        ac.addAction(UIAlertAction(title: "OK", style: .default))
        present(ac, animated: true)
        captureSession = nil
    }



    func metadataOutput(_ output: AVCaptureMetadataOutput, didOutput metadataObjects: [AVMetadataObject], from connection: AVCaptureConnection) {
        captureSession.stopRunning()

        if let metadataObject = metadataObjects.first {
            
            qrCodeFrameView?.frame = CGRect.zero
            if metadataObject.type == AVMetadataObject.ObjectType.qr {
                // If the found metadata is equal to the QR code metadata then update the status label's text and set the bounds
                let barCodeObject = previewLayer?.transformedMetadataObject(for: metadataObject)
                qrCodeFrameView?.frame = barCodeObject!.bounds
                
            }
            guard let readableObject = metadataObject as? AVMetadataMachineReadableCodeObject else { return }
            guard let stringValue = readableObject.stringValue else { return }
            AudioServicesPlaySystemSound(SystemSoundID(kSystemSoundID_Vibrate))
            
            found(code: stringValue)
        }

//        dismiss(animated: true)
    }

    func found(code: String) {
        
        print(code)
        self.lblWord.text = code
        self.strSearch = code
        self.btnSearch.backgroundColor = "#1ab562".getUIColor()
    }

    override var prefersStatusBarHidden: Bool {
        return true
    }

    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        return .portrait
    }
    
    
    
    
    @IBAction func RefreshButtonPressed(_ sender: Any) {
        self.lblWord.text = "Scanning.."
        self.btnSearch.backgroundColor = "#878787".getUIColor()
        DispatchQueue.main.async {
            self.captureSession.startRunning()
        }
    }
    
    @IBAction func backButtonPressed(_ sender: Any) {
        self.dismiss(animated: true)
    }
    
    @IBAction func SearchButtonPressed(_ sender: Any) {
        self.delegate?(strSearch)
        self.dismiss(animated: true)
    }
}
