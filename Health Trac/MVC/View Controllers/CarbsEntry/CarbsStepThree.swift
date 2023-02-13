//
//  CarbsStepThree.swift
//   Health Track

import UIKit
import AVKit

class CarbsStepThree: UIViewController {
    
    //MARK: - IBOutlets
    //=================================================
    @IBOutlet var carbsSTepThreeView: CarbsStepThreeView!
    
    //MARK: - Properties
    //=================================================
    var session: AVCaptureSession?
    var output = AVCapturePhotoOutput()
    var model = ReadingsModel()
    
    //MARK: - View lifecycles
    //=================================================
    override func viewDidLoad() {
        super.viewDidLoad()
        checkCameraPermission()
        actions()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        if AVCaptureDevice.authorizationStatus(for: .video) == .denied {
            carbsSTepThreeView.showWarnigView()
        }
    }
    
    //MARK: - Functions
    //=================================================
    
    ///Handles IBActions from the view
    func actions() {
        
        //Handling Skip Button Tapped
        //========================================================
        carbsSTepThreeView.skipBtnTapped = { [weak self] (button) in
            guard let `self` = self else { return }
            self.pushToNextStep()
        }
        
        //Handling Back Button Tapped
        //========================================================
        carbsSTepThreeView.navigationBar.backButtonTapped =  {[weak self] (button) in
            guard let `self` = self else { return }
            self.pop()
        }
        
        //Handling getFilePath
        //========================================================
        carbsSTepThreeView.getFilePath = { path in
            self.model.carbsMedia = path
        }
        
        //Handling Image Capture
        //========================================================
        carbsSTepThreeView.imageCapture = { [weak self] in
            guard let `self` = self else { return }
            self.output.capturePhoto(with: AVCapturePhotoSettings(), delegate: self)
        }
        
        //Handling Show Alert Button
        //========================================================
        carbsSTepThreeView.showAlertBtnTapped =  {[weak self] (button) in
            guard let `self` = self else { return }
            self.showAlert()
        }
    }
    
    ///Checks Camera permissions
    private func checkCameraPermission() {
        switch AVCaptureDevice.authorizationStatus(for: .video) {
        
        case .notDetermined:
            AVCaptureDevice.requestAccess(for: .video) { granted in
                guard granted else {
                    DispatchQueue.main.async {
                        self.showAlert()
                    }
                    return
                }
                DispatchQueue.main.async {
                    self.setupCamera()
                }
            }
        case .restricted:
            break
        case .denied:
            showAlert()
        case .authorized:
            setupCamera()
        @unknown default:
            break
        }
    }
    
    ///Sets up Camera
    private func setupCamera() {
        let session = AVCaptureSession()
        session.sessionPreset = AVCaptureSession.Preset.high
        if let device = AVCaptureDevice.default(for: .video) {
            do {
                let input = try AVCaptureDeviceInput.init(device: device)
                if session.canAddInput(input) {
                    session.addInput(input)
                }
                if session.canAddOutput(output) {
                    session.addOutput(output)
                }
                carbsSTepThreeView.previewLayer.videoGravity = .resizeAspectFill
                carbsSTepThreeView.previewLayer.session = session
                session.startRunning()
                self.session = session
            }
            catch {
                printDebug(error.localizedDescription)
            }
        }
    }
    
    ///Shows Alert View if camera permission is denied
    func showAlert() {
        let alertView = UIAlertController(title: StringConstant.cameraPermissionDenied.value, message: StringConstant.skipToNextStep.value, preferredStyle: .alert)
        alertView.addAction(UIAlertAction(title: StringConstant.ok.value, style: .cancel, handler: { _ in
            self.dismiss(animated: true) {
                self.carbsSTepThreeView.skipButtonTapped(self.carbsSTepThreeView.skipButton)
            }
        }))
        alertView.addAction(UIAlertAction(title: "Settings", style: .default, handler: { _ in
            self.dismiss(animated: true) {
                guard let settingsUrl = URL(string: UIApplication.openSettingsURLString) else {
                    return
                }
                if UIApplication.shared.canOpenURL(settingsUrl) {
                    UIApplication.shared.open(settingsUrl, completionHandler: { (success) in
                        printDebug("Settings opened: \(success)")
                    })
                }
            }
        }))
        self.present(alertView, animated: true, completion: nil)
    }
    
    ///Pushes to step Four
    func pushToNextStep() {
        let scene = CarbsViewController.instantiate(fromAppStoryboard: .ReadingEntry)
        scene.model = self.model
        DispatchQueue.main.asyncAfter(deadline: .now()+0.1) {
            scene.carbsView.carbsScrollView.contentOffset = CGPoint(x: scene.carbsView.frame.width*2, y: 0)
        }
        self.navigationController?.pushViewController(scene, animated: true)
    }
    
}

//MARK: - Extention AVCapturePhotoCaptureDelegate
//=================================================
extension CarbsStepThree: AVCapturePhotoCaptureDelegate {
    
    func photoOutput(_ output: AVCapturePhotoOutput, didFinishProcessingPhoto photo: AVCapturePhoto, error: Error?) {
        guard let data = photo.fileDataRepresentation() else { return }
        let image = UIImage(data: data)?.fixOrientation()
        
        session?.stopRunning()
        
        let fileManager = FileManager.default
        let documentsURL = fileManager.urls(for: .documentDirectory, in: .userDomainMask).first
        let documentPath = documentsURL?.path
        let filePath = documentsURL?.appendingPathComponent("\(Int(Date().timeIntervalSince1970)).png")
        do {
            guard let jpegImageData = image?.jpegData(compressionQuality: 1), let filePath = filePath else {return}
            try jpegImageData.write(to: filePath, options: .atomic)
            self.model.carbsMedia = "\(filePath.path)"
            self.pushToNextStep()
        } catch {
            printDebug("Couldn't write image")
        }
    }
}

