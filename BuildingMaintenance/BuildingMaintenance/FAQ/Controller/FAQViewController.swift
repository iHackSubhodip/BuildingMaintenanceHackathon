//
//  FAQViewController.swift
//  BuildingMaintenance
//
//  Created by Banerjee, Subhodip on 26/07/18.
//  Copyright © 2018 Subhodip. All rights reserved.
//

protocol ChatDelegate: class{
    func initialiseChatViewController(problemLabel: String)
}

import UIKit

class FAQViewController: UIViewController {

    let url = "http://www.mocky.io/v2/5b5c0eba3200006f00426270"
    // https://us-central1-soudhasahaya.cloudfunctions.net/verify
    // The above URl is supported by Google API/ Firebbase/ Kafka.
    var dataSet : [Items] = []
    var deviceName = ""
    var model = ""
    
    @IBOutlet weak var tableView: UITableView!{
        didSet {
            tableView.delegate = self
            tableView.dataSource = self
        }
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.isHidden = true
        tableViewSetup()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        parseJSON()
    }
    
    private func parseJSON() {
        dataSet = []
        guard let url = URL(string: url) else { return }
        let session = URLSession.shared.dataTask(with: url) { (data, response, error) in
            guard let data = data else { return }
            guard let result = try? JSONDecoder().decode(Datas.self, from: data) else {
                return
            }
            self.deviceName = result.devicename
            self.model = result.model
            for datas in result.data{
                self.dataSet.append(datas)
            }
            DispatchQueue.main.async {
                self.tableView.isHidden = false
                self.tableView.reloadData()
            }
        }
        session.resume()
    }
    

    private func tableViewSetup() {
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.estimatedRowHeight = 140
        tableView.isUserInteractionEnabled = true
        tableView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        tableView.scrollIndicatorInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        tableView.separatorStyle = .none
        tableView.allowsSelection = false
        tableView.reloadData()
    }
    

}


extension FAQViewController : UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let countVal = dataSet.count
        return countVal
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "Cell") as? FAQTableViewCell else { return UITableViewCell() }
        cell.model = dataSet[indexPath.row]
        cell.delegate = self
        cell.backgroundColor = UIColor(displayP3Red: 235.0/255.0, green: 241.0/255.0, blue: 247.0/255.0, alpha: 1.0)
        return cell
    }
}


extension FAQViewController : UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
    
}

extension FAQViewController: ChatDelegate{
    
    func initialiseChatViewController(problemLabel: String) {
        guard let chatVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "DecisionMakingViewController") as? DecisionMakingViewController else { return }
        chatVC.deviceName = deviceName
        chatVC.model = model
        chatVC.problemStatement = problemLabel
        navigationController?.pushViewController(chatVC, animated: true)
    }

}
