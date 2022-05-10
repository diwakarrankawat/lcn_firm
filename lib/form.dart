import 'dart:io';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';
import 'package:lcn_firm/api/worker.dart';
import 'package:lcn_firm/extras/colors.dart';
import 'package:lcn_firm/extras/extras.dart';
import 'package:lcn_firm/extras/texts.dart';

class FormLayout extends StatefulWidget {
  const FormLayout({Key? key}) : super(key: key);

  @override
  State<FormLayout> createState() => _FormLayoutState();
}

class _FormLayoutState extends State<FormLayout> {
  // controllers
  final TextEditingController _name = TextEditingController();
  final TextEditingController _email = TextEditingController();
  final TextEditingController _pass1 = TextEditingController();
  final TextEditingController _pass2 = TextEditingController();
  final TextEditingController _date = TextEditingController();

  String? imagePath;
  XFile? image;

  Gender gender = Gender.unselected;
  DateTime? date;

  //obscure text
  bool create = true;
  bool confirm = true;

  // validation key
  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Padding(
          padding: const EdgeInsets.all(16),
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                const SizedBox(height: 20),
                InkWell(
                  onTap: getImage,
                  child: Container(
                    height: 100,
                    width: 100,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.black45),
                      borderRadius: BorderRadius.circular(4),
                    ),
                    child: image == null
                        ? Column(
                            mainAxisSize: MainAxisSize.min,
                            children: const [
                              Icon(
                                Icons.add_a_photo,
                                color: Colors.black45,
                              ),
                              SizedBox(height: 5),
                              Text(
                                "Upload",
                                style: TextStyles.location,
                              )
                            ],
                          )
                        : Image.file(File(image?.path ?? '')),
                  ),
                ),
                const SizedBox(height: 20),
                TextFormField(
                  controller: _name,
                  cursorColor: WidgetColors.focusedInput,
                  decoration: getDeco("Full Name"),
                  validator: (t) {
                    String? er;
                    if (t?.isEmpty ?? true) {
                      er = "This field is required";
                    }
                    return er;
                  },
                  textInputAction: TextInputAction.next,
                ),
                const SizedBox(height: 20),
                TextFormField(
                  controller: _email,
                  cursorColor: WidgetColors.focusedInput,
                  decoration: getDeco("Email"),
                  validator: (t) {
                    String? er;
                    String pattern = r"^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]"
                        r"{0,253}[a-zA-Z0-9])?(?:\.[a-zA-Z0-9](?:[a-zA-Z0-9-]"
                        r"{0,253}[a-zA-Z0-9])?)*$";
                    RegExp regex = RegExp(pattern);
                    if (t?.isEmpty ?? true) {
                      er = "This field is required";
                    } else if (t == null || t.isEmpty || !regex.hasMatch(t)) {
                      er = 'Enter a valid email address';
                    }
                    return er;
                  },
                  textInputAction: TextInputAction.next,
                ),
                const SizedBox(height: 20),
                TextFormField(
                  controller: _pass1,
                  obscureText: create,
                  cursorColor: WidgetColors.focusedInput,
                  decoration: getDeco(
                    "Create Password",
                    icon: IconButton(
                      icon: Icon(
                        create ? Icons.visibility_off_outlined : Icons.visibility_outlined,
                        color: Colors.black45,
                      ),
                      onPressed: () {
                        setState(() {
                          create = !create;
                        });
                      },
                      splashRadius: 20,
                    ),
                  ),
                  autocorrect: false,
                  validator: (t) {
                    String? er;
                    if (t?.isEmpty ?? true) {
                      er = "This field is required";
                    }
                    return er;
                  },
                  textInputAction: TextInputAction.next,
                ),
                const SizedBox(height: 20),
                TextFormField(
                  controller: _pass2,
                  obscureText: confirm,
                  cursorColor: WidgetColors.focusedInput,
                  decoration: getDeco("Confirm Password",
                      icon: IconButton(
                        icon: Icon(
                          confirm ? Icons.visibility_off_outlined : Icons.visibility_outlined,
                          color: Colors.black45,
                        ),
                        onPressed: () {
                          setState(() {
                            confirm = !confirm;
                          });
                        },
                        splashRadius: 20,
                      )),
                  autocorrect: false,
                  validator: (t) {
                    String? er;
                    if (t?.isEmpty ?? true) {
                      er = "This field is required";
                    } else if (t != _pass1.text) {
                      er = "Password did not match";
                    }
                    return er;
                  },
                  textInputAction: TextInputAction.next,
                ),
                const SizedBox(height: 20),
                DropdownButtonFormField(
                  decoration: getDeco('Gender'),
                  validator: (Gender? gn) {
                    return (gn == Gender.unselected || gn == null) ? "This field is required" : null;
                  },
                  items: const [
                    DropdownMenuItem(child: Text("Male"), value: Gender.male),
                    DropdownMenuItem(child: Text("Female"), value: Gender.female),
                  ],
                  onChanged: (dynamic wn) {
                    setState(() {
                      gender = wn;
                    });
                  },
                ),
                const SizedBox(height: 20),
                TextFormField(
                  controller: _date,
                  decoration: getDeco("Date of Birth",
                      icon: const Icon(
                        Icons.calendar_month,
                        color: Colors.black45,
                      )),
                  readOnly: true,
                  onTap: () async {
                    var dt = await showDatePicker(
                        context: context, initialDate: date ?? DateTime(2000), firstDate: DateTime(1900), lastDate: DateTime(2021, 12, 31));
                    if (dt != null) {
                      setState(() {
                        date = dt;
                      });
                      var xt = date != null ? "${date?.day}/${date?.month}/${date?.year}" : "";
                      _date.text = xt;
                      print(xt);
                    }
                  },
                  validator: (txt) {
                    String? er;
                    if (date == null) {
                      er = "This field is required";
                    }
                    return er;
                  },
                ),
                const SizedBox(height: 20),

                Row(
                  children: [
                    Radio(value: "active", groupValue: "active", onChanged: (val) {}),
                    const Text("Active"),
                    const SizedBox(width: 10),
                    const Radio(value: 'deactive', groupValue: "active", onChanged: null),
                    const Text("Suspended", style: TextStyle(color: Colors.black45)),
                  ],
                ),
                const SizedBox(height: 20),

                //Submit Button
                Container(
                  margin: const EdgeInsets.all(20),
                  height: 60,
                  clipBehavior: Clip.hardEdge,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Material(
                    color: WidgetColors.submitButton,
                    child: InkWell(
                      onTap: submit,
                      child: const Center(child: Text("Submit", style: TextStyles.btnText)),
                    ),
                  ),
                ),
              ],
            ),
          ),
        )
      ],
    );
  }

  void getImage() async {
    var img = await ImagePicker().pickImage(source: ImageSource.gallery);
    setState(() {
      image = img;
    });
  }

  void submit() async {
    print(image);
    bool valid = _formKey.currentState?.validate() ?? false;
    if (!valid) {
      return;
    } else if (image == null) {
      print('err');
      Fluttertoast.showToast(msg: "Please add an Image first");
      return;
    }

    var g = await Api.submitDetails(File(image?.path ?? ''), image?.name ?? "", _name.text, _email.text, _pass1.text, gender.toString(), _date.text);
    if (g == 200) {
      Fluttertoast.showToast(msg: "Data Posted successfully");
    }
  }
}

InputDecoration getDeco(String hint, {Widget? icon}) {
  return InputDecoration(
      hintText: hint,
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: const BorderSide(color: WidgetColors.focusedInput, width: 1),
      ),
      focusColor: WidgetColors.focusedInput,
      suffixIcon: icon);
}
