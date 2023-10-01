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
            Text.Alert.dateAscending.localized
        case .dateDescending:
            Text.Alert.dateDescending.localized
        case .titleAscending:
            Text.Alert.titleAscending.localized
        case .titleDescending:
            Text.Alert.titleDescending.localized
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
            ascending ? .titleAscending : .titleDescending
        case .date:
            ascending ? .dateAscending : .dateDescending
        }
    }
}
