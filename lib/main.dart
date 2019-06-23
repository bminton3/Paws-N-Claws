// Flutter code sample for material.IconButton.2

// In this sample the icon button's background color is defined with an [Ink]
// widget whose child is an [IconButton]. The icon button's filled background
// is a light shade of blue, it's a filled circle, and it's as big as the
// button is.

import 'package:flutter/material.dart';
import 'ageDropDown.dart';

void main() => runApp(MyApp());

//======= Colors ========
// Colors.white for specific named colors
// Color(0xhex) for custom colors

// 0xFF65CAE0 - light blue?
// 0xFFA2CAC9 - teal?
// 0xFFD9DDC5 - tan
// 0xFFEB822F - orange
// 0xFFF26600 - bright orange
// 0xFF694533 - brown
// the first 2 digits are transparency.

// TODO naming routes. May be needed later
/*void main() {
  runApp(MaterialApp(
    home: MyAppHome(), // becomes the route named '/'
    routes: <String, WidgetBuilder> {
      '/a': (BuildContext context) => MyPage(title: 'page A'),
      '/b': (BuildContext context) => MyPage(title: 'page B'),
      '/c': (BuildContext context) => MyPage(title: 'page C'),
    },
  ));
}*/

// button ideas: OutlineButton, IconButton (probably this one)
// layout ideas: gridview

/// This Widget is the main application widget.
class MyApp extends StatelessWidget {
  final String _title = 'Paws and Claws Media';

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: _title,
      home: PawsAndClaws(),
    );
  }
}

class PawsAndClawsState extends State<PawsAndClaws> {
  final List<String> _pets = [
    'assets/Dog.png',
    'assets/Cat.png',
    'assets/Other.png'
  ];

  final List<Text> _dogBreeds = [
    Text("English Bulldog"),
    Text("Golden Retriever"),
    Text("German Shepard"),
    Text("Black Labrador")
  ];

  // Widgets only get rebuilt when there is a change in its state. Slider had to set
  // an instance variable's value to work
  double _age = 1;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _buildPetIcons(context),
    );
  }

  // TODO need title text: "What kind of pet do you have?"
  // and either text in the images or text below the images
  // TODO implement OrientationBuilder
  Widget _buildPetIcons(BuildContext context) {
    return Container(
        // this indigo has a sort of authoritative feeling
        decoration: BoxDecoration(color: Color(0xAF65CAE0)),
        child: Center(
            child: Container(
          decoration: BoxDecoration(
              color: Color(0xFFA2CAC9),
              border: Border.all(
                width: 1,
              ),
              borderRadius: new BorderRadius.only(
                  topLeft: const Radius.circular(40.0),
                  topRight: const Radius.circular(40.0),
                  bottomLeft: const Radius.circular(40.0),
                  bottomRight: const Radius.circular(40.0))),
          margin: const EdgeInsets.all(10.0),

          // ipad 6's logical resolution is 768 x 1024 px
          // width and height set to 75% of screen size
          width: MediaQuery.of(context).size.width * 0.75,
          height: MediaQuery.of(context).size.height * 0.55,
          child: _buildTappableButtons(context),
        )));
  }

  /**
   * TODO need to add text above the buttons but columns are fucking impossible
   */
  Widget _buildTappableButtons(BuildContext context) {
    // TODO we may not want a GridView because it's scrollable. May be fun for the users, though
    return Column(children: [
      Padding(padding: EdgeInsets.all(12.0)),
      Text('What type of best friend do you have?',
          style: TextStyle(
            fontSize: 32,
            color: Colors.white,
          )),
      Expanded(
        child: GridView.count(
            crossAxisCount: 3,
            padding: const EdgeInsets.all(75.0),
            mainAxisSpacing: 20.0,
            crossAxisSpacing: 20.0,
            shrinkWrap: true,
            children: _pets.map((String url) {
              return GridTile(
                // doesn't have size
                child: GestureDetector(
                  child: Container(
                    child: Image(
                      image: AssetImage(url),
                      fit: BoxFit.scaleDown,
                    ),
                  ),
                  // TODO there's gotta be a better way to do this
                  onTap: () => _onDogBreedClicked(null),
                ),
              );
            }).toList()),
      ),
    ]);
  }

  void _onAnimalClicked(index) {
    print("You tapped an item");
    Navigator.of(context).push(
      MaterialPageRoute<void>(
        builder: (BuildContext context) {
          return Scaffold(
              appBar: AppBar(
                title: Text("What breed is your dog?"),
              ),
              body: _buildDogBreedList(context));
        },
      ),
    );
  }

  // Widgets seem to always be named with an underscore and camelcase
  Widget _buildDogBreedList(BuildContext context) {
    return ListView.separated(
        itemBuilder: (context, index) {
          return ListTile(
            // TODO study this
            title: _dogBreeds[index],
            onTap: () => _onDogBreedClicked(index),
          );
        },
        // TODO see exactly what this does later
        separatorBuilder: (BuildContext context, int index) => Divider(
              color: Colors.deepOrange,
            ),
        itemCount: _dogBreeds.length);
  }

  void _onDogBreedClicked(index) {
    print("You selected a breed");
    Navigator.of(context).push(
      MaterialPageRoute<void>(
        builder: (BuildContext context) => new DogAgeDropDown(),
      ),
    );
  }

// ======== Age Slider =============
  Widget createAgeSlider() {
    return Slider(
      activeColor: Colors.blueGrey,
      value: _age,
      onChanged: (double sliderAge) {
        setState(() {
          print('user has clicked the slider!');
          _age = sliderAge;
        });
      },
      min: 0.0,
      max: 20.0,
      divisions: 4,
    );
  }

  Widget createAgeDropdown() {
    return DropdownButton<String>(
      onChanged: (newValue) {
        dropdownAge = newValue;
        setState(() {
          print(newValue);
        });
      },
      items: <String>[
        '0-6 months',
        '6 months to a year',
        '1 - 2 years',
        '2 - 10 years',
        'older'
      ].map<DropdownMenuItem<String>>((String value) {
        return DropdownMenuItem<String>(
          value: value,
          child: Text(value),
        );
      }).toList(),
      value: dropdownAge,
    );
  }
}

// ======== Globals =============ß
// main stateful widget
class PawsAndClaws extends StatefulWidget {
  @override
  PawsAndClawsState createState() => PawsAndClawsState();
}
