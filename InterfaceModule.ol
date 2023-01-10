// Interface naming pattern:
// {Sender}{Receiver}Interface

interface BuyerSellerInterface {
    OneWay:
        ask ( string ),
        accept ( string ),
        reject ( string ),
}

interface ShipperBuyerInterface {
    OneWay:
        details ( string )
}

interface SellerShipperInterface {
    OneWay:
        order ( string ),
}

interface SellerBuyerInterface {
    OneWay:
        quote ( int ),
}