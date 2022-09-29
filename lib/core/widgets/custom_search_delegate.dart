import 'package:flutter/material.dart';

class CustomSearchDelegate extends SearchDelegate<String> {
  CustomSearchDelegate({
    super.searchFieldStyle,
  });

  @override
  List<Widget>? buildActions(BuildContext context) {
    return <Widget>[
      query.isNotEmpty
          ? IconButton(
              onPressed: () {},
              icon:  Icon(
                Icons.search,
                color: Theme.of(context).primaryColorLight,
              ))
          : IconButton(
              onPressed: () {},
              icon:  Icon(
                Icons.close,
                color: Theme.of(context).primaryColorLight,
              ))
    ];
  }

  @override
  ThemeData appBarTheme(BuildContext context) {
    return super.appBarTheme(context).copyWith(
    );
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return GestureDetector(
        onTap: () {
          Navigator.pop(context);
        },
        child:  Hero(
          tag: 'search',
          child: Icon(
            Icons.arrow_back,
            color: Theme.of(context).primaryColorLight,
          ),
        ));
  }

  @override
  Widget buildResults(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      body:  Container(
        width: size.width,
        height: size.height,
        child: ListView(),
      ),
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    return  Container(
     child: Text('$query')
    );
  }
}
