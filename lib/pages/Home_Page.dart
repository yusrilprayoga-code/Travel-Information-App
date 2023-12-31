import 'package:flutter/material.dart';
import 'package:testing_dummy/constants/tourism_place.dart';
import 'package:testing_dummy/pages/Detail_Screen.dart';
import 'package:testing_dummy/pages/Profile.dart';

enum SortType {
  nameAscending,
  nameDescending,
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int currentPageIndex = 0;
  SortType currentSortType = SortType.nameAscending;
  bool isFavorite = false;
  String searchText = "";

  @override
  Widget build(BuildContext context) {
    tourismPlaceList.sort((a, b) {
      if (currentSortType == SortType.nameAscending) {
        return a.name.compareTo(b.name);
      } else if (currentSortType == SortType.nameDescending) {
        return b.name.compareTo(a.name);
      }
      return 0;
    });

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        automaticallyImplyLeading: false,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            IconButton(
              onPressed: () {
                Navigator.pushReplacement(context,
                    MaterialPageRoute(builder: (context) => MyHomePage()));
                SnackBar snackBar = SnackBar(
                  content: Text("Menu Clicked"),
                  duration: Duration(seconds: 1),
                );
                ScaffoldMessenger.of(context).showSnackBar(snackBar);
              },
              icon: Icon(Icons.home, color: Colors.black),
            ),
            Text("Home Page",
                style: TextStyle(
                  color: Colors.black,
                )),
            SizedBox(width: 0), // Jarak antara teks dan tombol logout
          ],
        ),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.pop(context);
              SnackBar snackBar = SnackBar(
                content: Text("Logout Success"),
                duration: Duration(seconds: 1),
              );
              ScaffoldMessenger.of(context).showSnackBar(snackBar);
            },
            icon: Icon(Icons.logout, color: Colors.black),
          ),
        ],
      ),
      body: SafeArea(
        child: Column(
          children: [
            //bagian atas
            Container(
                margin: EdgeInsets.symmetric(horizontal: 20, vertical: 30),
                child: Row(
                  children: [
                    Text(
                      "Authentic Traveler",
                      style: TextStyle(
                          fontSize: 25,
                          fontWeight: FontWeight.bold,
                          color: Colors.deepPurple),
                    ),
                  ],
                )),

            //bagian search
            Container(
              margin: EdgeInsets.symmetric(
                horizontal: 20,
              ),
              padding: EdgeInsets.symmetric(horizontal: 20),
              decoration: BoxDecoration(
                color: Colors.grey[200],
                borderRadius: BorderRadius.circular(15),
              ),
              child: TextFormField(
                onChanged: (value) {
                  setState(() {
                    searchText = value;
                  });
                },
                decoration: InputDecoration(
                  prefixIcon: Icon(Icons.search),
                  border: InputBorder.none,
                  hintText: "Search",
                  hintStyle: TextStyle(color: Colors.grey),
                ),
              ),
            ),

            //bagian list card
            SizedBox(height: 20),
            TourismPlaceList(),

            // bagian recommended places
            Container(
              margin: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
              padding: EdgeInsets.symmetric(horizontal: 15),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Recommended Places",
                    style: TextStyle(fontSize: 15, color: Colors.deepPurple),
                  ),
                  IconButton(
                    onPressed: () {
                      setState(() {
                        if (currentSortType == SortType.nameAscending) {
                          currentSortType = SortType.nameDescending;
                        } else {
                          currentSortType = SortType.nameAscending;
                        }
                      });
                    },
                    icon: Icon(
                      Icons.filter_list,
                      color: Colors.deepPurple,
                    ),
                  )
                ],
              ),
            ),
            Expanded(
              child: ListView.builder(
                itemCount: tourismPlaceList.length,
                itemBuilder: (context, index) {
                  final TourismPlace place = tourismPlaceList[index];
                  if (searchText.isNotEmpty &&
                      !place.name
                          .toLowerCase()
                          .contains(searchText.toLowerCase())) {
                    return Container();
                  }
                  return InkWell(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => DetailsScreen(place: place)),
                      );
                    },
                    child: Container(
                      margin: EdgeInsets.symmetric(
                          horizontal: 20,
                          vertical: 10), // Adjust vertical padding as needed
                      width: MediaQuery.of(context).size.width,
                      height: 70,
                      child: Row(
                        children: [
                          Container(
                            width: 70,
                            height: 70,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                image: DecorationImage(
                                    image: NetworkImage(place.imageUrls[0]),
                                    fit: BoxFit.cover)),
                          ),
                          SizedBox(width: 15),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                place.name,
                                style: TextStyle(
                                    fontSize: 15, fontWeight: FontWeight.bold),
                              ),
                              Text(
                                place.location,
                                style:
                                    TextStyle(fontSize: 12, color: Colors.grey),
                              )
                            ],
                          ),
                          Spacer(),
                          IconButton(
                            onPressed: () {
                              setState(() {
                                place.isFavorite = !place.isFavorite;
                              });
                            },
                            icon: Icon(
                              place.isFavorite
                                  ? Icons.favorite
                                  : Icons.favorite_border,
                              color:
                                  place.isFavorite ? Colors.red : Colors.grey,
                            ),
                          )
                        ],
                      ),
                    ),
                  );
                },
              ),
            )
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: 0,
        onTap: (value) {
          setState(() {
            if (value == 0) {
              MyHomePage();
            } else if (value == 1) {
              Navigator.pushReplacement(context,
                  MaterialPageRoute(builder: (context) => MyHomePage()));
            } else if (value == 2) {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => MyProfile()));
            }
          });
        },
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home Page',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.favorite),
            label: 'Favorite',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Profile',
          ),
        ],
      ),
    );
  }
}

class TourismPlaceList extends StatelessWidget {
  const TourismPlaceList({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 200,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: tourismPlaceList.length,
        itemBuilder: (context, index) {
          final TourismPlace place = tourismPlaceList[index];
          return InkWell(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => DetailsScreen(place: place)),
              );
            },
            child: Container(
              margin: EdgeInsets.only(left: 20),
              width: 150,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                  image: DecorationImage(
                      image: NetworkImage(place.imageUrls[0]),
                      fit: BoxFit.cover)),
              child: Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    gradient: LinearGradient(
                        begin: Alignment.bottomRight,
                        stops: [
                          0.3,
                          0.9
                        ],
                        colors: [
                          Colors.black.withOpacity(.8),
                          Colors.black.withOpacity(.1)
                        ])),
                child: Align(
                  alignment: Alignment.bottomLeft,
                  child: Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: Text(
                      place.name,
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 15,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
