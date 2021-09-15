//
//  ImageCell.swift
//  DogBreeds
//
//  Created by Enxhi Qemalli on 14.9.21.
//

import UIKit
import Combine

public class ImageCell: UICollectionViewCell{
    
    // MARK: - Properties
    
    let breedImageView = UIImageView()
    let favoriteImageView = UIImageView()
    let containerView = UIView()
    public static let reuseIdentifier = "BreedCell"
    public var viewModel: ImageCellModel?
    private var subscriptions = Set<AnyCancellable>()
    
    
    // MARK: - Life Cycle
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    public override func prepareForReuse() {
        super.prepareForReuse()
        viewModel = nil

    }
    
    func prepareCell(viewModel: ImageCellModel) {
        self.viewModel = viewModel
        guard let viewModel = self.viewModel else { return }
        
        breedImageView.setImage(url: viewModel.breedImage.value)
        viewModel.favoriteImage
            .assign(to: \.image, on: favoriteImageView)
            .store(in: &subscriptions)
    }
    
    private func setup() {
        
        contentView.addSubview(containerView)
        contentView.addSubview(breedImageView)
        contentView.addSubview(favoriteImageView)
        NSLayoutConstraint.activate([
            containerView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10),
            containerView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -10),
            containerView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10),
            containerView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -10),
            
            breedImageView.leadingAnchor.constraint(equalTo: containerView.leadingAnchor),
            breedImageView.trailingAnchor.constraint(equalTo: containerView.trailingAnchor),
            breedImageView.topAnchor.constraint(equalTo: containerView.topAnchor),
            breedImageView.bottomAnchor.constraint(equalTo: containerView.bottomAnchor),
            
            favoriteImageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -15),
            favoriteImageView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 15),
            favoriteImageView.heightAnchor.constraint(equalToConstant: 25),
            favoriteImageView.widthAnchor.constraint(equalToConstant: 25),

        ])
        translatesAutoresizingMaskIntoConstraints = false
        containerView.translatesAutoresizingMaskIntoConstraints = false
        breedImageView.translatesAutoresizingMaskIntoConstraints = false
        favoriteImageView.translatesAutoresizingMaskIntoConstraints = false
        favoriteImageView.image = UIImage(named: "icon-tab-favorite")
    }
    
    func addTofavorites(){
        favoriteImageView.image = UIImage(named: "icon-tab-favorite-selected")

    }
    
    func removeFromFavorites(){
        favoriteImageView.image = UIImage(named: "icon-tab-favorite")

    }

}

