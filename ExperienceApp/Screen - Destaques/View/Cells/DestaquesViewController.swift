//
//  DestaquesViewController.swift
//  ExperienceApp
//
//  Created by Juliana Vigato Pavan on 15/05/20.
//  Copyright © 2020 Zewu Chen. All rights reserved.
//

import UIKit

class DestaquesViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    // MARK: Outlets
    @IBOutlet weak var lblDestaque: UILabel!
    @IBOutlet weak var imgDestaque: UIImageView!
    @IBOutlet weak var infoDestaque: UILabel!
    @IBOutlet weak var tableView: UITableView!
    
    @IBOutlet weak var bottomTableView: NSLayoutConstraint!
    @IBOutlet weak var tableViewHeight: NSLayoutConstraint!
    // MARK: Variáveis
    let destaquesCell = "DestaquesTableViewCell"
    private var data: [DestaquesModel] = []
    private let controller = DestaquesController()
    var tururu = ["oi", "tudo", "bem"]
       
     // MARK: ViewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpTable()
        setNavigation()
        controller.delegate = self
      
    }
    
    func setNavigation() {
        // MARK: Título
//        self.navigationItem.title = "Teste"
        // MARK: Cor da Navigation
        navigationController?.setNavigationBarHidden(true, animated: false)
//        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
//        self.navigationController?.navigationBar.shadowImage = UIImage()
//        self.navigationController?.navigationBar.isTranslucent = true
//        self.navigationController?.view.backgroundColor = .clear
    }
    
    func setUpTable() {
        tableView.dataSource = self
        tableView.delegate   = self
        tableView.register(UINib(nibName: destaquesCell, bundle: nil), forCellReuseIdentifier: destaquesCell)
        tableView.separatorStyle = .none
    }
        func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            //  data.count
            return 3
        
        }

        func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            let celulaTable = self.tableView.dequeueReusableCell(withIdentifier: destaquesCell, for: indexPath) as? DestaquesTableViewCell
          //      celulaTable?.setUp(model: data[indexPath.row])
            //tableView.frame.size = //tableView.contentSize + valor
          
           //    self.tableViewHeight?.constant = self.tableView.contentSize.height
                        return celulaTable ?? UITableViewCell()
        }
    
    @IBAction func sairBtn(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
}
//func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
//
//    if scrollView == self.tableView {
//
//        let currentOffset: Float = Float(scrollView.contentOffset.y)
//
//        if currentOffset < 25 {
//            //refresh content
//        }
//
//        let offsetY       = tableView.contentOffset.y
//        let contentHeight = tableView.contentSize.height
//
//        if offsetY > contentHeight - scrollView.frame.size.height + 25 {
//            // load more
//        }
//
//    }

//}

extension DestaquesViewController: DestaquesControllerDelegate {
    func reloadData(data: [DestaquesModel]) {
        self.data = data
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
}
