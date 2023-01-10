from .InterfaceModule import BuyerSellerInterface, SellerBuyerInterface, SellerShipperInterface

include "console.iol"

service SellerService2 {

    execution{ concurrent }

    outputPort Buyer {
        Location: "socket://localhost:8001"
        Protocol: http { format = "json" }
        Interfaces: SellerBuyerInterface
    }

    
    outputPort Shipper {
        Location: "socket://localhost:8007"
        Protocol: http { format = "json" }
        Interfaces: SellerShipperInterface
    }
    

    inputPort BuyerSeller {
        location: "socket://localhost:8020"
        protocol: http { format = "json" }
        interfaces: BuyerSellerInterface
    }


    main {
        [ ask( request ) ] { 
            quote@Buyer(23)
            println@Console("Seller: Sent price of 23 for chips to buyer")()
        }

        [ accept( message ) ] {
            println@Console("Seller: Buyer accepted price for chips")()
            order@Shipper("chips")
            println@Console("Seller: Sent order to Shipper")()
        }

        [ reject( message ) ] {
            println@Console("Seller: Buyer rejected price for chips")()
        }
    }
}