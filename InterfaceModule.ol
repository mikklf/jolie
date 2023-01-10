
interface SellerInterface {
    OneWay:
        ask ( string ),
        accept ( string ),
        reject ( string ),
}


interface BuyerShipperInterface {
    OneWay:
        details ( string )
}

interface SellerShipperInterface {
    OneWay:
        order ( string ),
}

interface BuyerSellerInterface {
    OneWay:
        quote ( int ),
}


interface ExtendedBuyerSellerInterface {
    OneWay:
        accept ( string ),
        reject ( string )
    RequestResponse:
        ask ( string ) ( int ),
}