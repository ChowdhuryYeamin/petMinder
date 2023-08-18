//
//  ReminderListViewController.swift
//  petMinder
//
//  Created by Yamin Ayon on 8/16/23.
//
//
//import UIKit
//
//
//class ReminderListViewController: UICollectionViewController {
//    var dataSource: DataSource!
//    var reminders: [Reminder] = Reminder.sampleData
//
//
//    override func viewDidLoad() {
//        super.viewDidLoad()
//
//
//        let listLayout = listLayout()
//        collectionView.collectionViewLayout = listLayout
//
//
//        let cellRegistration = UICollectionView.CellRegistration(handler: cellRegistrationHandler)
//
//
//        dataSource = DataSource(collectionView: collectionView) {
//            (collectionView: UICollectionView, indexPath: IndexPath, itemIdentifier: Reminder.ID) in
//            return collectionView.dequeueConfiguredReusableCell(
//                using: cellRegistration, for: indexPath, item: itemIdentifier)
//        }
//
//
//        updateSnapshot()
//
//
//        collectionView.dataSource = dataSource
//    }
//
//
//    func pushDetailViewForReminder(withId id: Reminder.ID) {
//    }
//
//
//    private func listLayout() -> UICollectionViewCompositionalLayout {
//        var listConfiguration = UICollectionLayoutListConfiguration(appearance: .grouped)
//        listConfiguration.showsSeparators = false
//        listConfiguration.backgroundColor = .clear
//        return UICollectionViewCompositionalLayout.list(using: listConfiguration)
//    }
//}
