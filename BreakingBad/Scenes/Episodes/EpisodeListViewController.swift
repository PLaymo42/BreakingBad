//
//  ViewController.swift
//  BreakingBad
//
//  Created by Anthony Soulier on 26/11/2021.
//

import UIKit
import Combine
import BreakingBadAppDomain
import SwiftUI

//class EpisodeListViewController: UIHostingController<SeasonListView> {
//
//    init(viewModel: SeasonListViewModel) {
//        super.
//    }
//
//    @MainActor @objc required dynamic init?(coder aDecoder: NSCoder) {
//        fatalError("init(coder:) has not been implemented")
//    }
//
//}

//class EpisodeListViewModel: ListViewModel, ObservableObject {
//
//    typealias OUT = CharacterTableViewCell.Model
//
//    private let useCase: EpisodeListUseCase
//    private let imageLoader: ImageCacheLoader
//    var cellProvider: UITableViewDiffableDataSource<Section, CharacterTableViewCell.Model>.CellProvider
//
//    init(useCase: EpisodeListUseCase, imageLoader: ImageCacheLoader) {
//        self.useCase = useCase
//        self.imageLoader = imageLoader
//
//        cellProvider = { tableView, indexPath, item in
//            guard let cell = tableView.dequeueReusableCell(withIdentifier: "CharacterTableViewCell") as? CharacterTableViewCell else {
//                return UITableViewCell()
//            }
//            cell.set(model: item)
//            //            Task { await self.viewModel.fetchImage(for: item) }
//            return cell
//        }
//    }
//
//    @Published private var _items: [CharacterTableViewCell.Model] = []
//
//    var items: Published<[CharacterTableViewCell.Model]>.Publisher {
//        $_items
//    }
//
//    func load() async {
//        do {
//            let fetched = try await useCase.get()
//            _items = fetched.map { .init(name: $0.title) }
//
//        } catch {
//            print(error)
//        }
//    }
//
//    func fetchImage(for item: CharacterTableViewCell.Model) async {
//        guard let url = item.imageURL, item.image == nil,
//              let index = _items.firstIndex(of: item) else { return }
//
//        let image = try? await imageLoader.image(forURL: url)
//        var item = item
//        item.image = image
//        self._items[index] = item
//    }
//}
//
//protocol ListViewModel {
//    associatedtype OUT: Hashable
//    var items: Published<[OUT]>.Publisher { get }
//    func load() async
//
//    var cellProvider: UITableViewDiffableDataSource<Section, OUT>.CellProvider { get }
//}
//
//enum Section {
//    case main
//}
//
//class EpisodeListViewController<ViewModel: ListViewModel>: UIViewController
//where ViewModel.OUT == CharacterTableViewCell.Model {
//
//
//
//    private let tableView = UITableView()
//
//    private let viewModel: ViewModel
//    private var cancellables = Set<AnyCancellable>()
//
//
//    private lazy var dataSource = UITableViewDiffableDataSource<Section, ViewModel.OUT>(
//        tableView: tableView,
//        cellProvider: viewModel.cellProvider
//    )
//
//
//    init(viewModel: ViewModel) {
//        self.viewModel = viewModel
//        super.init(nibName: nil, bundle: nil)
//    }
//
//    required init?(coder: NSCoder) {
//        fatalError("init(coder:) has not been implemented")
//    }
//
//    override func viewDidLoad() {
//        super.viewDidLoad()
//
//        setup()
//        Task { await viewModel.load() }
//    }
//
//    func setup() {
//        setupHierarchy()
//        setupAutolayout()
//        setupUI()
//        bind()
//    }
//
//    func setupHierarchy() {
//        view.addSubview(tableView)
//    }
//
//    func setupAutolayout() {
//        tableView.translatesAutoresizingMaskIntoConstraints = false
//        NSLayoutConstraint.activate([
//            tableView.topAnchor.constraint(equalTo: view.topAnchor),
//            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
//            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
//            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
//        ])
//    }
//
//    func setupUI() {
//
//        tableView.register(
//            UINib(nibName: "CharacterTableViewCell", bundle: .main),
//            forCellReuseIdentifier: "CharacterTableViewCell"
//        )
//        tableView.dataSource = dataSource
//        tableView.rowHeight = 100
//    }
//
//    func bind() {
//
//        viewModel.items
//            .receive(on: DispatchQueue.main)
//            .sink { items in
//                var snapshot = NSDiffableDataSourceSnapshot<Section, ViewModel.OUT>()
//                snapshot.appendSections([.main])
//                snapshot.appendItems(items, toSection: .main)
//                self.dataSource.apply(snapshot, animatingDifferences: false)
//            }
//            .store(in: &cancellables)
//    }
//}
//
