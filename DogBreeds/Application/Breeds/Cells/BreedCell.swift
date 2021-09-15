//
//  BreedCell.swift
//  DogBreeds
//
//  Created by Enxhi Qemalli on 14.9.21.
//

import UIKit
import Combine

public class BreedCell: UITableViewCell{
    
    // MARK: - Properties
    
    let titleLabel = UILabel()
    let disclosureImageView = UIImageView()
    public static let reuseIdentifier = "BreedCell"
    public var viewModel: BreedCellModel?
    private var subscriptions = Set<AnyCancellable>()
    
    
    // MARK: - Life Cycle
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: .default, reuseIdentifier: reuseIdentifier)

        setup()
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    public override func prepareForReuse() {
        super.prepareForReuse()
        viewModel = nil

    }
    
    func prepareCell(viewModel: BreedCellModel) {
        self.viewModel = viewModel
        guard let viewModel = self.viewModel else { return }
        viewModel.title
            .assign(to: \.text, on: titleLabel)
            .store(in: &subscriptions)
        
    }
    
    private func setup() {
        
        contentView.addSubview(titleLabel)
        contentView.addSubview(disclosureImageView)
        NSLayoutConstraint.activate([
            titleLabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            titleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 15),
            disclosureImageView.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            disclosureImageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -10),
            disclosureImageView.heightAnchor.constraint(equalToConstant: 20),
            disclosureImageView.widthAnchor.constraint(equalToConstant: 20),

        ])
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        disclosureImageView.translatesAutoresizingMaskIntoConstraints = false
        disclosureImageView.image = UIImage(named: "icon-more")
    }
    
    
}

