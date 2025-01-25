//
//  HomeViewController.swift
//  HomeWork3.2
//
//  Created by Масуд Гаджиев on 19.01.2025.
//


import UIKit

class HomeViewController: UIViewController {
    
    lazy var gptButton = {
        $0.setTitle( "Запрос GPT", for: .normal)
        $0.setTitleColor(.white, for: .normal)
        $0.backgroundColor = .systemRed
        $0.layer.cornerRadius = 20
        $0.clipsToBounds = true
        $0.translatesAutoresizingMaskIntoConstraints = false
        return $0
    }(UIButton(primaryAction: UIAction(handler: { [weak self] _ in
        guard let self else {return}
        let gptVC = ViewController()
        navigationController?.pushViewController(gptVC, animated: true)
    })))
    
    lazy var delleButton = {
        $0.setTitle( "Генерация Изображения", for: .normal)
        $0.setTitleColor(.white, for: .normal)
        $0.backgroundColor = .systemRed
        $0.layer.cornerRadius = 20
        $0.clipsToBounds = true
        $0.translatesAutoresizingMaskIntoConstraints = false
        return $0
    }(UIButton(primaryAction: UIAction(handler: { [weak self] _ in
        guard let self else {return}
        let dalleVC = SecondViewController()
        navigationController?.pushViewController(dalleVC, animated: true)
    })))
    
    
    override func viewDidLoad() {
    
        super.viewDidLoad()
        view.backgroundColor = .white
        
        view.addSubview(gptButton)
        view.addSubview(delleButton)
        setupConstraints()
        }
    
    func setupConstraints() {
        NSLayoutConstraint.activate([
            gptButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: view.frame.height / 5 ),
            gptButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            gptButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            
            delleButton.topAnchor.constraint(equalTo: gptButton.bottomAnchor, constant: 15),
            delleButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            delleButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
        ])
    }
}
