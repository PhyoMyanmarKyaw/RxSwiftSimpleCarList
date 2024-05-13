//
//  ViewController.swift
//  Cars
//
//  Created by PhyoMyanmarKyaw on 23/03/2022.
//

import UIKit
import RxSwift
import RxCocoa
import NVActivityIndicatorView
import RealmSwift

class CarsListViewController: UIViewController {

    // MARK: - Outlets
    @IBOutlet weak var tableView: UITableView! {
        didSet {
            tableView.register(UINib(nibName: "CarCell", bundle: nil), forCellReuseIdentifier: CarCell.identifier)
            tableView.rowHeight = UITableView.automaticDimension
            tableView.estimatedRowHeight = 380
            tableView.addSubview(refreshControl)
            tableView.refreshControl = refreshControl
        }
    }
    
    // MARK: - Properties
    private let refreshControl = UIRefreshControl()
    private let disposeBag = DisposeBag()
    private let viewModel = CarViewModel()
    
    private let activityIndicatorView =
            NVActivityIndicatorView(frame: CGRect(),
            type: NVActivityIndicatorType.ballRotate)
    
    // MARK: - View Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
        setupBindings()
        viewModel.getCars()
    }
    
    private func setupUI() {
        title = "Cars"
        setupRefreshControl()
        setupActivityIndicator()
    }
    
    private func setupRefreshControl() {
        refreshControl.tintColor = .white
        refreshControl.addTarget(viewModel, action: #selector(viewModel.refreshCars), for: .valueChanged)
    }
    
    private func setupActivityIndicator() {
        self.activityIndicatorView.frame.size = CGSize(width: 46, height: 46)
        self.activityIndicatorView.center = self.view.center
        self.view.addSubview(activityIndicatorView)
        activityIndicatorView.startAnimating()
    }

    private func setupBindings() {
        
        // activity indicator binding
        viewModel.listLoadingStatus
            .drive(activityIndicatorView.rx.isHidden)
            .disposed(by: disposeBag)
        
        // PullToRefresh binding
        viewModel.refreshing
            .drive(refreshControl.rx.isRefreshing)
            .disposed(by: disposeBag)
        
        // TableView binding
        viewModel.car
            .drive(tableView.rx.items(cellIdentifier: CarCell.identifier,
                                 cellType: CarCell.self)) { row, model, cell in
                cell.mCar = model
            }
            .disposed(by: disposeBag)
        
        // ErrorAlert Binding
        viewModel.errorMessage
            .drive { message in
                if message != nil {
                    let alert = self.getAlert(title: AppConstants.errorAlertTitle,
                                             message: message)
                    DispatchQueue.main.async {
                        self.present(alert, animated: true, completion: nil)
                    }
                }
            }
            .disposed(by: disposeBag)
    }
}
