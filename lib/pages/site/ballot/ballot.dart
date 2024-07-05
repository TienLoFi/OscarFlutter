// ignore_for_file: library_private_types_in_public_api

import 'package:flutter/material.dart';
import 'package:oscar_ballot/consts.dart';
import 'package:oscar_ballot/services/api.dart';
import 'package:oscar_ballot/widgets/elements/select_nomination_popup.dart';
import 'package:oscar_ballot/widgets/main_header.dart';
import 'package:oscar_ballot/widgets/sidebars/user_sidebar.dart';

class SiteBallotPage extends StatefulWidget {
  const SiteBallotPage();
  @override
  _SiteBallotPageState createState() => _SiteBallotPageState();
}

class _SiteBallotPageState extends State<SiteBallotPage> {
  int _mostOscarMovieId = 10;
  int _isLockeBallotPage = 0;
  int _howMany = 1;
  Map<String, dynamic> _ballot = {};
  Map<String, dynamic> _ballotInfo = {};
  List<dynamic> _mostOscarOptions = [];
  List<dynamic> _howManyOptions = [];
  List<Map<String, dynamic>> _answers = [];
  List<dynamic> _categories = [];
  ScrollController _listviewController = ScrollController();
  int _totalCorrect = 0;
  int _score = 0;
  @override
  void initState() {
    super.initState();
    _fetchData();
  }

