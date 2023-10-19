import 'package:flutter/material.dart';

import '../../resources/assets_maneger.dart';
import '../../resources/color_maneger.dart';
import '../../resources/responsive.dart';

class AppCard extends StatelessWidget {
  const AppCard({Key? key, required this.img, required this.name, required this.rate, required this.city}) : super(key: key);
final String img;
final String name;
final String rate;
final String city;



  @override
  Widget build(BuildContext context) {
    return SizedBox(
        width: 200,
        height: 200,
        child: Material(
          elevation: 5,
          borderRadius: BorderRadius.circular(10),
          child: Column(
            children: [
              Expanded(
                flex: 2,
                child: Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      image: DecorationImage(
                          image: NetworkImage(img),
                          fit: BoxFit.cover)),
                ),
              ),

              Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Text(name),
                            Spacer(),
                            Text(
                             rate,
                              style: TextStyle(color: ColorManager.star),
                            ),
                            Icon(
                              Icons.star,
                              color: ColorManager.star,
                              size: 20,
                            )
                          ],
                        ),
                        responsive.sizedBoxH5,
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Icon(
                              Icons.location_on_outlined,
                              size: 15,
                            ),
                            Text(city),
                            Spacer(),
                            Text(
                              'see details',
                              style: Theme.of(context).textTheme.bodySmall,
                            ),
                          ],
                        ),
                      ],
                    ),
                  ))
            ],
          ),
        ));
  }
}
