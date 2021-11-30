//
//  ViewController.swift
//  BreakingBad
//
//  Created by Anthony Soulier on 26/11/2021.
//

import UIKit
import Combine

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
            cell.accessoryType = .disclosureIndicator
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
        viewModel.load()
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
        tableView.delegate = self
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

extension CharacterListViewController: UITableViewDelegate {

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {

        guard let character = dataSource.itemIdentifier(for: indexPath) else {
            return
        }

        viewModel.router.openDetail(id: character.id)
        
    }

}
