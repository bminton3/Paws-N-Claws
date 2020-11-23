import 'package:flutter/material.dart';
import 'package:my_vet_tv/util.dart';

String dropdownAge = 'Select one';
String dropdownBreed = 'Select one';

class DogAgeDropDown extends StatefulWidget {
  @override
  createState() => new DogAgeDropDownState();
}

class DogAgeDropDownState extends State<DogAgeDropDown> {
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
                child: Image.asset('assets/tailwag.png', fit: BoxFit.scaleDown),
              ))),
      Expanded(
          child: Stack(
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
                    width: 950,
                    child: Image(
                      fit: BoxFit.scaleDown,
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
                                borderRadius: BorderRadius.all(Radius.circular(10.0)),
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
                                borderRadius: BorderRadius.all(Radius.circular(10.0)),
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
        ],
      ))
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
            '0-6 Months',
            '6 Months - 1 Year',
            '1 - 2 Years',
            '2 - 4 Years',
            '4 - 6 Years',
            '6 - 10 Years',
            'older than 10 Years'
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
            'mixed breed'
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
