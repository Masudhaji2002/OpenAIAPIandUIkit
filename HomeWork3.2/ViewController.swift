//
//  ViewController.swift
//  HomeWork3.2
//
//  Created by Масуд Гаджиев on 18.01.2025.
//

import UIKit

class ViewController: UIViewController {
    
    
    private let networkManager = NetworkManage()
    private var mockData: [String] = []
    
    
    lazy var textField = {
        $0.placeholder = "Введите запрос"
        $0.textAlignment = .left
        $0.borderStyle = .roundedRect
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.textColor = .systemGray
        return $0
    }(UITextField())
    
    lazy var sendButton = {
        $0.setTitle( "Отправить", for: .normal)
        $0.setTitleColor(.white, for: .normal)
        $0.translatesAutoresizingMaskIntoConstraints = false
        return $0
    }(UIButton(primaryAction: sendRequest1))
    
    lazy var showResponce: UITableView = {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.dataSource = self
        $0.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        return $0
    }(UITableView(frame: .zero, style: .insetGrouped))
    
    lazy var sendRequest1 = UIAction { _ in
        self.sendReq1()
    }
    
    
    func sendReq1() {
        networkManager.sendRequest(message: textField.text ?? "") { choses in
            DispatchQueue.main.async {
                self.mockData.append(self.textField.text ?? "")
                self.mockData.append(choses[0].message.content)
                self.showResponce.reloadData()
                self.textField.text = ""
                                //print(self.mockData)
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .red
        view.addSubview(textField)
        view.addSubview(sendButton)
        view.addSubview(showResponce)
        setupConstraints()
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            textField.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 50),
            textField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            textField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            
            sendButton.topAnchor.constraint(equalTo: textField.bottomAnchor, constant: 10),
            sendButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            showResponce.topAnchor.constraint(equalTo: sendButton.bottomAnchor, constant: 10),
            showResponce.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            showResponce.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            showResponce.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -20),
        ])
    }
    
    
}

extension ViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        mockData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        var config = cell.defaultContentConfiguration()
        config.text = mockData[indexPath.row]
        cell.contentConfiguration = config
        return cell
    }
    
    
}

