import 'package:flutter/material.dart';

import 'frosted_glass.dart';

String dropdownAge = '0-6 months';
String dropdownBreed = 'Mut';

class DogAgeDropDown extends StatefulWidget {
  @override
  createState() => new DogAgeDropDownState();
}

class DogAgeDropDownState extends State<DogAgeDropDown> {
  // need to create a framework
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Stack(
          children: [
            Container(
                // this indigo has a sort of authoritative feeling
                decoration: BoxDecoration(color: Color(0xEF80D2F5)),
                child: Center(
                    child: Stack(children: [
                  Positioned(
                    bottom: -15.0,
                    left: -10.0,
                    child: Container(
                      width: 1100,
                      child: Image(
                        image: AssetImage('assets/bigdog.png'),
                      ),
                    ),
                  ),
                  Positioned(
                    right: 10.0,
                    bottom: 285.0,
                    child: Container(
                      width: 400,
                      child: Column(
                        children: <Widget>[
                          Padding(padding: EdgeInsets.all(12.0)),
                          Text('How old is your best friend?',
                              style: TextStyle(
                                fontSize: 24,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              )),
                          Container(
                            child: Container(
                              width: 200,
                              child: createAgeDropdown(),
                              decoration: ShapeDecoration(
                                color: Colors.white,
                                shape: RoundedRectangleBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(10.0)),
                                ),
                              ),
                            ),
                          ),
                          Padding(padding: EdgeInsets.all(12.0)),
                          Text('What breed is your best friend?',
                              style: TextStyle(
                                fontSize: 24,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              )),
                          Container(
                            child: Container(
                              width: 200,
                              child: createBreedDropdown(),
                              decoration: ShapeDecoration(
                                color: Colors.white,
                                shape: RoundedRectangleBorder(
                                  borderRadius:
                                  BorderRadius.all(Radius.circular(10.0)),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ]))),
            new FrostedGlassScreensaver(45),
          ],
    ));
  }

  Widget createAgeDropdown() {
    return DropdownButtonHideUnderline(
      child: ButtonTheme(
        alignedDropdown: true,
        child: DropdownButton<String>(
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
            '2 - 4 years',
            '4 - 6 years',
            '6 - 10 years',
            'older than 10 years'
          ].map<DropdownMenuItem<String>>((String value) {
            return DropdownMenuItem<String>(
              value: value,
              child: Text(value),
            );
          }).toList(),
          value: dropdownAge,
        ),
      ),
    );
  }

  Widget createBreedDropdown() {
    return DropdownButtonHideUnderline(
      child: ButtonTheme(
        alignedDropdown: true,
        child: DropdownButton<String>(
          onChanged: (newValue) {
            dropdownBreed = newValue;
            setState(() {
              print(newValue);
            });
            Navigator.of(context).pushNamed('/dogVideoPlayer');
          },
          items: <String>[
            'German Shepherd',
            'Bulldog',
            'Labrador Retriever',
            'Golden Retriever',
            'Poodle',
            'Beagle',
            'Yorkie',
            'Boxer',
            'Pug',
            'Husky',
            'Chihuahua',
            'Pointer',
            'Great Dane',
            'Mut'
          ].map<DropdownMenuItem<String>>((String value) {
            return DropdownMenuItem<String>(
              value: value,
              child: Text(value),
            );
          }).toList(),
          value: dropdownBreed,
        ),
      ),
    );
  }

  // TODO what does 'get' do?
  Widget get submitRatingButton {
    return RaisedButton(
      onPressed: () {
        Navigator.of(context).pushNamed('/dogVideoPlayer');
      },
      child: Text('Submit'),
      color: Colors.lightBlue,
    );
  }
}
