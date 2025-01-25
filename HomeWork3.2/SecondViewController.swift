//
//  SecondViewController.swift
//  HomeWork3.2
//
//  Created by Масуд Гаджиев on 19.01.2025.
//

import UIKit

class SecondViewController: UIViewController {
    
    private let networkManager2 = NetworkManagerImg()
    var imageURL: [String] = []
    
    lazy var textField = {
        $0.placeholder = "Введите запрос"
        $0.textAlignment = .left
        $0.borderStyle = .roundedRect
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.textColor = .systemGray
        return $0
    }(UITextField())
    
    lazy var sendButton = {
        $0.setTitle( "Сгенерировать", for: .normal)
        $0.setTitleColor(.systemRed, for: .normal)
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.backgroundColor = .white
        $0.layer.cornerRadius = 15
        $0.clipsToBounds = true
        return $0
    }(UIButton(primaryAction: sendRequest2))
    
    lazy var imageView = {
        $0.contentMode = .scaleAspectFit
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.clipsToBounds = true
        $0.layer.cornerRadius = 10
        return $0
    }(UIImageView())
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .red
        view.addSubview(textField)
        view.addSubview(sendButton)
        view.addSubview(imageView)
        setupConstraints()
        
    }
    
    lazy var sendRequest2 = UIAction { _ in
        self.sendReq2()
    }
    
    func sendReq2() {
            networkManager2.sendSecondRequest(prompt: textField.text ?? "") { [weak self] images in
                guard let self = self else { return }
                DispatchQueue.main.async {
                    if let url = images.first?.url {
                        self.imageURL.append(url)
                        if let imageUrl = URL(string: url) {
                            URLSession.shared.dataTask(with: imageUrl) { data, _, error in
                                if let data = data, error == nil {
                                    DispatchQueue.main.async {
                                        self.imageView.image = UIImage(data: data)
                                    }
                                } else {
                                    print("Ошибка загрузки изображения: \(error?.localizedDescription ?? "неизвестная ошибка")")
                                }
                            }.resume()
                        }
                    }
                    self.textField.text = ""
                }
            }
        }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            textField.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 50),
            textField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            textField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            
            sendButton.topAnchor.constraint(equalTo: textField.bottomAnchor, constant: 10),
            sendButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            sendButton.trailingAnchor.constraint(equalTo: view.leadingAnchor, constant: -20),
            sendButton.heightAnchor.constraint(equalToConstant: 40),
            sendButton.widthAnchor.constraint(equalToConstant: view.frame.width - 40),
            
            imageView.topAnchor.constraint(equalTo: sendButton.bottomAnchor, constant: 10),
            imageView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            imageView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            imageView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -20),
        ])
    }
    
    
}
