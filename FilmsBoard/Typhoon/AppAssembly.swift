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
                #selector(AppCoordinator.init(
                    tabsCoordinatorProvider:mapCoordinatorProvider:listsCoordinatorProvider:aboutCoordinatorProvider:))) { (initializer) in
                        initializer?.injectParameter(with: self)
                        initializer?.injectParameter(with: self)
                        initializer?.injectParameter(with: self)
                        initializer?.injectParameter(with: self)
                }
            definition?.scope = .singleton
        }
    }

    @objc
    public dynamic func tabsCoordinator() -> Any {
        return TyphoonDefinition.withClass(TabsCoordinator.self) { (definition) in
            definition?.useInitializer(
                #selector(TabsCoordinator.init(
                    mediaItemsTabCoordinatorProvider:searchTabCoordinatorProvider:))) { (initializer) in
                        initializer?.injectParameter(with: self)
                        initializer?.injectParameter(with: self)
            }
            definition?.scope = .prototype
        }
    }

    @objc
    public dynamic func mediaItemsTabCoordinator() -> Any {
        return TyphoonDefinition.withClass(MediaItemsTabCoordinator.self) { (definition) in
            definition?.useInitializer(
                #selector(MediaItemsTabCoordinator.init(mediaItemsViewModelProvider:
                    mediaItemsCategoryViewModelProvider:detailFilmViewModelProvider:trailerCoordinatorProvider:))) { (initializer) in
                        initializer?.injectParameter(with: self)
                        initializer?.injectParameter(with: self)
                        initializer?.injectParameter(with: self)
                        initializer?.injectParameter(with: self)
            }
            definition?.scope = .prototype
        }
    }

    @objc
    public dynamic func searchTabCoordinator() -> Any {
        return TyphoonDefinition.withClass(SearchTabCoordinator.self) { (definition) in
            definition?.useInitializer(
                #selector(SearchTabCoordinator.init(searchViewModelProvider:detailFilmViewModelProvider:trailerCoordinatorProvider:))) { (initializer) in
                    initializer?.injectParameter(with: self)
                    initializer?.injectParameter(with: self)
                    initializer?.injectParameter(with: self)
                }
            definition?.scope = .prototype
        }
    }

    @objc
    public dynamic func mapCoordinator() -> Any {
        return TyphoonDefinition.withClass(MapCoordinator.self) { (definition) in
            definition?.useInitializer(
                #selector(MapCoordinator.init(mapViewModel:))) { (initializer) in
                    initializer?.injectParameter(with: self.mapViewModel())
                }
            definition?.scope = .prototype
        }
    }

    @objc
    public dynamic func listsCoordinator() -> Any {
        return TyphoonDefinition.withClass(ListsCoordinator.self) { (definition) in
            definition?.useInitializer(
            #selector(ListsCoordinator.init(listsViewModelProvider:detailedListViewModelProvider:detailFilmViewModelProvider:trailerCoordinatorProvider:))) { (initializer) in
                initializer?.injectParameter(with: self)
                initializer?.injectParameter(with: self)
                initializer?.injectParameter(with: self)
                initializer?.injectParameter(with: self)
            }
            definition?.scope = .prototype
        }
    }

    @objc
    public dynamic func aboutCoordinator() -> Any {
        return TyphoonDefinition.withClass(AboutCoordinator.self) { (definition) in
            definition?.scope = .prototype
        }
    }

    @objc
    public dynamic func mediaItemsViewModel() -> Any {
        return TyphoonDefinition.withClass(MediaItemsViewModel.self) { (definition) in
            definition?.useInitializer(
                #selector(MediaItemsViewModel.init(storage:apiManagerProvider:))) { (initializer) in
                    initializer?.injectParameter(with: self.mediaItemsStorage())
                    initializer?.injectParameter(with: self)
                }
            definition?.scope = .prototype
        }
    }

    @objc
    public dynamic func mediaItemsCategoryViewModel() -> Any {
        return TyphoonDefinition.withClass(MediaItemsCategoryViewModel.self) { (definition) in
            definition?.useInitializer(
                #selector(MediaItemsCategoryViewModel.init(storage:apiManagerProvider:))) { (initializer) in
                    initializer?.injectParameter(with: self.mediaItemsStorage())
                    initializer?.injectParameter(with: self)
                }
            definition?.scope = .prototype
        }
    }

    @objc
    public dynamic func searchViewModel() -> Any {
        return TyphoonDefinition.withClass(SearchViewModel.self) { (definition) in
            definition?.useInitializer(
            #selector(SearchViewModel.init(storage:apiManagerProvider:))) { (initializer) in
                initializer?.injectParameter(with: self.mediaItemsStorage())
                initializer?.injectParameter(with: self)
            }
            definition?.scope = .prototype
        }
    }

    @objc
    public dynamic func detailFilmViewModel() -> Any {
        return TyphoonDefinition.withClass(DetailFilmViewModel.self) { (definition) in
            definition?.useInitializer(
            #selector(DetailFilmViewModel.init(storage:db:apiManagerProvider:notificationsManager:))) { (initializer) in
                    initializer?.injectParameter(with: self.mediaItemsStorage())
                    initializer?.injectParameter(with: self.sqliteDatabase())
                    initializer?.injectParameter(with: self)
                    initializer?.injectParameter(with: self.notificationsManager())
                }
            definition?.scope = .prototype
        }
    }

    @objc
    public dynamic func mapViewModel() -> Any {
        return TyphoonDefinition.withClass(MapViewModel.self) { (definition) in
            definition?.scope = .prototype
        }
    }
    
    @objc
    public dynamic func trailerCoordinator() -> Any {
        return TyphoonDefinition.withClass(TrailerCoordinator.self) { (definition) in
            definition?.useInitializer(
            #selector(TrailerCoordinator.init(viewModelProvider:))) { (initializer) in
                initializer?.injectParameter(with: self)
            }
            definition?.scope = .prototype
        }
    }

    @objc
    public dynamic func trailerViewModel() -> Any {
        return TyphoonDefinition.withClass(TrailerViewModel.self) { (definition) in
            definition?.useInitializer(
            #selector(TrailerViewModel.init(storage:apiManagerProvider:))) { (initializer) in
                initializer?.injectParameter(with: self.mediaItemsStorage())
                initializer?.injectParameter(with: self)
            }
            definition?.scope = .prototype
        }
    }

    @objc
    public dynamic func listsViewModel() -> Any {
        return TyphoonDefinition.withClass(ListsViewModel.self) { (definition) in
            definition?.useInitializer(
            #selector(ListsViewModel.init(database:))) { (initializer) in
                initializer?.injectParameter(with: self.sqliteDatabase())
            }
            definition?.scope = .prototype
        }
    }

    @objc
    public dynamic func detailedListViewModel() -> Any {
        return TyphoonDefinition.withClass(DetailedListViewModel.self) { (definition) in
            definition?.useInitializer(
            #selector(DetailedListViewModel.init(storage:database:))) { (initializer) in
                initializer?.injectParameter(with: self.mediaItemsStorage())
                initializer?.injectParameter(with: self.sqliteDatabase())
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
            definition?.scope = .prototype
        }
    }

    @objc
    public dynamic func moviesAPIManager() -> Any {
        return TyphoonDefinition.withClass(MoviesAPIManager.self) { (definition) in
            definition?.useInitializer(
                #selector(MoviesAPIManager.init(storage:apiCommunicatorProvider:))) { (initializer) in
                    initializer?.injectParameter(with: self.mediaItemsStorage())
                    initializer?.injectParameter(with: self)
                }
            definition?.scope = .singleton
        }
    }

    @objc
    public dynamic func moviesAPICommunicator() -> Any {
        return TyphoonDefinition.withClass(MoviesAPICommunicator.self) { (definition) in
            definition?.useInitializer(
                #selector(MoviesAPICommunicator.init(networkReachability:))) { (initializer) in
                    initializer?.injectParameter(with: self.networkReachability())
                }
            definition?.scope = .singleton
        }
    }

    @objc
    public dynamic func networkReachability() -> Any {
        return TyphoonDefinition.withClass(NetworkReachability.self) { (definition) in
            definition?.scope = .singleton
        }
    }

    @objc
    public dynamic func notificationsManager() -> Any {
        return TyphoonDefinition.withClass(NotificationsManager.self) { (definition) in
            definition?.useInitializer(
                #selector(NotificationsManager.init(db:))) { (initializer) in
                    initializer?.injectParameter(with: self.sqliteDatabase())
                }
            definition?.scope = .singleton
        }
    }
}
