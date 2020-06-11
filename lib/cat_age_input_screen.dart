import 'package:flutter/material.dart';
import 'package:my_vet_tv/util.dart';

import 'frosted_glass.dart';

String dropdownAge = 'Select one';
String dropdownBreed = 'Select one';

class CatAgeDropDown extends StatefulWidget {
  @override
  createState() => new CatAgeDropDownState();
}

class CatAgeDropDownState extends State<CatAgeDropDown> {
  // need to create a framework
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Column(children: [
      Container(
          decoration: BoxDecoration(color: AppBarColor),
          child: Align(
              alignment: Alignment.centerLeft,
              child: Container(
                height: 110,
                width: 360,
                child: Image.asset('assets/pnclogo1.png', fit: BoxFit.scaleDown),
              ))),
      Expanded(
          child: Stack(children: [
        Container(
            decoration: BoxDecoration(color: Color(0xEF80D2F5)),
            child: Center(
                child: Stack(children: [
              Positioned(
                bottom: -10.0,
                left: -30.0,
                child: Container(
                  width: 950,
                  child: Image(
                    image: AssetImage('assets/bigCat.png'),
                  ),
                ),
              ),
              Positioned(
                right: 10.0,
                bottom: 325.0,
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
        //new FrostedGlassScreensaver(45),
      ]))
    ]));
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
            'Select one',
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
            'Select one',
            'Siamese',
            'Persian',
            'Maine Coon',
            'Ragdoll',
            'Bengal',
            'Abyssinian',
            'Birman',
            'Oriental Shorthair',
            'Sphynx',
            'Devon Rex',
            'Himalayan',
            'American Shorthair',
            'Unknown',
            'Mixed',
            'Other'
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
        Navigator.of(context).pushNamed('/catVideoPlayer');
      },
      child: Text('Submit'),
      color: Colors.lightBlue,
    );
  }
}
