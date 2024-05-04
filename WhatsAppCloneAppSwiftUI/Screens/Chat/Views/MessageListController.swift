//
//  MessageListController.swift
//  WhatsAppCloneAppSwiftUI
//
//  Created by Alican TARIM on 4.05.2024.
//

import Foundation
import UIKit
import SwiftUI

final class MessageListController: UIViewController {
    
    // MARK: View's LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpViews()
    }
    
    // MARK: Properties
    private let cellIdentifier = "MessageListController"
    // Table View' i olusturdum.
    private lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.separatorStyle = .none
//        tableView.backgroundColor = .red
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()
    
    // MARK: Methods
    private func setUpViews() {
        view.addSubview(tableView)
        // Boyutlandirma
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])
        
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: cellIdentifier)
    }
}

// MARK: UITableViewDelegate & UITableViewDataSource
extension MessageListController: UITableViewDelegate, UITableViewDataSource {
    // Use a uikit tableView, use a swiftui view as the cell
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath)
        cell.backgroundColor = .clear
        cell.selectionStyle = .none
        cell.contentConfiguration = UIHostingConfiguration {
//            Text("PLACEHOLDER")
//                .font(.largeTitle)
//                .bold()
//                .frame(maxWidth: .infinity)
//                .frame(height: 200)
//                .background(Color.gray.opacity(0.1))
            BubbleTextView(item: .sentPlaceholder)
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 20
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
}

#Preview {
    MessageListView()
}
