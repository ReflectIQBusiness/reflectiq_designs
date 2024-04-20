import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: const Color(0xffF6F6F9),
        appBar: AppBar(
            backgroundColor: Colors.transparent,
            elevation: 0,
            toolbarHeight: 100,
            leadingWidth: 70,
            leading: IconButton(
              icon: SvgPicture.asset('assets/menu.svg'),
              onPressed: () {
                // Navigator.pop(context);
              },
            ),
            actions: [
              IconButton(
                icon: SvgPicture.asset('assets/notification.svg'),
                onPressed: () {
                  // Navigator.pop(context);
                },
              ),
              const SizedBox(width: 20),
            ],
            bottom: PreferredSize(
              preferredSize: const Size.fromHeight(0),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: createHeader(),
              ),
            )),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 30),
            child: Column(children: [
              createOverview(context),
              Row(
                children: [
                  Text(
                    'Best Plans',
                    style: GoogleFonts.dmSans(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const Spacer(),
                  Text(
                    'See All →',
                    style: GoogleFonts.roboto(
                      fontSize: 18,
                      fontWeight: FontWeight.w500,
                      color: const Color(0xffFE555D),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              createPlans(context),
              const SizedBox(height: 40),
              Row(
                children: [
                  Text(
                    'Investment Guide',
                    style: GoogleFonts.dmSans(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              ListTile(
                title: Text(
                  'Basic type of investments',
                  style: GoogleFonts.dmSans(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: const Color(0xff4F4F4F),
                  ),
                ),
                subtitle: Text(
                  'This is how you set your foot for 2020 Stock market recession. What’s next for you? This is how you set your foot for 2020 Stock market recession. What’s next for you?',
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: GoogleFonts.roboto(
                    fontSize: 14,
                    fontWeight: FontWeight.normal,
                    color: const Color(0xff474747),
                  ),
                ),
                trailing: const CircleAvatar(
                  radius: 30,
                  backgroundImage: NetworkImage('https://picsum.photos/200'),
                ),
              ),
              const Divider(
                indent: 30,
                endIndent: 30,
              ),
              ListTile(
                title: Text(
                  'How much can you start with?',
                  style: GoogleFonts.dmSans(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: const Color(0xff4F4F4F),
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                subtitle: Text(
                  'What do you like to see? It’s a very different market from 2018. The way you invest in 2020 will be different from 2018.',
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: GoogleFonts.roboto(
                    fontSize: 14,
                    fontWeight: FontWeight.normal,
                    color: const Color(0xff474747),
                  ),
                ),
                trailing: const CircleAvatar(
                  radius: 30,
                  backgroundImage: NetworkImage('https://picsum.photos/300'),
                ),
              ),
            ]),
          ),
        ),
        bottomNavigationBar: createBottomBar());
  }

  SizedBox createPlans(BuildContext context) {
    return SizedBox(
      height: 200,
      child: ListView(
        itemExtent: MediaQuery.of(context).size.width / 2.5,
        padding: EdgeInsets.zero,
        shrinkWrap: true,
        scrollDirection: Axis.horizontal,
        children: [
          Container(
            height: double.infinity,
            padding: const EdgeInsets.only(
              left: 20,
              top: 20,
            ),
            decoration: BoxDecoration(
              gradient: const LinearGradient(
                colors: [Color(0xffD98F39), Color(0xffF0C735)],
                begin: Alignment.bottomLeft,
                end: Alignment.topCenter,
              ),
              borderRadius: BorderRadius.circular(20),
            ),
            width: MediaQuery.of(context).size.width / 2.5,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.max,
              children: [
                Text(
                  'Gold Plan',
                  style: GoogleFonts.roboto(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                Text(
                  '30% return',
                  style: GoogleFonts.roboto(
                    fontSize: 13,
                    fontWeight: FontWeight.w600,
                    color: Colors.white,
                  ),
                ),
                const Spacer(),
                Align(
                  alignment: Alignment.bottomRight,
                  child: Image.asset(
                    'assets/gold.png',
                    height: 128,
                    color: const Color(0xffD98F39),
                    colorBlendMode: BlendMode.modulate,
                  ),
                )
              ],
            ),
          ),
          Container(
            height: double.infinity,
            padding: const EdgeInsets.only(
              left: 20,
              top: 20,
            ),
            margin: const EdgeInsets.only(left: 10),
            decoration: BoxDecoration(
              gradient: const LinearGradient(
                colors: [Color(0xff979797), Color(0xffCAC9C9)],
                begin: Alignment.bottomLeft,
                end: Alignment.topCenter,
              ),
              borderRadius: BorderRadius.circular(20),
            ),
            width: MediaQuery.of(context).size.width / 2.5,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.max,
              children: [
                Text(
                  'Silver Plan',
                  style: GoogleFonts.roboto(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                Text(
                  '60% return',
                  style: GoogleFonts.roboto(
                    fontSize: 13,
                    fontWeight: FontWeight.w600,
                    color: Colors.white,
                  ),
                ),
                const Spacer(),
                Align(
                  alignment: Alignment.bottomRight,
                  child: Image.asset(
                    'assets/silver.png',
                    height: 128,
                    color: const Color(0xff979797),
                    colorBlendMode: BlendMode.modulate,
                  ),
                ),
              ],
            ),
          ),
          //platinum plan
          Container(
            height: double.infinity,
            margin: const EdgeInsets.only(left: 10),
            padding: const EdgeInsets.only(
              left: 20,
              top: 20,
            ),
            decoration: BoxDecoration(
              gradient: const LinearGradient(
                colors: [Color(0xfff615EE2), Color(0xffBA8DF3)],
                begin: Alignment.bottomLeft,
                end: Alignment.topCenter,
              ),
              borderRadius: BorderRadius.circular(20),
            ),
            width: MediaQuery.of(context).size.width / 2.5,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.max,
              children: [
                Text(
                  'Platinum Plan',
                  style: GoogleFonts.roboto(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                Text(
                  '90% return',
                  style: GoogleFonts.roboto(
                    fontSize: 13,
                    fontWeight: FontWeight.w600,
                    color: Colors.white,
                  ),
                ),
                const Spacer(),
                Align(
                  alignment: Alignment.bottomRight,
                  child: Image.asset(
                    'assets/platinum.png',
                    height: 128,
                    color: const Color(0xfff615ee2),
                    colorBlendMode: BlendMode.modulate,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  BottomNavigationBar createBottomBar() {
    return BottomNavigationBar(
      backgroundColor: const Color.fromRGBO(0, 0, 0, 0),
      elevation: 0,
      showUnselectedLabels: true,
      showSelectedLabels: true,
      selectedLabelStyle: GoogleFonts.catamaran(
        fontSize: 12,
        fontWeight: FontWeight.w600,
      ),
      unselectedLabelStyle: GoogleFonts.catamaran(
        fontSize: 12,
        fontWeight: FontWeight.w600,
      ),
      type: BottomNavigationBarType.fixed,
      selectedItemColor: const Color(0xff31A062),
      unselectedItemColor: const Color(0xffBDBDBD),
      items: <BottomNavigationBarItem>[
        BottomNavigationBarItem(
          icon: Padding(
            padding: const EdgeInsets.only(bottom: 3),
            child: SvgPicture.asset('assets/Home 1.svg'),
          ),
          label: 'Home',
        ),
        BottomNavigationBarItem(
          icon: Padding(
            padding: const EdgeInsets.only(bottom: 3),
            child: SvgPicture.asset('assets/Search 1.svg'),
          ),
          label: 'Product',
        ),
        BottomNavigationBarItem(
          icon: Padding(
            padding: const EdgeInsets.only(bottom: 3),
            child: SvgPicture.asset('assets/transaction 1.svg'),
          ),
          label: 'Transaction',
        ),
        BottomNavigationBarItem(
          icon: Padding(
            padding: const EdgeInsets.only(bottom: 3),
            child: SvgPicture.asset('assets/Profile 1.svg'),
          ),
          label: 'Profile',
        ),
      ],
    );
  }

  Widget createOverview(BuildContext context) {
    return Stack(
      children: [
        Opacity(
          opacity: 0.8,
          child: ImageFiltered(
            imageFilter: ImageFilter.blur(
              sigmaX: 10,
              sigmaY: 10,
            ),
            child: SvgPicture.asset(
              'assets/shadow.svg',
              fit: BoxFit.fitWidth,
              width: MediaQuery.of(context).size.width / 1.2,
            ),
          ),
        ),
        Container(
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            gradient: const LinearGradient(
              colors: [Color(0xff31A078), Color(0xff31A05F)],
              begin: Alignment.bottomLeft,
              end: Alignment.topCenter,
            ),
            borderRadius: BorderRadius.circular(20),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.16),
                blurRadius: 4,
                offset: const Offset(0, 4), // changes position of shadow
              ),
            ],
          ),
          width: MediaQuery.of(context).size.width / 1.2,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Your total asset portfolio',
                  style: GoogleFonts.roboto(
                    fontSize: 17,
                    fontWeight: FontWeight.w600,
                    color: Colors.white,
                  )),
              const SizedBox(height: 10),
              Row(
                children: [
                  Text(
                    'N203,935',
                    style: GoogleFonts.roboto(
                      fontSize: 32,
                      fontWeight: FontWeight.w600,
                      color: Colors.white,
                    ),
                  ),
                  const Spacer(),
                  ElevatedButton(
                      onPressed: () {},
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15),
                        ),
                      ),
                      child: Text(
                        'Invest now',
                        style: GoogleFonts.roboto(
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                          color: const Color(0xff31A062),
                        ),
                      )),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }

  createHeader() {
    return Row(
      children: [
        Text(
          "Welcome, Jessie.",
          style: GoogleFonts.dmSans(
            fontSize: 34,
            fontWeight: FontWeight.bold,
          ),
          textAlign: TextAlign.start,
        ),
      ],
    );
  }
}
