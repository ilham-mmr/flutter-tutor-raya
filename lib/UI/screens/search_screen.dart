import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:tutor_raya_mobile/UI/widgets/favorite_card.dart';
import 'package:tutor_raya_mobile/UI/widgets/result_card.dart';
import 'package:tutor_raya_mobile/styles/color_constants.dart';
import 'package:tutor_raya_mobile/styles/style_constants.dart';

class SearchScreen extends StatelessWidget {
  SearchScreen({Key? key}) : super(key: key);

  DateTime selectedDate = DateTime.now();
  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
      // backgroundColor: kBasicBackgroundColor,
      body: SafeArea(
        child: SingleChildScrollView(
            child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              TextFormField(
                keyboardType: TextInputType.emailAddress,
                decoration: InputDecoration(
                  fillColor: Colors.white,
                  filled: true,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  labelStyle: TextStyle(
                    fontSize: 20,
                  ),
                  hintText: 'Search Tutor here',
                  prefixIcon: const Icon(Icons.search),
                  suffixIcon: IconButton(
                    onPressed: () {
                      showModalBottomSheet(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        context: context,
                        builder: (_) => Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            children: [
                              Text('Filter'),
                              ElevatedButton(
                                onPressed: () => _selectDate(context),
                                child: Text('Select date'),
                              ),
                              ElevatedButton(
                                onPressed: () {},
                                child: Text('apply'),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                    icon: const FaIcon(FontAwesomeIcons.filter),
                  ),
                ),
              ),
              Container(
                height: 500,
                child: ListView(
                  shrinkWrap: true,
                  children: [
                    ResultCard(),
                    ResultCard(),
                    ResultCard(),
                  ],
                ),
              )
            ],
          ),
        )),
      ),
    );
  }

  _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: selectedDate, // Refer step 1
      firstDate: DateTime(2000),
      lastDate: DateTime(2025),
    );
    if (picked != null && picked != selectedDate) {}
    // setState(() {
    //   selectedDate = picked;
    // });
  }
}
