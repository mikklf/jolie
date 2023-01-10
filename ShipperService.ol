from .InterfaceModule import BuyerShipperInterface, SellerShipperInterface

include "console.iol"

service SellerService {

    execution{ concurrent }

    outputPort Buyer {
        location: "socket://localhost:8006"
        protocol: http { format = "json" }
        interfaces: BuyerShipperInterface
    }

    inputPort SellerShipper {
        location: "socket://localhost:8007"
        protocol: http { format = "json" }
        interfaces: SellerShipperInterface
    }

    main {
        [ order ( product ) ] {
            details@Buyer("invoice for " + product)
            println@Console("Sent invoice")()
        }
    }
}