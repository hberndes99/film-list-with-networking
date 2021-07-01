//
//  WatchListViewController.swift
//  networking-with-film-api
//
//  Created by Harriette Berndes on 01/07/2021.
//

import UIKit

class WatchListViewController: UIViewController {
    
    var watchList: [Film]
    private var watchListTableView: UITableView!
    
    init(watchList: [Film]) {
        self.watchList = watchList
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        print(watchList)
        view.backgroundColor = .red
        
        watchListTableView = UITableView(frame: self.view.bounds, style: UITableView.Style.plain)
        watchListTableView.translatesAutoresizingMaskIntoConstraints = false
        watchListTableView.register(FilmListTableViewCell.self, forCellReuseIdentifier: "filmCell")
        watchListTableView.dataSource = self
        watchListTableView.delegate = self
        
        view.addSubview(watchListTableView)
        // addConstraints()
        
    }
    

    func addConstraints() {
        NSLayoutConstraint.activate([
            watchListTableView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            watchListTableView.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])
    }
}


extension WatchListViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let height: CGFloat = 90
        return height
    }
}


extension WatchListViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return watchList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = watchListTableView.dequeueReusableCell(withIdentifier: "filmCell", for: indexPath) as! FilmListTableViewCell
        let film = watchList[indexPath.row]
        cell.selectionStyle = .none
        cell.configureCell(for: film)
        return cell
    }
}
