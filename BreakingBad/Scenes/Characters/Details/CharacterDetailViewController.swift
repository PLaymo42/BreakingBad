//
//  CharacterDetailViewController.swift
//  BreakingBad
//
//  Created by Anthony Soulier on 29/11/2021.
//

import Foundation
import UIKit
import BreakingBadAppDomain
import Combine

class CharacterDetailViewModel: ObservableObject {

    private let useCase: CharacterDetailUseCase
    private let imageFetcher: ImageCacheLoader

    init(useCase: CharacterDetailUseCase, imageFetcher: ImageCacheLoader) {
        self.useCase = useCase
        self.imageFetcher = imageFetcher
    }

    @Published var model: CharacterDetailViewController.Model?

    func load(id: Int) {
        Task {
            guard let character = try? await useCase.get(id: id) else {
                return
            }

            let model = CharacterDetailViewController.Model(
                title: character.infos.name,
                header: .init(
                    nickname: "a.k.a \(character.infos.nickname)",
                    birthday: character.infos.birthday,
                    playedBy: "Played by: \(character.infos.portrayed)",
                    headshot: nil,
                    statusImage: image(forStatus: character.infos.status),
                    statusImageColor: color(forStatus: character.infos.status)
                ),
                quotes: character.quotes.map { $0.quote }
            )
            DispatchQueue.main.async {
                self.model = model
            }

            if let url = character.infos.headshotURL,
               let image = try? await imageFetcher.image(forURL: url) {
                DispatchQueue.main.async {
                    var model = self.model
                    model?.header.headshot = image
                    self.model = model
                }
            }

        }
    }

    private func image(forStatus status: CharacterEntity.Status) -> UIImage? {
        switch status {
        case .alive:
            return UIImage(systemName: "heart.fill")
        case .presumedDead, .dead:
            return UIImage(systemName: "heart.slash")
        case .unknown:
            return UIImage(systemName: "questionmark")
        }
    }

    private func color(forStatus status: CharacterEntity.Status) -> UIColor {
        switch status {
        case .alive:
            return .systemRed
        case .presumedDead, .dead, .unknown:
            return .systemGray
        }
    }
}

class CharacterDetailViewController: UIViewController {

    enum Section {
        case header
        case quotes
    }

    struct Model {
        var title: String
        var header: CharacterDetailHeaderTableViewCell.Model
        var quotes: [String]
    }

    private let characterId: Int

    private var viewModel: CharacterDetailViewModel
    private var cancellables = Set<AnyCancellable>()

    private let tableView = UITableView()

    private lazy var dataSource = UITableViewDiffableDataSource<Section, AnyHashable>(
        tableView: tableView,
        cellProvider: { tableView, indexPath, item in

            switch item {
            case let header as CharacterDetailHeaderTableViewCell.Model:

                guard let cell = tableView.dequeueReusableCell(withIdentifier: "CharacterDetailHeaderTableViewCell") as? CharacterDetailHeaderTableViewCell else {
                    return UITableViewCell()
                }

                cell.set(model: header)

                return cell
            case let quote as String:
                guard let cell = tableView.dequeueReusableCell(withIdentifier: "QuoteCell") else {
                    return UITableViewCell()
                }

                var content = UIListContentConfiguration.valueCell()
                content.text = quote
                content.textProperties.font = .preferredFont(forTextStyle: .body)
                cell.contentConfiguration = content

                cell.selectionStyle = .none

                return cell
            default:
                return UITableViewCell()
            }
        })

    init(characterId: Int, viewModel: CharacterDetailViewModel) {
        self.viewModel = viewModel
        self.characterId = characterId
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        setup()
        viewModel.load(id: characterId)
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
            UINib(nibName: "CharacterDetailHeaderTableViewCell", bundle: .main),
            forCellReuseIdentifier: "CharacterDetailHeaderTableViewCell"
        )

        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "QuoteCell")
    }

    func bind() {
        viewModel.$model
            .receive(on: DispatchQueue.main)
            .sink { model in

                self.title = model?.title

                var snapshot = NSDiffableDataSourceSnapshot<Section, AnyHashable>()
                snapshot.appendSections([.header, .quotes])

                guard let model = model else {
                    self.dataSource.apply(snapshot, animatingDifferences: false)
                    return
                }

                snapshot.appendItems([model.header], toSection: .header)
                snapshot.appendItems(model.quotes, toSection: .quotes)

                self.dataSource.apply(snapshot, animatingDifferences: false)
            }
            .store(in: &cancellables)
    }
}
