//
//  BaseVC.swift
//  Health Track

import UIKit
import IQKeyboardManagerSwift
import EmptyDataSet_Swift
import AVFoundation

class BaseVC: UIViewController, UITextFieldDelegate {
    
    enum LeftNavType {
        case back, none
    }
    enum NavBarType {
        case normal, lookUp, clearBackground, none
    }
    
    enum NoDataFoundCase {
        case noData
        case other
    }
    
    // MARK: - Variables
    //===================
    private var returnKeyHandler: IQKeyboardReturnKeyHandler?
    
    // MARK: - Life Cycle
    //===================
    override func viewDidLoad() {
        super.viewDidLoad()
        
        defaultSetup()
        self.setNeedsStatusBarAppearanceUpdate()
        // Do any additional setup after loading the view.
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .default
    }
}

// MARK: - Extension for Methods
//=======================================
extension BaseVC {
    
    //To setup IQkeybord Manager
    func defaultSetup() {
        returnKeyHandler = IQKeyboardReturnKeyHandler(controller: self)
        returnKeyHandler?.lastTextFieldReturnKeyType = .done
    }
}

// MARK: - Extension for Navigation Methods
//=======================================
extension BaseVC {
    
    // MARK: - SET NAVIGATION BAR Methods
    //=================================
    func setNavigationBar(withTitle title: String? = nil,
                          leftNavType: LeftNavType? = nil,
                          firstRightBtnImg: UIImage? = nil,
                          secRightBtnImg: UIImage? = nil,
                          thirdRightBtnImg: UIImage? = nil,
                          fourthRightBtnImg: UIImage? = nil,
                          firstRightBtnTitle: String? = nil,
                          secRightBtnTitle: String? = nil,
                          thirdRightBtnTitle: String? = nil,
                          fourthRightBtnTitle: String? = nil,
                          tintColor: UIColor? = nil,
                          barTintColor: UIColor? = nil,
                          attributesColor: UIColor? = nil, navBarType: NavBarType = .normal) {
        
        //FOR LEFT BAR BUTTON
        var leftBtn = [UIBarButtonItem]()
        var firstRightBtn = UIBarButtonItem()
        var secRightBtn = UIBarButtonItem()
        var thirdRightBtn = UIBarButtonItem()
        var fourthRightBtn = UIBarButtonItem()
        
        if let lftNavType = leftNavType {
            if lftNavType == .back {
                if navBarType == .normal {
                    let image = #imageLiteral(resourceName: "icBack").withRenderingMode(.alwaysOriginal)
                    let backBtn = UIBarButtonItem(image: image, style: UIBarButtonItem.Style.plain, target: self, action: #selector(onClickBackNavigationBarButton(_:)))
                    leftBtn.append(backBtn)
                } else {
                    let image = #imageLiteral(resourceName: "icBackWhite").withRenderingMode(.alwaysOriginal)
                    let backBtn = UIBarButtonItem(image: image, style: UIBarButtonItem.Style.plain, target: self, action: #selector(onClickBackNavigationBarButton(_:)))
                    leftBtn.append(backBtn)
                }
            }
        }
        
        //FOR FIRST RIGHT BAR BUTTON
        if let rightBtnImg = firstRightBtnImg {
            let btn: UIButton = UIButton()
            btn.setImage(rightBtnImg, for: UIControl.State.normal)
            btn.addTarget(self, action: #selector(onClickFirstRightNavigationBarButton(_:)), for: UIControl.Event.touchUpInside)
            btn.frame = CGRect(x: 0, y: 0, width: 30, height: 30)
            firstRightBtn = UIBarButtonItem(customView: btn)
        } else if let rightBtnTitle = firstRightBtnTitle {
            firstRightBtn = UIBarButtonItem(title: rightBtnTitle, style: .plain, target: self, action: #selector(onClickFirstRightNavigationBarButton(_:)))
            firstRightBtn.setTitleTextAttributes([
            NSAttributedString.Key.foregroundColor: AppColors.white, NSAttributedString.Key.font: AppFonts.Montserrat_SemiBold.withSize(14)], for: .normal)
        }
        
        //FOR SECOND RIGHT BAR BUTTON
        if let rightBtnImg = secRightBtnImg {
            let btn: UIButton = UIButton()
            btn.setImage(rightBtnImg, for: UIControl.State.normal)
            btn.addTarget(self, action: #selector(onClickSecRightNavigationBarButton(_:)), for: UIControl.Event.touchUpInside)
            btn.frame = CGRect(x: 0, y: 0, width: 30, height: 30)
            secRightBtn = UIBarButtonItem(customView: btn)
        } else if let rightBtnTitle = secRightBtnTitle {
            secRightBtn = UIBarButtonItem(title: rightBtnTitle, style: .plain, target: self, action: #selector(onClickSecRightNavigationBarButton(_:)))
        }
        
        //FOR THIRD RIGHT BAR BUTTON
        if let rightBtnImg = thirdRightBtnImg {
            let btn: UIButton = UIButton()
            btn.setImage(rightBtnImg, for: UIControl.State.normal)
            btn.addTarget(self, action: #selector(onClickThirdRightNavigationBarButton(_:)), for: UIControl.Event.touchUpInside)
            btn.frame = CGRect(x: 0, y: 0, width: 30, height: 30)
            thirdRightBtn = UIBarButtonItem(customView: btn)
        } else if let rightBtnTitle = thirdRightBtnTitle {
            thirdRightBtn = UIBarButtonItem(title: rightBtnTitle, style: .plain, target: self, action: #selector(onClickThirdRightNavigationBarButton(_:)))
        }
        
        //FOR Fourth RIGHT BAR BUTTON
        if let rightBtnImg = fourthRightBtnImg {
            let btn: UIButton = UIButton()
            btn.setImage(rightBtnImg, for: UIControl.State.normal)
            btn.addTarget(self, action: #selector(onClickFourthRightNavigationBarButton(_:)), for: UIControl.Event.touchUpInside)
            btn.frame = CGRect(x: 0, y: 0, width: 30, height: 30)
            fourthRightBtn = UIBarButtonItem(customView: btn)
        } else if let rightBtnTitle = fourthRightBtnTitle {
            fourthRightBtn = UIBarButtonItem(title: rightBtnTitle, style: .plain, target: self, action: #selector(onClickFourthRightNavigationBarButton(_:)))
        }
        
        let tColor = (tintColor == nil) ? (navBarType == .normal ? AppColors.white: AppColors.black): tintColor
        let barTColor = (barTintColor == nil) ? (navBarType == .normal ? AppColors.black: AppColors.white): barTintColor
        
        let tAttributes = (attributesColor == nil) ? [
            NSAttributedString.Key.foregroundColor: AppColors.black, NSAttributedString.Key.font: AppFonts.Montserrat_SemiBold.withSize(19)]:
            [
                NSAttributedString.Key.foregroundColor: attributesColor ?? tColor, NSAttributedString.Key.font: AppFonts.Montserrat_SemiBold.withSize(19)]
        
        self.navigationController?.navigationBar.isTranslucent = false
        self.navigationController?.navigationBar.shadowImage = UIImage()
        //    UIApplication.shared.statusBarStyle = .default
        
        if navBarType == .clearBackground {
            self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
            self.navigationController?.navigationBar.shadowImage = UIImage()
            self.navigationController?.navigationBar.isTranslucent = true
            self.navigationController?.view.backgroundColor = .clear
        }
        
        self.updateNavigationBar(withTitle: title,
                                 leftButton: leftBtn,
                                 rightButtons: [firstRightBtn,
                                                secRightBtn,
                                                thirdRightBtn,
                                                fourthRightBtn],
                                 tintColor: tColor,
                                 barTintColor: barTColor,
                                 titleTextAttributes: tAttributes as [NSAttributedString.Key: Any])
    }
    
    @objc func onClickBackNavigationBarButton(_ sender: UIButton) {
        self.pop()
    }
    
    @objc func onClickHomeNavigationBarButton(_ sender: UIButton) {
        
    }
    
    @objc func onClickFirstRightNavigationBarButton(_ sender: UIButton) {
        
    }
    
    @objc func onClickSecRightNavigationBarButton(_ sender: UIButton) {
        
    }
    
    @objc func onClickThirdRightNavigationBarButton(_ sender: UIButton) {
        
    }
    
    @objc func onClickFourthRightNavigationBarButton(_ sender: UIButton) {
        
    }
}

// MARK: - Extension for Textfield Delegate
//=======================================
extension BaseVC {
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        return true
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        return true
    }
    
    func textFieldShouldClear(_ textField: UITextField) -> Bool {
        return  true
    }
}

// MARK: - Extension for EmptyDataSet
//=======================================
extension BaseVC {
    
    // MARK: - settingEmptyDataSet method
    //=================================
    func settingEmptyDataSet(placeholder: String, placeholderTV: UITableView, isLargeText: Bool = false, emptyDataState: NoDataFoundCase = NoDataFoundCase.noData) {
        
        let myAttribute = [NSAttributedString.Key.font: AppFonts.Montserrat_Bold.withSize(isLargeText ? 17: 14),
                           NSAttributedString.Key.foregroundColor: UIColor.init(light: .black, dark: .white)]
        
        let message = placeholder
        let stringPlaceholder = NSAttributedString(string: "\n\(message)\n\n\n", attributes: myAttribute)
        
        placeholderTV.emptyDataSetView { view in
            view.titleLabelString(stringPlaceholder)
                //.image(UIImage(named: "icEmptyStateNodata"))
                .isScrollAllowed(true)
                .isImageViewAnimateAllowed(true)
                .didTapDataButton {
                    // Do nothing
                }
                .didTapContentView {
                    // Do nothing
                }
        }
    }
    
    // MARK: - settingEmptyDataSet for collectionview method
    //=================================
    func settingEmptyDataSetForCollectionView(placeholder: String, placeholderCV: UICollectionView, isLargeText: Bool = false, emptyDataState: NoDataFoundCase = NoDataFoundCase.noData) {
        
        let myAttribute = [NSAttributedString.Key.font: AppFonts.Montserrat_Bold.withSize(isLargeText ? 17: 14),
                           NSAttributedString.Key.foregroundColor: AppColors.black]
        
        var message = ""
        switch emptyDataState {
        case .noData:
            message = StringConstant.noResultFound.value
        case .other:
            message = ""
        }
        
        let stringPlaceholder = NSAttributedString(string: "\n\(message)\n\n\n", attributes: myAttribute)
        
        placeholderCV.emptyDataSetView { view in
            view.titleLabelString(stringPlaceholder)
                //.image(UIImage(named: "icEmptyStateNodata"))
                .isScrollAllowed(true)
                .isImageViewAnimateAllowed(true)
                .didTapDataButton {
                    // Do nothing
                }
                .didTapContentView {
                    // Do nothing
                }
        }
    }
}


