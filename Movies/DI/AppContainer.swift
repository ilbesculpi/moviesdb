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
        registerServices()
        registerViewModels()
    }
    
    static func registerViewModels() {
        
        container.register(MovieListViewModelContract.self) { _ in
            let repository = container.resolve(MovieService.self)!
            return MovieListViewModel(repository: repository)
        }
        
    }
    
    static func registerServices() {
        
        container.register(MovieService.self) { _ in
            MovieServiceImpl()
        }
        
    }
    
    static func configure(_ viewController: MovieListViewController) {
        if let viewModel = container.resolve(MovieListViewModelContract.self) {
            viewController.viewModel = viewModel
            viewModel.view = viewController
        }
    }
    
}
