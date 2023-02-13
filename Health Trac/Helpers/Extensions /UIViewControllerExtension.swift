//
//  UIViewControllerExtension.swift
// Health Track
//


import Foundation
import UIKit
import AssetsLibrary
import AVFoundation
import Photos
import MobileCoreServices
//import NVActivityIndicatorView

// UIViewController extension
extension UIViewController {

    //UIViewController extension for Image picker
    typealias ImagePickerDelegateController = (UIViewController & UIImagePickerControllerDelegate & UINavigationControllerDelegate)

    func captureImage(delegate controller: ImagePickerDelegateController,
                      photoGallery: Bool = true,
                      camera: Bool = true,
                      removeImage: Bool = false,
                      mediaType: [String] = [kUTTypeImage as String], removeImageBlock: (() -> Void)? = nil) {

        let chooseOptionText =  StringConstant.chooseOptions.value
        let alertController = UIAlertController(title: chooseOptionText, message: nil, preferredStyle: .actionSheet)

        if photoGallery {

            let chooseFromGalleryText =  StringConstant.chooseFromGallery.value
            let alertActionGallery = UIAlertAction(title: chooseFromGalleryText, style: .default) { _ in
                self.checkAndOpenLibrary(delegate: controller, mediaType: mediaType)
            }
            alertController.addAction(alertActionGallery)
        }

        if camera {

            let takePhotoText =  StringConstant.takePhoto.value
            let alertActionCamera = UIAlertAction(title: takePhotoText, style: .default) { _ in
                self.checkAndOpenCamera(delegate: controller, mediaType: mediaType)
            }
            alertController.addAction(alertActionCamera)
        }

        if removeImage {

            let chooseFromGalleryText =  StringConstant.removePhoto.value
            let alertActionGallery = UIAlertAction(title: chooseFromGalleryText, style: .default) { _ in

                if let handler = removeImageBlock {
                    handler()
                }
            }
            alertController.addAction(alertActionGallery)
        }

        let cancelText =  StringConstant.cancel.value
        let alertActionCancel = UIAlertAction(title: cancelText, style: .cancel) { _ in
        }
        alertController.addAction(alertActionCancel)

        controller.present(alertController, animated: true, completion: nil)
    }

    func checkAndOpenCamera(delegate controller: ImagePickerDelegateController, mediaType: [String] = [kUTTypeImage as String]) {

        let authStatus = AVCaptureDevice.authorizationStatus(for: AVMediaType.video)
        switch authStatus {

        case .authorized:

            let imagePicker = UIImagePickerController()
            imagePicker.delegate = controller
            imagePicker.mediaTypes = mediaType
            imagePicker.videoMaximumDuration = 15
            let sourceType = UIImagePickerController.SourceType.camera
            if UIImagePickerController.isSourceTypeAvailable(sourceType) {

                imagePicker.sourceType = sourceType
                imagePicker.allowsEditing = false

                if imagePicker.sourceType == .camera {
                    imagePicker.showsCameraControls = true
                }
                controller.present(imagePicker, animated: true, completion: nil)

            } else {

                let cameraNotAvailableText = StringConstant.cameraNotAvailable.value
                self.showAlert(title: "Error", msg: cameraNotAvailableText)
            }

        case .notDetermined:
            AVCaptureDevice.requestAccess(for: AVMediaType.video, completionHandler: { granted in

                if granted {

                    DispatchQueue.main.async {
                        let imagePicker = UIImagePickerController()
                        imagePicker.delegate = controller
                        imagePicker.mediaTypes = mediaType
                        imagePicker.videoMaximumDuration = 15

                        let sourceType = UIImagePickerController.SourceType.camera
                        if UIImagePickerController.isSourceTypeAvailable(sourceType) {

                            imagePicker.sourceType = sourceType
                            if imagePicker.sourceType == .camera {
                                imagePicker.allowsEditing = false
                                imagePicker.showsCameraControls = true
                            }
                            controller.present(imagePicker, animated: true, completion: nil)

                        } else {
                            let cameraNotAvailableText = StringConstant.cameraNotAvailable.value
                            self.showAlert(title: "Error", msg: cameraNotAvailableText)
                        }
                    }
                }
            })

        case .restricted:
            alertPromptToAllowCameraAccessViaSetting(StringConstant.restrictedFromUsingCamera.value)

        case .denied:
            alertPromptToAllowCameraAccessViaSetting(StringConstant.changePrivacySettingAndAllowAccessToCamera.value)
        @unknown default:
            fatalError("invalid state")
        }
    }
    
