import 'package:covid_tracker_app/Model/world_stats_model.dart';
import 'package:covid_tracker_app/Services/stats_services.dart';
import 'package:covid_tracker_app/View/countries_list.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pie_chart/pie_chart.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class WorldStatsScreen extends StatefulWidget {
  const WorldStatsScreen({super.key});

  @override
  State<WorldStatsScreen> createState() => _WorldStatsScreenState();
}

class _WorldStatsScreenState extends State<WorldStatsScreen> with TickerProviderStateMixin {

  late final AnimationController _controller = AnimationController(
      duration: const Duration(seconds: 3),
      vsync: this)..repeat();

  void dispose(){
    super.dispose();
    _controller.dispose();
  }

  final colorlist = <Color> [
    const Color(0xff4285F4),
    const Color(0xff1aa260),
    const Color(0xffde5246)
  ];

  @override
  Widget build(BuildContext context) {

    StatsServices statsServices = StatsServices();

    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Column(
            children: [
              SizedBox(height: MediaQuery.of(context).size.height * .05,),
              FutureBuilder<WorldStatsModel>(
                  future: statsServices.fetchWorldStatsRecords(),
                  builder: (context, AsyncSnapshot<WorldStatsModel> snapshot){
                    if (!snapshot.hasData){
                      return Expanded(
                          flex: 1,
                          child: SpinKitFadingCircle(
                            color: Colors.white,
                            size: 50.0,
                            controller: _controller,
                          )
                      );
                    }
                    else if( snapshot.hasError){
                      return Center(
                        child: Text('Error: ${snapshot.error}'),
                      );
                    }
                    else{
                      return Column(
                        children: [
                          PieChart(
                            dataMap: {
                              "Total" : double.parse(snapshot.data!.cases.toString()),
                              "Recovered": double.parse(snapshot.data!.recovered.toString()),
                              "Deaths": double.parse(snapshot.data!.deaths.toString())
                            },
                            chartValuesOptions: const ChartValuesOptions(
                              showChartValuesInPercentage: true
                            ),
                            animationDuration: const Duration(milliseconds: 1200),
                            colorList: colorlist,
                            chartType: ChartType.ring,
                            chartRadius: MediaQuery.of(context).size.width /3,
                            legendOptions: const LegendOptions(
                                legendPosition: LegendPosition.left
                            ) ,),
                          Padding(
                            padding:  EdgeInsets.symmetric(vertical: MediaQuery.of(context).size.height * .06),
                            child: Card(
                              child: Column(
                                children: [
                                  ResuseableRow(title: 'Total', value: snapshot.data!.cases.toString()),
                                  ResuseableRow(title: 'Deaths', value: snapshot.data!.deaths.toString()),
                                  ResuseableRow(title: 'Recovered', value: snapshot.data!.recovered.toString()),
                                  ResuseableRow(title: 'Active', value: snapshot.data!.active.toString()),
                                  ResuseableRow(title: 'Critical', value: snapshot.data!.critical.toString()),
                                  ResuseableRow(title: 'Today Deaths', value: snapshot.data!.todayDeaths.toString()),
                                  ResuseableRow(title: 'Today Recovered', value: snapshot.data!.todayRecovered.toString()),
                                ],
                              ),
                            ),
                          ),
                          GestureDetector(
                            onTap: (){
                              Navigator.push(context, MaterialPageRoute(builder: (context)=> CountriesListScreen()));
                            },
                            child: Container(
                              height: 60,
                              decoration: BoxDecoration(
                                  color:  const Color(0xff1aa260),
                                  borderRadius: BorderRadius.circular(10)),
                              child: const Center(
                                child: Text("Track Countries"),
                              ),
                            ),
                          )
                        ],
                      );
                    }
                  },),
            ],
          ),
        ),
      ),
    );
  }
}

class ResuseableRow extends StatelessWidget {
  String title, value;
   ResuseableRow({required this.title, required this.value});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 10,right: 10,top: 10,bottom: 5),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(title),
              Text(value)
            ],
          ),
          const SizedBox(height: 5,),
          const Divider()
        ],
      ),
    );
  }
}
