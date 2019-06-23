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
                child: Column(
                  children: <Widget>[
                    Padding(padding: EdgeInsets.all(12.0)),
                    Text('How old is your best friend?',
                        style: TextStyle(
                          fontSize: 24,
                          color: Colors.white,
                        )),
                    Padding(padding: EdgeInsets.all(12.0)),
                    Container(
                      padding: EdgeInsets.symmetric(
                        vertical: 16.0,
                        horizontal: 16.0,
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Flexible(
                            flex: 1,
                            child:  Center(
                              child: DropdownButton<String>(
                                onChanged: (newValue) {
                                  dropdownAge = newValue;
                                  setState(() {
                                    print(newValue);
                                  });
                                },
                                items: <String>['0-6 months', '6 months to a year', '1 - 2 years', '2 - 10 years', 'older']
                                    .map<DropdownMenuItem<String>>((String value) {
                                  return DropdownMenuItem<String>(
                                    value: value,
                                    child: Text(value),
                                  );
                                }).toList(),
                                value: dropdownAge,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Padding(padding: EdgeInsets.all(12.0)),
                    submitRatingButton,
                  ],
                ),
              ))),
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
      items: <String>['0-6 months', '6 months to a year', '1 - 2 years', '2 - 10 years', 'older']
          .map<DropdownMenuItem<String>>((String value) {
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
      onPressed: (){
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