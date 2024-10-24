// This Source Code Form is subject to the terms of the Mozilla Public
// License, v. 2.0. If a copy of the MPL was not distributed with this
// file, You can obtain one at http://mozilla.org/MPL/2.0/

import XCTest

@testable import Client

final class HomepageDiffableDataSourceTests: XCTestCase {
    var collectionView: UICollectionView?
    var diffableDataSource: HomepageDiffableDataSource?

    override func setUpWithError() throws {
        try super.setUpWithError()

        collectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
        let collectionView = try XCTUnwrap(collectionView)
        diffableDataSource = HomepageDiffableDataSource(
            collectionView: collectionView
        ) { (collectionView, indexPath, item) -> UICollectionViewCell? in
            return UICollectionViewCell()
        }
    }

    override func tearDown() {
        diffableDataSource = nil
        collectionView = nil
        super.tearDown()
    }

    // MARK: - applyInitialSnapshot
    func test_applyInitialSnapshot_hasCorrectData() throws {
        let dataSource = try XCTUnwrap(diffableDataSource)

        dataSource.applyInitialSnapshot()

        let snapshot = dataSource.snapshot()
        XCTAssertEqual(snapshot.numberOfSections, 3)
        XCTAssertEqual(snapshot.sectionIdentifiers, [.header, .topSites, .pocket])

        XCTAssertEqual(snapshot.itemIdentifiers(inSection: .header).count, 3)
        XCTAssertEqual(snapshot.itemIdentifiers(inSection: .topSites).count, 2)
        XCTAssertEqual(snapshot.itemIdentifiers(inSection: .pocket).count, 1)
    }

    // MARK: - updateHeaderSection
    func test_updateHeaderSection_hasCorrectData() throws {
        let dataSource = try XCTUnwrap(diffableDataSource)

        dataSource.applyInitialSnapshot()
        dataSource.updateHeaderSection()

        let snapshot = dataSource.snapshot()
        XCTAssertEqual(snapshot.numberOfSections, 3)
        XCTAssertEqual(snapshot.sectionIdentifiers, [.header, .topSites, .pocket])

        XCTAssertEqual(snapshot.itemIdentifiers(inSection: .header).count, 1)
        XCTAssertEqual(snapshot.itemIdentifiers(inSection: .topSites).count, 2)
        XCTAssertEqual(snapshot.itemIdentifiers(inSection: .pocket).count, 1)
    }

    func test_updateHeaderSection_withoutInitialSection_hasCorrectData() throws {
        let dataSource = try XCTUnwrap(diffableDataSource)

        dataSource.updateHeaderSection()

        let snapshot = dataSource.snapshot()
        XCTAssertEqual(snapshot.numberOfSections, 1)
        XCTAssertEqual(snapshot.sectionIdentifiers, [.header])
        XCTAssertEqual(snapshot.itemIdentifiers(inSection: .header).count, 1)
    }
}
