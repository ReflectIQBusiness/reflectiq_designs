import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:iconly/iconly.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class WalletPage extends StatefulWidget {
  const WalletPage({super.key});

  @override
  State<WalletPage> createState() => _WalletPageState();
}

class _WalletPageState extends State<WalletPage> with SingleTickerProviderStateMixin {
  String _selected = "Yearly";
  final TooltipBehavior _tooltip = TooltipBehavior(
    enable: true,
  );

  TabController? _tabController;

  @override
  void initState() {
    setState(() {
      _tabController = TabController(length: 2, vsync: this);
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(children: [
        Container(
            padding: const EdgeInsets.all(20),
            margin: const EdgeInsets.symmetric(
              horizontal: 10,
              vertical: 20,
            ),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(20),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Theme(
                  data: ThemeData(
                    useMaterial3: false,
                  ),
                  child: Row(
                    children: [
                      SizedBox(
                        width: MediaQuery.of(context).size.width / 2,
                        child: TabBar(
                          labelColor: Colors.white,
                          unselectedLabelColor: const Color(0xff25272d),
                          controller: _tabController,
                          indicatorSize: TabBarIndicatorSize.tab,
                          indicator: BoxDecoration(
                            borderRadius: BorderRadius.circular(100),
                            color: const Color(0xff25272d),
                          ),
                          tabs: const [
                            Tab(
                              text: 'Income',
                            ),
                            Tab(text: 'Outcome'),
                          ],
                        ),
                      ),
                      const Spacer(),
                      createDropdown()
                    ],
                  ),
                ),
                const SizedBox(height: 20),
                SizedBox(
                  height: 350,
                  child: TabBarView(
                    controller: _tabController,
                    children: [
                      createBody(total: 3000, prices: [
                        _ChartData("Jan", 1500),
                        _ChartData("Feb", 2000),
                        _ChartData("Mar", 1800),
                        _ChartData("Apr", 2200),
                        _ChartData("May", 2500),
                        _ChartData("Jun", 2300),
                        _ChartData("Jul", 7421),
                      ]),
                      createBody(total: 3000, prices: [
                        _ChartData("Jan", 2500),
                        _ChartData("Feb", 1000),
                        _ChartData("Mar", 1800),
                        _ChartData("Apr", 2200),
                        _ChartData("May", 2500),
                        _ChartData("Jun", 2300),
                      ]),
                    ],
                  ),
                ),
              ],
            )),
        const Text(
          'Tracking By categories',
          style: TextStyle(color: Colors.white),
        ),
        Row(
          children: [
            Expanded(
              child: Container(
                padding: const EdgeInsets.all(20),
                margin: const EdgeInsets.only(left: 20, top: 20, bottom: 20),
                decoration: BoxDecoration(
                  color: Colors.white10,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: const Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        SizedBox(
                          width: 100,
                          child: Text(
                            'Monthly Salay',
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                        Icon(
                          IconlyBold.work,
                          color: Colors.white,
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Text(
                      "+\$1.290",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 25,
                        fontWeight: FontWeight.bold,
                      ),
                    )
                  ],
                ),
              ),
            ),
            Expanded(
              child: Container(
                padding: const EdgeInsets.all(20),
                margin: const EdgeInsets.only(right: 20, top: 20, bottom: 20, left: 5),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: const Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        SizedBox(
                          width: 100,
                          child: Text(
                            'Stock Dividend',
                            style: TextStyle(color: Color(0xff25272d)),
                          ),
                        ),
                        Icon(
                          IconlyBold.category,
                          color: Color(0xff25272d),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Text(
                      "+\$400",
                      style: TextStyle(
                        color: Color(0xff25272d),
                        fontSize: 25,
                        fontWeight: FontWeight.bold,
                      ),
                    )
                  ],
                ),
              ),
            )
          ],
        )
      ]),
    );
  }

  createBody({required total, required List<_ChartData> prices}) {
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      const Text('Total',
          style: TextStyle(
            color: Color(0xff25272d),
          )),
      Text(
        '+\$$total',
        style: const TextStyle(
          color: Color(0xff25272d),
          fontSize: 25,
          fontWeight: FontWeight.bold,
        ),
      ),
      SizedBox(
        height: 220,
        child: SfCartesianChart(
          plotAreaBorderWidth: 0,
          primaryXAxis: const CategoryAxis(
            majorGridLines: MajorGridLines(width: 0),
            axisLine: AxisLine(width: 0),
          ),
          primaryYAxis: const NumericAxis(
            isVisible: false,
          ),
          borderWidth: 0,
          tooltipBehavior: _tooltip,
          series: <CartesianSeries<_ChartData, String>>[
            ColumnSeries<_ChartData, String>(
              dataSource: prices,
              xValueMapper: (_ChartData data, _) => data.x,
              yValueMapper: (_ChartData data, _) => data.y,
              name: 'Price variation',
              gradient: LinearGradient(
                colors: [
                  const Color(0xff25272d),
                  const Color(0xff25272d).withOpacity(0.8),
                ],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
              ),
              borderRadius: BorderRadius.circular(10),
            )
          ],
        ),
      ),
      const SizedBox(
        height: 20,
      ),
      ElevatedButton(
          onPressed: () {},
          style: ButtonStyle(
            shape: MaterialStatePropertyAll(RoundedRectangleBorder(borderRadius: BorderRadius.circular(10))),
            backgroundColor: MaterialStatePropertyAll(Colors.green[200]),
            maximumSize: const MaterialStatePropertyAll(Size(double.infinity, 50)),
            minimumSize: const MaterialStatePropertyAll(Size(double.maxFinite, 50)),
          ),
          child: const Text('Download report', style: TextStyle(color: Color(0xff25272d)))),
    ]);
  }

  Widget createDropdown() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 5),
      decoration: BoxDecoration(
        color: CupertinoColors.systemGrey4.withOpacity(0.2),
        borderRadius: BorderRadius.circular(10),
      ),
      child: DropdownButton(
          padding: EdgeInsets.zero,
          isDense: true,
          dropdownColor: CupertinoColors.systemGrey4,
          elevation: 0,
          underline: const SizedBox(),
          style: const TextStyle(color: Color(0xff25272d)),
          icon: const Icon(
            CupertinoIcons.chevron_down,
            color: Color(0xff25272d),
            size: 12,
          ),
          value: _selected,
          items: const [
            DropdownMenuItem(
              value: "Yearly",
              child: Text(
                "Yearly",
              ),
            ),
            DropdownMenuItem(
              value: "Monthly",
              child: Text(
                "Monthly",
              ),
            ),
            DropdownMenuItem(
              value: "Daily",
              child: Text(
                "Daily",
              ),
            ),
          ],
          onChanged: (value) {
            setState(() {
              _selected = value.toString();
            });
          }),
    );
  }
}

class _ChartData {
  _ChartData(this.x, this.y);

  final String x;
  final double y;
}
