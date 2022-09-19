//
//  View.swift
//  CryptoAppWithVIPER
//
//  Created by Bedirhan Altun on 19.09.2022.
//

import Foundation
import UIKit

// Talks to --> presenter
//Class, protocol
//View Controller

protocol AnyView{
    var presenter: AnyPresenter? {get set}
    
    func update(with cryptos: [Crypto])
    func update(with error: String)
    
}

class CryptoViewController: UIViewController,AnyView,UITableViewDelegate,UITableViewDataSource{
    var presenter: AnyPresenter?
    var cryptosList: [Crypto] = []
    
    private let tableView : UITableView = {
        let table = UITableView()
        table.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        table.isHidden = true
        return table
        
    }()
    
    private let messageLabel: UILabel = {
        let label = UILabel()
        label.isHidden = false
        label.text = "Downloading ..."
        label.font = UIFont.systemFont(ofSize: 20)
        label.textColor = .black
        label.textAlignment = .center
        return label
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .yellow
        view.addSubview(tableView)
        view.addSubview(messageLabel)
        
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        //TableView bütün ekranı kaplıyor bounds ile.
        tableView.frame = view.bounds
        // 2 - 100 veya 2 - 25 width ve heighlerın yarısını alıp x ve y den çıkardık.
        messageLabel.frame = CGRect(x: view.frame.width / 2 - 100, y: view.frame.height / 2 - 25, width: 200, height: 50 )
    }
    
    
    func update(with cryptos: [Crypto]) {
        DispatchQueue.main.async {
            self.cryptosList = cryptos
            self.messageLabel.isHidden = true
            self.tableView.reloadData()
            self.tableView.isHidden = false
        }
    }
    
    func update(with error: String) {
        
        DispatchQueue.main.async {
            self.cryptosList = []
            self.tableView.isHidden = true
            self.messageLabel.text = error
            self.messageLabel.isHidden = false
        }
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cryptosList.count
    }
    
    func getRandomColor() -> UIColor {
             //Generate between 0 to 1
             let red:CGFloat = CGFloat(drand48())
             let green:CGFloat = CGFloat(drand48())
             let blue:CGFloat = CGFloat(drand48())

             return UIColor(red:red, green: green, blue: blue, alpha: 1.0)
        }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        //defaultContentConfiguration üst tarafta veya alt tarafta ne gösterilsin konusunda yardımcı oluyor.
        var content = cell.defaultContentConfiguration()
        content.text = cryptosList[indexPath.row].currency
        content.secondaryText = cryptosList[indexPath.row].price
        cell.contentConfiguration = content
        cell.backgroundColor = getRandomColor()
        
        return cell
    }
    
    
    
}
