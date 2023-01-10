from .InterfaceModule import SellerBuyerInterface, ShipperBuyerInterface, BuyerSellerInterface

include "console.iol"

service BuyerService {

    execution{ single }

    outputPort Seller {
        Location: "socket://localhost:8000"
        Protocol: http { format = "json" }
        Interfaces: BuyerSellerInterface
    }

    inputPort ShipperBuyer {
        location: "socket://localhost:8006"
        protocol: http { format = "json" }
        interfaces: ShipperBuyerInterface
    }

    inputPort SellerBuyer {
        location: "socket://localhost:8001"
        protocol: http { format = "json" }
        interfaces: SellerBuyerInterface
    }

    main {
        ask@Seller("chips")
        {
            [quote(price)] {
                if (price < 20) {
                    println@Console( "Buyer: Price lower than 20. Accepting...")()
                    accept@Seller("Ok to buy chips for " + price)
                    println@Console("Buyer: Waiting for invoice")()
                    [details(invoice)]
                    println@Console( "Buyer: Received " + invoice + " from Shipper!")()
                } else {
                    println@Console( "Buyer: Price not lower than 20. Rejecting...")()
                    reject@Seller("Not ok to buy chips for " + price)
                }
            }
        }

    }
}