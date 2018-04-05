//
//  ShopViewController.swift
//  ExpenseTracker
//
//  Created by Peter Alt on 4/5/18.
//  Copyright © 2018 Peter Alt. All rights reserved.
//

import UIKit

class ShopViewController: UIViewController {

    @IBOutlet weak var navigationTitle: UINavigationItem!
    @IBOutlet weak var itemTableView: UITableView!
    @IBOutlet weak var totalLabel: UILabel!
    
    weak var shop: Shop!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        totalLabel.text = "Total: \(shop.totalFormatted)"
        navigationTitle.title = shop.name
        super.viewWillAppear(animated)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func dismissViewController(_ sender: Any) {
        self.dismiss(animated: true, completion: {})
    }

}

extension ShopViewController : UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.shop.items.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "itemCell", for: indexPath) as! ItemTableViewCell
        cell.format(item: self.shop.items[indexPath.row])
        return cell
    }
    
}
