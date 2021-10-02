//
//  ViewController.swift
//  ButterFly-App
//
//  Created by Techlocker on 2/10/21.
//

import UIKit

class HomeViewController: UIViewController {
    @IBOutlet weak var pruchaseTableView: UITableView!
    var netUtils = NetUtils()
    var purchaseOrders = [PurchaseOrder]()
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        configureUI()
        attachDelegates()
        callApi()
    }
    
    
    
    
    //MARK: Attaching Delegates
    func attachDelegates(){
        netUtils.responseDelegate = self
        pruchaseTableView.delegate = self
        pruchaseTableView.dataSource = self
        
    }
    
    //MARK: Configuring UI
    func configureUI(){
        navigationController?.navigationBar.prefersLargeTitles = true
    }
    
    
    //MARK: Moving to Details View Controller
    func segueToDetailsView(purchaseOrder:PurchaseOrder){
        
        let detailsViewStoryBoard = UIStoryboard(name: "DetailsViewStoryBoard", bundle: .main)
        let detailsViewController = detailsViewStoryBoard.instantiateViewController(withIdentifier: "detailsViewController") as! DetailsViewController
        detailsViewController.purchaseOrder = purchaseOrder
        self.navigationController?.pushViewController(detailsViewController, animated: true)
        
    }
    
    //MARK: On Add Purchase PRessed
    @IBAction func onAddPurchase(_ sender: Any) {
        segueToAddPurchaseViewController()
    }
    
    
    //MARK: Segue To AddPurchaseViewController
    func segueToAddPurchaseViewController(){
        let addPurchaseStoryBoard = UIStoryboard(name: "AddPurchaseStoryBoard", bundle: .main)
        let addPurchaseViewController = addPurchaseStoryBoard.instantiateViewController(withIdentifier: "addPurchaseViewController") as! AddPurchaseViewController
        
        present(addPurchaseViewController, animated: true, completion: nil)
    }
    
    
    //MARK: Calling API
    func callApi(){
        netUtils.fetchData()
    }
    
}


// MARK: Table View Delegate Methods
extension HomeViewController:UITableViewDelegate,UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return purchaseOrders.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let purchaseCell = tableView.dequeueReusableCell(withIdentifier: "purchaseCell", for: indexPath) as! HomeTableViewCell
        
        purchaseCell.itemsCountLabel.text = "Items: \(purchaseOrders[indexPath.row].items.count)"
        purchaseCell.lastUpdatedLabel.text = "last Updated:\n" + purchaseOrders[indexPath.row].last_updated
        purchaseCell.poIdLabel.text = "Purchase Order ID: \(purchaseOrders[indexPath.row].id)"
        
        return purchaseCell;
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        segueToDetailsView(purchaseOrder: purchaseOrders[indexPath.row])
    }
}


//MARK: Fetching response
extension HomeViewController:ResponseDelegate{
    func onResponseDelegate(purchases: [PurchaseOrder]) {
        purchaseOrders.removeAll()
        purchaseOrders.append(contentsOf: purchases)
        DispatchQueue.main.async {
            self.pruchaseTableView.reloadData()
        }
   
        print(purchases)
        
    }
}

