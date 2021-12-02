import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:studentadda/services/locationService.dart';

class CustomDropDown extends StatefulWidget {
  @override
  _CustomDropDownState createState() => _CustomDropDownState();
}

class _CustomDropDownState extends State<CustomDropDown> {
  String city = "Hyderabad";
  @override
  Widget build(BuildContext context) {
    return Consumer<LocationService>(
      builder: (context, locationService, _) => Container(
        height: 45,
        width: 150,
        decoration: BoxDecoration(
            color: Colors.black.withOpacity(0.05),
            borderRadius: BorderRadius.all(Radius.circular(10))),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            DropdownButton<String>(
              onChanged: (String? value) {
                locationService.setLocation(value!);
              },
              icon: Container(),
              underline: Container(),
              style: Theme.of(context).textTheme.headline5,
              value: locationService.location,
              items: <String>["Hyderabad", "Bangalore", "Chennai", "Mumbai"]
                  .map<DropdownMenuItem<String>>((String cityName) {
                return DropdownMenuItem<String>(
                  value: cityName,
                  child: Text(
                    cityName,
                    style: TextStyle(fontSize: 18.0),
                  ),
                );
              }).toList(),
            ),
            Container(
              decoration: BoxDecoration(
                shape: BoxShape.circle,
              ),
              child: Icon(
                Icons.arrow_drop_down,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
