//
//  HomeViewController.swift
//  Sample

import UIKit

class HomeViewController: UIViewController, UITableViewDelegate, UITableViewDataSource{
    
    @IBOutlet weak var tableView:UITableView!
    @IBOutlet weak var indicatorView: UIView!
    
    private var result: [Results]? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.tableFooterView = nil
        loadApiData()
    }

    //MARK:- Method
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return result?.count ?? 0
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: TableViewCell.self), for: indexPath) as! TableViewCell
        cell.result = result?[indexPath.row]
        cell.loadData()
        return cell
    }
    //MARK:- Method
    /*
     Declaration   loadApiData()
     
     Description   This method used to get Sleep Values by Date
          
     Declared In   MDActiveEnergy.swift
     */
    private func loadApiData(){
        let session = URLSession(configuration: .default)
        guard let url = URL(string: .url) else{
            return
        }
        var request = URLRequest(url: url, cachePolicy: .reloadIgnoringCacheData, timeoutInterval: 60)
        request.httpMethod = .get
        session.dataTask(with: request) { (data, response, error) in
            DispatchQueue.main.async {
                self.indicatorView.isHidden = true
                guard let dataResult = data, let result = try? JSONDecoder().decode([Results].self, from: dataResult) else{
                    return
                }
                self.result = result
                self.tableView.reloadData()
            }
        }.resume()
    }
}

