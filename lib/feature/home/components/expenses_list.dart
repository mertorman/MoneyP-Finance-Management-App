import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:rounded_expansion_tile/rounded_expansion_tile.dart';

import '../../../product/constant/color_settings.dart';
import '../model/list_item_model.dart';

class ListItem extends StatelessWidget {
  const ListItem(
      {Key? key,
      required this.expenseType,
      required this.expenseTitle,
      required this.expenseDescription,
      required this.expenseTotal,
      required this.expenseIcon,
      required this.expenseColor})
      : super(key: key);
  final String expenseType;
  final String expenseTitle;
  final String expenseDescription;
  final String expenseIcon;
  final String expenseTotal;
  final String expenseColor;

  Column info(String info, String value) {
    return Column(
      children: [
        Text(
          info,
          style: TextStyle(
              color: ColorSettings.themeColor.shade200,
              fontSize: 16,
              fontFamily: 'OpenSans',
              fontWeight: FontWeight.w400),
        ),
        SizedBox(
          height: 8,
        ),
        Text(
          value,
          style: TextStyle(
              fontSize: 14,
              fontFamily: 'OpenSans',
              fontWeight: FontWeight.w500),
        ),
      ],
    );
  }

  static Widget getItem(BuildContext ctx, ListItemModel itemModel) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
      child: ListItem(
          expenseColor: itemModel.expenseColor!,
          expenseDescription: itemModel.expenseDescription!,
          expenseIcon: itemModel.expenseIcon!,
          expenseTitle: itemModel.expenseTitle!,
          expenseTotal: itemModel.expenseTotal!,
          expenseType: itemModel.expenseType!),
    );
  }

  static Widget getGroupSeparator(ListItemModel value) {
    final DateTime now = DateTime.now();
    final DateFormat formatter = DateFormat('d');
    final String today = formatter.format(now);
    final String yesterday =
        formatter.format(DateTime.now().subtract(Duration(days: 1)));

    String groupText =
        '${value.expenseDay}.${value.expenseMonth}.${value.expenseYear}';

    if (value.expenseDay.toString() == today) {
      groupText = 'Today';
    } else if (value.expenseDay.toString() == yesterday) {
      groupText = 'Yesterday';
    }
    return SizedBox(
      height: 50,
      child: Align(
        alignment: Alignment.centerLeft,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            groupText,
            style: TextStyle(
                color: Colors.grey.shade400,
                fontWeight: FontWeight.bold,
                fontSize: 14.6),
            textAlign: TextAlign.center,
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          padding: EdgeInsets.all(8),
          margin: EdgeInsets.only(top: 13),
          decoration: BoxDecoration(
              color: Colors.white, borderRadius: BorderRadius.circular(16)),
          child: RoundedExpansionTile(
            trailing: Container(
              width: 36,
              height: 36,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(24),
                  color: Colors.blue.withAlpha(80)),
              child: Material(
                borderRadius: BorderRadius.circular(24),
                type: MaterialType.transparency,
                clipBehavior: Clip.hardEdge,
                child: Icon(
                  Icons.arrow_downward_outlined,
                  color: Color(0xFFF7F7F7),
                ),
              ),
            ),
            title: Padding(
              padding: const EdgeInsets.only(top: 7),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Container(
                    margin: EdgeInsets.only(right: 20),
                    child: Image.asset(
                      expenseIcon,
                      width: 55,
                      height: 55,
                    ),
                  ),
                  Row(
                    children: [
                      Text(
                        '\$$expenseTotal',
                        style: TextStyle(
                            color: Color(0xFF3b67b5),
                            fontSize: 28,
                            fontWeight: FontWeight.bold),
                      ),
                      Container(
                        margin: EdgeInsets.only(bottom: 12, left: 0),
                        child: Text('.30',
                            style: TextStyle(
                                color: Color(0xFF3b67b5),
                                fontSize: 16,
                                fontWeight: FontWeight.bold)),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            children: [
              Row(
                children: [
                  Expanded(
                    child: Divider(
                      thickness: 1,
                    ),
                  ),
                  Text(
                    'Expense Details',
                    style: TextStyle(color: Colors.grey.shade500),
                  ),
                  Expanded(
                    child: Divider(
                      thickness: 1,
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 5,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    info('Title', expenseTitle),
                    Container(
                      width: 1,
                      height: 40,
                      color: Colors.grey,
                    ),
                    info('Description', expenseDescription),
                    Container(
                      width: 1,
                      height: 40,
                      color: Colors.grey,
                    ),
                    ElevatedButton(
                        onPressed: () {},
                        child: Text('Edit'),
                        style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.blue.withOpacity(0.4),
                            minimumSize: Size(
                                MediaQuery.of(context).size.width * 0.15,
                                MediaQuery.of(context).size.height * 0.03)))
                  ],
                ),
              )
            ],
          ),
        ),
        Container(
          width: 132,
          height: 24,
          alignment: Alignment.center,
          margin: EdgeInsets.only(left: 16),
          padding: EdgeInsets.symmetric(vertical: 4, horizontal: 24),
          decoration: BoxDecoration(
            color: Color(int.parse(expenseColor)).withOpacity(0.65),
            borderRadius: BorderRadius.circular(36),
          ),
          child: Text(
            expenseType,
            style: TextStyle(
                color: Colors.white, fontWeight: FontWeight.w500, fontSize: 14),
          ),
        ),
      ],
    );
  }
}
