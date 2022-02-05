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
            sortBy = .title
            ascending = true
        case .titleDescending:
            sortBy = .title
            ascending = false
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