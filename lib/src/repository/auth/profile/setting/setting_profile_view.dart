import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:vidvibe/src/repository/classes/repository_text.dart';

class SettingProfileView extends StatelessWidget {
  const SettingProfileView({super.key});

  @override
  Widget build(BuildContext context) {
    final h = MediaQuery.of(context).size.height;
    final w = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {},
          icon: Icon(
            Icons.arrow_back_ios,
            color: Colors.black,
            size: h * 0.03,
          ),
        ),
        title: Text(
          RepositoryText.setting,
          style: GoogleFonts.pacifico(
            textStyle: TextStyle(
              color: Colors.black,
              fontSize: h * 0.04,
            ),
          ),
        ),
      ),
      body: ListView.builder(
        itemBuilder: (context, index) {
          return SizedBox(
            height: h * 0.15,
            width: w,
            child: Stack(
              alignment: Alignment.bottomCenter,
              children: [
                Container(
                  height: h * 0.1,
                  width: w,
                  color: Colors.amber,
                ),
                Positioned(
                  top: 10,
                  right: 20,
                  child: Image.asset(
                    'assets/icons/delete_10024290.png',
                    width: w * 0.1,
                    height: h * 0.1,
                  ),
                ),
              ],
            ),
          );
        },
        shrinkWrap: true,
        itemCount: 5,
      ),
    );
  }
}
