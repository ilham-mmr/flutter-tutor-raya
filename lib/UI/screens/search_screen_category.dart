import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';
import 'package:provider/provider.dart';
import 'package:tutor_raya_mobile/UI/screens/search_screen.dart';
import 'package:tutor_raya_mobile/UI/widgets/tutor_card.dart';
import 'package:tutor_raya_mobile/models/tutor.dart';
import 'package:tutor_raya_mobile/providers/tutor.dart';
import 'package:tutor_raya_mobile/styles/color_constants.dart';
import 'package:tutor_raya_mobile/styles/style_constants.dart';
import 'package:intl/intl.dart';

class SearchScreenCategory extends StatefulWidget {
  const SearchScreenCategory({Key? key, required this.keyword})
      : super(key: key);
  final String keyword;
  @override
  State<SearchScreenCategory> createState() => _SearchScreenCategoryState();
}

class _SearchScreenCategoryState extends State<SearchScreenCategory> {
  DateTime? _selectedDate;

  final TextEditingController textEditingController = TextEditingController();

  RangeValues _currentPriceRange = const RangeValues(0, 500000);
  List<String> selected = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              GestureDetector(
                onTap: () {
                  Navigator.of(context).pop();
                  pushNewScreen(
                    context,
                    screen: const SearchScreen(),
                    withNavBar: true, // OPTIONAL VALUE. True by default.
                    pageTransitionAnimation: PageTransitionAnimation.slideUp,
                  );
                },
                child: TextFormField(
                  keyboardType: TextInputType.emailAddress,
                  cursorColor: kTorqueiseBackgroundColor,
                  enabled: false,
                  decoration: InputDecoration(
                    fillColor: Colors.white,
                    filled: true,
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: kTorqueiseBackgroundColor),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: kTorqueiseBackgroundColor),
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    labelStyle: const TextStyle(
                      fontSize: 20,
                    ),
                    hintText: 'Search Tutor here',
                    prefixIcon: Icon(
                      Icons.search,
                      color: kTorqueiseBackgroundColor,
                    ),
                    suffixIcon: IconButton(
                      onPressed: () {
                        _showFilter(context);
                      },
                      icon: FaIcon(
                        FontAwesomeIcons.filter,
                        color: kTorqueiseBackgroundColor,
                      ),
                    ),
                  ),
                  onFieldSubmitted: (value) {
                    _querySearch(context, value);
                  },
                ),
              ),
              Expanded(
                flex: 10,
                child: Consumer<TutorProvider>(
                  builder: (context, tutorsList, child) {
                    // List<Tutor> tutors = tutorsList.tutors;

                    return FutureBuilder(
                      future: tutorsList.getTutorsByCategory(
                          keyword: widget.keyword),
                      builder: (context, snapshot) {
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return const Center(
                            child: CircularProgressIndicator(),
                          );
                        }

                        List<Tutor> data = snapshot.data as List<Tutor>;
                        if (data.isEmpty) {
                          return SingleChildScrollView(
                            child: Padding(
                              padding: const EdgeInsets.only(top: 60),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  SvgPicture.asset(
                                    'assets/images/illustration/undraw_searching_re_3ra9.svg',
                                    height: 250,
                                  ),
                                  const Padding(
                                    padding: EdgeInsets.only(bottom: 32),
                                    child: Text(
                                      'Not Available',
                                      textAlign: TextAlign.start,
                                      style: TextStyle(fontSize: 18),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          );
                        }
                        return ListView.builder(
                          itemCount: data.length,
                          itemBuilder: (context, index) {
                            return ChangeNotifierProvider.value(
                                value: data[index], child: const TutorCard());
                          },
                        );
                      },
                    );
                  },
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  _showFilter(BuildContext context) {
    showModalBottomSheet(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
      context: context,
      builder: (context) => Padding(
        padding: const EdgeInsets.all(8.0),
        child: StatefulBuilder(
          builder: (BuildContext context, setState) {
            return Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Expanded(
                  child: Column(
                    children: [
                      Text(
                        'Filter',
                        style: kTitleBoldTextStyle.copyWith(fontSize: 38),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Price",
                            style: kTitleBoldTextStyle,
                          ),
                          Row(
                            children: [
                              Text(
                                "Rp${_currentPriceRange.start.round().toString()}",
                                style:
                                    kTitleBoldTextStyle.copyWith(fontSize: 18),
                              ),
                              const Text('-'),
                              Text(
                                "Rp${_currentPriceRange.end.round().toString()}",
                                style:
                                    kTitleBoldTextStyle.copyWith(fontSize: 18),
                              ),
                            ],
                          )
                        ],
                      ),
                      RangeSlider(
                        values: _currentPriceRange,
                        max: 500000,
                        min: 0,
                        divisions: 10,
                        activeColor: kOrangeBackgroundColor,
                        labels: RangeLabels(
                          "RP" + _currentPriceRange.start.round().toString(),
                          "RP" + _currentPriceRange.end.round().toString(),
                        ),
                        onChanged: (RangeValues values) {
                          setState(() {
                            _currentPriceRange = values;
                          });
                        },
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Date",
                            style: kTitleBoldTextStyle,
                          ),
                          Row(
                            children: [
                              _selectedDate == null
                                  ? Text('data')
                                  : Text(
                                      DateFormat("EEEE, d MMMM y")
                                          .format(_selectedDate!)
                                          .toString(),
                                      style: kTitleBoldTextStyle.copyWith(
                                          fontSize: 18),
                                    ),
                              const SizedBox(
                                width: 8,
                              ),
                              ElevatedButton(
                                onPressed: () => _selectDate(context),
                                child:
                                    const FaIcon(FontAwesomeIcons.calendarAlt),
                                style: ButtonStyle(
                                  backgroundColor: MaterialStateProperty.all(
                                      kOrangeBackgroundColor),
                                ),
                              )
                            ],
                          )
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Category",
                            style: kTitleBoldTextStyle,
                          ),
                        ],
                      ),
                      Row(
                        children: const [],
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () {
                        _querySearch(context, textEditingController.text);
                      },
                      style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.all(
                              kOrangeBackgroundColor)),
                      child: const Text('Apply'),
                    ),
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }

  _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _selectedDate!,
      firstDate: DateTime.now(),
      lastDate: DateTime(2100),
    );
    if (picked != null && picked != _selectedDate) {
      _selectedDate = picked;
      setState(() {});
    }
  }

  void _querySearch(
    BuildContext context,
    String value,
  ) async {
    Map<String, dynamic>? filters = {
      "minPrice": _currentPriceRange.start.toString(),
      "maxPrice": _currentPriceRange.end.toString(),
      "date":
          _selectedDate == null ? "" : _selectedDate.toString().split(" ")[0],
      "category": ""
    };

    context.loaderOverlay.show();
    await Provider.of<TutorProvider>(context, listen: false)
        .searchTutors(keyword: value, filters: filters);
    context.loaderOverlay.hide();

    // Navigator.of(context).pop();
  }
}
