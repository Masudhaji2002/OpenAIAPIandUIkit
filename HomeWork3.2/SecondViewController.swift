//
//  SecondViewController.swift
//  HomeWork3.2
//
//  Created by Масуд Гаджиев on 19.01.2025.
//

import UIKit
import SDWebImage

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
        super.viewDidLayoutSubviews()
        view.backgroundColor = .red
        view.addSubview(textField)
        view.addSubview(sendButton)
        view.addSubview(imageView)
        view.addSubview(activityIndicator)
        setupConstraints()
        
    }
    
    lazy var sendRequest2 = UIAction { _ in
        self.sendReq2()
    }
    
    lazy var activityIndicator: UIActivityIndicatorView = {
        let indicator = UIActivityIndicatorView(style: .large)
        indicator.translatesAutoresizingMaskIntoConstraints = false
        indicator.hidesWhenStopped = true
        return indicator
    }()
    
    
    func sendReq2() {
        
        networkManager2.sendSecondRequest(prompt: textField.text ?? "") { [weak self] imageUrl in
            DispatchQueue.main.async {
                self?.activityIndicator.stopAnimating()

                guard let urlString = imageUrl.first?.url, let imageUrl = URL(string: urlString) else {
                    print("Ошибка: URL изображения невалиден или пуст")
                    return
                }

                print("Загрузка изображения с URL: \(urlString)")
                self?.imageView.sd_setImage(with: imageUrl) { image, error, _, _ in
                    if let error = error {
                        print("Ошибка загрузки изображения: \(error.localizedDescription)")
                    } else {
                        print("Изображение успешно загружено")
                    }
                }
                self?.textField.text = ""
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
            sendButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            sendButton.heightAnchor.constraint(equalToConstant: 40),
            //sendButton.widthAnchor.constraint(equalToConstant: view.frame.width - 40),
            
            imageView.topAnchor.constraint(equalTo: sendButton.bottomAnchor, constant: 10),
            imageView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            imageView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            imageView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -20),
            
            activityIndicator.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            activityIndicator.centerYAnchor.constraint(equalTo: view.centerYAnchor),
        ])
    }
}
