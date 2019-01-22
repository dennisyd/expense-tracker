//
//  ReceiptStore.swift
//  ExpenseTracker
//
//  Created by Peter Alt on 4/4/18.
//  Copyright © 2018 Peter Alt. All rights reserved.
//

import Foundation

class Store {
    
    private(set) var receipts = [Receipt]()
    private(set) var shops = [Shop]()
    
    private let sourceURL = URL(string: "https://raw.githubusercontent.com/peteralt/expenseTracker/master/ExpenseTracker/server_data/groceries.json")!
    
    init() {
    }
    
    func update(completion: @escaping ( Error? ) -> Void) {
        self.download(completion: { path, error in
            if (error == nil && path != nil) {
                let data = try? Data(contentsOf: URL(fileURLWithPath: path!), options: .mappedIfSafe)
                self.process(data: data!)
                completion(nil)
            }
            completion(error)
        })
    }
    
    internal func download(completion: @escaping (String?, Error?) -> Void) {
        let documentsUrl =  FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
        let destinationUrl = documentsUrl.appendingPathComponent(sourceURL.lastPathComponent)
        
        let session = URLSession(configuration: URLSessionConfiguration.default, delegate: nil, delegateQueue: nil)
        var request = URLRequest(url: sourceURL)
        request.httpMethod = "GET"
        let task = session.dataTask(with: request, completionHandler:
        {
            data, response, error in
            if error == nil
            {
                if let response = response as? HTTPURLResponse
                {
                    if response.statusCode == 200
                    {
                        if let data = data
                        {
                            if let _ = try? data.write(to: destinationUrl, options: Data.WritingOptions.atomic)
                            {
                                completion(destinationUrl.path, error)
                            }
                            else
                            {
                                completion(destinationUrl.path, error)
                            }
                        }
                        else
                        {
                            completion(destinationUrl.path, error)
                        }
                    }
                }
            }
            else
            {
                completion(destinationUrl.path, error)
            }
        })
        task.resume()
    }
    
    internal func process(data: Data) {
        do {
            receipts = try JSONDecoder().decode([Receipt].self, from: data)
            
            for receipt in receipts {
                if let shopIndex = shops.index(where: { $0.name == receipt.shop }) {
                    shops[shopIndex].addReceipt(receipt: receipt)
                } else {
                    let shop = Shop(name: receipt.shop, receipt: receipt)
                    shops.append(shop)
                }
            }
        } catch {
            print("caught: \(error)")
        }
    }
}
