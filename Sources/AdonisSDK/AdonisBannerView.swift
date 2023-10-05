//
//  AdonisBannerView.swift
//  AdonisDemo
//
//  Created by Kemal Türk on 30.09.2023.
//

import Foundation
import UIKit
import SDWebImage
import StoreKit


public class AdonisBannerView: UIView {
    
    private let client: AdonisClient = AdonisHttpClient()
    
    private var timer: Timer?
    private var heightConstraint: NSLayoutConstraint?
    private var response: ViewResponse?
    
    
    private let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.backgroundColor = .black
        imageView.clipsToBounds = true
        return imageView
    }()
    
    public weak var delegate: AdonisBannerViewDelegate?
    
    public init() {
        super.init(frame: .zero)
        
        setupLayout()
        fetch()
        
        NotificationCenter.default.addObserver(self, selector: #selector(didEnterBackground), name: UIApplication.didEnterBackgroundNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(willEnterForeground), name: UIApplication.willEnterForegroundNotification, object: nil)
        
        startTimer()
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
                
                delegate?.didLoad()
            }
        }
    }
    
    private func startTimer() {
        timer = Timer.scheduledTimer(timeInterval: 45, target: self, selector: #selector(timerFired), userInfo: nil, repeats: true)
    }
    
    @objc
    private func didTap() {
        guard let id = response?.id, let url = URL(string: response?.url ?? "") else { return }
        
        Task { await client.sendClickEvent(id: id) }

        if UIApplication.shared.canOpenURL(url) {
            if let appID = response?.appID {
                let storeViewController = SKStoreProductViewController()
                let parameters = [SKStoreProductParameterITunesItemIdentifier: appID]
                storeViewController.loadProduct(withParameters: parameters) { _, err in
                    if err != nil {
                        UIApplication.shared.open(url)
                    } else {
                        let keyWindow = UIApplication.shared.windows.first(where: { $0.isKeyWindow }) ?? UIApplication.shared.windows.first
                        keyWindow?.rootViewController?.present(storeViewController, animated: true)
                    }
                }
            } else {
                UIApplication.shared.open(url)
            }
        }
    }
    
    @objc
    private func didEnterBackground() {
        timer?.invalidate()
    }
    
    @objc
    private func willEnterForeground() {
        startTimer()
    }
    
    @objc
    private func timerFired() {
        fetch()
    }
    
}
