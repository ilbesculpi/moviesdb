//
//  Application container to register/provide dependencies
//

import Foundation
import Swinject

class AppContainer {
    
    //static var instance: AppContainer = AppContainer()
    static var container: Container = Container()

    private init() {
        
    }
    
    static func bootstrap() {
        registerViewModels()
    }
    
    static func registerViewModels() {
        
        container.register(MovieListViewModelContract.self) { _ in
            MovieListViewModel()
        }
        
    }
    
    static func configure(_ viewController: MovieListViewController) {
        viewController.viewModel = container.resolve(MovieListViewModelContract.self)
    }
    
}
