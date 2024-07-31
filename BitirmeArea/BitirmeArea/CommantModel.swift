//
//  CommantModel.swift
//  BitirmeArea
//
//  Created by Sema UĞUR on 30.05.2024.
//

import Foundation
import Parse

class CommentsModel {
    var id: String
    var text: String
    var placeId: String
    var createdAt: Date?

    init(object: PFObject) {
        self.id = object.objectId ?? ""
        self.text = object["text"] as? String ?? ""
        self.placeId = object["placeId"] as? String ?? ""
        self.createdAt = object.createdAt
    }
}

/*
import Foundation
import Parse

class Comment: PFObject, PFSubclassing {
    
    @NSManaged var text: String
    @NSManaged var placeID: String
    // İhtiyaç duyarsanız, kullanıcı bilgileri gibi diğer alanları da ekleyebilirsiniz.
    
    // Parse sınıf adını belirtin
    class func parseClassName() -> String {
        return "Comments"
    }
    
    // İstenirse, başka özel metodlar da eklenebilir.
}
*/
