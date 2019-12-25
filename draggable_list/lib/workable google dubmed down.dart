// Copyright 2018 The Chromium Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.
/*
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

void main(){
  runApp(MaterialApp(
    home: ReorderableListDemo(),
  ));
}

class ReorderableListDemo extends StatefulWidget {
  @override
  _ListDemoState createState() => _ListDemoState();
}

class _ListItem {
  final String value;
  bool checkState;
  _ListItem(this.value, this.checkState);
}

class _ListDemoState extends State<ReorderableListDemo> {

  final List<_ListItem> _items = <String>[
    'A', 'B', 'C', 'D',
  ].map<_ListItem>((String item) => _ListItem(item, false)).toList();

  Widget buildListTile(_ListItem item) {
    Widget listTile;
        listTile = CheckboxListTile(
          key: Key(item.value),
          value: item.checkState ?? false,
          onChanged: (bool newValue) {
            setState(() {
              item.checkState = newValue;
            });
          },
          title: Text('This item represents ${item.value}.'),
          secondary: const Icon(Icons.drag_handle),
        );

    return listTile;
  }

  void _onReorder(int oldIndex, int newIndex) {
    setState(() {
      if (newIndex > oldIndex) {
        newIndex -= 1;
      }
      final _ListItem item = _items.removeAt(oldIndex);
      _items.insert(newIndex, item);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Reorderable list'),
      ),
      body: Scrollbar(
        child: ReorderableListView(
          onReorder: _onReorder,
          children: _items.map<Widget>(buildListTile).toList(),
        ),
      ),
    );
  }
}
*/