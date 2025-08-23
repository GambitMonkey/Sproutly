//
//  JournalViewController.swift
//  Sproutly
//
//  Created by Deniz Turan Çağlarca on 20.08.2025.
//

import UIKit

final class JournalViewController: UIViewController {
    private let repository: JournalRepositoryProtocol
    
    private let journalTitleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = Strings.Journal.journalTitle
        label.font = .systemFont(ofSize: 24, weight: .bold)
        return label
    }()
    
    private let textView: UITextView = {
        let tv = UITextView()
        tv.layer.borderColor = UIColor.systemGray4.cgColor
        tv.layer.borderWidth = 1
        tv.layer.cornerRadius = 8
        tv.font = .systemFont(ofSize: 16)
        return tv
    }()
    
    private let journalEntryLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = Strings.Journal.journalEntryTitle
        label.font = .systemFont(ofSize: 18, weight: .semibold)
        return label
    }()
    
    private var entries: [JournalEntry] = []
    private let tableView = UITableView()
    
    init(repository: JournalRepositoryProtocol) {
        self.repository = repository
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) { fatalError("init(coder:) has not been implemented") }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        
        setupUI()
        loadEntries()
    }
    
    private func setupUI() {
        let saveButton = UIButton(type: .system)
        saveButton.setTitle("Save", for: .normal)
        saveButton.addTarget(self, action: #selector(saveEntry), for: .touchUpInside)
        
        let stack = UIStackView(arrangedSubviews: [journalTitleLabel, textView, saveButton])
        stack.axis = .vertical
        stack.spacing = 8
        stack.translatesAutoresizingMaskIntoConstraints = false
        
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.dataSource = self
        tableView.delegate = self
        
        view.addSubview(stack)
        view.addSubview(journalEntryLabel)
        view.addSubview(tableView)
        
        NSLayoutConstraint.activate([
            stack.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 12),
            stack.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 12),
            stack.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -12),
            textView.heightAnchor.constraint(equalToConstant: 100),
            
            journalEntryLabel.topAnchor.constraint(equalTo: stack.bottomAnchor, constant: 12),
            journalEntryLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 12),
            journalEntryLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            
            tableView.topAnchor.constraint(equalTo: journalEntryLabel.bottomAnchor, constant: 12),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
    
    private func loadEntries() {
        entries = repository.fetchEntries()
        tableView.reloadData()
    }
    
    @objc private func saveEntry() {
        guard !textView.text.isEmpty else { return }
        repository.addEntry(text: textView.text)
        textView.text = ""
        loadEntries()
    }
}

extension JournalViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if entries.isEmpty {
            let emptyLabel = UILabel()
            emptyLabel.text = Strings.Journal.journalNoEntryText
            emptyLabel.textAlignment = .center
            tableView.backgroundView = emptyLabel
        } else {
            tableView.backgroundView = nil
        }
        return entries.count
    }
    
    func tableView(_ tableView: UITableView,
                   cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .subtitle, reuseIdentifier: nil)
        let entry = entries[indexPath.row]
        cell.textLabel?.text = entry.text
        cell.textLabel?.numberOfLines = 0
        if let date = entry.date {
            let formatter = DateFormatter()
            formatter.dateStyle = .medium
            formatter.timeStyle = .short
            cell.detailTextLabel?.text = formatter.string(from: date)
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView,
                   commit editingStyle: UITableViewCell.EditingStyle,
                   forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            let entry = entries[indexPath.row]
            repository.deleteEntry(entry)
            loadEntries()
        }
    }
}
