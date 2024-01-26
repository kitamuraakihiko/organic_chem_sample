//
//  SettingVC.swift
//  OrganicChemistry
//
//  Created by 北村昌彦 on 2021/12/11.
//

import UIKit
import StoreKit

class SettingVC: UIViewController {
    
    @IBOutlet weak var spinner: UIActivityIndicatorView! {
        didSet {
            spinner.hidesWhenStopped = true
        }
    }
    @IBOutlet weak var tableView: UITableView!
    private var pm = PurchaseManager()
    
    private let contentText = [
        (header: "リストア", description: "タップしてリストアできます。\n\nアプリを再インストールした場合に行います。購入をアップルに確認し、購入が確認できればコンテンツを開放します。"),
        (header: "サブスクリプション登録", description: "\nタップすると説明画面に移行します。\n"),
        (header: "開発者より", description: "このアプリは個人が開発しています。十分に注意していますが、ミスが含まれている可能性があります。ミスを発見した場合は、ご連絡ください。また、アプリを使ってくださる方の意見を沢山取り入れたいと考えております。要望はApple Storeのレビューかサポートへご連絡ください。"),
        (header: "免責事項", description: "このアプリから生じた全てのトラブルについて一切の責任を負いません。ご了承ください。"),
        (header: "今後追加予定の機能", description: """
         ・一問一答などのテスト
         ・構造式一覧
         
         その他要望があれば可能な限り実現します。
         """)
    ]
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        pm.delegate = self
        tableView.delegate = self
        tableView.dataSource = self
    }
}

extension SettingVC: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "SetingVCCell", for: indexPath)
        cell.backgroundColor = K.Color.accentBrighter

        var content = cell.defaultContentConfiguration()
        content.textProperties.color = .white
        content.text = contentText[indexPath.section].description
        cell.contentConfiguration = content
        
        return cell
    }
    
    
    func numberOfSections(in tableView: UITableView) -> Int {
        contentText.count
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
        content.text = contentText[section].header
        header.contentConfiguration = content
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        contentText[section].header
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        tableView.cellForRow(at: indexPath)?.isSelected = false
        
        switch indexPath.section {
            
        case 0:
            spinner.startAnimating()
            view.isUserInteractionEnabled = false
            self.tabBarController?.tabBar.isUserInteractionEnabled = false
            pm.isValid()
            
        case 1:
            performSegue(withIdentifier: K.Segue.SettingVCtoOfferVC, sender: nil)
            
        default:
            return
            
        }
    }
}

extension SettingVC: completeTransactionDelegate {
    func cancel() {
        dismiss(animated: true, completion: nil)
    }
    
    func completeTransaction() {
        spinner.stopAnimating()
        
        let popUp = PopUp(viewController: self, style: .check)
        popUp.start(completion: nil)
        
        self.view.isUserInteractionEnabled = true
        self.tabBarController?.tabBar.isUserInteractionEnabled = true
    }
}
