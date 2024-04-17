import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class InvestementPage extends StatefulWidget {
  const InvestementPage({super.key});

  @override
  State<InvestementPage> createState() => _InvestementPageState();
}

class _InvestementPageState extends State<InvestementPage> {
  final TooltipBehavior _tooltip = TooltipBehavior(
    enable: true,
  );
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 20,
          vertical: 10,
        ),
        child: Column(children: [
          createHeader(),
          const SizedBox(height: 20),
          createBody(),
        ]),
      ),
    );
  }

  Widget createHeader() {
    return Row(
      children: [
        const Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Balance investment', style: TextStyle(color: Colors.white)),
            Text(
              '\$390,000',
              style: TextStyle(
                color: Colors.white,
                fontSize: 25,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
        const SizedBox(width: 20),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
          decoration: BoxDecoration(
            color: Colors.green[200]!.withOpacity(0.1),
            borderRadius: BorderRadius.circular(20),
          ),
          child: Text(
            '+2.5%',
            style: TextStyle(
              color: Colors.green[200],
              fontSize: 12,
              fontWeight: FontWeight.w900,
            ),
          ),
        ),
      ],
    );
  }

  Widget createBody() {
    var data = [
      _ChartData("Jan", [200, 230, 250, 270, 290]),
      _ChartData("Feb", [210, 240, 260, 280, 300]),
      _ChartData("Mar", [220, 250, 270, 290, 310]),
      _ChartData("Apr", [230, 260, 280, 300, 320]),
      _ChartData("May", [240, 270, 290, 310, 330]),
      _ChartData("Jun", [250, 280, 300, 320, 340]),
      _ChartData("Jul", [260, 290, 310, 330, 350]),
      _ChartData("Aug", [270, 300, 320, 340, 360]),
    ];
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white12,
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.16),
            blurRadius: 50,
          ),
        ],
      ),
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(6),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(20),
            ),
            child: ListTile(
              leading: SvgPicture.asset('assets/google.svg', height: 40, width: 40),
              title: const Text('Alpha', style: TextStyle(fontWeight: FontWeight.bold)),
              subtitle: const Text('Goo', style: TextStyle(color: Colors.black54)),
              trailing: const Text('\$220.00', style: TextStyle(color: Colors.black, fontSize: 20)),
            ),
          ),
          const SizedBox(height: 30),
          SizedBox(
              height: 250,
              child: SfCartesianChart(
                  plotAreaBorderWidth: 0,
                  primaryXAxis: const CategoryAxis(
                    labelStyle: TextStyle(color: Colors.white),
                    majorGridLines: MajorGridLines(width: 0),
                  ),
                  primaryYAxis: const NumericAxis(
                    labelStyle: TextStyle(color: Colors.white),
                    majorGridLines: MajorGridLines(width: 0),
                  ),
                  tooltipBehavior: _tooltip,
                  series: <CartesianSeries<_ChartData, String>>[
                    BoxAndWhiskerSeries<_ChartData, String>(
                      dataSource: data,
                      width: 0.1,
                      xValueMapper: (_ChartData data, _) => data.x,
                      yValueMapper: (_ChartData data, _) => data.y,
                      name: 'Value',
                      showMean: true,
                      gradient: LinearGradient(colors: [
                        Colors.green[100]!,
                        Colors.green[300]!,
                      ]),
                    )
                  ])),
          const SizedBox(height: 30),
          Wrap(
            children: [
              Container(
                width: 100,
                padding: const EdgeInsets.symmetric(vertical: 10),
                decoration: BoxDecoration(
                  color: Colors.white12,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: const Column(
                  children: [
                    Text('\$220.00', style: TextStyle(color: Colors.green, fontSize: 20)),
                    Text('Hight', style: TextStyle(color: Colors.white24)),
                  ],
                ),
              ),
              const SizedBox(width: 20),
              Container(
                width: 100,
                padding: const EdgeInsets.symmetric(vertical: 10),
                decoration: BoxDecoration(
                  color: Colors.white12,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: const Column(
                  children: [
                    Text('\$220.00', style: TextStyle(color: Colors.red, fontSize: 20)),
                    Text('Low', style: TextStyle(color: Colors.white24)),
                  ],
                ),
              ),
              const SizedBox(width: 30),
              Container(
                width: 100,
                padding: const EdgeInsets.symmetric(vertical: 10),
                decoration: BoxDecoration(
                  color: Colors.white12,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: const Column(
                  children: [
                    Text('25.85', style: TextStyle(color: Colors.white, fontSize: 20)),
                    Text('Vol', style: TextStyle(color: Colors.white24)),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 20),
          Row(
            children: [
              Expanded(
                child: ElevatedButton(
                    onPressed: () {},
                    style: ButtonStyle(
                      shape: MaterialStatePropertyAll(RoundedRectangleBorder(borderRadius: BorderRadius.circular(200))),
                      backgroundColor: const MaterialStatePropertyAll(Colors.white),
                      padding: const MaterialStatePropertyAll(EdgeInsets.symmetric(vertical: 15)),
                    ),
                    child: const Text('Withdraw', style: TextStyle(color: Colors.black, fontSize: 20))),
              ),
              const SizedBox(width: 20),
              Expanded(
                child: ElevatedButton(
                    onPressed: () {},
                    style: ButtonStyle(
                      shape: MaterialStatePropertyAll(RoundedRectangleBorder(borderRadius: BorderRadius.circular(200))),
                      backgroundColor: MaterialStatePropertyAll(Colors.green[200]),
                      padding: const MaterialStatePropertyAll(EdgeInsets.symmetric(vertical: 15)),
                    ),
                    child: const Text('Buy', style: TextStyle(color: Colors.black, fontSize: 20))),
              ),
            ],
          )
        ],
      ),
    );
  }
}

class _ChartData {
  _ChartData(this.x, this.y);

  final String x;
  final List<double> y;
}
