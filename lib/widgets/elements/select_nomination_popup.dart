import 'package:flutter/material.dart';
import 'package:oscar_ballot/consts.dart';

class SelectNominationPopup extends StatefulWidget {
  final String title;
  final List<dynamic> itemList;
  final int selectedItemValue;
  final void Function(Map<String, dynamic>?) onItemSelected;

  const SelectNominationPopup({
    Key? key,
    required this.title,
    required this.itemList,
    required this.selectedItemValue,
    required this.onItemSelected,
  }) : super(key: key);

  @override
  _SelectNominationPopupState createState() => _SelectNominationPopupState();
}

class _SelectNominationPopupState extends State<SelectNominationPopup> {
  int? _selectedItem;
  String? _selectItemName;
  @override
  void initState() {
    super.initState();
    _selectedItem = widget.selectedItemValue;
    _selectItemName = '';
  }

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    final width = screenSize.width - 50.0;
    final height = width;
    return Dialog(
      backgroundColor: Colors.white,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.0)),
      elevation: 4.0,
      clipBehavior: Clip.antiAlias,
      insetPadding: const EdgeInsets.symmetric(
        vertical: 24.0,
        horizontal: 25.0,
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
           Padding(
            padding: const EdgeInsets.fromLTRB(20.0, 18.0, 20.0, 4.0),
            child: Text(
              widget.title,
              style: const TextStyle(
                color: Consts.primaryColor,
                fontSize: 20.0,
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.center,
            ),
          ),
          SizedBox(
            width: width,
            height: height,
            child: Stack(
              fit: StackFit.expand,
              children: <Widget>[
                ListView.builder(
                  shrinkWrap: true,
                  itemCount: widget.itemList.length,
                  itemBuilder: (context, index) {
                    Map<String, dynamic> nomination = widget.itemList[index];
                    String nominationName = nomination['name'];
                    int nominationId = int.parse(nomination['id']);
                    return RadioListTile<int>(
                      title: Text(nominationName),
                      value: nominationId,
                      groupValue: _selectedItem,
                      onChanged: (value) {
                        setState(() {
                          _selectedItem = nominationId;
                          _selectItemName = nominationName;
                        });
                      },
                    );
                  },
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(
              left: 20.0,
              right: 20.0,
              bottom: 16.0,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: Text('Cancel'),
                ),
                TextButton(
                  onPressed: () {
                    widget.onItemSelected({
                      "selected_nomination_name": _selectItemName,
                      "selected_nomination_id": _selectedItem
                    });
                    Navigator.of(context).pop();
                  },
                  child: Text('OK'),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}