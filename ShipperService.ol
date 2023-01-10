from .InterfaceModule import ShipperBuyerInterface, SellerShipperInterface

include "console.iol"

service SellerService {

    execution{ concurrent }

    outputPort Buyer {
        location: "socket://localhost:8006"
        protocol: http { format = "json" }
        interfaces: ShipperBuyerInterface
    }

    inputPort SellerShipper {
        location: "socket://localhost:8007"
        protocol: http { format = "json" }
        interfaces: SellerShipperInterface
    }

    main {
        [ order ( product ) ] {
            println@Console("Shipper: Received order for " + product + " from seller.")()
            details@Buyer("invoice for " + product)
            println@Console("Shipper: Sent invoice for " + product + " to buyer.")()
        }
    }
}