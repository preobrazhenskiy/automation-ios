//
//  UICollectionView+CellViewModel.swift
//  WeatherApp
//
//  Created by Dmitry Pliushchai on 11/26/19.
//  Copyright © 2019 Andersen. All rights reserved.
//

import UIKit

extension UICollectionView {
    
    func dequeueReusableCell(with viewModel: AnyCellViewModel, for indexPath: IndexPath) -> UICollectionViewCell {
        let identifier = type(of: viewModel).uniqueIdentifier
        let cell = dequeueReusableCell(withReuseIdentifier: identifier, for: indexPath)
        viewModel.setup(cell: cell)
        return cell
    }
    
    func register(_ modelType: AnyCellViewModel.Type) {
        if let nibFileName = (modelType.cellClass as? NibInitializable.Type)?.nibFileName {
            let nib = UINib(nibName: nibFileName, bundle: Bundle(for: modelType.cellClass))
            register(nib, forCellWithReuseIdentifier: modelType.uniqueIdentifier)
            
        } else {
            register(modelType.cellClass, forCellWithReuseIdentifier: modelType.uniqueIdentifier)
        }
    }
    
    func register(_ models: [AnyCellViewModel.Type]) {
        models.forEach { register($0) }
    }
    
    func register(_ models: AnyCellViewModel.Type...) {
        models.forEach { register($0) }
    }
    
    func register<T: CellViewModel>(_ viewModel: T.Type) where T.Cell: UICollectionViewCell {
        register(T.Cell.self, forCellWithReuseIdentifier: T.uniqueIdentifier)
    }
    
    func register<T: CellViewModel>(_ viewModel: T.Type) where T.Cell: UICollectionViewCell, T.Cell: NibInitializable {
        let nib = UINib(nibName: T.Cell.nibFileName, bundle: Bundle(for: T.Cell.self))
        register(nib, forCellWithReuseIdentifier: T.uniqueIdentifier)
    }
}