  void _showAlertDialog(String title, String message) {
    // Create the AlertDialog
    AlertDialog alert =  AlertDialog(
      title: Text(title),
      content: Text(message),
      actions: [
        // Add button to close the dialog
        TextButton(
          onPressed: () {
            Navigator.of(context).pop(); // Close the dialog
          },
          child: Text("Close"),
        ),
      ],
    );

    // Show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

  Future<void> _fetchData() async {
    final res = await Api().siteBallotIndex();
    if (res['status']) {
       setState(() {
        _ballot = res['data']['ballot']??{};
        _ballotInfo = res['data']['ballot_info']??{};
        _mostOscarMovieId = _ballot.isNotEmpty?int.parse(_ballot['most_oscar_movie_id']) : 0;
        _isLockeBallotPage= int.parse(res['data']['lock_ballot_page']);
        _howMany =  _ballot.isNotEmpty?int.parse(_ballot['how_many']) : 1;
        _totalCorrect = _ballotInfo['total_correct']??0;
        _score = _ballotInfo['score']??0;
        _mostOscarOptions = res['data']['most_oscar_movies']?? [];
        if (_mostOscarMovieId == 0 && _mostOscarOptions.isNotEmpty) {
          final first = _mostOscarOptions[0];
         _mostOscarMovieId = int.parse(first['id']);
        }
        _howManyOptions = res['data']['how_manys']?? [];
        _categories = res['data']['categories']??[];
        _answers = [];
        for (var category in _categories) {
          _answers.add({
            "category_id": category['id'],
            "nomination_id": category['selected_nomination_id']
          });
        }
      });
    }
  }


  void storeBallot() async {

    final res = await Api().siteBallotStore(_mostOscarMovieId, _howMany, _answers);
    if (!res['status']) {
      AlertDialog alert =  AlertDialog(
        title: Text("Error"),
        content: Text(res['message']),
        actions: [
          // Add button to close the dialog
          TextButton(
            onPressed: () {
              Navigator.of(context).pop(); // Close the dialog
            },
            child: Text("Close"),
          ),
        ],
      );

      // Show the dialog
      showDialog(
        // ignore: use_build_context_synchronously
        context: context,
        builder: (BuildContext context) {
          return alert;
        },
      );
    }

    // ignore: use_build_context_synchronously
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Save successful!'),
        duration: Duration(seconds: 2), // Adjust the duration as needed
      ),
    );
  }

 

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: UserSidebar(),
      body:SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            MainHeaderWidget(),
            SizedBox(height: 16.0),
            SafeArea(
              child: 
                Padding(
                  padding: EdgeInsets.all(16.0),
                  child: Column(
                    children: [
                      // Result Info
                      Row(
                        children: [
                          Text(
                            "Score: $_score/100",
                            style: TextStyle(
                              fontSize: 16.0,
                              fontWeight: FontWeight.bold,
                              color: Consts.darkColor,
                            ),
                          ),
                          SizedBox(width: 80.0),
                          Text(
                            'Correct Answer: $_totalCorrect',
                            style: TextStyle(
                              fontSize: 16.0,
                              fontWeight: FontWeight.bold,
                              color: Consts.darkColor
                            ),
                          ),
                        ],
                      ),

                      SizedBox(height: 16.0),
                      // Tiebreaker Question
                      Text(
                        'TIEBREAKER QUESTIONS',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Consts.primaryColor,
                          fontSize: 18
                        ),
                      ),
                      DropdownButtonFormField<int>(
                        value: _mostOscarMovieId,
                        onChanged: (value) {
                          _mostOscarMovieId = value!;
                        },
                        items: _mostOscarOptions.map((option) {
                          return DropdownMenuItem<int>(
                            value: int.parse(option['id']),
                            child: Text(option['name']),
                          );
                        }).toList(),
                        decoration: InputDecoration(labelText: 'Most Oscar'),
                      ),
                      SizedBox(height: 8.0),
                      DropdownButtonFormField<int>(
                        value: _howMany,
                        onChanged: (value) {
                          _howMany = value!;
                        },
                        items: _howManyOptions.map((option) {
                          return DropdownMenuItem<int>(
                            value: option['id'],
                            child: Text(option['name'].toString()),
                          );
                        }).toList(),
                        decoration: InputDecoration(labelText: 'How Many'),
                      ),

                      SizedBox(height: 16.0),
                      // Description
                      Text(
                        'BALLOT FOR EACH CATEGORY',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Consts.primaryColor,
                          fontSize: 18
                        ),
                      ),

                      SizedBox(height: 8.0),
                      // Description
                      Text(
                        'Please click on a category to select a nomination',
                        style: TextStyle(
                          color: Color.fromARGB(255, 130, 131, 136),
                          fontSize: 14
                        ),
                      ),
                    ]
                  )
              )
            ),

            Expanded(
              child: ListView.builder(
                controller: _listviewController,
                itemCount: _categories.length,
                itemBuilder: (context, index) {
                  Map<String, dynamic> category = _categories[index];
                  String categoryName = category['name'];
                  int categoryId = int.parse(category['id']);
                  int selectedNominationId = int.parse(category['selected_nomination_id']??"0");
                  String selectedNominationName = category['selected_nomination_name']??'No votes yet.';
                  final nominations = category['nominations']??[];
                  int length = nominations.length;
                  String title = "$categoryName($length)";
                  return ListTile(
                    title: Text(title),
                    subtitle: Text(selectedNominationName),
                    titleTextStyle: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Consts.primaryColor, 
                      fontSize: 16,
                      fontStyle: FontStyle.normal,
                    ),
                    subtitleTextStyle: TextStyle(
                      color: Color.fromARGB(255, 130, 131, 136),
                      fontSize: 14,
                      fontStyle: FontStyle.italic,
                    ),
                    onTap: () {
                       if (_isLockeBallotPage == 1) {
                          _showAlertDialog("Warning", "Ballot page was disable");
                          return;
                       }
                      _showCategoryNominations(nominations, selectedNominationId, categoryId, categoryName, index);
                    },
                  );
                },
              )
            ),
            Visibility(
              visible: _isLockeBallotPage == 0? true : false,
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ElevatedButton(
                      onPressed: () {
                        _fetchData();
                      },
                      style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all<Color>(Colors.red),
                        textStyle: MaterialStateProperty.all<TextStyle>(TextStyle(color: Colors.white)),
                        foregroundColor: MaterialStateProperty.all<Color>(Colors.white),
                      ),
                      child: Text('Reset'),
                    ),
                    SizedBox(width: 16), // Add space between buttons
                    ElevatedButton(
                      onPressed: () {
                        storeBallot();
                      },
                      style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all<Color>(Colors.green),
                        textStyle: MaterialStateProperty.all<TextStyle>(TextStyle(color: Colors.white)),
                        foregroundColor: MaterialStateProperty.all<Color>(Colors.white),
                      ),
                      child: Text('Save'),
                    ),
                  ],
                ),
              )
            ),
          ],
        ),
      ),
    );
  }

   void _showCategoryNominations(List<dynamic> nominations, int selectedNominationId, int categoryId, String title, int categoryIndex) 
  {
    showDialog(
              context: context,
              builder: (BuildContext context) {
                return SelectNominationPopup(
                  title: title,
                  itemList: nominations,
                  selectedItemValue: selectedNominationId,
                  onItemSelected: (value) {
                    _answers.removeWhere((element) => element['category_id'] == categoryId);
                    _answers.add({
                      "category_id": categoryId,
                      "nomination_id": value?["selected_nomination_id"]
                    });
                    setState(() {
                      _categories[categoryIndex]["selected_nomination_id"] = value?["selected_nomination_id"].toString();
                      _categories[categoryIndex]["selected_nomination_name"] = value?["selected_nomination_name"];
                    });
                  },
                );
              },
            );
  }
}

