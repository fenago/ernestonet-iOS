import 'dart:math';

import 'package:flutter/material.dart';

import '../../core/extensions/theme_x.dart';
import '../../core/extensions/padding_x.dart';
import '../../core/services/local_storage_service.dart';
import '../../locator.dart';
import '../shared/ui_helper.dart';

class SortFilterPage extends StatefulWidget {
  @override
  _SortFilterPageState createState() => _SortFilterPageState();
}

class _SortFilterPageState extends State<SortFilterPage> {
  int selectedIndex = 4;
  List<String> sortFilterItems = [
    'Brand',
    'Color',
    'Condition',
    'Size',
    'Price',
    'Material',
    'Trend',
    'Flaw',
    'Params',
    'Flutter',
    'Widgets',
  ];
  List<String> list1 = ['Hardly Used', 'New without tag', 'Gently Used'];
  List<String> list2 = ['Small Damage', 'No Warranty', 'Good Condition'];
  List<String> list3 = ['Scratch', 'Glass Broken', 'Too Old'];

  List<String> getSortFilterSubItems() {
    final random = Random();
    final lists = [list1, list2, list3];
    return lists[random.nextInt(3)];
  }

  @override
  Widget build(BuildContext context) {
    final localStorageService = locator<LocalStorageService>();

    return MediaQuery(
      data: MediaQuery.of(context).copyWith(textScaleFactor: 1.0),
      child: Scaffold(
        body: SafeArea(
          child: Container(
            margin: const EdgeInsets.symmetric(vertical: 10.0),
            color: context.theme().scaffoldBackgroundColor,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Center(
                  child: Icon(Icons.drag_handle, color: Colors.grey),
                ),
                Text('Sort and Filters', style: context.textTheme().subtitle1).paddingHorizontal(8.0),
                UIHelper.verticalSpaceExtraSmall(),
                Expanded(
                  child: Container(
                    margin: const EdgeInsets.symmetric(vertical: 10.0),
                    color: context.theme().scaffoldBackgroundColor,
                    child: Row(
                      children: <Widget>[
                        Expanded(
                          flex: 3,
                          child: Container(
                            child: ListView.builder(
                              itemCount: sortFilterItems.length,
                              itemBuilder: (context, index) => InkWell(
                                onTap: () {
                                  setState(() {
                                    selectedIndex = index;
                                  });
                                },
                                child: Container(
                                  alignment: Alignment.centerLeft,
                                  height: 45.0,
                                  color: (selectedIndex == index)
                                      ? localStorageService.darkMode ? Colors.grey[400] : Colors.white
                                      : localStorageService.darkMode ? Colors.grey[800] : Colors.grey[200],
                                  child: _FilterListItem(
                                    title: sortFilterItems[index],
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                        Expanded(
                          flex: 4,
                          child: _SubSortFilter(
                            list: getSortFilterSubItems(),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: <Widget>[
                    Expanded(
                      flex: 3,
                      child: FlatButton(
                        child: Text(
                          'Clear All',
                          style: TextStyle(color: context.theme().accentColor),
                        ),
                        onPressed: () {},
                      ),
                    ),
                    Expanded(
                      flex: 4,
                      child: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 8.0),
                        child: RaisedButton(
                          color: context.theme().accentColor,
                          child: Text(
                            'Apply',
                            style: TextStyle(color: Colors.white),
                          ),
                          onPressed: () {},
                        ),
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _FilterListItem extends StatelessWidget {
  final String title;
  const _FilterListItem({
    Key key,
    @required this.title,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final localStorageService = locator<LocalStorageService>();
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Expanded(
          child: Align(
            alignment: Alignment.centerLeft,
            child: Text(
              title,
              style: context.textTheme().bodyText2,
            ).paddingHorizontal(8.0),
          ),
        ),
        Container(
          color: localStorageService.darkMode ? Colors.grey[800] : Colors.grey[300],
          height: 1.0,
        )
      ],
    );
  }
}

class _SubSortFilter extends StatefulWidget {
  final List<String> list;
  const _SubSortFilter({Key key, @required this.list}) : super(key: key);

  @override
  _SubSortFilterState createState() => _SubSortFilterState();
}

class _SubSortFilterState extends State<_SubSortFilter> {
  TextEditingController _sortEditingController;

  @override
  void initState() {
    super.initState();
    _sortEditingController = TextEditingController();
  }

  @override
  void dispose() {
    super.dispose();
    _sortEditingController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final localStorageService = locator<LocalStorageService>();
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            alignment: Alignment.centerLeft,
            height: 40.0,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20.0),
              color: localStorageService.darkMode ? context.theme().scaffoldBackgroundColor : Colors.grey[200],
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Icon(Icons.search, size: 20.0),
                Expanded(
                  child: Container(
                    margin: const EdgeInsets.only(left: 8.0, bottom: 5.0, right: 8.0),
                    height: 40.0,
                    child: TextField(
                      controller: _sortEditingController,
                      decoration: InputDecoration(border: InputBorder.none, hintStyle: TextStyle(fontSize: 13.0), hintText: 'Search..'),
                      style: TextStyle(
                        fontSize: 16.0,
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
          UIHelper.verticalSpaceSmall(),
          Expanded(
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 5.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    'Top Picks',
                    style: TextStyle(
                      fontSize: 12.0,
                      color: Colors.grey,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  Expanded(
                    child: ListView.builder(
                      scrollDirection: Axis.vertical,
                      itemCount: widget.list.length,
                      itemBuilder: (context, index) => Ink(
                        child: Container(
                          alignment: Alignment.centerLeft,
                          height: 45.0,
                          child: Column(
                            children: <Widget>[
                              Expanded(
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: <Widget>[
                                    _FilterListItem(
                                      title: widget.list[index],
                                    ),
                                    Spacer(),
                                    IconButton(
                                      icon: Icon(Icons.check_box_outline_blank),
                                      iconSize: 18.0,
                                      onPressed: () {},
                                    )
                                  ],
                                ),
                              ),
                              Container(
                                color: Colors.grey[300],
                                height: 0.5,
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
