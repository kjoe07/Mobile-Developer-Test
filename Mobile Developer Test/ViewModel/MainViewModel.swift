//
//  MainVIewModel.swift
//  Mobile Developer Test
//
//  Created by kjoe on 12/28/20.
//

import Foundation
class MainViewModel{
    var list: [Hits]?
    var service: ListService!
    let end = ListEndpoint(path: "/api/v1/search_by_date", queryItems: [URLQueryItem(name: "query", value: "ios")])
    var success: (()->Void)?
    
    func titleForCell(index: Int) -> String{
        return list?[index].storyTitle ?? "N/A"
    }
    
    func autorAndDate(index: Int) -> String{
       return  "\(list?[index].author ?? "Author not avaible") - \(list?[index].createdAt ?? "Created date is not avaible")"
    }
    
    func loadData(){
       _ = service.getList(endPoint: end, completion: {result in
        print("result:",result)
            switch result{
            case .success(let data):
                self.list = data.hits
                self.success?()
            case .failure(let e):
                print(e.localizedDescription)
            }
        })
    }
    
    init(service: ListService) {
        self.service = service
    }
    
    
}
