

import 'package:flutter/material.dart';
import 'package:movieflix/ui/base/base_stateful_widget.dart';
import 'package:movieflix/ui/home/bloc/topRated_bloc.dart';
import 'package:movieflix/ui/nowPlaying/nowPlayingScreen.dart';
import 'package:movieflix/ui/topRated/topRatedScreen.dart';

import '../../colors.dart';
import 'bloc/nowPlaying_bloc.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends BaseStatefulWidgetState<HomePage> {
  int _currentIndex = 0;

  Icon actionIcon = new Icon(
    Icons.search,
    color: Colors.white,
  );
  Widget appBarTitle = new Text(
    "Movie Flix",
    style: new TextStyle(color: Colors.white),
  );
  final TextEditingController _searchQuery = new TextEditingController();
  final _nowPlayingBloc = NowPlayingBloc();
  final _topRatedBloc = TopRatedBloc();

  String searchText = '';
  List<Widget> _children() => [
    NowPlayingScreen(searchText),
    TopRatedScreen(searchText)
  ];

  @override
  void initState(){
    super.initState();
    _searchQuery.addListener(() {
      if(_searchQuery.text.isEmpty){
        if(_currentIndex == 0) {
          setState(() {
            _nowPlayingBloc.getData(query: '');
          });
        }else{
          setState(() {
            _topRatedBloc.getData(query: '');
          });
        }
      }else{
        if(_currentIndex == 0){
          setState(() {  searchText = _searchQuery.text;
          _nowPlayingBloc.getData(query: searchText);});
        }else{

          setState(() { searchText = _searchQuery.text;
          _topRatedBloc.getData(query: searchText);});
        }
      }
    });
  }
  /*_HomePageState() {
    _searchQuery.addListener(() {
      if (_searchQuery.text.isEmpty) {
        _homeBloc.getData(query: '');
      } else {
        searchText = _searchQuery.text ;
        _homeBloc.getData(query: _searchQuery.text);
      }
    });
  }*/

  void _handleSearchEnd() {
    setState(() {
      this.actionIcon = new Icon(
        Icons.search,
        color: Colors.white,
      );
      this.appBarTitle = new Text("Movie Flix",
          style: new TextStyle(color: Colors.white));
      _searchQuery.clear();
    });
  }

  Widget buildBar(BuildContext context) {
    return new AppBar(centerTitle: true, title: appBarTitle, actions: <Widget>[
      new IconButton(
        icon: actionIcon,
        onPressed: () {
          setState(() {
            if (this.actionIcon.icon == Icons.search) {
              this.actionIcon = new Icon(
                Icons.close,
                color: Colors.white,
              );
              this.appBarTitle = new TextField(
                controller: _searchQuery,
                autofocus: true,
                style: new TextStyle(
                  color: Colors.white,
                ),
                decoration: new InputDecoration(
                    prefixIcon: new Icon(Icons.search, color: Colors.white),
                    hintText: "Find here...",
                    hintStyle: new TextStyle(
                        color: colorBlackGradient90, fontSize: 20.0)),
              );
            } else {
              _handleSearchEnd();
            }
          });
        },
      ),
    ]);
  }

  @override
  Widget build(BuildContext context) {
    final List<Widget> children = _children( );
    return Scaffold(
      appBar: buildBar(context),
      backgroundColor: colorGrayscale10,
      body: children[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: colorBlack,
        selectedItemColor: colorMinionYellow,
        unselectedItemColor: colorWhite,
        onTap: onTabTapped,
        currentIndex: _currentIndex,
        items: [
          new BottomNavigationBarItem(
              icon: Icon(Icons.play_arrow), title: Text("Now Playing")),
          new BottomNavigationBarItem(
              icon: Icon(Icons.star), title: Text("Top Rated"))
        ],
      ),
    );
  }

  void onTabTapped(int value) {
    setState(() {
      _currentIndex = value ;
    });
  }

}
