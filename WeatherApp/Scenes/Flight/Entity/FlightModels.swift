import UIKit

enum FlightModels {
    
    enum Popular {
        struct Request {
        }
        
        struct Response {
            struct Item {
                let identifier: Int
                let origin: String
                let destination: String
                let airlineName: String
                let airlineLogo: URL?
                let departureDate: Date?
                let returnDate: Date?
                let price: Double
                let transfers: Int
            }
            let flights: [Item]
            let currency: String
        }
        
        struct ViewModel {
            struct Item {
                let identifier: Int
                let origin: String
                let destination: String
                let airlineName: String
                let airlineLogo: URL?
                let departureDate: String?
                let returnDate: String?
                let price: String
                let transfers: String
            }
            let flights: [Item]
        }
    }
    
    enum SelectFlight {
        struct Request {
            let identifier: Int
        }
    }
    
    enum Failure {
        
        struct Response {
            let error: Error
        }
        
        struct ViewModel {
            let errorMessage: String
        }
    }
}
