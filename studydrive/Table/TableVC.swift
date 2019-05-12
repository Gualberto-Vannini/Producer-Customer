//
//  ViewController.swift
//  studydrive
//
//  Created by Gualberto on 11/05/2019.
//  Copyright © 2019 Gualberto. All rights reserved.
//

import UIKit

//MARK: struct for the info's table cell
struct cellData {
    let newProduct : String?
}

class TableVC: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    //MARK: Outlet and Var
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var addingProducer: UIButton!
    @IBOutlet weak var addingCustomer: UIButton!
    @IBOutlet weak var numbConsumer: UILabel!
    @IBOutlet weak var numbProducer: UILabel!
    var globalCounterProducerClick = 0
    var globalCounterCustomerClick = 0
    var newProductList = [String]()
    var data = [cellData]()
    
    //MARK: Action to add a new producer
    @IBAction func addProdAction(_ sender: Any) {
       
        //Create a counter of Producer
        globalCounterProducerClick += 1
        numbProducer.text = "\(globalCounterProducerClick)"
        
        //Adding row without timing, just on first click
        addingProduct(numberProducer: globalCounterProducerClick)  //Passing as parameter the counter or Producer
       
        //Adding a timer to relunch func newProd
        _ = Timer.scheduledTimer(timeInterval: 3.0,
                                 target: self,
                                 selector:#selector(self.newProd),
                                 userInfo:  globalCounterProducerClick,
                                 repeats: true)
    }
    @objc func newProd(timer:Timer) {
        //Adding row with timing each 3 sec
        addingProduct(numberProducer: timer.userInfo as! Int) //Passing as parameter the counter or Producer
    }
    //Main func to add new products
    func addingProduct(numberProducer:Int){
        let userInfo = numberProducer
        //Adding new producer
        let addingNewProduct = "Product of Producer n.\(userInfo)"
        let insertData = cellData.init(newProduct: addingNewProduct)
        data.insert(insertData, at: 0)
        let indexPath = IndexPath(row: 0, section: 0)
        self.tableView.beginUpdates()
        self.tableView.insertRows(at: [indexPath], with: .automatic)
        self.tableView.endUpdates()
        self.tableView.reloadData()
    }
    
    
    //MARK: Action to add a new customer
    @IBAction func addCustAction(_ sender: Any) {
        let countingRows = tableView.numberOfRows(inSection: 0) //How many rows are shown?
        
        //3 possibiles cases:
        
        if globalCounterProducerClick > 0 && countingRows > 0 // *** 1° case: exists at least 1 Producer and 1 Product shown on table
        {
            //Create a counter of Customers
            globalCounterCustomerClick += 1
            numbConsumer.text = "\(globalCounterCustomerClick)"
            
            //Adding row without timing, just on first click
            addingCustomers()

            //Adding a timer to relunch func newCust
            _ = Timer.scheduledTimer(timeInterval: 4.0,
                                     target: self,
                                     selector:#selector(self.newCust),
                                     userInfo:  nil,
                                     repeats: true)
        } else if globalCounterProducerClick == 0  {  // *** 2° case: add a customer before than add at least 1 Producer
            //UIAlert to advise
            //Into AppDelegate I created little extension for UIAlert
            //to avoid to write all code for UIAlert 2 times
            self.displayAlert(title: "We don't have product to sell",
                              message: "Add new Producers to offer to your Customers new produtcs!")
            
        }  else if globalCounterProducerClick > 0 && countingRows == 0 {// *** 3°case: add a new customer when there are no products for him
            //Into AppDelegate I created little extension for UIAlert
            //to avoid to write all code for UIAlert 2 times
            self.displayAlert(title: "We need more Producer",
                              message: "There aren't products to add a new customer. Wait a second or add a new Producer to get more products faster.")
        }
    }

    @objc func newCust() {
        if data.count > 1 {
            addingCustomers()
        }
    }
    
    //Main func to add new products
    func addingCustomers(){
        //Adding new customer
        data.remove(at: 0)
        let indexPath = IndexPath(row: 0, section: 0)
        tableView.beginUpdates()
        tableView.deleteRows(at: [indexPath], with: .automatic)
        tableView.endUpdates()
        tableView.reloadData()
    }
    
    
    //MARK: viewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Style buttons
        addingCustomer.layer.cornerRadius = 20.0
        addingProducer.layer.cornerRadius = 20.0
        
        //Assign element to the struct data
        for i in newProductList{
            let insertData = cellData.init(newProduct: i)
            data.append(insertData)
        }
        
        //Assign custom reuse identifier and associate to CustomCellClass
        tableView.register(CustomCell.self, forCellReuseIdentifier: "custom")
        
        //Avoid empty cells into table View
        tableView.tableFooterView = UIView()
        tableView.reloadData()
    }
    
    //MARK: Table Data and rendering
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = self.tableView.dequeueReusableCell(withIdentifier: "custom") as! CustomCell
        cell.newProduct = data[indexPath.row].newProduct
        
        //mantain layout of subview during scrolling
        cell.layoutSubviews()
        
        return cell
    }
}
