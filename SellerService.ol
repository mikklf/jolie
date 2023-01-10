<<<<<<< HEAD
from .InterfaceModule import BuyerSellerInterface, SellerBuyerInterface, SellerShipperInterface, ExtendedBuyerSellerInterface
=======
from .InterfaceModule import BuyerSellerInterface, SellerInterface, SellerShipperInterface
>>>>>>> parent of 3146af1 (Updates)

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
<<<<<<< HEAD
        interfaces: ExtendedBuyerSellerInterface
=======
        interfaces: SellerInterface
>>>>>>> parent of 3146af1 (Updates)
    }


    main {
<<<<<<< HEAD
        [ ask( request ) ( price )  { 
            println@Console("Seller: Replied price of 17 for chips to buyer")()
            price = 17
        } ]
=======
        [ ask( request ) ] { 
            quote@Buyer(17)
            println@Console("asked")()
        }
>>>>>>> parent of 3146af1 (Updates)

        [ accept( message ) ] {
            order@Shipper("chips")
            println@Console("accepted")()
        }

        [ reject( message ) ] {
            println@Console("rejected")()
        }
    }
}