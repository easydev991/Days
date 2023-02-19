enum ItemSort: String {
    case title, date
}

enum SortBy: CaseIterable {
    case dateAscending
    case dateDescending
    case titleAscending
    case titleDescending

    var title: String {
        switch self {
        case .dateAscending:
            return Text.Alert.dateAscending.localized
        case .dateDescending:
            return Text.Alert.dateDescending.localized
        case .titleAscending:
            return Text.Alert.titleAscending.localized
        case .titleDescending:
            return Text.Alert.titleDescending.localized
        }
    }
}

struct ItemSortModel {
    var sortBy: ItemSort
    var ascending: Bool

    init(_ sort: SortBy) {
        switch sort {
        case .dateAscending:
            self.sortBy = .date
            self.ascending = true
        case .dateDescending:
            self.sortBy = .date
            self.ascending = false
        case .titleAscending:
            self.sortBy = .title
            self.ascending = true
        case .titleDescending:
            self.sortBy = .title
            self.ascending = false
        }
    }

    var sorting: SortBy {
        switch sortBy {
        case .title:
            return ascending ? .titleAscending : .titleDescending
        case .date:
            return ascending ? .dateAscending : .dateDescending
        }
    }
}
