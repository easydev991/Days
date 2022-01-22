enum ItemSort: String {
    case itemName, date
}

enum SortBy: CaseIterable {
    case dateAscending
    case dateDescending
    case titleAscending
    case titleDescending

    var title: String {
        switch self {
        case .dateAscending:
            return Text.Button.dateAscending.text
        case .dateDescending:
            return Text.Button.dateDescending.text
        case .titleAscending:
            return Text.Button.titleAscending.text
        case .titleDescending:
            return Text.Button.titleDescending.text
        }
    }
}

struct ItemSortModel {
    var sortBy: ItemSort
    var ascending: Bool

    init(_ sort: SortBy) {
        switch sort {
        case .dateAscending:
            sortBy = .date
            ascending = true
        case .dateDescending:
            sortBy = .date
            ascending = false
        case .titleAscending:
            sortBy = .itemName
            ascending = true
        case .titleDescending:
            sortBy = .itemName
            ascending = false
        }
    }

    var sorting: SortBy {
        switch sortBy {
        case .itemName:
            return ascending ? .titleAscending : .titleDescending
        case .date:
            return ascending ? .dateAscending : .dateDescending
        }
    }
}
