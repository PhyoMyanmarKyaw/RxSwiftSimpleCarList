//
//  APIService.swift
//  Cars
//
//  Created by PhyoMyanmarKyaw on 23/03/2022.
//

import Foundation
import RxSwift
import Alamofire

class APIService {
    
    // MARK: - Singleton
    static let shared = APIService()
    
    // MARK: - Properties
    static var isConnectedToInternet:Bool {
        return NetworkReachabilityManager()?.isReachable ?? false
    }
    
    // MARK: - Web Requests
    func fetchCars() -> Single<[CarPlainModel]> {
        Single.create {(single) -> Disposable in
            
            let request = AF.request(AppConstants.API_URL,
                                     parameters: nil,
                                     requestModifier: { $0.timeoutInterval = 5 })
                            .response { response in
            switch response.result {
                case .success(let data):
                    guard let data = data else { return }
                    guard let car = try? JSONDecoder().decode([CarModel].self, from: data) else {
                        return single(.failure(BaseError("JSON decoding error!")))
                    }
                    //let carPlainModel = car.toPlainModel()
                    let carPlainModel = car.map { $0.toPlainModel() }
                    single(.success(carPlainModel))
                    
                    //Cache api's result
                    RealmHelper.shared.save(carPlainModel: carPlainModel)
                
                case .failure(let error):
                    return single(.failure(BaseError(error.localizedDescription)))
                }
            }
            request.resume()
            
            return Disposables.create {
                request.cancel()
            }
        }
    }
}
