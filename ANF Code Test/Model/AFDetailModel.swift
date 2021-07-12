import Foundation

struct AFDetailModel: Codable {
    let title: String?
    let backgroundImage: String?
    let content: [ContentDetailModel]?
    let promoMessage: String?
    let topDescription: String?
    let bottomDescription: String?
    
    enum CodingKeys: String, CodingKey {
        case title = "title"
        case backgroundImage = "backgroundImage"
        case content = "content"
        case promoMessage = "promoMessage"
        case topDescription = "topDescription"
        case bottomDescription = "bottomDescription"
    }
    
    var isTopDescAvailable:Bool {
        return (topDescription?.isEmpty ?? true)
    }
    
    var isTitleAvailable:Bool {
        return (title?.isEmpty ?? true)
    }
    
    var isPromoAvailable:Bool {
        return (promoMessage?.isEmpty ?? true)
    }
    
    var isBottomDescAvailable:Bool {
        return (bottomDescription?.isEmpty ?? true)
    }
    
    var isContentAvailable:Bool {
        return !(content?.count ?? 0 > 0)
    }
    
    init(title: String,
         backgroundImage: String,
         content: [ContentDetailModel],
         promoMessage: String,
         topDescription: String,
         bottomDescription: String) {
        self.title = title
        self.backgroundImage = backgroundImage
        self.content = content
        self.promoMessage = promoMessage
        self.topDescription = topDescription
        self.bottomDescription = bottomDescription
    }
}

struct ContentDetailModel : Codable {
    let target : String?
    let title : String?
    
    enum CodingKeys: String, CodingKey {
        case target = "target"
        case title = "title"
    }
}

/*
 
 "title": "TOPS STARTING AT $12",
 "backgroundImage": "anf-20160527-app-m-shirts.jpg",
 "content": [
   {
     "target": "https://www.abercrombie.com/shop/us/mens-new-arrivals",
     "title": "Shop Men"
   },
   {
     "target": "https://www.abercrombie.com/shop/us/womens-new-arrivals",
     "title": "Shop Women"
   }
 ],
 "promoMessage": "USE CODE: 12345",
 "topDescription": "A&F ESSENTIALS",
 "bottomDescription": "*In stores & online. <a href=\\\"http://www.abercrombie.com/anf/media/legalText/viewDetailsText20160602_Tier_Promo_US.html\\\">Exclusions apply. See Details</a>"
 
 */
