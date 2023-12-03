import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart' as intl;
import 'package:novoy/presentation/home%20screen/cubit/cubit.dart';
import 'package:novoy/presentation/home%20screen/cubit/state.dart';
import 'package:novoy/resources/color_maneger.dart';
import 'package:novoy/resources/responsive.dart';

import '../../resources/assets_maneger.dart';
import '../../shared/component/text_form_field.dart';

class EditPlan extends StatefulWidget {
  const EditPlan({super.key});

  @override
  State<EditPlan> createState() => EditPlanState();
}

class EditPlanState extends State<EditPlan> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorManager.lightPrimary,
      appBar: AppBar(
        title: const Text("Edit a Plan"),
      ),
      body: BlocConsumer<HomeCubit, HomeState>(
        listener: (context, state) {},
        builder: (context, state) {
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  responsive.sizedBoxH10,
                  const Text("Trip Name"),
                  AppTextFormField(
                    controller: HomeCubit.get(context).tripNameController,
                    prefix: Image.asset(AppAssets.plane),
                  ),
                  SizedBox(
                    height: responsive.sHeight(context) * .2,
                  ),
                  const Text("Destination"),
                  SizedBox(
                    width: double.infinity,
                    child: Material(
                      borderRadius: BorderRadius.circular(50),
                      child: DropdownButtonFormField<String>(
                        decoration: InputDecoration(
                          prefix: Image.asset(AppAssets.location),
                          border: OutlineInputBorder(
                              borderSide:
                                  BorderSide(color: ColorManager.primary),
                              borderRadius: BorderRadius.circular(50),),
                          enabledBorder: OutlineInputBorder(
                              borderSide:
                                  BorderSide(color: ColorManager.primary),
                              borderRadius: BorderRadius.circular(50),),
                          focusedBorder: OutlineInputBorder(
                              borderSide:
                                  BorderSide(color: ColorManager.primary),
                              borderRadius: BorderRadius.circular(50),),
                        ),
                        items: [
                          "Riyadh",
                          "Jeddah",
                          "Dammam",
                          "Al-Ula",
                        ]
                            .map(
                              (e) => DropdownMenuItem(
                                onTap: () {},
                                value: e,
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 8.0,),
                                  child: Text(e),
                                ),
                              ),
                            )
                            .toList(),
                        onChanged: (val) {
                          setState(() {
                            HomeCubit.get(context).startLocationDescription =
                                val!;
                          });
                        },
                        value: "Riyadh",
                      ),
                    ),
                  ),
                  SizedBox(
                    height: responsive.sHeight(context) * .2,
                  ),
                  const Text("Date"),
                  AppTextFormField(
                    onTap: () async {
                      await pickDateTime();
                    },
                    controller: HomeCubit.get(context).startdateController,
                    prefix: Image.asset(AppAssets.calender),
                  ),
                  SizedBox(
                    height: responsive.sHeight(context) * .1,
                  ),
                  ElevatedButton(onPressed: () async {}, child: const Text("Create")),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  DateTimeRange dateRange = DateTimeRange(
    start: DateTime.now(),
    end: DateTime.now(),
  );

  Future<DateTimeRange?> pickDate() async => await showDateRangePicker(
        context: context,
        initialDateRange: dateRange,
        firstDate: DateTime(2023),
        lastDate: DateTime(2100),
        builder: (context, child) {
          return Theme(
            data: ThemeData(
              dialogBackgroundColor: ColorManager.lightPrimary,
            ),
            child: child!,
          );
        },
      );

  Future pickDateTime() async {
    var cubit = HomeCubit.get(context);
    DateTimeRange? date = await pickDate();
    if (date == null) return;
    /* TimeOfDay? time = await pickTime();*/
    final firstDate = date.start;
    final lastDate = date.end;
    setState(() {
      HomeCubit.get(context).startdateController.text =
          '${intl.DateFormat('yyyy-MM-dd').format(firstDate)}  ${intl.DateFormat('yyyy-MM-dd').format(lastDate)}';
    });
  }
}
