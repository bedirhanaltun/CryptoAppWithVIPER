//
//  Interactor.swift
//  CryptoAppWithVIPER
//
//  Created by Bedirhan Altun on 19.09.2022.
//

import Foundation

//Class, protocol
//Talks to --> Presenter

protocol AnyInteractor{
    var presenter: AnyPresenter?{get set}
    
    func downloadCryptos()
}

class CryptoInteractor: AnyInteractor{

    var presenter: AnyPresenter?
    func downloadCryptos() {
        guard let url = URL(string: "https://raw.githubusercontent.com/atilsamancioglu/K21-JSONDataSet/master/crypto.json")
        else{
            return
        }
        let task = URLSession.shared.dataTask(with: url) { [weak self] data, response, error in
            
            guard let data = data, error == nil else{
                self?.presenter?.interactorDidDownloandCrypto(result: .failure(NetworkError.NetworkFailed))
                return
            }
            
            do{
                let cryptos = try JSONDecoder().decode([Crypto].self, from: data)
                self?.presenter?.interactorDidDownloandCrypto(result: .success(cryptos))
                
            }
            catch{
                self?.presenter?.interactorDidDownloandCrypto(result: .failure(NetworkError.ParsingFailed))
            }
        }
        task.resume()
    }
    
    
}
