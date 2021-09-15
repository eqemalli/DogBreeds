//
//  FavoriteViewController.swift
//  DogBreeds
//
//  Created by Enxhi Qemalli on 15.9.21.
//

import Combine
import UIKit

class FavoritesViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    // MARK: - Properties
    
    let coordinator: FavoritesCoordinator
    let viewModel: FavoritesViewModel
    private var subscriptions = Set<AnyCancellable>()
    private var loadDataSubject = PassthroughSubject<Void,Never>()
    var collectionView: UICollectionView
  
    // MARK: - Initializers
    
    init(viewModel: FavoritesViewModel) {
        self.coordinator = viewModel.coordinator
        self.viewModel = viewModel
        collectionView = UICollectionView(frame: CGRect(x: 5, y: 0, width: 400, height: 40), collectionViewLayout: UICollectionViewLayout())
        
        super.init(nibName: nil, bundle: nil)
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        preparecollectionView()
        setupBindings()
        loadDataSubject.send()
        collectionView.backgroundColor = .white
        view.backgroundColor = .white
        setup()
        super.viewDidLoad()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        setupBindings()
        loadDataSubject.send()
        collectionView.reloadData()
        super.viewWillAppear(true)
    }
    
    private func preparecollectionView() {
        let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        layout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 10, right: 0)
        layout.itemSize = CGSize(width: view.frame.width/2, height: view.frame.width/2)
        layout.minimumInteritemSpacing = 0
        layout.minimumLineSpacing = 0
        collectionView = UICollectionView(frame: self.view.frame, collectionViewLayout: layout)
        collectionView.register(ImageCell.self, forCellWithReuseIdentifier: ImageCell.reuseIdentifier)
        collectionView.dataSource = self
        collectionView.delegate = self
        
        collectionView.reloadData()
    }
    
    func setup(){
        view.addSubview(collectionView)
        NSLayoutConstraint.activate([
            collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            collectionView.topAnchor.constraint(equalTo: view.topAnchor),
            collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
        ])
        collectionView.translatesAutoresizingMaskIntoConstraints = false
    }
    
    /// Function to observe various event call backs from the viewmodel as well as Notifications.
    private func  setupBindings() {
        viewModel.attachViewEventListener(loadData: loadDataSubject.eraseToAnyPublisher())
        
        viewModel.reloadImagesList
            .sink(receiveCompletion: { completion in
                
            }) { [weak self] _ in
                DispatchQueue.main.async {
                    let indexPath = IndexPath(item: 0, section: 0)
                    self?.collectionView.reloadSections(IndexSet(integer: indexPath.section) )
                    
                }
            }
            .store(in: &subscriptions)
    }
    
}


//MARK: UIcollectionViewDatasource
extension FavoritesViewController {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.numberOfItems
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ImageCell.reuseIdentifier, for: indexPath) as! ImageCell
        cell.prepareCell(viewModel: viewModel.dataSource[indexPath.item])
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: view.frame.width/2, height: view.frame.width/2)
    }
}
