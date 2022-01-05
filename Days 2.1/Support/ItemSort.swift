enum ItemSort: String {
    case itemName, date
}

struct ItemSortModel {
    var sortBy: ItemSort
    var ascending: Bool
}
