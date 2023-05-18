import 'package:drag_and_drop_lists/drag_and_drop_item.dart';
import 'package:drag_and_drop_lists/drag_and_drop_list.dart';
import 'package:drag_and_drop_lists/drag_and_drop_lists.dart';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter/services.dart';
import 'package:salebee/Screen/test/dragable/data_drag.dart';
import 'package:salebee/Screen/test/dragable/model_drag.dart';

class MainPage extends StatefulWidget {
  @override
  _MainPage createState() => _MainPage();
}

class _MainPage extends State<MainPage> {
  late List<DragAndDropList> lists;
  List<DraggableList> newList = [];
  List<DraggableListItem> itemsss = [

      DraggableListItem(
        status: 3,
        title: 'Orange',
        urlImage:
        'https://images.unsplash.com/photo-1582979512210-99b6a53386f9?ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&ixlib=rb-1.2.1&auto=format&fit=crop&w=934&q=80',
      ),
    DraggableListItem(
      status: 3,
      title: 'Orange',
      urlImage:
      'https://images.unsplash.com/photo-1582979512210-99b6a53386f9?ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&ixlib=rb-1.2.1&auto=format&fit=crop&w=934&q=80',
    ),
    DraggableListItem(
      status: 3,
      title: 'Orange',
      urlImage:
      'https://images.unsplash.com/photo-1582979512210-99b6a53386f9?ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&ixlib=rb-1.2.1&auto=format&fit=crop&w=934&q=80',
    ),
    DraggableListItem(
      status: 3,
      title: 'Orange',
      urlImage:
      'https://images.unsplash.com/photo-1582979512210-99b6a53386f9?ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&ixlib=rb-1.2.1&auto=format&fit=crop&w=934&q=80',
    ),
    DraggableListItem(
      status: 3,
      title: 'Orange',
      urlImage:
      'https://images.unsplash.com/photo-1582979512210-99b6a53386f9?ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&ixlib=rb-1.2.1&auto=format&fit=crop&w=934&q=80',
    ),
    DraggableListItem(
      status: 3,
      title: 'Orange',
      urlImage:
      'https://images.unsplash.com/photo-1582979512210-99b6a53386f9?ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&ixlib=rb-1.2.1&auto=format&fit=crop&w=934&q=80',
    ), DraggableListItem(
      status: 1,
      title: 'Orange',
      urlImage:
      'https://images.unsplash.com/photo-1582979512210-99b6a53386f9?ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&ixlib=rb-1.2.1&auto=format&fit=crop&w=934&q=80',
    ),
    DraggableListItem(
      status: 1,
      title: 'Orange',
      urlImage:
      'https://images.unsplash.com/photo-1582979512210-99b6a53386f9?ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&ixlib=rb-1.2.1&auto=format&fit=crop&w=934&q=80',
    ), DraggableListItem(
      status: 2,
      title: 'Orange',
      urlImage:
      'https://images.unsplash.com/photo-1582979512210-99b6a53386f9?ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&ixlib=rb-1.2.1&auto=format&fit=crop&w=934&q=80',
    ),
    DraggableListItem(
      status: 4,
      title: 'Orange',
      urlImage:
      'https://images.unsplash.com/photo-1582979512210-99b6a53386f9?ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&ixlib=rb-1.2.1&auto=format&fit=crop&w=934&q=80',
    ),



      DraggableListItem(
        status: 2,
        title: 'Apple',
        urlImage:
        'https://images.unsplash.com/photo-1560806887-1e4cd0b6cbd6?ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&ixlib=rb-1.2.1&auto=format&fit=crop&w=3367&q=80',
      ),
      DraggableListItem(
        status: 4,
        title: 'Blueberries',
        urlImage:
        'https://images.unsplash.com/photo-1595231776515-ddffb1f4eb73?ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&ixlib=rb-1.2.1&auto=format&fit=crop&w=1950&q=80',
      ),

  ];
  List headerList = [
    HeaderModel(
        id: 1,
        header: "one frt"
    ),
    HeaderModel(
        id: 2,
        header: "two frt"
    ),

    HeaderModel(
        id: 3,
        header: "three frt"
    ),
    HeaderModel(
        id: 4,
        header: "four frt"
    ),
  ];
  List<DraggableList> result = [];
  makeNewList(){
    headerList.forEach((modelA) {
      var children = itemsss.where((modelB) => modelB.status == modelA.id).toList();
      result.add(DraggableList(
        header: modelA,
        items: children,
      ));
    });

    }


  @override
  void initState() {
    super.initState();
    makeNewList();


    lists = result.map(buildList).toList();
  }

  @override
  Widget build(BuildContext context) {
    final backgroundColor = Color.fromARGB(255, 243, 242, 248);

    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: AppBar(
        title: Text("Dragable"),
        centerTitle: true,
      ),
      body: Container(
        width: 1000,
        child: DragAndDropLists(
          listWidth: 250,

          axis: Axis.horizontal,
          // lastItemTargetHeight: 50,
          // addLastItemTargetHeightToTop: true,
          // lastListTargetSize: 30,
          listPadding: EdgeInsets.all(16),
          listInnerDecoration: BoxDecoration(
            color: Theme.of(context).canvasColor,
            borderRadius: BorderRadius.circular(10),
          ),
          children: lists,
          itemDivider: Divider(thickness: 2, height: 2, color: backgroundColor),
          itemDecorationWhileDragging: BoxDecoration(
            color: Colors.white,
            boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 4)],
          ),
          listDragHandle: buildDragHandle(isList: true),
          itemDragHandle: buildDragHandle(),
          onItemReorder: onReorderListItem,
          onListReorder: onReorderList,
        ),
      ),
    );
  }

  DragHandle buildDragHandle({bool isList = false}) {
    final verticalAlignment = isList
        ? DragHandleVerticalAlignment.top
        : DragHandleVerticalAlignment.center;
    final color = isList ? Colors.blueGrey : Colors.black26;

    return DragHandle(
      verticalAlignment: verticalAlignment,
      child: Container(
        padding: EdgeInsets.only(right: 10),
        child: Icon(Icons.menu, color: color),
      ),
    );
  }



  DragAndDropList buildList(DraggableList list) => DragAndDropList(

        header: Container(
          padding: EdgeInsets.all(8),
          child: Text(
            list.header.header,
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
          ),
        ),
        children: list.items
            .map((item) => DragAndDropItem(
                  child: ListTile(
                    leading: Image.network(
                      item.urlImage,
                      width: 40,
                      height: 40,
                      fit: BoxFit.cover,
                    ),
                    title: Text(item.title),
                  ),
                ))
            .toList(),
      );

  void onReorderListItem(
    int oldItemIndex,
    int oldListIndex,
    int newItemIndex,
    int newListIndex,
  ) {
    setState(() {
      final oldListItems = lists[oldListIndex].children;
      final newListItems = lists[newListIndex].children;

      final movedItem = oldListItems.removeAt(oldItemIndex);
      newListItems.insert(newItemIndex, movedItem);
    });
  }

  void onReorderList(
    int oldListIndex,
    int newListIndex,
  ) {
    setState(() {
      final movedList = lists.removeAt(oldListIndex);
      lists.insert(newListIndex, movedList);
    });
  }
}
