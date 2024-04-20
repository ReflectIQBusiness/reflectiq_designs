import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  @override
  Widget build(BuildContext context) {
    var outlineInputBorder = OutlineInputBorder(
      borderRadius: BorderRadius.circular(20),
      borderSide: const BorderSide(
        width: 0.5,
        color: Color(0xff828282),
      ),
    );
    var focusBorder = OutlineInputBorder(
      borderRadius: BorderRadius.circular(20),
      borderSide: const BorderSide(
        width: 0.5,
        color: Color(0xff828282),
      ),
    );
    return Scaffold(
      appBar: AppBar(
          toolbarHeight: 100,
          leadingWidth: 70,
          leading: IconButton(
            icon: SvgPicture.asset('assets/arrow.svg'),
            onPressed: () {
              Navigator.pop(context);
            },
          )),
      body: Center(
        child: Column(
          children: <Widget>[
            Text(
              'Create an account',
              style: GoogleFonts.dmSans(fontSize: 34, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 5),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: MediaQuery.of(context).size.width / 7),
              child: Text(
                'Invest and double your income now',
                style: GoogleFonts.roboto(
                  fontSize: 17,
                  fontWeight: FontWeight.w600,
                  color: const Color(0xff4F4F4F),
                ),
                textAlign: TextAlign.center,
              ),
            ),
            SizedBox(height: MediaQuery.of(context).size.height / 10.71),
            SizedBox(
              width: MediaQuery.of(context).size.width / 1.2,
              child: TextFormField(
                decoration: InputDecoration(
                  hintText: 'Full name',
                  hintStyle: GoogleFonts.roboto(
                    fontSize: 17,
                    fontWeight: FontWeight.normal,
                    color: const Color(0xff828282),
                  ),
                  border: outlineInputBorder,
                  focusedBorder: focusBorder,
                  enabledBorder: outlineInputBorder,
                ),
              ),
            ),
            const SizedBox(height: 20),
            SizedBox(
              width: MediaQuery.of(context).size.width / 1.2,
              child: TextFormField(
                decoration: InputDecoration(
                  hintText: 'Email address',
                  hintStyle: GoogleFonts.roboto(
                    fontSize: 17,
                    fontWeight: FontWeight.normal,
                    color: const Color(0xff828282),
                  ),
                  contentPadding: const EdgeInsets.all(20),
                  border: outlineInputBorder,
                  focusedBorder: focusBorder,
                  enabledBorder: outlineInputBorder,
                ),
              ),
            ),
            const SizedBox(height: 20),
            SizedBox(
              width: MediaQuery.of(context).size.width / 1.2,
              child: TextFormField(
                decoration: InputDecoration(
                  hintText: 'Password',
                  hintStyle: GoogleFonts.roboto(
                    fontSize: 17,
                    fontWeight: FontWeight.normal,
                    color: const Color(0xff828282),
                  ),
                  contentPadding: const EdgeInsets.all(20),
                  border: outlineInputBorder,
                  focusedBorder: focusBorder,
                  enabledBorder: outlineInputBorder,
                ),
              ),
            ),
            const SizedBox(height: 20),
            //button
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
            SizedBox(height: MediaQuery.of(context).size.height / 45),
            TextButton(
              style: TextButton.styleFrom(
                maximumSize: Size(MediaQuery.of(context).size.width / 1.2, 60),
                minimumSize: Size(MediaQuery.of(context).size.width / 1.2, 60),
              ),
              onPressed: () {
                Navigator.pushNamed(context, '/login');
              },
              child: Text(
                'Already have an account?',
                style: GoogleFonts.roboto(
                  fontSize: 17,
                  fontWeight: FontWeight.w600,
                  color: const Color(0xff31A062),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
