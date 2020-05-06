//
//  CaloriesEatenViewController.swift
//  Healthify
//
//  Created by shelly choudhary on 18/04/20.
//  Copyright © 2020 shelly choudhary. All rights reserved.
//

import UIKit

class CaloriesEatenViewController: UIViewController {
    
    // MARK: - ▼▼▼ IBOUTLET Properties ▼▼▼
    @IBOutlet weak var tbleView: UITableView!
    
    // MARK: - ▼▼▼ Properties ▼▼▼
    var calEatenModal: [CaloriesEaten] = []
    var fireStoreDB: Firestore!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        prepareDataSource()

        // Do any additional setup after loading the view.
    }
    
    private var fireCloudStoreDBRef: Firestore {
        let settings = FirestoreSettings()
        Firestore.firestore().settings = settings
        // [END setup]
        fireStoreDB = Firestore.firestore()
        return fireStoreDB
    }
    
    private func prepareDataSource() {
        calEatenModal = CaloriesEaten.prepapreDataSource()
        tbleView.reloadData()
    }
    
    @objc func saveMealPlansToFirebase(sender: Timer){
        
        guard let indexPath = sender.userInfo as? IndexPath else {return}
        let uid = Auth.auth().currentUser?.uid
        guard let dbRef = appDelegate.dbRef?.child(kUsers).child(uid!).child(kFitnessRegime) else {
            return
        }
        guard let title = calEatenModal[indexPath.section].title , let name = calEatenModal[indexPath.section].name?[indexPath.row] else {
            return
        }
        dbRef.updateChildValues([title: name]) { [weak self] (err, dbRef) in
            guard err == nil else {return}
           // self?.createCloudFireStorage()
           // self?.addDocument()
            Util.showAlertWithMessage("MEAL_ADDED_ALERT".localizeString(), title: Key_Alert.lowercased()) {
                self?.navigationController?.popViewController(animated: true)
            }
            LoaderView.kill()
        }
        
    }
    
//    private func createCloudFireStorage() {
//
//        let documentRef = fireCloudStoreDBRef.collection(kUsers).document(kUserFitnessRegime)
//        let userPlanInfoRef = fireCloudStoreDBRef.document(kUsers+"/"+kUserFitnessRegime)
//
//        let fitnessRegRef = fireCloudStoreDBRef
//        .collection("user").document("regime")
//        .collection("messages").document("message1")
//
//    }
    
    
    private func addDocument() {
          // [START add_document]
          // Add a new document with a generated id.
          var ref: DocumentReference? = nil
          ref = fireCloudStoreDBRef.collection(kUsers).addDocument(data: [
            "emailId": LoggedInUser.shared.emailId,
            "country": LoggedInUser.shared.country
          ]) { err in
              if let err = err {
                  print("Error adding document: \(err)")
              } else {
                  print("Document added with ID: \(ref!.documentID)")
              }
          }
          // [END add_document]
      }
    
    // MARK:- Tap Gesture Action
    @objc func gestureAction(sender: UITapGestureRecognizer) {
        
        if let section = sender.view?.tag {
            
            guard calEatenModal[section].name!.count > 0 else { return }
            if calEatenModal[section].isExpanded {
                calEatenModal[section].isExpanded = false
            } else {
                calEatenModal[section].isExpanded = !calEatenModal[section].isExpanded
            }
            
            tbleView.beginUpdates()
            tbleView.reloadSections([section], with: .fade)
            tbleView.endUpdates()
            
            if calEatenModal[section].isExpanded {
                tbleView.scrollToRow(at: IndexPath(item: 0, section: (sender.view?.tag)!), at: .top, animated: true)
            }else {
                tbleView.contentOffset = .zero
            }
        }
    }
    
    // MARK: - ▼▼▼ IBOUTLET ACTION ▼▼▼
    @IBAction func btnBack_action(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    
}
// MARK: - ▼▼▼ EXTENSION UITABLEIVEWDELEGATE,UITABLEIVEWDATASOURCE ▼▼▼

extension CaloriesEatenViewController: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return calEatenModal.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return  calEatenModal[section].isExpanded ? (calEatenModal[section].name ?? []).count : 0
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 50
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
    
    // HeaderView In Section
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        
        let containerView = UIView(frame: CGRect(x: 0, y: 0, width: tableView.frame.width, height: 60))
        containerView.tag = section
        containerView.backgroundColor = .white
        
        // category name
        let title = UILabel(frame: CGRect(x: 15, y: containerView.frame.height / 2 - 15, width: containerView.frame.size.width - 30, height: 30))
        title.font = UIFont(name: "HelveticaNeue-Thin", size: 18.0)!
        title.textColor = .black
        title.textAlignment = .center
        title.text = calEatenModal[section].title
        
        // Up or Down Arraow
        let imageView = UIImageView(frame: CGRect(x: containerView.frame.size.width - 40, y: title.frame.origin.y + 7.5, width: 15, height: 15))
        imageView.tintColor = #colorLiteral(red: 0, green: 0.5812222362, blue: 0.9731387496, alpha: 1)
        imageView.image = calEatenModal[section].isExpanded ? UIImage(systemName: "minus.rectangle") : UIImage(systemName: "plus.rectangle")
        
        containerView.addSubview(title)
        containerView.addSubview(imageView)
        
        // tapGesture
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(gestureAction))
        containerView.addGestureRecognizer(tapGesture)
        
        return containerView
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueCell(cellType: CaloriesDetailTblCell.self)
        cell.selectionStyle = .none
        cell.lblMealName.text = calEatenModal[indexPath.section].name![indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        LoaderView.show()
        Timer.scheduledTimer(timeInterval: 1.5, target: self, selector: #selector(self.saveMealPlansToFirebase(sender:)), userInfo: indexPath, repeats: false)
        
    }
    
    
    
}
