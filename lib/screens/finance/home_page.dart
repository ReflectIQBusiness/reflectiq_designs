import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with TickerProviderStateMixin {
  String _selected = "January";
  TabController? _tabController;
  @override
  void initState() {
    setState(() {
      _tabController = TabController(length: 3, vsync: this);
    });
    super.initState();
  }

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
          createOverview(),
          createTracking(),
        ]),
      ),
    );
  }

  Container createTracking() {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: const Color(0xff1e2026),
        borderRadius: BorderRadius.circular(30),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          const Text(
            'Tracking your finance goal',
            style: TextStyle(color: Colors.white),
          ),
          const SizedBox(height: 20),
          //tab bar view
          Theme(
            data: ThemeData(
              useMaterial3: false,
            ),
            child: DefaultTabController(
              length: 3,
              child: TabBar(
                labelColor: const Color(0xff25272d),
                unselectedLabelColor: Colors.white54,
                labelPadding: const EdgeInsets.all(0),
                controller: _tabController,
                indicatorSize: TabBarIndicatorSize.tab,
                indicator: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Colors.white54,
                ),
                tabs: const [
                  Tab(
                    text: 'Home',
                  ),
                  Tab(text: 'New Car'),
                  Tab(text: 'Vacation'),
                ],
              ),
            ),
          ),
          const SizedBox(height: 20),
          SizedBox(
            height: 220,
            child: TabBarView(
              controller: _tabController,
              children: [
                createBody(
                  price: 3000,
                  saving: 700,
                  target: 24000,
                ),
                createBody(
                  price: 100,
                  saving: 800,
                  target: 4000,
                ),
                createBody(
                  price: 200,
                  saving: 300,
                  target: 1000,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Column createBody({required double price, required double saving, required double target}) {
    return Column(
      children: [
        Text('\$$price', style: const TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold)),
        Chip(
          shape: const StadiumBorder(),
          shadowColor: Colors.transparent,
          padding: EdgeInsets.zero,
          labelStyle: TextStyle(color: Colors.green[200]),
          label: const Text('On track'),
          color: MaterialStatePropertyAll(Colors.black.withOpacity(0.5)),
        ),
        const SizedBox(height: 30),
        Row(
          children: [
            Text('Routine saving: \$$saving', style: const TextStyle(color: Colors.white)),
            const Spacer(),
            Text('Target \$$target', style: const TextStyle(color: Colors.white)),
          ],
        ),
        const SizedBox(height: 10),
        LinearProgressIndicator(
          value: saving / target,
          color: Colors.green[200],
          backgroundColor: Colors.white24,
          borderRadius: BorderRadius.circular(20),
        ),
        const SizedBox(height: 20),
        ElevatedButton(
            onPressed: () {},
            style: ButtonStyle(
              shape: MaterialStatePropertyAll(RoundedRectangleBorder(borderRadius: BorderRadius.circular(10))),
              backgroundColor: MaterialStatePropertyAll(Colors.green[200]),
              maximumSize: const MaterialStatePropertyAll(Size(double.infinity, 50)),
              minimumSize: const MaterialStatePropertyAll(Size(double.maxFinite, 50)),
            ),
            child: const Text('Add income', style: TextStyle(color: Colors.black))),
      ],
    );
  }

  Widget createOverview() {
    return ListView.builder(
      shrinkWrap: true,
      padding: const EdgeInsets.only(bottom: 20),
      physics: const NeverScrollableScrollPhysics(),
      itemCount: 2,
      itemBuilder: (context, index) {
        return Container(
          margin: const EdgeInsets.only(bottom: 10),
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: const Color(0xff1e2026),
            borderRadius: BorderRadius.circular(10),
          ),
          child: Row(
            children: [
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.35,
                child: Text(
                  index == 0 ? 'Monthly total income' : 'Monthly Spending',
                  style: const TextStyle(color: Colors.white, fontSize: 14),
                ),
              ),
              const Spacer(),
              Text(
                index == 0 ? '\$1,000,000' : '\$500,000',
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(width: 3),
              Icon(
                index == 0 ? CupertinoIcons.arrow_up : CupertinoIcons.arrow_down,
                color: index == 0 ? Colors.green : Colors.red,
              ),
            ],
          ),
        );
      },
    );
  }

  Column createHeader() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            const Text('Our balance', style: TextStyle(color: Colors.white)),
            const Spacer(),
            createMonthsDropdown(),
          ],
        ),
        const Text(
          '\$1,000,000',
          style: TextStyle(
            color: Colors.white,
            fontSize: 25,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }

  Widget createMonthsDropdown() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 2),
      decoration: BoxDecoration(
        color: Colors.white24,
        borderRadius: BorderRadius.circular(10),
      ),
      child: DropdownButton(
          padding: EdgeInsets.zero,
          isDense: true,
          dropdownColor: const Color(0xff25272d),
          underline: const SizedBox(),
          style: const TextStyle(color: Colors.white),
          icon: const Icon(
            CupertinoIcons.chevron_down,
            color: Colors.white,
            size: 12,
          ),
          value: _selected,
          items: const [
            DropdownMenuItem(
              value: "January",
              child: Text("January"),
            ),
            DropdownMenuItem(
              value: "February",
              child: Text("February"),
            ),
            DropdownMenuItem(
              value: "March",
              child: Text("March"),
            ),
            DropdownMenuItem(
              value: "April",
              child: Text("April"),
            ),
            DropdownMenuItem(
              value: "May",
              child: Text("May"),
            ),
            DropdownMenuItem(
              value: "June",
              child: Text("June"),
            ),
            DropdownMenuItem(
              value: "July",
              child: Text("July"),
            ),
            DropdownMenuItem(
              value: "August",
              child: Text("August"),
            ),
            DropdownMenuItem(
              value: "September",
              child: Text("September"),
            ),
            DropdownMenuItem(
              value: "October",
              child: Text("October"),
            ),
            DropdownMenuItem(
              value: "November",
              child: Text("November"),
            ),
            DropdownMenuItem(
              value: "December",
              child: Text("December"),
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
// SingleChildScrollView(
//       child: Padding(
//         padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             createHeader(),
//             const SizedBox(height: 20),
//             createOverview(),
//             createTracking(),
//           ],
//         ),
//       ),
//     );