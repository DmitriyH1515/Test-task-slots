//
//  GamesViewController.swift
//  Test task slots
//
//  Created by Dmitriy Havrylenko on 14.06.2022.
//

import UIKit

enum State {
    case popular
    case allGames
}

class GamesViewController: UIViewController {
    @IBOutlet weak var contentView: UIView!
    
    @IBOutlet weak var popularButton: UIButton!
    @IBOutlet weak var popularUnderline: UIView!
    
    @IBOutlet weak var allGamesButton: UIButton!
    @IBOutlet weak var allGamesUnderline: UIView!
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    private var state: State = .popular
    
    private var viewModel: GamesViewModel?
    
    private let reuseIdentifier = "imageCell"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel = GamesViewModel()
        setupCollectionView()
        setupStyle()
    }

    @IBAction func tapOnPopular(_ sender: UIButton) {
        guard state == .allGames else { return }
        setButtonStyle(for: .popular)
    }
    
    @IBAction func tapOnAllGames(_ sender: UIButton) {
        guard state == .popular else { return }
        setButtonStyle(for: .allGames)
    }
    
    private func setupStyle() {
        contentView.layer.cornerRadius = 20
        contentView.layer.maskedCorners = [.layerMaxXMinYCorner, .layerMinXMinYCorner]
        
        setButtonStyle(for: state)
        
        popularUnderline.backgroundColor = .red
        allGamesUnderline.backgroundColor = .red
    }
    
    private func setupCollectionView() {
        collectionView.delegate = self
        collectionView.dataSource = self
    }
    
    private func setButtonStyle(for state: State) {
        switch state {
        case .popular:
            popularButton.tintColor = .white
            popularButton.titleLabel?.font =  UIFont.systemFont(ofSize: 20, weight: .bold)
            popularUnderline.isHidden = false
            allGamesButton.tintColor = .lightGray
            allGamesButton.titleLabel?.font = UIFont.systemFont(ofSize: 20, weight: .regular)
            allGamesUnderline.isHidden = true
            
            self.state = .popular
        case .allGames:
            popularButton.tintColor = .lightGray
            popularButton.titleLabel?.font = UIFont.systemFont(ofSize: 20, weight: .regular)
            popularUnderline.isHidden = true
            
            allGamesButton.tintColor = .white
            allGamesButton.titleLabel?.font = UIFont.systemFont(ofSize: 20, weight: .bold)
            allGamesUnderline.isHidden = false
            
            self.state = .allGames
        }
        collectionView.reloadData()
    }
}

extension GamesViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        switch state {
        case .allGames:
            return viewModel?.allGames.count ?? 0
        case .popular:
            return viewModel?.popularGames.count ?? 0
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(
              withReuseIdentifier: reuseIdentifier,
              for: indexPath) as? GameCollectiomViewCell else {
            return UICollectionViewCell()
        }
        
        switch state {
        case .allGames:
            cell.imageView.image = UIImage(named: viewModel?.allGames[indexPath.row].image ?? "")
        case .popular:
            cell.imageView.image = UIImage(named: viewModel?.popularGames[indexPath.row].image ?? "")
        }
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if indexPath.row == 0 {
            return CGSize(width: 500, height: 60)
        } else  {
            return CGSize(width: contentView.frame.width / 2 - 30, height: 60)
        }
    }
}
