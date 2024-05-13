//
//  CarViewModel.swift
//  Cars
//
//  Created by PhyoMyanmarKyaw on 23/03/2022.
//

import Foundation
import RxSwift
import RxCocoa

class CarViewModel {
    
    // MARK: - Properties
    private let _listLoadingStatus = BehaviorRelay<Bool>(value: true)
    private let _cars = BehaviorRelay<[CarPlainModel]>(value: [])
    private let _errorMessage = BehaviorRelay<String?>(value: nil)
    private let _refreshing = BehaviorRelay<Bool>(value: false)
    
    private let disposeBag = DisposeBag()
    
    var car: Driver<[CarPlainModel]> {
        return _cars.asDriver(onErrorJustReturn: [])
    }
    
    var errorMessage: Driver<String?> {
        return _errorMessage.asDriver(onErrorJustReturn: nil)
    }
    
    var refreshing: Driver<Bool> {
        return _refreshing.asDriver(onErrorJustReturn: false)
    }
    
    var listLoadingStatus: Driver<Bool> {
        return _listLoadingStatus.asDriver(onErrorJustReturn: false)
    }

    // MARK: - Network request
    func getCars() {
        if APIService.isConnectedToInternet {
            
            //show main indicator
            self._listLoadingStatus.accept(false)
            APIService.shared.fetchCars()
                .subscribe { cars in
                    
                    self._errorMessage.accept(nil)
                    self._cars.accept(cars)
                    self._listLoadingStatus.accept(true) //hide main indicator
                    
                } onFailure: { error in
                    self._errorMessage.accept(AppConstants.generalErrorMessage)
                }
                .disposed(by: disposeBag)
        } else {
            // load cache from realm
            let cachedCar = RealmHelper.shared.load()
            self._cars.accept(cachedCar)
            self._errorMessage.accept(AppConstants.offlineErrorMessage)
        }
    }
    
    // MARK: - PullToRefresh #selector
    @objc func refreshCars() {
       
        if APIService.isConnectedToInternet {
            self._refreshing.accept(true)
            APIService.shared.fetchCars()
                .subscribe { cars in
                    
                    self._errorMessage.accept(nil)
                    self._refreshing.accept(false)
                    self._cars.accept(cars)
                    self._listLoadingStatus.accept(true)
                    
                } onFailure: { error in
                    self._errorMessage.accept(AppConstants.generalErrorMessage)
                    self._refreshing.accept(false)
                }
                .disposed(by: disposeBag)
        } else {
            self._refreshing.accept(false)
        }
    }
}
