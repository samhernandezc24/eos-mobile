class DropListModel {
  DropListModel(this.listOptionItems);
  final List<OptionItem> listOptionItems;
}

class OptionItem {
  OptionItem({required this.title, this.id});
  final String? id;
  final String title;
}
