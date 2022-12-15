import 'package:flutter/material.dart';
import 'package:flutter_svg_provider/flutter_svg_provider.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:moneyp/feature/home/components/expense_add_widget.dart';
import 'package:moneyp/feature/home/controller/expense_controller.dart';

import '../model/expense_model.dart';

class ExpenseWidget extends StatelessWidget {
  ExpenseWidget({super.key, required this.controller,required this.expenseTotal,required this.title,required this.expenseDesc});
  ExpenseController controller;
  TextEditingController expenseTotal;
  TextEditingController title;
  TextEditingController expenseDesc;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Padding(
          padding: const EdgeInsets.only(top: 10, left: 20),
          child: Container(
            height: controller.tabController.index == 0 ? MediaQuery.of(context).size.height * 0.1 : MediaQuery.of(context).size.height * 0.17,
            child: controller.tabController.index == 0 ?
            ListView.builder(
                shrinkWrap: true,
                scrollDirection: Axis.horizontal,
                itemCount: ExpenseModel.expenseItems.length,
                itemBuilder: (context, index) {
                  return Obx(
                    () => GestureDetector(
                      onTap: () {
                        controller.expenseSec(index);

                        if (controller.selectedExpense.value != null) {
                          controller.selectedExpense.value!.isSelected = false;
                        }
                        ExpenseModel.expenseItems[index].isSelected =
                            !ExpenseModel.expenseItems[index].isSelected!;
                        controller.selectedExpense.value =
                            ExpenseModel.expenseItems[index];
                        ExpenseModel.expenseItems.refresh();
                      },
                      child: category_widget(
                        isSelected:
                            ExpenseModel.expenseItems[index].isSelected!,
                        title: ExpenseModel.expenseItems[index].expenseType!,
                        imageUrl: ExpenseModel.expenseItems[index].imagePath!,
                        containerColor: Color(
                            int.parse(ExpenseModel.expenseItems[index].color!)),
                      ),
                    ),
                  );
                }) : Image(width: MediaQuery.of(context).size.width,height: MediaQuery.of(context).size.height * 0.17,image: Svg("assets/images/income_money.svg"))
          ),
        ),
        const SizedBox(
          height: 8,
        ),
        Container(
          width: MediaQuery.of(context).size.width * 0.9,
          height: MediaQuery.of(context).size.height * 0.07,
          decoration: BoxDecoration(
              color: Color.fromARGB(255, 245, 245, 245),
              borderRadius: BorderRadius.circular(10)),
          child: Padding(
            padding:
                const EdgeInsets.only(left: 10, right: 18, top: 10, bottom: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Icon(Icons.euro, color: Colors.grey),
                const SizedBox(
                  width: 10,
                ),
                Expanded(
                    child: TextField(
                  controller: expenseTotal,
                  keyboardType: TextInputType.number,
                  style: GoogleFonts.poppins(),
                  decoration: const InputDecoration.collapsed(
                    hintText: "Enter total budget",
                    border: InputBorder.none,
                  ),
                )),
                const VerticalDivider(color: Colors.blue),
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
          height: 8,
        ),
        Container(
          width: MediaQuery.of(context).size.width * 0.9,
          height: MediaQuery.of(context).size.height * 0.07,
          decoration: BoxDecoration(
              color: Color.fromARGB(228, 245, 245, 245),
              borderRadius: BorderRadius.circular(10)),
          child: Padding(
            padding:
                const EdgeInsets.only(left: 10, right: 18, top: 10, bottom: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Icon(Icons.title, color: Colors.grey),
                const SizedBox(
                  width: 10,
                ),
                Expanded(
                    child: TextField(
                  controller: title,
                  style: GoogleFonts.poppins(),
                  decoration:  InputDecoration.collapsed(
                    hintText: controller.tabController.index == 0 ? "Enter expense title" : "Enter income title" ,
                    border: InputBorder.none,
                  ),
                )),
              ],
            ),
          ),
        ),
        const SizedBox(
          height: 8,
        ),
        Container(
          width: MediaQuery.of(context).size.width * 0.9,
          height: MediaQuery.of(context).size.height * 0.13,
          decoration: BoxDecoration(
              color: Color.fromARGB(228, 245, 245, 245),
              borderRadius: BorderRadius.circular(10)),
          child: Padding(
            padding: EdgeInsets.only(right: 15, left: 15, top: 10, bottom: 2),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                TextField(
                  controller: expenseDesc,
                  maxLines: 4,
                  keyboardType: TextInputType.multiline,
                  style: GoogleFonts.poppins(),
                  decoration:  InputDecoration.collapsed(
                    hintText:  controller.tabController.index == 0 ? "Enter expense description" : "Enter income description",
                    border: InputBorder.none,
                  ),
                )
              ],
            ),
          ),
        ),
      ],
    );
  }
}
