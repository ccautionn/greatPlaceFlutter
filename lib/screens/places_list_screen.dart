import 'package:flutter/material.dart';
import '../providers/great_places.dart';
import 'package:provider/provider.dart';
import '../screens/add_place_screen.dart';

class PlacesListScreen extends StatelessWidget {
  const PlacesListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Your Places'),
        actions: [
          IconButton(
              onPressed: () {
                Navigator.of(context).pushNamed(AddPlaceScreen.routeName);
              },
              icon: const Icon(Icons.add))
        ],
      ),
      body: FutureBuilder(
        future:
            Provider.of<GreatPlaces>(context, listen: false).fetAndSetPlaces(),
        builder: (ctx, snapshot) =>
            snapshot.connectionState == ConnectionState.waiting
                ? const Center(
                    child: CircularProgressIndicator(),
                  )
                : Consumer<GreatPlaces>(
                    child: const Center(
                      child: Text('Got no places yet, start add some!'),
                    ),
                    builder: (ctx, greatPlaces, ch) => greatPlaces.items.isEmpty
                        ? ch as Widget
                        : ListView.builder(
                            itemCount: greatPlaces.items.length,
                            itemBuilder: (context, i) => ListTile(
                              leading: CircleAvatar(
                                backgroundImage:
                                    FileImage(greatPlaces.items[i].image),
                              ),
                              title: Text(greatPlaces.items[i].title),
                              onTap: () {
                                //got detail page
                              },
                            ),
                          )),
      ),
    );
  }
}
