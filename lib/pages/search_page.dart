import 'package:bus_reservation_udemy/providers/app_data_provider.dart';
import 'package:bus_reservation_udemy/utils/constants.dart';
import 'package:bus_reservation_udemy/utils/helper_functions.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({super.key});

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  String? fromCity, toCity;
  DateTime? departureDate, returnDate;
  final _key = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Search'),
      ),
      body: Form(
        key: _key,
        child: Center(
            child: ListView(
          shrinkWrap: true,
          padding: const EdgeInsets.all(16),
          children: [
            DropdownButtonFormField<String>(
                value: fromCity,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return emptyFieldErrMessage;
                  }
                  return null;
                },
                decoration: const InputDecoration(
                  errorStyle: TextStyle(color: Colors.red),
                ),
                hint: const Text('From'),
                isExpanded: true,
                items: cities.map((city) {
                  return DropdownMenuItem<String>(
                    value: city,
                    child: Text(city),
                  );
                }).toList(),
                onChanged: (value) {
                  setState(() {
                    fromCity = value;
                  });
                }),
            const SizedBox(
              height: 26,
            ),
            DropdownButtonFormField<String>(
                value: toCity,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return emptyFieldErrMessage;
                  }
                  return null;
                },
                decoration: const InputDecoration(
                  errorStyle: TextStyle(color: Colors.red),
                ),
                hint: const Text('To'),
                isExpanded: true,
                items: cities.map((city) {
                  return DropdownMenuItem<String>(
                    value: city,
                    child: Text(city),
                  );
                }).toList(),
                onChanged: (value) {
                  setState(() {
                    toCity = value;
                  });
                }),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                TextButton(
                    onPressed: _selectedDate,
                    child: const Text('Select Departure Date')),
                Text(departureDate == null
                    ? 'No date selected'
                    : getFormattedDate(departureDate!,
                        pattern: "EEE MMM dd, yyyy")),
              ],
            ),
            Center(
                child: SizedBox(
              width: 150,
              child: ElevatedButton(
                  onPressed: _search, child: const Text('Search')),
            ))
          ],
        )),
      ),
    );
  }

  void _selectedDate() async {
    final selectedDate = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime.now(),
        lastDate: DateTime.now().add(const Duration(days: 7)));
    if (selectedDate != null) {
      setState(() {
        departureDate = selectedDate;
      });
    }
  }

  void _search() {
    if (departureDate == null) {
      showMessage(context, emptyDate);
      return;
    }

    if (_key.currentState!.validate()) {
      Provider.of<AppDataProvider>(context, listen: false)
          .getRouteByCityFromAndCityTo(fromCity!, toCity!)
          .then((value) {
        Navigator.pushNamed(context, routeNameSearchResultPage, arguments: [
          value,
          getFormattedDate(
            departureDate!,
          )
        ]);
      });
    }
  }
}
