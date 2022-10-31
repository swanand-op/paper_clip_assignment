import 'dart:math';

import 'package:flutter/material.dart';
import 'package:paper_clip_assignment/services/api%20calls/api_calls.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';

class MainUI extends StatefulWidget {
  const MainUI({Key? key}) : super(key: key);

  @override
  State<MainUI> createState() => _MainUIState();
}

class _MainUIState extends State<MainUI> {

  bool isViewMore = false;
  Future<Map> _company = APICalls().fetchCompany();
  Future<List<Map>> _performance = APICalls().fetchPerformance();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(top: 60),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              //company info
              Text(
                'Overview',
                style: TextStyle(
                  color: Colors.indigo[900],
                  fontSize: 25,
                  fontWeight: FontWeight.bold
                ),
              ),
              Divider(
                color: Colors.black,
                height: 25,
                thickness: 0.5,
              ),
              Container(
                padding: EdgeInsets.zero,
                child: FutureBuilder<Map>(
                  future: _company,
                  builder: (BuildContext context, AsyncSnapshot snapshot) {
                    if(snapshot.hasError) {
                      print(snapshot.error);
                      return Center(child: Text("error occurred ${snapshot.error}"),);
                    }
                    if(snapshot.hasData) {
                      var companyInfo = snapshot.data;
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          ListTile(
                            leading: Text(
                              'Sector',
                              style: TextStyle(
                                color: Colors.indigo[800],
                                fontSize: 15,
                              ),
                            ),
                            trailing: Wrap(
                              children: [
                                Icon(Icons.account_balance_outlined, color: Colors.amber,),
                                SizedBox(width: 10,),
                                Text(
                                  companyInfo['Sector'],
                                  style: TextStyle(
                                      fontSize: 15
                                  ),
                                ),
                              ],
                            ),
                          ),
                          ListTile(
                            leading: Text(
                              'Industry',
                              style: TextStyle(
                                color: Colors.indigo[800],
                                fontSize: 15,
                              ),
                            ),
                            trailing: Wrap(
                              children: [
                                Icon(Icons.account_balance_sharp, color: Colors.amber,),
                                SizedBox(width:10,),
                                Text(
                                  companyInfo['Industry'],
                                  style: TextStyle(
                                      fontSize: 15
                                  ),
                                ),
                              ],
                            ),
                          ),
                          ListTile(
                            leading: Text(
                              'Market Cap.',
                              style: TextStyle(
                                color: Colors.indigo[800],
                                fontSize: 15,
                              ),
                            ),
                            trailing: Text(
                              companyInfo['MCAP'].toString() + ' Cr.',
                              style: TextStyle(
                                  fontSize: 15
                              ),
                            ),
                          ),
                          ListTile(
                            leading: Text(
                              'Enterprice Value(EV)',
                              style: TextStyle(
                                color: Colors.indigo[800],
                                fontSize: 15,
                              ),
                            ),
                            trailing: Text(
                              companyInfo['EV'].toString(),
                              style: TextStyle(
                                  fontSize: 15
                              ),
                            ),
                          ),
                          ListTile(
                            leading: Text(
                              'Book Value/Share',
                              style: TextStyle(
                                color: Colors.indigo[800],
                                fontSize: 15,
                              ),
                            ),
                            trailing: Text(
                              companyInfo['BookNavPerShare'].toString(),
                              style: TextStyle(
                                  fontSize: 15
                              ),
                            )
                          ),
                          ListTile(
                            leading: Text(
                              'Price-Earning Ratio (PE)',
                              style: TextStyle(
                                color: Colors.indigo[800],
                                fontSize: 15,
                              ),
                            ),
                            trailing: Wrap(
                              children: [
                                Icon(Icons.account_balance_outlined),
                                Text(
                                  companyInfo['Sector'],
                                  style: TextStyle(
                                      fontSize: 15
                                  ),
                                ),
                              ],
                            ),
                          ),
                          ListTile(
                            leading: Text(
                              'PEG Ratio',
                              style: TextStyle(
                                color: Colors.indigo[800],
                                fontSize: 15,
                              ),
                            ),
                            trailing: Text(
                              companyInfo['PEGRatio'].toString(),
                              style: TextStyle(
                                  fontSize: 15
                              ),
                            ),
                          ),
                          ListTile(
                            leading: Text(
                              'Dividand yeald',
                              style: TextStyle(
                                color: Colors.indigo[800],
                                fontSize: 15,
                              ),
                            ),
                            trailing: Text(
                              companyInfo['Yield'].toString(),
                              style: TextStyle(
                                  fontSize: 15
                              ),
                            )
                          ),
                          ListTile(
                            trailing: TextButton(
                              child: Text(isViewMore? 'view less': 'view more'),
                              onPressed: (){
                                setState(() {
                                  isViewMore = !isViewMore;
                                });
                              },
                            ),
                          ),
                        ],
                      );
                    }
                    return Center(child: CircularProgressIndicator(),);
                  }
                ),
              ),
              //company performance
              Text(
                'Performance',
                style: TextStyle(
                    color: Colors.indigo[900],
                    fontSize: 25,
                    fontWeight: FontWeight.bold
                ),
              ),
              Divider(
                color: Colors.black,
                height: 25,
                thickness: 0.5,
              ),
              FutureBuilder(
                future: _performance,
                builder: (BuildContext context, AsyncSnapshot snapshot) {
                  if(snapshot.hasError) {
                    print(snapshot.error);
                  }if(snapshot.hasData){
                    List<dynamic> companyPerformance = snapshot.data;
                    return ListView.builder(
                      scrollDirection: Axis.vertical,
                      shrinkWrap: true,
                      itemCount: companyPerformance.length,
                      itemBuilder: (context, index) {
                        bool isNegative = false;
                        double percentage = (companyPerformance[index]['ChangePercent'])/100;
                        if(percentage < 0) {
                          percentage = percentage.abs();
                          isNegative = true;
                        }else if(percentage > 1.0) {
                          percentage = 1;
                        }
                        return ListTile(
                          leading: Padding(
                            padding: const EdgeInsets.only(right: 20),
                            child: Text(
                              companyPerformance[index]['Label'],
                              style: TextStyle(
                                fontSize: 15,
                              ),
                            ),
                          ),

                          title: LinearPercentIndicator(
                            lineHeight: 30,
                            percent: percentage,
                            animation: true,
                            progressColor: isNegative? Colors.red:Colors.green,
                          ),
                          trailing: Wrap(
                            children: [
                              Icon(isNegative?Icons.arrow_drop_down_sharp:Icons.arrow_drop_up_rounded,
                                color: isNegative?Colors.red:Colors.green,
                              ),
                              Text(isNegative? percentage.toStringAsFixed(1) + '%':
                              (companyPerformance[index]['ChangePercent']).toStringAsFixed(1) + '%',
                                style: TextStyle(
                                  color: isNegative?Colors.red:Colors.green,
                                  fontSize: 15,
                                ),
                              ),
                            ],
                          ),
                        );
                      }
                    );
                  }
                  return Center(child: CircularProgressIndicator(),);
                }
              ),
            ],
          ),
        ),
      ),
    );
  }
}
