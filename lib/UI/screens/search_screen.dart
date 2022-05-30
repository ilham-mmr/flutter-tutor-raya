import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:provider/provider.dart';
import 'package:tutor_raya_mobile/UI/widgets/tutor_card.dart';
import 'package:tutor_raya_mobile/models/tutor.dart';
import 'package:tutor_raya_mobile/providers/tutor.dart';
import 'package:tutor_raya_mobile/styles/color_constants.dart';
import 'package:tutor_raya_mobile/styles/style_constants.dart';
import 'package:intl/intl.dart';

class SearchScreen extends StatefulWidget {
  SearchScreen({Key? key}) : super(key: key);

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  DateTime _selectedDate = DateTime.now();

  final TextEditingController textEditingController = TextEditingController();

  RangeValues _currentPriceRange = const RangeValues(0, 500000);
  List<String> selected = [];

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
      body: SafeArea(
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
                  labelStyle: const TextStyle(
                    fontSize: 20,
                  ),
                  hintText: 'Search Tutor here',
                  prefixIcon: const Icon(Icons.search),
                  suffixIcon: IconButton(
                    onPressed: () {
                      _showFilter(context);
                    },
                    icon: const FaIcon(FontAwesomeIcons.filter),
                  ),
                ),
                onFieldSubmitted: (value) {
                  _querySearch(context, value);
                },
              ),
              Expanded(
                flex: 10,
                child: Consumer<TutorProvider>(
                  builder: (context, tutorsList, child) {
                    List<Tutor> tutors = tutorsList.tutors;

                    return ListView.builder(
                      itemCount: tutors.length,
                      itemBuilder: (context, index) {
                        return ChangeNotifierProvider.value(
                            value: tutors[index], child: TutorCard());
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
                              Text(
                                DateFormat("EEEE, d MMMM y")
                                    .format(_selectedDate)
                                    .toString(),
                                style:
                                    kTitleBoldTextStyle.copyWith(fontSize: 18),
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
      initialDate: _selectedDate, // Refer step 1
      firstDate: DateTime(2000),
      lastDate: DateTime(2025),
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
      "date": "",
      "category": ""
    };
    // context.loaderOverlay.show();
    await Provider.of<TutorProvider>(context, listen: false)
        .searchTutors(keyword: value, filters: filters);
    // context.loaderOverlay.hide();

    // Navigator.of(context).pop();
  }
}
