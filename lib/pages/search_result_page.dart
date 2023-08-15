import 'package:bus_reservation_udemy/models/bus_schedule.dart';
import 'package:bus_reservation_udemy/models/but_route.dart';
import 'package:bus_reservation_udemy/providers/app_data_provider.dart';
import 'package:bus_reservation_udemy/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SearchPageRoute extends StatelessWidget {
  const SearchPageRoute({super.key});

  @override
  Widget build(BuildContext context) {
    final argList = ModalRoute.of(context)!.settings.arguments as List;
    final BusRoute route = argList[0];
    final String departureDate = argList[1];
    // final provider = Provider.of<AppDataProvider>(context);
    // provider.getSchedulesByRouteName(route.routeName);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Search Result on '),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          Text(
              'Showing Result ${route.cityFrom} to ${route.cityTo} on $departureDate',
              style:
                  const TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
          Consumer<AppDataProvider>(builder: (context, provider, _) {
            return FutureBuilder<List<BusSchedule>>(
                future: provider.getSchedulesByRouteName(route.routeName),
                builder: (context, snapshot) {
                  final scheduleList = snapshot.data!;
                  if (snapshot.hasData) {
                    return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: scheduleList
                            .map((e) => ScheduleItemView(
                                date: departureDate, schedule: e))
                            .toList());
                  }
                  if (snapshot.hasError) {
                    return const Text('Failed to fetch data');
                  }
                  return const Center(child: CircularProgressIndicator());
                });
          })
        ],
      ),
    );
  }
}

class ScheduleItemView extends StatelessWidget {
  final String date;
  final BusSchedule schedule;
  const ScheduleItemView(
      {super.key, required this.date, required this.schedule});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.pushNamed(context, routeNameSeatPlanPage,
            arguments: [schedule, date]);
      },
      child: Card(
        child: Column(
          children: [
            ListTile(
              title: Text(schedule.busRoute.routeName),
              subtitle: Text(
                  '${schedule.busRoute.cityFrom} to ${schedule.busRoute.cityTo}'),
              trailing: Text(schedule.departureTime),
            ),
            Padding(
              padding: const EdgeInsets.all(16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text('Available Seats'),
                  Text(schedule.busRoute.cityFrom)
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text('Fare'),
                  Text(schedule.ticketPrice.toStringAsFixed(2))
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
