//
//  SelectTypeView.swift
//
//  Copyright © 2020 shelly choudhary. All rights reserved.
//

import UIKit

enum SelectType {
    case countryCode
//    case city
    case cancelReason
}


class ListView: UIView {
    
    //MARK: Properties
    @IBOutlet weak var tblCodeList: UITableView!
    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var txtFieldSearchCountryCode: TextField!
    @IBOutlet weak var lblTitle: UILabel!
    
    var list: [ListDetail]!
    var callBack: ((ListDetail) -> ())!
    var lastSelection: ListDetail?
    var selectType: SelectType = .countryCode
    
    
    static func initialize(lastSelected: ListDetail?, type: SelectType, callback: @escaping ((ListDetail) -> ())) {
        
        let nib = UINib(nibName: "ListView", bundle: Bundle.main)
        let codeView = nib.instantiate(withOwner: self, options: nil)[0] as! ListView
        codeView.frame = UIScreen.main.bounds
        codeView.lastSelection = lastSelected
        codeView.tblCodeList.register(UINib(nibName: "ListCell", bundle: nil), forCellReuseIdentifier: "ListCell")
        codeView.tblCodeList.estimatedRowHeight = 100
        codeView.callBack = callback
        codeView.selectType = type
        UIApplication.currentViewController()?.view.addSubview(codeView)
        codeView.setDataOnList()
    }
    
    //MARK:- set Data On View
    func setDataOnList() {
        
        txtFieldSearchCountryCode.isHidden = false
        txtFieldSearchCountryCode.constraints.filter({$0.firstAttribute == .height}).first?.constant = 40.0
        list = self.readCountryCodeJson()
        changeColor()
        containerView.transformView()
        reloadTable()
    }
    

    
    //MARK: action methods of textfied
    @IBAction func edtingChange(_ sender: Any) {
        list.removeAll()
        list = readCountryCodeJson()
        changeColor()
        
        guard txtFieldSearchCountryCode.text! != "" else {
            tblCodeList.reloadData()
            return
        }
        list = list.filter({$0.name.lowercased().contains(txtFieldSearchCountryCode.text!.lowercased())})
        if list.count > 0 {
            self.tblCodeList.removeBackgroundText()
        }else {
            self.tblCodeList.displayBackgroundText(text: "No Data")
        }
        tblCodeList.reloadData()
    }
    
    
    //MARK:- read ContryCode JSON
    func readCountryCodeJson() -> [ListDetail] {
        
        let countries = Util.getJsonData("countryCodes")
        return countries.map({ ListDetail(name: $0["name"]!, code: $0["dial_code"], id: nil, isoCode: $0["code"]) })

    }
  
    
    //MARK:- reload tableView
    func reloadTable() {
        DispatchQueue.main.async {
            self.tblCodeList.reloadData()
        }
    }
    
    @IBAction func btnCancel(_ sender: Any) {
        self.removeView()
    }
    
    // ChangeTintColor
    func changeColor () {
        for (index, item) in list.enumerated() {
            if item.name == lastSelection?.name && item.code == lastSelection?.code {
                list[index].isSelected = true
                
            }
        }
    }
    
    func removeView() {
        UIView.animate(withDuration: 0.5, animations: {
            self.alpha = 0
        }) { (finish) in
            self.removeFromSuperview()
        }
    }
}

// MARK: TABLEVIEW DATASOURCE AND DELEGATE
extension ListView: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return (list ?? []).count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ListCell", for: indexPath)as! ListCell
        cell.selectionStyle = .none
        
        cell.setUpData(selectTypeList: list[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        _ = list.map({ $0.isSelected == false })
        list[indexPath.row].isSelected  = true
        
        if let completion = self.callBack {
            completion(list[indexPath.row])
        }
        self.removeView()
    }
    
    
}

extension UITableView {
    
    func displayBackgroundText(text: String, fontStyle: String = "HelveticaNeue", fontSize: CGFloat = 16.0) {
        let lbl = UILabel();
        
        if let headerView = self.tableHeaderView {
            lbl.frame = CGRect(x: 0, y: headerView.bounds.size.height, width: self.bounds.size.width, height: self.bounds.size.height - headerView.bounds.size.height)
        } else {
            lbl.frame = CGRect(x: 10, y: 0, width: self.bounds.size.width - 20, height: self.bounds.size.height);
        }
        lbl.text = text;
        lbl.textColor = UIColor.black;
        lbl.numberOfLines = 0;
        lbl.textAlignment = .center;
        lbl.font = UIFont(name: fontStyle, size:fontSize);
        let backgroundView = UIView(frame: CGRect(x: 0, y: 0, width: self.bounds.size.width, height: self.bounds.size.height));
        backgroundView.addSubview(lbl);
        self.backgroundView = backgroundView;
    }
    
    func removeBackgroundText() {
        self.backgroundView = nil
    }
    
}



