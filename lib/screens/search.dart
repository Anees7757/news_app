// ignore_for_file: prefer_const_constructors

// ignore: import_of_legacy_library_into_null_safe
import 'package:chips_choice/chips_choice.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:news_app/main.dart';
import 'package:news_app/services/data_service.dart';

import '../category.dart';

class Search extends StatefulWidget {
  const Search({Key? key}) : super(key: key);

  @override
  _SearchState createState() => _SearchState();
}

class _SearchState extends State<Search> {
  int tag = 15;
  List<String> options = [
    'covid',
    'android',
    'entertainment',
    'cryptoCurrency',
    'politics',
    'automotive',
    'sports',
    'education',
    'fashion',
    'travel',
    'food',
    'tech',
    'science',
    'apple',
  ];

  final TextEditingController _searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
            setState(() {
              _searchController.clear();
              search = '';
            });
          },
        ),
        titleSpacing: 0,
        title: SizedBox(
          height: 35,
          child: TextField(
            controller: _searchController,
            textAlignVertical: TextAlignVertical.bottom,
            autofocus: true,
            autocorrect: true,
            cursorColor: Colors.white,
            style: TextStyle(color: Colors.white),
            textInputAction: TextInputAction.search,
            onChanged: (text) {
              setState(() {
                search = text;
              });
            },
            decoration: InputDecoration(
              focusColor: Colors.black,
              hintText: 'Type Something',
              hintStyle: TextStyle(color: Colors.white),
              suffixIcon: GestureDetector(
                onTap: () {
                  setState(() {
                    _searchController.clear();
                  });
                },
                child: Icon(
                  Icons.highlight_off,
                  color: Colors.grey[200],
                ),
              ),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(50.0),
              ),
              focusedBorder: OutlineInputBorder(
                borderSide: const BorderSide(color: Colors.black),
                borderRadius: BorderRadius.circular(50.0),
              ),
              filled: true,
              fillColor: isDarkMode! ? CupertinoColors.systemGrey : Colors.red[600],
            ),
          ),
        ),
        // ignore: prefer_const_literals_to_create_immutables
        actions: [
          SizedBox(width: 15),
        ],
      ),
      body: Column(
        children: [
          ChipsChoice<int>.single(
            scrollPhysics: BouncingScrollPhysics(),
            value: tag,
            onChanged: (val) => setState(() {
              tag = val;
              search = options[tag];
              FocusScope.of(context).unfocus();
            }),
            choiceItems: C2Choice.listFrom<int, String>(
              source: options,
              value: (i, v) => i,
              label: (i, v) => v,
            ),
          ),
          Expanded(child: Category().stories("Search", 5)),
        ],
      ),
    );
  }
}
