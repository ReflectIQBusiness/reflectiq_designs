import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class IntroPage extends StatelessWidget {
  const IntroPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Image.asset('assets/intro.png'),
            const SizedBox(height: 20),
            Text(
              'Stay on top of your finance with us.',
              style: GoogleFonts.dmSans(
                fontSize: 34,
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 11),
            Padding(
              padding: EdgeInsets.symmetric(
                horizontal: MediaQuery.of(context).size.width / 7,
              ),
              child: Text(
                'We are your new financial Advisors to recommed the best investments for you.',
                style: GoogleFonts.roboto(
                  fontSize: 17,
                  fontWeight: FontWeight.w600,
                  color: Color(0xff4F4F4F),
                ),
                textAlign: TextAlign.center,
              ),
            ),
            const SizedBox(height: 89),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                primary: const Color(0xff31A062),
                foregroundColor: Colors.white,
                maximumSize: Size(MediaQuery.of(context).size.width / 1.2, 60),
                minimumSize: Size(MediaQuery.of(context).size.width / 1.2, 60),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
              ),
              onPressed: () {
                Navigator.pushNamed(context, '/login');
              },
              child: Text(
                'Create account',
                style: GoogleFonts.roboto(
                  fontSize: 17,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
            TextButton(
              style: TextButton.styleFrom(
                maximumSize: Size(MediaQuery.of(context).size.width / 1.2, 60),
                minimumSize: Size(MediaQuery.of(context).size.width / 1.2, 60),
              ),
              onPressed: () {
                Navigator.pushNamed(context, '/login');
              },
              child: Text(
                'Login',
                style: GoogleFonts.roboto(
                  fontSize: 17,
                  fontWeight: FontWeight.w600,
                  color: Color(0xff31A062),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
