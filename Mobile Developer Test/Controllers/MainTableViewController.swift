//
//  MainTableViewController.swift
//  Mobile Developer Test
//
//  Created by kjoe on 12/28/20.
//

import UIKit

class MainTableViewController: UITableViewController {
    
    let utility = NetworkReachability()
    var vm: MainViewModel!
    let refresh = UIRefreshControl()
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.refreshControl = refresh
        vm = MainViewModel(service: RemoteLoaderWithLocalFeedBack(remote: RemoteListService(loader: CustomNetWorkLoader(session: URLSession.shared), resquetable: Resquetable()), local: LocalListLoader(), monitor: utility))
        vm.success = { [weak self] in
            DispatchQueue.main.async {
                guard let self = self else {return}
                self.tableView.refreshControl?.endRefreshing()
                self.tableView.reloadData()
            }
        }
        print("send to load with refresh")
        self.refresh.addTarget(self, action: #selector(self.loadData), for: UIControl.Event.valueChanged)
        print("sended")
        self.loadData()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.navigationBar.isHidden = true
    }

    override func viewWillDisappear(_ animated: Bool) {
        self.navigationController?.navigationBar.isHidden = false
    }
    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return vm.list.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text =  vm.titleForCell(index: indexPath.row)
        cell.detailTextLabel?.text = vm.autorAndDate(index: indexPath.row)
        return cell
    }
    
    
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            vm.list.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if vm.list[indexPath.row].storyUrl != nil {
            self.performSegue(withIdentifier: "web", sender: indexPath.row)
        }else{
            showAlert()
        }
    }
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let vc = segue.destination as! WebViewController
        vc.url = vm.list[sender as! Int].storyUrl ?? ""
    }


    @objc func loadData(){
        print("load data")
        self.tableView.refreshControl?.beginRefreshing()
        vm.loadData()
    }
    func showAlert(){
        let alert = UIAlertController(title: "Ups!", message: "no valid url found", preferredStyle: .alert)
        let action = UIAlertAction(title: "Ok", style: .cancel, handler: nil)
        alert.addAction(action)
        self.present(alert, animated: true, completion: nil)
    }
}
