//
//  AppAssembly.swift
//  FilmsBoard
//
//  Created by Pablo on 07/03/2018.
//  Copyright © 2018 Pablo. All rights reserved.
//

import Foundation
import Typhoon

@objc
class AppAssembly: TyphoonAssembly {

    @objc
    public dynamic func appCoordinator() -> Any {
        return TyphoonDefinition.withClass(AppCoordinator.self) { (definition) in
            definition?.useInitializer(
                #selector(AppCoordinator.init(tabsCoordinatorProvider:))) { (initializer) in
                    initializer?.injectParameter(with: self)
                }
            definition?.scope = .singleton
        }
    }
    

    
    
    @objc
    public dynamic func detailFilmViewModel() -> Any {
        return TyphoonDefinition.withClass(DetailFilmViewModel.self) { (definition) in
            definition?.useInitializer(
            #selector(DetailFilmViewModel.init(storage:database:dateUtils:))) { (initializer) in
                initializer?.injectParameter(with: self.mediaItemsStorage())
                initializer?.injectParameter(with: self.sqliteDatabase())
                initializer?.injectParameter(with: self.dateUtils())
            }
            definition?.scope = .prototype
        }
    }
    
    
    

    @objc
    public dynamic func tabsCoordinator() -> Any {
        return TyphoonDefinition.withClass(TabsCoordinator.self) { (definition) in
            definition?.useInitializer(
                #selector(TabsCoordinator.init(mediaItemsTabCoordinatorProvider:))) { (initializer) in
                    initializer?.injectParameter(with: self)
                }
            definition?.scope = .prototype
        }
    }

    @objc
    public dynamic func mediaItemsTabCoordinator() -> Any {
        return TyphoonDefinition.withClass(MediaItemsTabCoordinator.self) { (definition) in
            definition?.useInitializer(
            #selector(MediaItemsTabCoordinator.init(viewModel:detailFilmViewModelProvider:trailerCoordinatorProvider:))) { (initializer) in
                    initializer?.injectParameter(with: self.mediaItemsViewModel())
                    initializer?.injectParameter(with: self)
                    initializer?.injectParameter(with: self)
                }
            definition?.scope = .prototype
        }
    }
    
    

    @objc
    public dynamic func mediaItemsViewModel() -> Any {
        return TyphoonDefinition.withClass(MediaItemsViewModel.self) { (definition) in
            definition?.useInitializer(
                #selector(MediaItemsViewModel.init(storage:))) { (initializer) in
                    initializer?.injectParameter(with: self.mediaItemsStorage())
                }
            definition?.scope = .prototype
        }
    }
    
    @objc
    public dynamic func trailerCoordinator() -> Any {
        return TyphoonDefinition.withClass(TrailerCoordinator.self) { (definition) in
            definition?.useInitializer(
            #selector(TrailerCoordinator.init(viewModel:))) { (initializer) in
                initializer?.injectParameter(with: self.trailerViewModel())
            }
            definition?.scope = .prototype
        }
    }
    
    
    
    @objc
    public dynamic func trailerViewModel() -> Any {
        return TyphoonDefinition.withClass(TrailerViewModel.self) { (definition) in
            definition?.useInitializer(
            #selector(TrailerViewModel.init(storage:))) { (initializer) in
                initializer?.injectParameter(with: self.mediaItemsStorage())
            }
            definition?.scope = .prototype
        }
    }
    
    
    @objc
    public dynamic func listsViewModel() -> Any {
        return TyphoonDefinition.withClass(ListsViewModel.self) { (definition) in
            definition?.useInitializer(
            #selector(ListsViewModel.init(database:))) { (initializer) in
                initializer?.injectParameter(with: self.mediaItemsStorage())
            }
            definition?.scope = .prototype
        }
    }
    

    @objc
    public dynamic func mediaItemsStorage() -> Any {
        return TyphoonDefinition.withClass(MediaItemsStorage.self) { (definition) in
            definition?.scope = .singleton
        }
    }
    
    
    @objc
    public dynamic func sqliteDatabase() -> Any {
        return TyphoonDefinition.withClass(SQLiteDatabase.self) { (definition) in
            definition?.useInitializer(
            #selector(SQLiteDatabase.init))
            
            definition?.scope = .prototype
        }
    }
    
    @objc
    public dynamic func dateUtils() -> Any {
        return TyphoonDefinition.withClass(DateUtils.self) { (definition) in
            definition?.scope = .singleton
        }
    }
}
