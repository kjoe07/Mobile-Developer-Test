//
//  NetworkReachability.swift
//  Mobile Developer Test
//
//  Created by kjoe on 12/28/20.
//

import Foundation
import Network
protocol ListService{
    func getList(endPoint: Endpoint,completion: @escaping (Result<Response,Error>)-> Void)  -> NetworkCancelable?
}
class RemoteListService:ListService{
    var loader: NetworkLoader
    var requestable:  Resquetable
    func getList(endPoint: Endpoint, completion: @escaping (Result<Response,Error>) -> Void) -> NetworkCancelable? {
        do {
            let r = try requestable.createRequest(endPoint: endPoint)
            return loader.loadData(request: r, completion: {result in
                switch result{
                case .success(let d):
                    do{
                        let resp = try JSONDecoder().decode(Response.self, from: d)
                        UserDefaults.standard.setValue(d, forKey: endPoint.queryItems?.first?.value ?? "ios")
                        completion(.success(resp))
                    }catch{
                        completion(.failure(error))
                    }
                case .failure(let e):
                    completion(.failure(e))
                }
            })
        }catch{
            completion(.failure(error))
            return nil
        }
    }
    
    init(loader: NetworkLoader,resquetable:Resquetable) {
        self.loader = loader
        self.requestable = resquetable
    }    
}
class LocalListLoader: ListService{
    func getList(endPoint: Endpoint, completion: @escaping (Result<Response, Error>) -> Void) -> NetworkCancelable? {
        let name = endPoint.queryItems?.first?.value ?? "ios"
        guard let data = UserDefaults.standard.data(forKey: name) else {completion(.failure(customError.badData)); return nil }
        do {
            let decoder = try JSONDecoder().decode(Response.self, from: data)// else { completion(.failure(error)); return nil}
            completion(.success(decoder))
        }catch{
            completion(.failure(error))
        }
        return nil
    }    
}

class RemoteLoaderWithLocalFeedBack: ListService{
    var remote: RemoteListService!
    var local: LocalListLoader!
    var monitor: NetworkReachability
    func getList(endPoint: Endpoint, completion: @escaping (Result<Response, Error>) -> Void) -> NetworkCancelable? {
        if  monitor.isNetworkAvailable(){
           return  remote.getList(endPoint: endPoint, completion: { result in
                switch result{
                case.success(let d):
                    completion(.success(d))
                case .failure(let e):
                    completion(.failure(e))
                }
            })
        }else{
           return local.getList(endPoint: endPoint, completion: {result in
                switch result{
                case .success(let d):
                    completion(.success(d))
                case .failure(let e):
                    completion(.failure(e))
                }
            })
        }
    }
    
    init(remote: RemoteListService,local: LocalListLoader, monitor: NetworkReachability) {
        self.remote = remote
        self.local = local
        self.monitor = monitor
    }
}
