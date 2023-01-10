from .InterfaceModule import SellerInterface, BuyerShipperInterface, BuyerSellerInterface

include "console.iol"

service BuyerService {

    execution{ single }

    outputPort Seller {
        Location: "socket://localhost:8000"
        Protocol: http { format = "json" }
        Interfaces: SellerInterface
    }

    inputPort ShipperBuyer {
        location: "socket://localhost:8006"
        protocol: http { format = "json" }
        interfaces: BuyerShipperInterface
    }

    inputPort SellerBuyer {
        location: "socket://localhost:8001"
        protocol: http { format = "json" }
        interfaces: BuyerSellerInterface
    }

    main {
        ask@Seller("chips")
        {
            [quote(price)] {
                if (price < 20) {
                    println@Console( "price lower than 20")()
                    accept@Seller("Ok to buy chips for " + price)
                    println@Console("waiting for invoice")()
                    [details(invoice)]
                    println@Console( "Received " + invoice + " from Shipper!")()
                } else {
                    println@Console( "price not lower than 20")()
                    reject@Seller("Not ok to buy chips for " + price)
                }
            }
        }

    }
}