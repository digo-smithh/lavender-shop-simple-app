//
//  ListView.swift
//  Lavender Shop
//
//  Created by Rodrigo Smith Rodrigues on 07/08/22.
//

import UIKit

class ListView: UIView {
    
    lazy var collectionView: UICollectionView = {
        let configuration = UICollectionLayoutListConfiguration(appearance: .insetGrouped)
        
        let layout = UICollectionViewCompositionalLayout.list(using: configuration)
        
        let collectonView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectonView.translatesAutoresizingMaskIntoConstraints = false
        collectonView.backgroundColor = .systemGroupedBackground
        
        return collectonView
    }()
    
    init() {
        super.init(frame: .zero)
        setup()
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }

    func setup() {
    }
    
    func setupSubviews() {
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: topAnchor),            collectionView.leadingAnchor.constraint(equalTo: leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: trailingAnchor),
            collectionView.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
        
        addSubview(collectionView)
    }

}
