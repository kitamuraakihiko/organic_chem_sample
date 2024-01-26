//
//  ListVC.swift
//  OrganicChemistry
//
//  Created by 北村昌彦 on 2021/12/11.
//

import UIKit
import StoreKit
import SwiftyStoreKit

class ListVC: UIViewController {
    
    @IBOutlet weak var quizListTableView: UITableView!
    private var sectionLimitForNormalUser = 2
    private var purchaseManager = PurchaseManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        quizListTableView.delegate = self
        quizListTableView.dataSource = self
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        // performSegue(withIdentifier: K.Segue.TabBarControllertoExplainVC, sender: nil)
    }
}

extension ListVC: UITableViewDelegate, UITableViewDataSource {
    
    
    // Section
    func numberOfSections(in tableView: UITableView) -> Int {
        QuizFiles.chapterNameList.count
    }
    
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        QuizFiles.chapterNameList[section]
    }
    
    
    //Header
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        30
    }
    
    
    func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
        guard let header = view  as? UITableViewHeaderFooterView else { return }
        var content = header.defaultContentConfiguration()
        content.textProperties.color = .white
        content.textProperties.font = UIFont.boldSystemFont(ofSize: 15)
        content.text = QuizFiles.chapterNameList[section]
        header.contentConfiguration = content
    }
    
    
    // Cell
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        QuizFiles.columnNameList[section].count
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = quizListTableView.dequeueReusableCell(withIdentifier: K.ListVC.cellId, for: indexPath)
        cell.backgroundColor = K.Color.accentBrighter
        
        var content = cell.defaultContentConfiguration()
        content.text = QuizFiles.columnNameList[indexPath.section][indexPath.row]
        content.textProperties.color = .white
        
//        // if not Perchased, display lock image
//        if !UserDefaults.standard.bool(forKey: "isPurchased") {
//            if sectionLimitForNormalUser <= indexPath.section {
//                content.image = UIImage(systemName: "lock")?.withTintColor(.white, renderingMode: .alwaysOriginal)
//            }
//        } else {
//            content.image = nil
//        }
        
        cell.contentConfiguration = content
        
        return cell
    }
    

    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        quizListTableView.cellForRow(at: indexPath)?.isSelected = false
        
        // if not Perchased, promote Perchase
#if DEBUG
        print("--select", UserDefaults.standard.bool(forKey: K.Purchase.isPurchased))
#endif
        if !UserDefaults.standard.bool(forKey: K.Purchase.isPurchased) {
            if sectionLimitForNormalUser <= indexPath.section {
                performSegue(withIdentifier: K.Segue.listVCtoOfferVC, sender: nil)
            }
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let cv = segue.destination as? ListViewVC {
            let indexPath = quizListTableView.indexPathForSelectedRow!
            cv.chapterName = QuizFiles.chapterNameList[indexPath.section]
            cv.columnName = QuizFiles.columnNameList[indexPath.section][indexPath.row]
        }
    }
    
    override func shouldPerformSegue(withIdentifier identifier: String, sender: Any?) -> Bool {
        // if not Perchased, cant go next vc
        switch identifier {
            
        case K.Segue.TabBarControllertoExplainVC:
            return true
        
        default:
            if quizListTableView.indexPathForSelectedRow!.section < sectionLimitForNormalUser {
                return true
            } else {
                return UserDefaults.standard.bool(forKey: K.Purchase.isPurchased)
            }
        }
    }
}
