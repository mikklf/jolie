from .InterfaceModule import SellerBuyerInterface, ShipperBuyerInterface, BuyerSellerInterface

include "console.iol"

service BuyerService {

    execution{ single }

    outputPort Seller1 {
        Location: "socket://localhost:8000"
        Protocol: http { format = "json" }
        Interfaces: BuyerSellerInterface
    }
    
    outputPort Seller2 {
        Location: "socket://localhost:8020"
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
        ask@Seller1("chips")
        [quote(price1)]
        ask@Seller2("chips") 
        [quote(price2)]
        {       
            if (price1 < 20 || price2 < 20) { 
                if (price1 < price2) {
                    println@Console( "Buyer: Seller1 price lower than Seller2. Accepting Seller1...")()
                    accept@Seller1("Ok to buy chips for " + price)
					|
                    reject@Seller2("Not ok to buy chips for " + price)
                } else {
                    println@Console( "Buyer: Seller2 price lower than Seller1. Accepting Seller2...")()
                    accept@Seller2("Ok to buy chips for " + price)
					|
                    reject@Seller1("Not ok to buy chips for " + price)
                }

                println@Console("Buyer: Waiting for invoice")()
                [details(invoice)]
                println@Console( "Buyer: Received " + invoice + " from Shipper!")()

            } else {
                println@Console( "Buyer: Both prices higher then 20. Rejecting both...")()
                reject@Seller1("Not ok to buy chips for " + price)
				|
                reject@Seller2("Not ok to buy chips for " + price)
            }
            
        }

    }
}