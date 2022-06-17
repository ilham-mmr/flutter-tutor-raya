import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:provider/provider.dart';
import 'package:toast/toast.dart';
import 'package:tutor_raya_mobile/UI/widgets/category_item.dart';
import 'package:tutor_raya_mobile/UI/widgets/tutor_card.dart';
import 'package:tutor_raya_mobile/models/category.dart';
import 'package:tutor_raya_mobile/models/tutor.dart';
import 'package:tutor_raya_mobile/providers/category.dart';
import 'package:tutor_raya_mobile/providers/tutor.dart';
import 'package:tutor_raya_mobile/styles/color_constants.dart';
import 'package:tutor_raya_mobile/styles/style_constants.dart';
import 'package:intl/intl.dart';
import 'package:collection/collection.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({Key? key}) : super(key: key);

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
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
              TextFormField(
                keyboardType: TextInputType.emailAddress,
                cursorColor: kTorqueiseBackgroundColor,
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
              Expanded(
                flex: 10,
                child: Consumer<TutorProvider>(
                  builder: (context, tutorsList, child) {
                    List<Tutor> tutors = tutorsList.tutors;
                    if (tutors.isEmpty) {
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
                      itemCount: tutors.length,
                      itemBuilder: (context, index) {
                        return ChangeNotifierProvider.value(
                            value: tutors[index], child: const TutorCard());
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

  List<Category> _pickedItems = [];

  _showFilter(BuildContext context) async {
    await Provider.of<CategoryProvider>(context, listen: false)
        .getCategoryList();
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
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'Filter',
                            style: kTitleBoldTextStyle.copyWith(fontSize: 38),
                          ),
                          IconButton(
                            onPressed: () async {
                              var category = Provider.of<CategoryProvider>(
                                  context,
                                  listen: false);
                              category.emptyCategoryList();
                              await category.getCategoryList();

                              setState(() {
                                _currentPriceRange =
                                    const RangeValues(0, 500000);
                                _selectedDate = null;
                                _pickedItems = [];
                              });
                            },
                            icon: const Icon(Icons.restore_outlined),
                            color: kOrangeBackgroundColor,
                          )
                        ],
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
                                  ? Text(
                                      'Select your prefered date',
                                      style: kTitleBoldTextStyle.copyWith(
                                        fontSize: 18,
                                      ),
                                    )
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
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          "Category",
                          style: kTitleBoldTextStyle,
                        ),
                      ),
                      Expanded(
                        child: Consumer<CategoryProvider>(
                          builder: (context, category, child) {
                            List<Category> categoryList = category.categoryList;
                            if (categoryList.isEmpty) {
                              return const Center(
                                  child: CircularProgressIndicator());
                            }
                            return ListView.builder(
                              scrollDirection: Axis.horizontal,
                              itemCount: categoryList.length,
                              itemBuilder: (context, index) {
                                Category category = categoryList[index];
                                Category? pickedItem =
                                    _pickedItems.firstWhereOrNull(
                                        (element) => element.id == category.id);
                                return CategoryItem(
                                  category: category,
                                  isSelected: pickedItem != null ? true : false,
                                  onSelected: (value) {
                                    if (value) {
                                      //add to the list
                                      _pickedItems.add(categoryList[index]);
                                    } else {
                                      _pickedItems.removeWhere((element) =>
                                          element.id == categoryList[index].id);
                                    }

                                    setState(() {});
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
        initialDate: _selectedDate ?? DateTime.now(),
        firstDate: DateTime.now(),
        lastDate: DateTime(2100),
        builder: (context, child) {
          return Theme(
            data: Theme.of(context).copyWith(
              colorScheme: ColorScheme.light(
                primary: kOrangeBackgroundColor, // header background color
                onPrimary: Colors.white, // header text color
                onSurface: Colors.black, // body text color
              ),
            ),
            child: child!,
          );
        });
    if (picked != null && picked != _selectedDate) {
      _selectedDate = picked;
      setState(() {});
    }
  }

  void _querySearch(
    BuildContext context,
    String value,
  ) async {
    String categories = "";
    for (var element in _pickedItems) {
      categories += '${element.id.toString()},';
    }

    Map<String, dynamic>? filters = {
      "minPrice": _currentPriceRange.start.toString(),
      "maxPrice": _currentPriceRange.end.toString(),
      "date":
          _selectedDate == null ? "" : _selectedDate.toString().split(" ")[0],
      "category": categories
    };
    context.loaderOverlay.show();
    var tutorProvider = Provider.of<TutorProvider>(context, listen: false);
    await tutorProvider.searchTutors(keyword: value, filters: filters);
    if (tutorProvider.tutors.isEmpty) {
      Toast.show("Tutors aren't available now, try again later",
          duration: Toast.lengthLong, gravity: Toast.bottom);
    }

    context.loaderOverlay.hide();

    // Navigator.of(context).pop();
  }
}
