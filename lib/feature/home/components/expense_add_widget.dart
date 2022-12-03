import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:moneyp/feature/home/controller/home_controller.dart';
import 'package:moneyp/feature/home/controller/expense_controller.dart';
import 'package:moneyp/feature/home/model/expense_model.dart';
import 'package:moneyp/feature/home/view/homepage_view.dart';
import 'package:moneyp/product/constant/color_settings.dart';

class ExpenseBottomSheet extends StatefulWidget {
  const ExpenseBottomSheet({super.key});

  @override
  State<ExpenseBottomSheet> createState() => _ExpenseBottomSheetState();
}

class _ExpenseBottomSheetState extends State<ExpenseBottomSheet> {
  ExpenseController controller = Get.find();
  final listKey = GlobalKey<AnimatedListState>();
  TextEditingController title = TextEditingController();
  TextEditingController expenseDesc = TextEditingController();
  TextEditingController expenseTotal = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height / 1.25,
      decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(50), topRight: Radius.circular(50))),
      child: Padding(
        padding: const EdgeInsets.only(left: 15, top: 15, bottom: 15),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Expense Add',
              style: TextStyle(
                  color: ColorSettings.themeColor.shade200,
                  fontSize: 20,
                  fontWeight: FontWeight.bold),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 20, left: 20),
              child: Container(
                height: 100,
                child:

                    /*AnimatedList(
                    key: listKey,
                    shrinkWrap: true,
                    scrollDirection: Axis.horizontal,
                    initialItemCount: ExpenseModel.expenseItems.length,
                    itemBuilder: (context, index, animation) {
                      return category_widget(
                        title: ExpenseModel.expenseItems[index][0],
                        imageUrl: ExpenseModel.expenseItems[index][1],
                        containerColor: Color(
                            int.parse(ExpenseModel.expenseItems[index][2])),
                        onPressed: () {
                          controller.expenseSec(index);
                          listKey.currentState.build(context)
                        },
                      );
                    },
                  )*/
                    ListView.builder(
                  shrinkWrap: true,
                  scrollDirection: Axis.horizontal,
                  itemCount: ExpenseModel.expenseItems.length,
                  itemBuilder: (context, index) {
                    return category_widget(
                      title: ExpenseModel.expenseItems[index][0],
                      imageUrl: ExpenseModel.expenseItems[index][1],
                      containerColor:
                          Color(int.parse(ExpenseModel.expenseItems[index][2])),
                      onPressed: () {
                        controller.expenseSec(index);
                      },
                    );
                  },
                ),
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Container(
              width: MediaQuery.of(context).size.width * 0.9,
              height: MediaQuery.of(context).size.height * 0.07,
              decoration: BoxDecoration(
                  color: Colors.blue.shade800.withOpacity(0.15),
                  borderRadius: BorderRadius.circular(30)),
              child: Padding(
                padding: const EdgeInsets.only(
                    left: 10, right: 18, top: 10, bottom: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Icon(Icons.euro, color: Colors.grey),
                    SizedBox(
                      width: 10,
                    ),
                    Expanded(
                        child: TextField(
                      controller: expenseTotal,
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration.collapsed(
                        hintText: "Enter total budget",
                        border: InputBorder.none,
                      ),
                    )),
                    VerticalDivider(color: Colors.blue),
                    DropdownButton(
                      hint: Text(
                        'EUR',
                        style: TextStyle(color: Colors.blue),
                      ),
                      iconDisabledColor: Colors.blue,
                      items: [],
                      onChanged: (value) {},
                    )
                  ],
                ),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Container(
              width: MediaQuery.of(context).size.width * 0.9,
              height: MediaQuery.of(context).size.height * 0.07,
              decoration: BoxDecoration(
                  color: Colors.blue.shade800.withOpacity(0.15),
                  borderRadius: BorderRadius.circular(30)),
              child: Padding(
                padding: const EdgeInsets.only(
                    left: 10, right: 18, top: 10, bottom: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Icon(Icons.title, color: Colors.grey),
                    SizedBox(
                      width: 10,
                    ),
                    Expanded(
                        child: TextField(
                      controller: title,
                      decoration: InputDecoration.collapsed(
                        hintText: "Enter expense title",
                        border: InputBorder.none,
                      ),
                    )),
                  ],
                ),
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Container(
              width: MediaQuery.of(context).size.width * 0.9,
              height: MediaQuery.of(context).size.height * 0.13,
              decoration: BoxDecoration(
                  color: Colors.blue.shade800.withOpacity(0.15),
                  borderRadius: BorderRadius.circular(30)),
              child: Padding(
                padding: EdgeInsets.all(15),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Description',
                      style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                          color: Colors.grey.shade500),
                    ),
                    Expanded(
                        child: TextField(
                      controller: expenseDesc,
                    )),
                    Expanded(child: TextField())
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(30),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  ElevatedButton(
                    onPressed: () async {
                      if (title.text.length > 1) {
                        await controller.addExpense(
                            title.text, expenseDesc.text, expenseTotal.text);
                        await homeController.grafikYuzdeHesaplama();
                      }

                      Get.back();
                    },
                    child: Text(
                      'Save',
                    ),
                    style: ElevatedButton.styleFrom(
                        primary: Colors.blue,
                        minimumSize: Size(130, 55),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30))),
                  ),
                  OutlinedButton(
                    onPressed: () {},
                    child: Text('Reset'),
                    style: OutlinedButton.styleFrom(
                      foregroundColor: Colors.red,
                      side: BorderSide(color: Colors.red),
                      minimumSize: Size(
                        130,
                        55,
                      ),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30)),
                    ),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}

class category_widget extends StatelessWidget {
  category_widget(
      {Key? key,
      required this.title,
      required this.imageUrl,
      required this.containerColor,
      required this.onPressed,
      this.widthHeight})
      : super(key: key);

  final String imageUrl;
  final String title;
  final Color containerColor;
  void Function()? onPressed;
  double? widthHeight = 90;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Row(
        children: [
          AnimatedContainer(
            duration: const Duration(milliseconds: 100),
            width: MediaQuery.of(context).size.width * 0.18,
            height: MediaQuery.of(context).size.height * 0.1,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(18),
              color: containerColor.withOpacity(0.33),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Image.asset(
                  imageUrl,
                  width: 25,
                  height: 25,
                ),
                Text(
                  title,
                  style: TextStyle(
                      color: containerColor,
                      fontSize: 15,
                      fontWeight: FontWeight.bold),
                ),
              ],
            ),
          ),
          const SizedBox(
            width: 30,
          )
        ],
      ),
    );
  }
}
