//
//  Router.swift
//  CryptoAppWithVIPER
//
//  Created by Bedirhan Altun on 19.09.2022.
//

import Foundation
import UIKit

//When we run the code, this file tells us to start location.
//(Uygulama ilk açıldığında hangi view gözükecek? Cevabını Router verir.)Diğer dosyaları orkestra eder.
//Entry Point
//Class,Protocol

//Swift artık nerede EntryPoint görürse bunu algılayacak.
typealias EntryPoint = UIViewController & AnyView

protocol AnyRouter{
    var entry: EntryPoint? {get}
    //Diğer dosyalardan bu fonksiyona erişebilmek için static olarak tanımlıyoruz.
    static func startExecution() -> AnyRouter
}

class CryptoRouter: AnyRouter{
    
    var entry: EntryPoint?
    
    static func startExecution() -> AnyRouter {
        
        let router = CryptoRouter()
        var RouterView: AnyView = CryptoViewController()
        var RouterPresenter: AnyPresenter = CryptoPresenter()
        var RouterInteractor: AnyInteractor = CryptoInteractor()
        
        RouterView.presenter = RouterPresenter
        
        RouterPresenter.view = RouterView
        RouterPresenter.interactor = RouterInteractor
        RouterPresenter.router = router
        
        RouterInteractor.presenter = RouterPresenter
        
        router.entry = RouterView as? EntryPoint
        
        return router
    }
    
    
}

