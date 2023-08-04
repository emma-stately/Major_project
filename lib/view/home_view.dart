import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:snippet_coder_utils/FormHelper.dart';
import '../utils/routes/routes_name.dart';
import '../view_model/user_view_model.dart';

class HomeView extends StatefulWidget {
  const HomeView({Key? key}) : super(key: key);

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  List<dynamic> cities = [];
  List<dynamic> placesMasters = [];
  List<dynamic> places = [];

  String? cityId;
  String? placeId;

  @override
  void initState() {
    super.initState();

    cities.add({"id": 1, "name": "Kathmandu"});
    cities.add({"id": 2, "name": "Pokhara"});

    placesMasters = [
      {"ID": 1, "Name": "Pashupatinath", "ParentId": 1},
      {"ID": 2, "Name": "Syambhunath", "ParentId": 1},
      {"ID": 3, "Name": "Boudhanath stupa", "ParentId": 1},
      {"ID": 4, "Name": "Thamel", "ParentId": 1},
      {"ID": 5, "Name": "Kathmandu Durbar Square", "ParentId": 1},
      {"ID": 6, "Name": "kapan Monastry", "ParentId": 1},
      {"ID": 7, "Name": "Garden of Dreams", "ParentId": 1},
      {"ID": 8, "Name": "Crematoria", "ParentId": 1},
      {"ID": 9, "Name": "Shanti Yoga academy", "ParentId": 1},
      {"ID": 10, "Name": "Budhanilkantha", "ParentId": 1},
      {"ID": 11, "Name": "Saga", "ParentId": 1},
      {"ID": 12, "Name": "Godawari", "ParentId": 1},
      {"ID": 13, "Name": "Shivpuri Park", "ParentId": 1},
      {"ID": 1, "Name": "Fewa Lake", "ParentId": 2},
      {"ID": 2, "Name": "Mahendra Gufa", "ParentId": 2},
      {"ID": 3, "Name": "Devis Fall", "ParentId": 2},
      {"ID": 4, "Name": "pundi cot", "ParentId": 2},
      {"ID": 5, "Name": "Chamero Gufa", "ParentId": 2},
    ];
  }

  @override
  Widget build(BuildContext context) {
    final userPreference = Provider.of<UserViewModel>(context);
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.blue,
          elevation: 0,
          title:
              const Text("Home", style: TextStyle(fontWeight: FontWeight.bold)),
          centerTitle: true,
          automaticallyImplyLeading: false,
          actions: [
            Center(
              child: InkWell(
                onTap: () {
                  userPreference.remove().then((value) {
                    Navigator.pushNamed(context, RoutesName.login);
                  });
                },
                child: const Text('Logout'),
              ),
            ),
            const SizedBox(
              width: 20,
            )
          ],
        ),
        body: Column(
          children: [
            FormHelper.dropDownWidgetWithLabel(
              context,
              "City you'd like to visit",
              "Select City",
              cityId,
              cities,
              (onChangedVal) {
                setState(() {
                  cityId = onChangedVal;
                  print("selected City: $onChangedVal");

                  places = placesMasters
                      .where(
                        (placeItem) =>
                            placeItem["ParentId"].toString() ==
                            onChangedVal.toString(),
                      )
                      .toList();
                  print(places);
                  placeId = null;
                });
              },
              (onValidateVal) {
                if (onValidateVal == null) {
                  return "Please Select City";
                }
                return null;
              },
              borderColor: Theme.of(context).primaryColor,
              borderFocusColor: Theme.of(context).primaryColor,
              borderRadius: 10,
            ),
            FormHelper.dropDownWidgetWithLabel(
              context,
              "Kind of Place you like",
              "select Place",
              placeId,
              places,
              (onChangedVal) {
                placeId = onChangedVal;
                print("Selected Place : $onChangedVal");
              },
              (onValidate) {
                return null;
              },
              borderColor: Theme.of(context).primaryColor,
              borderFocusColor: Theme.of(context).primaryColor,
              borderRadius: 10,
              optionValue: "ID",
              optionLabel: "Name",
            )
          ],
        ));
  }
}
