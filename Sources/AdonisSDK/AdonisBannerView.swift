//
//  AdonisBannerView.swift
//  AdonisDemo
//
//  Created by Kemal Türk on 30.09.2023.
//

import Foundation
import UIKit
import SDWebImage


public class AdonisBannerView: UIView {
    
    private let client: AdonisClient = AdonisHttpClient()
    
    private var heightConstraint: NSLayoutConstraint?
    private var response: ViewResponse?
    
    private let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.backgroundColor = .black
        imageView.clipsToBounds = true
        return imageView
    }()
    
    public init() {
        super.init(frame: .zero)
        
        fetch()
        setupLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupLayout() {
        addSubview(imageView)
        imageView.fillSuperView()
        heightConstraint = imageView.height(0)
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(didTap))
        imageView.addGestureRecognizer(tapGesture)
        imageView.isUserInteractionEnabled = true
    }
    
    private func fetch() {
        Task {
            let result = await client.view()
            self.response = result.value
            guard let image = response?.image else { return }
                        
            await MainActor.run {
                heightConstraint?.constant = 80
                imageView.sd_setImage(with: URL(string: image))
                superview?.layoutIfNeeded()
            }
        }
    }
    
    @objc
    private func didTap() {
        guard let id = response?.id, let url = URL(string: response?.url ?? "") else { return }
        
        Task { await client.sendClickEvent(id: id) }
        
        if UIApplication.shared.canOpenURL(url) {
            UIApplication.shared.open(url)
        }
    }
    
}
