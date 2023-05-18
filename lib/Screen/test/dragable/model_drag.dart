class DraggableList {
  final HeaderModel header;
  final List<DraggableListItem> items;

  const DraggableList({
    required this.header,
    required this.items,
  });
}

class DraggableListItem {
  final int status;
  final String title;
  final String urlImage;

  const DraggableListItem({
    required this.status,
    required this.title,
    required this.urlImage,
  });
}

class HeaderModel {
  final String header;
  final int id;


  const HeaderModel({
    required this.header,
    required this.id,
  });
}