    func checkAndOpenVideoCamera(delegate controller: ImagePickerDelegateController, mediaType: [String] = [kUTTypeImage as String]) {

        let authStatus = AVCaptureDevice.authorizationStatus(for: AVMediaType.video)
        switch authStatus {

        case .authorized:

            let imagePicker = UIImagePickerController()
            imagePicker.delegate = controller
            imagePicker.mediaTypes = [kUTTypeMovie as String]
            imagePicker.videoMaximumDuration = 15
            let sourceType = UIImagePickerController.SourceType.camera
            if UIImagePickerController.isSourceTypeAvailable(sourceType) {

                imagePicker.sourceType = sourceType
                imagePicker.allowsEditing = true
                imagePicker.isNavigationBarHidden = true
                imagePicker.isToolbarHidden = true
                imagePicker.allowsEditing = true
//
//                if imagePicker.sourceType == .camera {
//                    imagePicker.showsCameraControls = true
//                }
                controller.present(imagePicker, animated: true, completion: nil)

            } else {

                let cameraNotAvailableText = StringConstant.cameraNotAvailable.value
                self.showAlert(title: "Error", msg: cameraNotAvailableText)
            }

        case .notDetermined:
            AVCaptureDevice.requestAccess(for: AVMediaType.video, completionHandler: { granted in

                if granted {

                    DispatchQueue.main.async {
                        let imagePicker = UIImagePickerController()
                        imagePicker.delegate = controller
                        imagePicker.mediaTypes = [kUTTypeMovie as String]
                        imagePicker.videoMaximumDuration = 15
                        let sourceType = UIImagePickerController.SourceType.camera
                        if UIImagePickerController.isSourceTypeAvailable(sourceType) {

                            imagePicker.sourceType = sourceType
                            imagePicker.allowsEditing = true
                            imagePicker.isNavigationBarHidden = true
                            imagePicker.isToolbarHidden = true
                            imagePicker.allowsEditing = true
            //
            //                if imagePicker.sourceType == .camera {
            //                    imagePicker.showsCameraControls = true
            //                }
                            controller.present(imagePicker, animated: true, completion: nil)

                        } else {
                            let cameraNotAvailableText = StringConstant.cameraNotAvailable.value
                            self.showAlert(title: "Error", msg: cameraNotAvailableText)
                        }
                    }
                }
            })

        case .restricted:
            alertPromptToAllowCameraAccessViaSetting(StringConstant.restrictedFromUsingCamera.value)

        case .denied:
            alertPromptToAllowCameraAccessViaSetting(StringConstant.changePrivacySettingAndAllowAccessToCamera.value)
        @unknown default:
            fatalError("invalid state")
        }
    }
    
    func checkAndOpenPhotoVideoLibrary(delegate controller: ImagePickerDelegateController, mediaType: [String] = [kUTTypeImage as String, kUTTypeMovie as String, kUTTypeVideo as String]) {

        let authStatus = PHPhotoLibrary.authorizationStatus()
        switch authStatus {

        case .notDetermined:
            let imagePicker = UIImagePickerController()
            imagePicker.delegate = controller
            imagePicker.mediaTypes = mediaType
            let sourceType = UIImagePickerController.SourceType.photoLibrary
            imagePicker.sourceType = sourceType
            imagePicker.allowsEditing = false
            imagePicker.videoMaximumDuration = 1
            imagePicker.videoExportPreset = AVAssetExportPresetPassthrough

            controller.present(imagePicker, animated: true, completion: nil)

        case .restricted:
            alertPromptToAllowCameraAccessViaSetting(StringConstant.restrictedFromUsingLibrary.value)

        case .denied:
            alertPromptToAllowCameraAccessViaSetting(StringConstant.changePrivacySettingAndAllowAccessToLibrary.value)

        case .authorized:
            let imagePicker = UIImagePickerController()
            imagePicker.delegate = controller
            let sourceType = UIImagePickerController.SourceType.photoLibrary
            imagePicker.sourceType = sourceType
            imagePicker.allowsEditing = false
            imagePicker.mediaTypes = mediaType
            imagePicker.videoMaximumDuration = 1
            imagePicker.videoExportPreset = AVAssetExportPresetPassthrough

            controller.present(imagePicker, animated: true, completion: nil)
        @unknown default:
            fatalError("invalid state")
        }
    }
    
    func checkAndOpenLibrary(delegate controller: ImagePickerDelegateController, mediaType: [String] = [kUTTypeImage as String]) {

        let authStatus = PHPhotoLibrary.authorizationStatus()
        switch authStatus {

        case .notDetermined:
            let imagePicker = UIImagePickerController()
            imagePicker.delegate = controller
            imagePicker.mediaTypes = mediaType
            let sourceType = UIImagePickerController.SourceType.photoLibrary
            imagePicker.sourceType = sourceType
            imagePicker.allowsEditing = false
            imagePicker.videoMaximumDuration = 15

            controller.present(imagePicker, animated: true, completion: nil)

        case .restricted:
            alertPromptToAllowCameraAccessViaSetting(StringConstant.restrictedFromUsingLibrary.value)

        case .denied:
            alertPromptToAllowCameraAccessViaSetting(StringConstant.changePrivacySettingAndAllowAccessToLibrary.value)

        case .authorized:
            let imagePicker = UIImagePickerController()
            imagePicker.delegate = controller
            let sourceType = UIImagePickerController.SourceType.photoLibrary
            imagePicker.sourceType = sourceType
            imagePicker.allowsEditing = false
            imagePicker.mediaTypes = mediaType
            imagePicker.videoMaximumDuration = 15

            controller.present(imagePicker, animated: true, completion: nil)
        @unknown default:
            fatalError("invalid state")
        }
    }

