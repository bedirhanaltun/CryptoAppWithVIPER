//
//  Presenter.swift
//  CryptoAppWithVIPER
//
//  Created by Bedirhan Altun on 19.09.2022.
//

import Foundation

//Class,protocol
//Talks to --> View,Router,Interactor

enum NetworkError: Error{
    case NetworkFailed
    case ParsingFailed
}


protocol AnyPresenter{
    //Protokollerde tanımladığımız değişkeni değiştiricek miyiz yoksa çekecek miyiz? sorusuna get-set ile cevap veriyoruz.
    var router: AnyRouter? {get set}
    var interactor: AnyInteractor? {get set}
    var view: AnyView? {get set}
    
    func interactorDidDownloandCrypto(result: Result<[Crypto],Error>)
}

class CryptoPresenter: AnyPresenter{
    var router: AnyRouter?
    var interactor: AnyInteractor?{
        didSet{
            interactor?.downloadCryptos()
        }
    }
    var view: AnyView?
    
    func interactorDidDownloandCrypto(result: Result<[Crypto], Error>) {
        switch result{
        case .success(let cryptos):
            view?.update(with: cryptos)
            
        case .failure(let error):
            view?.update(with: error.localizedDescription)
            //view.update
    }
}
}
