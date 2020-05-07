
//  AppDelegate.swift
//  HealthyApp
//
//  Created by shelly choudhary on 25/03/20.
//  Copyright © 2020 shelly choudhary. All rights reserved.


import UIKit
import IQKeyboardManagerSwift
import Kingfisher
import Firebase

@UIApplicationMain
 class AppDelegate: UIResponder, UIApplicationDelegate {
    
    // MARK: - ▼▼▼ Properties ▼▼▼
    var navigationController : UINavigationController!
    var window: UIWindow?
    var dbRef: DatabaseReference?
    var fireStoreDB: Firestore!
    
    // MARK: - ▼▼▼ Computed Properties ▼▼▼
    private var fireCloudStoreDBRef: Firestore {
        let settings = FirestoreSettings()
        Firestore.firestore().settings = settings
        fireStoreDB = Firestore.firestore()
        return fireStoreDB
    }
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        setupWindow()
        initialSetup(application)
        setFBObserverAtAppLaunch()
        return true
    }
    
    
    // MARK: - ▼▼▼ Setup Window & Root Method ▼▼▼
    private func setupWindow() {
        navigationController = UINavigationController()
        navigationController.isNavigationBarHidden = true
        window = UIWindow(frame: UIScreen.main.bounds)
        window!.rootViewController = navigationController
        window?.makeKeyAndVisible()
    }
    
    
    //MARK: - Private Method
    private func initialSetup(_ application: UIApplication) {
        
        FirebaseApp.configure()
        dbRef = Database.database().reference()
        setupAppResources()
        setupUserNavigation()
    }
    
    
    
    // MARK: - ▼▼▼ OBSERVER ON FDB UPDATES ▼▼▼
    private func setFBObserverAtAppLaunch() {
        if let currentUser = Auth.auth().currentUser {
            LoaderView.show()
            appDelegate.dbRef?.child(kUsers).child(currentUser.uid).observe(.value, with: { (dmsnpshot) in
                print("FETCHING UPDATED DB ---------->>>>>>>>>>>>",dmsnpshot)
                LoaderView.kill()
                guard (dmsnpshot.value as? NSDictionary) != nil else {return}
                let dict = (dmsnpshot.value as! NSDictionary)
                LoggedInUser.shared.updateLoggedInUser(dict: dict)
                self.refreshDocument()
            })
        }
        
    }
    
    
    
    
    // MARK: - ▼▼▼ CREATE FIRESTORE CLOUD STORAGE ▼▼▼
    private func addDocument() {
        // [START add_document]
        // Add a new document with a generated id.
        fireCloudStoreDBRef.collection(kUsers).document(LoggedInUser.shared.emailId).setData(self.getDataDict){ err in
            if let err = err {
                print("Error adding document: \(err)")
            } else {
                self.refreshDocument()
                print("Document added with ID: \(LoggedInUser.shared.emailId)")
            }
        }
        // [END add_document]
    }
    
    
    
    
    // MARK: - ▼▼▼ CHECK FIRESTORE CLOUD STORAGE ▼▼▼
    /*
     check if database collection exists:
     1. If not, then create database by calling addDocument()
     2. Add data to existing database. 
     */
    private func refreshDocument() {
        
        fireCloudStoreDBRef.collection(kUsers).document(LoggedInUser.shared.emailId).getDocument { [weak self] (document, error) in
            guard let weakSelf = self else {return}
            guard  error == nil else {
                print("Document Error !!!!!")
                return
            }
            if let document = document {
                if document.exists {
                    self?.fireCloudStoreDBRef.collection(kUsers).document(LoggedInUser.shared.emailId).setData((weakSelf.getDataDict))
                }else {
                    self?.addDocument()
                    
                }
            }
            
        }

    }
    
    
    
    // MARK: - ▼▼▼ DATABASE STORAGE USER-DETAILS ▼▼▼
    var getDataDict: [String: Any] {
        
        let data: [String: Any] = ["BreakFast":  LoggedInUser.shared.userFitnessRegime?.breakFast ?? "",
                                   "Morning Snack":  LoggedInUser.shared.userFitnessRegime?.morningsnack ?? "",
                                   "Lunch":  LoggedInUser.shared.userFitnessRegime?.lunch ?? "",
                                   "Evening Snack":  LoggedInUser.shared.userFitnessRegime?.eveningSnack ?? "",
                                   "Dinner":  LoggedInUser.shared.userFitnessRegime?.dinner ?? "",
                                   "Water":  LoggedInUser.shared.userFitnessRegime?.water ?? "",
                                   "Goals":  LoggedInUser.shared.userFitnessRegime?.goals ?? "",
                                   "Steps":  LoggedInUser.shared.userFitnessRegime?.steps ?? ""]
        return data
    }
    
    
    
    
    
    /// Method is used to setup 3rd Party App resources
    private func setupAppResources() {
        ImageCache.default.maxCachePeriodInSecond = 60 * 60 * 24 * 7
        IQKeyboardManager.shared.enable = true
        IQKeyboardManager.shared.enableAutoToolbar = true
        IQKeyboardManager.shared.shouldResignOnTouchOutside = true
        LanguageManager.setupCurrentLanguage()

    }
    
    private func setupUserNavigation() {
        navigationController.setViewControllers([setupRootVC()], animated: true)
    }
    
    private func setupRootVC() -> UIViewController {
        
        let isUserLoggedIn = UserDefaults.standard.bool(forKey: UserLoggedIn)
        if isUserLoggedIn { LoggedInUser.shared.retrieveDetails()  }
        return isUserLoggedIn ? Storyboard.dashboard.instantaite(TabBarVC.self) : checkLanguageAlreadyChanged()
    }
    
    private func checkLanguageAlreadyChanged() -> UIViewController {
        
        return LanguageManager.currentLanguageCode() != nil ? Storyboard.onboarding.instantaite(LoginVC.self) : Storyboard.onboarding.instantaite(ChangeLanguageVC.self)
    }
    
    
}
