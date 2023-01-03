from .InterfaceModule import BuyerSellerInterface, SellerInterface, SellerShipperInterface

include "console.iol"

service SellerService {

    execution{ concurrent }

    outputPort Buyer {
        Location: "socket://localhost:8001"
        Protocol: http { format = "json" }
        Interfaces: BuyerSellerInterface
    }

    
    outputPort Shipper {
        Location: "socket://localhost:8007"
        Protocol: http { format = "json" }
        Interfaces: SellerShipperInterface
    }
    

    inputPort BuyerSeller {
        location: "socket://localhost:8000"
        protocol: http { format = "json" }
        interfaces: SellerInterface
    }


    main {
        [ ask( request ) ] { 
            quote@Buyer(17)
            println@Console("asked")()
        }

        [ accept( message ) ] {
            order@Shipper("chips")
            println@Console("accepted")()
        }

        [ reject( message ) ] {
            println@Console("rejected")()
        }
    }
}