import 'package:flutter/material.dart';
import 'videoPlayer.dart';

String dropdownAge = '0-6 months';

class DogAgeDropDown extends StatefulWidget {
  @override
  createState() => new DogAgeDropDownState();
}

class DogAgeDropDownState extends State<DogAgeDropDown> {
  // TODO this is code copied over from main to get the same look and feel
  // need to create a framework
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
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
                      padding: EdgeInsets.symmetric(
                        vertical: 5.0,
                        horizontal: 5.0,
                      ),
                      child: Container(
                        width: 200,
                        child: TextField(
                          autofocus: true,
                          maxLines: 1,
                          style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                              fontSize: 28,),
                          decoration: InputDecoration(
                              border: OutlineInputBorder(
                                borderSide: BorderSide.none,
                                borderRadius: const BorderRadius.all(
                                  const Radius.circular(10.0),
                                ),
                              ),
                              filled: true,
                              fillColor: Colors.white),
                          onSubmitted: (String submittedString) {
                            Navigator.of(context).push(
                              MaterialPageRoute<void>(
                                builder: (BuildContext context) => new VideoPlayer(),
                              ),
                            );
                          },
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ]))),
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

  // TODO what does 'get' do?
  Widget get submitRatingButton {
    return RaisedButton(
      onPressed: () {
        Navigator.of(context).push(
          MaterialPageRoute<void>(
            builder: (BuildContext context) => new VideoPlayer(),
          ),
        );
      },
      child: Text('Submit'),
      color: Colors.lightBlue,
    );
  }
}
