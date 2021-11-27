//
//  ViewController.swift
//  BreakingBad
//
//  Created by Anthony Soulier on 26/11/2021.
//

import UIKit
import Combine
import BreakingBadAppDomain

class CharacterListViewModel: ObservableObject {

    private let useCase: CharacterListUseCase
    private let imageLoader: ImageCacheLoader

    init(useCase: CharacterListUseCase, imageLoader: ImageCacheLoader) {
        self.useCase = useCase
        self.imageLoader = imageLoader
    }

    @Published private(set) var items: [CharacterTableViewCell.Model] = []

    func load() async {
        items = ((try? await useCase.get()) ?? []).map { .init(name: $0.nickname, imageURL: $0.headshotURL) }
    }

    func fetchImage(for item: CharacterTableViewCell.Model) async {
        guard let url = item.imageURL, item.image == nil,
              let index = items.firstIndex(of: item) else { return }

        let image = try? await imageLoader.image(forURL: url)
        var item = item
        item.image = image
        self.items[index] = item
    }

}

class CharacterListViewController: UIViewController {

    enum Section {
        case main
    }

    private let tableView = UITableView()

    private let viewModel: CharacterListViewModel
    private var cancellables = Set<AnyCancellable>()

    private lazy var dataSource = UITableViewDiffableDataSource<Section, CharacterTableViewCell.Model>(
        tableView: tableView,
        cellProvider: { tableView, indexPath, item in
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "CharacterTableViewCell") as? CharacterTableViewCell else {
                return UITableViewCell()
            }
            cell.set(model: item)
            Task { await self.viewModel.fetchImage(for: item) }
            return cell
        })


    init(viewModel: CharacterListViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        setup()
        Task { await viewModel.load() }
    }

    func setup() {
        setupHierarchy()
        setupAutolayout()
        setupUI()
        bind()
    }

    func setupHierarchy() {
        view.addSubview(tableView)
    }

    func setupAutolayout() {
        tableView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.topAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])
    }

    func setupUI() {

        tableView.register(
            UINib(nibName: "CharacterTableViewCell", bundle: .main),
            forCellReuseIdentifier: "CharacterTableViewCell"
        )
        tableView.dataSource = dataSource
        tableView.rowHeight = 100
    }

    func bind() {

        viewModel.$items
            .receive(on: DispatchQueue.main)
            .sink { items in
                var snapshot = NSDiffableDataSourceSnapshot<Section, CharacterTableViewCell.Model>()
                snapshot.appendSections([.main])
                snapshot.appendItems(items, toSection: .main)
                self.dataSource.apply(snapshot, animatingDifferences: false)
            }
            .store(in: &cancellables)
    }
}

