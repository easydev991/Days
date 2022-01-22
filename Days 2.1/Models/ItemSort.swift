enum ItemSort: String {
    case itemName, date
}

enum SortBy {
    case dateAscending
    case dateDescending
    case titleAscending
    case titleDescending
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
