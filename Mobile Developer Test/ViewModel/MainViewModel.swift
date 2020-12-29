//
//  MainVIewModel.swift
//  Mobile Developer Test
//
//  Created by kjoe on 12/28/20.
//

import Foundation
class MainViewModel{
    var list: [Hits] = []
    var service: ListService!
    let end = ListEndpoint(path: "/api/v1/search_by_date", queryItems: [URLQueryItem(name: "query", value: "ios")])
    var success: (()->Void)?
    let formater = DateFormatter()
    let secondFormater = RelativeDateTimeFormatter()
    func titleForCell(index: Int) -> String{
        return list[index].storyTitle ?? "N/A"
    }
    
    func autorAndDate(index: Int) -> String{
        let date = list[index].createdAt
        return  "\(list[index].author ?? "Author not available") - \(self.relativeDatefromPost(dateS: date!))"
    }
    
    func loadData(){
       _ = service.getList(endPoint: end, completion: {result in
        print("result:",result)
            switch result{
            case .success(let data):
                self.list.insert(contentsOf: data.hits ?? [], at: 0)
                self.success?()
            case .failure(let e):
                print(e.localizedDescription)
            }
        })
    }
    
    init(service: ListService) {
        self.service = service
    }
    
    func relativeDatefromPost(dateS: String) -> String{
        print("date:",dateS)
        //formater.doesRelativeDateFormatting = false
        formater.locale = Locale(identifier: "en_US")
        formater.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSZ"
        formater.timeZone = TimeZone(identifier: "UTC")
        let date = formater.date(from: dateS)
        print("date object:",date?.description)
        //formater.doesRelativeDateFormatting = true
        
        secondFormater.dateTimeStyle = .numeric
        secondFormater.unitsStyle = .short
        //secondFormater.formattingContext = .beginningOfSentence
        secondFormater.locale = Locale(identifier: "en_US")
        return secondFormater.localizedString(for: date!, relativeTo: Date())//(from: date ?? Date())
    }
    
}
