//
//  ViewController.swift
//  Examples
//
//  Created by Kemal Türk on 1.10.2023.
//

import UIKit
import AdonisSDK


class ViewController: UIViewController {
    
    private let bannerView = AdonisBannerView()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupLayout()
    }
    
    private func setupLayout() {
        view.addSubview(bannerView)
        
        bannerView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            bannerView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            bannerView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            bannerView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])
    }

}

