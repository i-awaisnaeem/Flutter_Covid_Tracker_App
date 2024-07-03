import 'package:covid_tracker_app/View/world_stats.dart';
import 'package:flutter/material.dart';
import 'countries_list.dart';

class DetailsScreen extends StatefulWidget {

  String name;
  String image;
  int totalCases, totalDeaths, totalRecovered, active, critical, todayRecovered, test;

   DetailsScreen({
    required this.name,
    required this.image,
    required this.totalRecovered,
    required this.totalCases,
    required this.totalDeaths,
    required this.active,
    required this.critical,
    required this.todayRecovered,
    required this.test
});

  @override
  State<DetailsScreen> createState() => _DetailsScreenState();
}

class _DetailsScreenState extends State<DetailsScreen> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.name),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Stack(
                alignment: Alignment.topCenter,
                children: [
                  Padding(padding: EdgeInsets.only(top: MediaQuery.of(context).size.height * .067),
                  child: Card(
                    child: Column(
                      children: [
                        SizedBox(height: MediaQuery.of(context).size.height * .06,),
                        ResuseableRow(title: 'Total Cases', value: widget.totalCases.toString()),
                        ResuseableRow(title: 'Total Recovered', value: widget.totalRecovered.toString()),
                        ResuseableRow(title: 'Deaths', value: widget.totalDeaths.toString()),
                        ResuseableRow(title: 'Active Cases', value: widget.active.toString()),
                        ResuseableRow(title: 'Critical', value: widget.critical.toString()),
                        ResuseableRow(title: 'Today Recovered', value: widget.todayRecovered.toString()),
                        ResuseableRow(title: 'Tests', value: widget.test.toString()),
                      ],
                    ),
                  ),),
                  CircleAvatar(
                    radius: 50,
                    backgroundImage: NetworkImage(widget.image),
                  )
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
