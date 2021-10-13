import UIKit

struct ExchangeRate {
    var currencyRate: Double {
        
        willSet {
            print("환율이 \(currencyRate)에서 \(newValue)로 변경예정")
        }
        didSet {
            print("환율이 \(oldValue)에서 \(currencyRate)로 변경완료")
        }
    }
    
    var USD: Double {
        willSet {
            print("환전 금액: KRW \(newValue * currencyRate)로 환전될 예정")
        }
        didSet {
            print("USD: \(USD) -> KRW: \(USD * currencyRate)로 환전 완료")
        }
    }
    
    var KRW: Double {
        willSet {
            print("환전 금액: USD \(newValue / currencyRate)로 환전될 예정")
        }
        didSet {
            print("KRW: \(KRW) -> USD: \(KRW / currencyRate)로 환전 완료")
        }
    }
    
}


var rate = ExchangeRate(currencyRate: 1350, USD: 1, KRW: 500000)
rate.KRW = 500000
rate.USD = 370
rate.currencyRate = 1100
rate.KRW = 500000
rate.USD = 454

