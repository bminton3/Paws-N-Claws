import 'package:flutter/material.dart';
import 'videoPlayer.dart';

String dropdownAge = '0-6 months';

class DogAgeDropDown extends StatefulWidget {


  @override
  createState() => new DogAgeDropDownState();


}

class DogAgeDropDownState extends State<DogAgeDropDown> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("How old is your pup?"),
      ),
      body: Column(
        children: <Widget>[
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
          submitRatingButton,
        ],
      ),
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