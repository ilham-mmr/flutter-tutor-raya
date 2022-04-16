import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class TutorCard extends StatelessWidget {
  const TutorCard({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Card(
        elevation: 2,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15.0),
        ),
        child: SizedBox(
          height: 500,
          width: 200,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Stack(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(15),
                        topRight: Radius.circular(15)),
                    child: Image.network(
                      "https://picsum.photos/500/200?random=1",
                      height: 90,
                      width: 200,
                      fit: BoxFit.contain,
                    ),
                  ),
                  Positioned(
                    bottom: 50,
                    right: 15, //give the values according to your requirement
                    child: CircleAvatar(
                      radius: 16,
                      backgroundColor: Colors.white,
                      child: Icon(
                        Icons.favorite,
                        color: Colors.red,
                      ),
                    ),
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('David'),
                    Text('Rp90000/hr'),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  children: [
                    Text('Programming'),
                    SizedBox(
                      width: 4,
                    ),
                    Text('Maths'),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(right: 6),
                      child: FaIcon(
                        FontAwesomeIcons.solidStar,
                        color: Colors.yellow,
                        size: 16,
                      ),
                    ),
                    Text('5.0'),
                    Text('(34)'),
                  ],
                ),
              )
              // Padding(
              //   padding: const EdgeInsets.all(8.0),
              //   child: Row(
              //     children: [
              //       Text('Technology'),
              //       SizedBox(
              //         width: 4,
              //       ),
              //       Text('Science'),
              //     ],
              //   ),
              // ),
            ],
          ),
        ),
      ),
    );
  }
}