    func alertPromptToAllowCameraAccessViaSetting(_ message: String) {
        DispatchQueue.main.async {
            let alertText = StringConstant.alert.value
            let cancelText = StringConstant.cancel.value
            let settingsText = StringConstant.settings.value

            let alert = UIAlertController(title: alertText, message: message, preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: settingsText, style: .default, handler: { (_) in

                if #available(iOS 10.0, *) {
                    UIApplication.shared.open(URL(string: UIApplication.openSettingsURLString)!, options: [:], completionHandler: nil)
                } else {
                    // Fallback on earlier versions
                    UIApplication.shared.openURL(URL(string: UIApplication.openSettingsURLString)!)
                }
                alert.dismiss(animated: true, completion: nil)
            }))
            alert.addAction(UIAlertAction(title: cancelText, style: .cancel, handler: nil))
            self.present(alert, animated: true, completion: nil)
        }
    }

    ///Adds Child View Controller to Parent View Controller
    func add(childViewController: UIViewController) {

        self.addChild(childViewController)
        childViewController.view.frame = self.view.bounds
        self.view.addSubview(childViewController.view)
        childViewController.didMove(toParent: self)
    }

    ///Removes Child View Controller From Parent View Controller
    var removeFromParent: Void {

        self.willMove(toParent: nil)
        self.view.removeFromSuperview()
        self.removeFromParent()
    }

    ///Updates navigation bar according to given values
    func updateNavigationBar(withTitle title: String? = nil, leftButton: [UIBarButtonItem]? = nil, rightButtons: [UIBarButtonItem]? = nil, tintColor: UIColor? = nil, barTintColor: UIColor? = nil, titleTextAttributes: [NSAttributedString.Key: Any]? = nil) {
        self.navigationController?.isNavigationBarHidden = false
        if let tColor = barTintColor {
            self.navigationController?.navigationBar.barTintColor = tColor
        }
        if let tColor = tintColor {
            self.navigationController?.navigationBar.tintColor = tColor
        }
        if let button = leftButton {
            self.navigationItem.leftBarButtonItems = button
        }
        if let rightBtns = rightButtons {
            self.navigationItem.rightBarButtonItems = rightBtns
        }
        if let ttle = title {
            self.title = ttle
        }
        if let ttleTextAttributes = titleTextAttributes {
            self.navigationController?.navigationBar.titleTextAttributes =   ttleTextAttributes
        }
    } 
    ///Not using static as it won't be possible to override to provide custom storyboardID then
    class var storyboardID: String {

        return "\(self)"
    }

    //function to pop the target from navigation Stack
    @objc func pop(animated: Bool = true) {
        _ = self.navigationController?.popViewController(animated: animated)
    }

    func popToSpecificViewController(atIndex index: Int, animated: Bool = true) {

        if let navVc = self.navigationController, navVc.viewControllers.count > index {

            _ = self.navigationController?.popToViewController(navVc.viewControllers[index], animated: animated)
        }
    }

    func showAlert( title: String = "", msg: String, _ completion: (() -> Void)? = nil) {

        let alertViewController = UIAlertController(title: title, message: msg, preferredStyle: UIAlertController.Style.alert)
        let okAction = UIAlertAction(title: StringConstant.ok.value, style: UIAlertAction.Style.default) { (_: UIAlertAction) -> Void in

            alertViewController.dismiss(animated: true, completion: nil)
            completion?()
        }

        alertViewController.addAction(okAction)

        self.present(alertViewController, animated: true, completion: nil)

    }

    /// Start Loader
//    func startNYLoader() {
//        startAnimating(CGSize(width: 50, height: 50), type: NVActivityIndicatorType.ballRotateChase, color: AppColors.rouge, backgroundColor: AppColors.loaderBkgroundColor)
//    }
    
    func showAlert( title : String = "",
                    msg : String,
                    cancelTitle : String = StringConstant.cancel.value,
                    actionTitle : String = StringConstant.ok.value,
                    actioncompletion : (()->())? = nil,
                    cancelcompletion : (()->())? = nil) {
        
        let alertViewController = UIAlertController(title: title, message: msg, preferredStyle: UIAlertController.Style.alert)
        let okAction = UIAlertAction(title: actionTitle, style: UIAlertAction.Style.default) { (action : UIAlertAction) -> Void in
            
            alertViewController.dismiss(animated: true, completion: nil)
            actioncompletion?()
        }
        
        let cancelAction = UIAlertAction(title: cancelTitle, style: UIAlertAction.Style.cancel) { (action : UIAlertAction) -> Void in
            
            alertViewController.dismiss(animated: true, completion: nil)
            cancelcompletion?()
        }
        
        alertViewController.addAction(okAction)
        alertViewController.addAction(cancelAction)
        
        self.present(alertViewController, animated: true, completion: nil)
        
    }
}
