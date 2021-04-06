import 'package:flutter/material.dart';
import 'package:flutter_workout/const.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_workout/model/user.dart';
import 'package:flutter_workout/screens/friends_screens/friends_screen.dart';
import 'package:flutter_workout/service/database.dart';

class SearchFriend extends StatefulWidget {
  static const String id = "Search Friend Screen";

  @override
  _SearchFriendState createState() => _SearchFriendState();
}

class _SearchFriendState extends State<SearchFriend> {
  TextEditingController searchController = TextEditingController();

  buildNoContent() {
    final Orientation orientation = MediaQuery.of(context).orientation;
    return Container(
      child: Center(
        child: ListView(
          shrinkWrap: true,
          children: [
            Text(
              "Find Friends from their Username",
              textAlign: TextAlign.center,
              style: TextStyle(
                  fontWeight: orientation == Orientation.portrait
                      ? FontWeight.w500
                      : FontWeight.w800),
            )
          ],
        ),
      ),
    );
  }

  buildSearchResults() {
    return FutureBuilder(
        future: searchResultsFuture,
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return Center(child: CircularProgressIndicator());
          }
          List<UserRsult> searchResults = [];
          snapshot.data.docs.forEach((doc) {
            UserModel user = UserModel.fromDocument(doc);
            UserRsult searchResult = UserRsult(user);
            searchResults.add(searchResult);
          });
          return ListView(
            children: searchResults,
          );
        });
  }

  Future<QuerySnapshot> searchResultsFuture;

  handleSearch(String query) {
    Future<QuerySnapshot> users =
        usersRef.where("display_name", isGreaterThanOrEqualTo: query).get();
    setState(() {
      searchResultsFuture = users;
    });
  }

  clearSearch() {
    searchController.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          backgroundColor: midNightBlue,
          elevation: 0,
          centerTitle: false,
          title: Text('Add'),
          actions: [
            IconButton(
                icon: Icon(Icons.arrow_back_ios_rounded),
                onPressed: () {
                  Navigator.pop(context);
                })
          ],
        ),
        body: Column(
          children: [
            SizedBox(height: 20),
            //search bar
            TextFormField(
              controller: searchController,
              decoration: InputDecoration(
                hintText: "Search Username...",
                filled: true,
                prefixIcon: Icon(Icons.account_box_rounded, size: 28),
                suffixIcon: IconButton(
                  icon: Icon(Icons.clear),
                  onPressed: clearSearch,
                ),
              ),
              onFieldSubmitted: handleSearch,
            ),
            //results lists
            Expanded(
              child: searchResultsFuture == null
                  ? buildNoContent()
                  : buildSearchResults(),
            ),
          ],
        ));
  }
}

class UserRsult extends StatelessWidget {
  final UserModel user;

  const UserRsult(this.user);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: midNightBlue,
      child: Column(
        children: [
          GestureDetector(
            onTap: () {
              print("tapped");
            },
            child: ListTile(
              tileColor: darkBlack,
              leading: Icon(Icons.account_circle_rounded, size: 45),
              title: Text(
                user.displayName,
                style: TextStyle(fontWeight: FontWeight.w500),
              ),
              subtitle: Text(user.username),
            ),
          ),
          Divider(height: 5.0, color: Colors.white)
        ],
      ),
    );
  }
}
