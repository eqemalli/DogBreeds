//
//  BreedsViewController.swift
//  DogBreeds
//
//  Created by Enxhi Qemalli on 14.9.21.
//

import Combine
import UIKit

class BreedsViewController: UITableViewController {
    
    // MARK: - Properties
    
    let coordinator: BreedsCoordinator
    let viewModel: BreedsViewModel
    private var subscriptions = Set<AnyCancellable>()
    private var loadDataSubject = PassthroughSubject<Void,Never>()
    
    // MARK: - Initializers
    
    init(viewModel: BreedsViewModel) {
        self.coordinator = viewModel.coordinator
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        view.backgroundColor = .white
        prepareTableView()
        setupBindings()
        loadDataSubject.send()
        title = "All Breeds"
        super.viewDidLoad()
        
    }
    
    private func prepareTableView() {
        tableView.register(BreedCell.self, forCellReuseIdentifier: BreedCell.reuseIdentifier)
        tableView.dataSource = self
        tableView.delegate = self
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 100
        tableView.reloadData()
    }
    
        
    /// Function to observe various event call backs from the viewmodel as well as Notifications.
    private func setupBindings() {
        viewModel.attachViewEventListener(loadData: loadDataSubject.eraseToAnyPublisher())
        
        viewModel.reloadBreedList
            .sink(receiveCompletion: { completion in
                
            }) { [weak self] _ in
                self?.tableView.reloadData()
            }
            .store(in: &subscriptions)
    }

}


//MARK: UICollectionViewDatasource
extension BreedsViewController {
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.numberOfRows
        
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: BreedCell.reuseIdentifier, for: indexPath) as! BreedCell
        cell.selectionStyle = .none
       cell.prepareCell(viewModel: viewModel.tableDataSource[indexPath.row])
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        coordinator.presentBreedImagesViewController(title: viewModel.tableDataSource[indexPath.row].title.value ?? "Breed")
    }
}
