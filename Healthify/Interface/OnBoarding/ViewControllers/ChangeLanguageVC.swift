//
//  ChangeLanguageVC.swift
//  HealthyApp
//
//  Created by shelly choudhary on 25/03/20.
//  Copyright © 2020 shelly choudhary. All rights reserved.
//

import UIKit


class ChangeLanguageVC: UIViewController {
    
    // MARK: - ▼▼▼ Properties ▼▼▼
    @IBOutlet weak var tblLangView: UITableView!
    var tblDataSource: [String] = [kEnglishLang.localizeString(), kSpanishLang.localizeString()]
    var selectedIndex: Int = -1


    override func viewDidLoad() {
        super.viewDidLoad()
        selectedIndex = LanguageManager.currentLanguageIndex()
    }
    
    
    private func setupAppLanguage() {
        
        LanguageManager.saveLanguage(by: self.selectedIndex)
        LanguageManager.setupCurrentLanguage()
        if let languageCode = LanguageManager.currentLanguageCode() {
            UserDefaults.standard.set([languageCode], forKey: kAppleLanguages)
            UserDefaults.standard.synchronize()
            //LoggedInUser.shared.language = languageCode
        }
        LoaderView.kill()
        Util.showAlertWithMessage("LANGUAGE_CHANGED_SUCCESS".localizeString(), title: "Alert") {
            self.navigationController?.pushViewController(Storyboard.onboarding.instantaite(LoginVC.self), animated: true)
        }
        
    }
    
    @objc func dismissLoader(){
       setupAppLanguage()
    }
    
        @IBAction func btnSkip_action(_ sender: Any) {
            navigationController?.pushViewController(Storyboard.onboarding.instantaite(LoginVC.self), animated: true)
    }
}


extension ChangeLanguageVC: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        tblDataSource.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueCell(cellType: LanguageTbleCell.self)
        cell.setupCell(data: tblDataSource[indexPath.row])
        return cell
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if LanguageManager.currentLanguageCode() == tblDataSource[indexPath.row].type() {
            Util.showAlertWithMessage("ALREADY_CHOSEN_LANG_ALERT".localizeString(), title: Key_Alert.localizeString())
            return
        }
        selectedIndex = indexPath.row
        LoaderView.show()
        Timer.scheduledTimer(timeInterval: 3.0, target: self, selector: #selector(self.dismissLoader), userInfo: nil, repeats: false)
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
}
