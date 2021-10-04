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
    var purchaseOrdersList = [PurchaseOrder]()
    var loadingIndicator = GeneralUtils.getLoadingIndicator()
    var databaseController:DatabaseController?
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        configureUI()
        attachDelegates()
        initDatabase()
        //callApi()
    }
    
 
    //MARK: Attaching Delegates
    func attachDelegates(){
        netUtils.responseDelegate = self
        pruchaseTableView.delegate = self
        pruchaseTableView.dataSource = self
        
    }
    
    //MARK: Initialize Database
    func initDatabase(){
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        databaseController = appDelegate.databaseController
        present(loadingIndicator, animated: true, completion: nil)
        databaseController?.databaseDelegate = self
        databaseController?.initializeRepository()
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
        detailsViewController.databaseUpdateDelegate = self
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
        
        addPurchaseViewController.onDatabaseUpdated = self
        
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
        return purchaseOrdersList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let purchaseCell = tableView.dequeueReusableCell(withIdentifier: "purchaseCell", for: indexPath) as! HomeTableViewCell
        
        purchaseCell.itemsCountLabel.text = "Items: \(purchaseOrdersList[indexPath.row].numberofitems)"
        purchaseCell.lastUpdatedLabel.text = "last Updated:\n \(purchaseOrdersList[indexPath.row].lastupdated!)"
        purchaseCell.poIdLabel.text = "Purchase Order ID: \(purchaseOrdersList[indexPath.row].id)"
        
        return purchaseCell;
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        segueToDetailsView(purchaseOrder: purchaseOrdersList[indexPath.row])
    }
}


//MARK: Fetching response
extension HomeViewController:ApiResponseDelegate{
    func onApiResponseDelegate(purchases: [Purchase]) {

    }
}

//MARK: Fetching data stored in database
extension HomeViewController:DatabaseResponseDelegate{
    func onDatabaseResponseDelegate(isCompleted: Bool, purchaseOrders: [PurchaseOrder]) {
        purchaseOrdersList.removeAll()
        purchaseOrdersList.append(contentsOf: purchaseOrders)
        if isCompleted {
            DispatchQueue.main.async {
                self.pruchaseTableView.reloadData()
                self.loadingIndicator.dismiss(animated: true, completion: nil)
            }
        }
    }
}


//MARK: getting a response from the database controller
extension HomeViewController:DatabaseUpdatedDelegate{
    func onDatabaseUpdated() {
        purchaseOrdersList.removeAll()
        purchaseOrdersList.append(contentsOf: (databaseController?.fetchAllPruchases())!)
            DispatchQueue.main.async {
                self.pruchaseTableView.reloadData()
                self.loadingIndicator.dismiss(animated: true, completion: nil)
            }
    }
}






