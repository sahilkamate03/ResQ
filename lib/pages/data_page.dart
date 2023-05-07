import 'package:flutter/material.dart';

class DataPage extends StatefulWidget {
  const DataPage({Key? key}) : super(key: key);

  @override
  State<DataPage> createState() => _DataPageState();
}

class _DataPageState extends State<DataPage> {
  final _formKey = GlobalKey<FormState>();
  final _textFieldFocusNode = FocusNode();
  double latitude = 0;
  double longitude = 0;

  TextEditingController arduinolatitudeController = TextEditingController();
  TextEditingController arduinolongitudeController = TextEditingController();
  TextEditingController hospitallatitudeController = TextEditingController();
  TextEditingController hospitallongitudeController = TextEditingController();


  bool isLoading = false;
/*
  @override
  void initState() {
    super.initState();
    arduinoCoordinateController.text = '$latitude, $longitude';
    hospitalCoordinateController.text = '$latitude, $longitude';
  }
*/
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: GestureDetector(
        onTap: () {
          FocusScope.of(context).unfocus();
        },
        child: Scaffold(
          backgroundColor: const Color.fromARGB(255, 255, 255, 255),
          body: SingleChildScrollView(
            child: Center(
              child: Form(
                key: _formKey,
                child: Column(
                  children: [
                    const Padding(
                      padding: EdgeInsets.only(left: 50, top: 70),
                      child: ImageIcon(
                        AssetImage("images/resQ_logo.png"),
                        size: 200,
                        color: Color.fromARGB(255, 75, 175, 80),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          //1st row
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              SizedBox(
                                width: 100,
                                child: TextFormField(
                                  focusNode: _textFieldFocusNode,
                                  onTap: () {
                                    _textFieldFocusNode.unfocus();
                                  },
                                  decoration: InputDecoration(
                                    fillColor: Colors.black,
                                    focusColor: Colors.black,
                                    prefixIcon: Center(
                                      child: IconButton(
                                        onPressed: () {},
                                        icon: const Icon(
                                          Icons.location_on,
                                          color: Colors.green,
                                        ),
                                        alignment: Alignment.center,
                                      ),
                                    ),
                                    border: const OutlineInputBorder(
                                      borderRadius: BorderRadius.zero,
                                      borderSide: BorderSide(
                                        width: 4.0,
                                        color: Colors.black,
                                        style: BorderStyle.solid,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(
                                width: 145,
                                child: TextFormField(
                                  focusNode: _textFieldFocusNode,
                                  onTap: () {
                                    _textFieldFocusNode.unfocus();
                                  },
                                  decoration: const InputDecoration(
                                    fillColor: Colors.black,
                                    focusColor: Colors.black,
                                    hintText: '        Latitude',
                                    hintStyle:
                                        TextStyle(fontWeight: FontWeight.bold),
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.zero,
                                      borderSide: BorderSide(
                                        width: 4.0,
                                        color: Colors.black,
                                        style: BorderStyle.solid,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(
                                width: 145,
                                child: TextFormField(
                                  focusNode: _textFieldFocusNode,
                                  onTap: () {
                                    _textFieldFocusNode.unfocus();
                                  },
                                  decoration: const InputDecoration(
                                    fillColor: Colors.black,
                                    focusColor: Colors.black,
                                    hintText: '      Longitude',
                                    hintStyle:
                                        TextStyle(fontWeight: FontWeight.bold),
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.zero,
                                      borderSide: BorderSide(
                                        width: 4.0,
                                        color: Colors.black,
                                        style: BorderStyle.solid,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),

                          //2nd Row
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              SizedBox(
                                width: 100,
                                child: TextFormField(
                                  focusNode: _textFieldFocusNode,
                                  onTap: () {
                                    _textFieldFocusNode.unfocus();
                                  },
                                  decoration: const InputDecoration(
                                    fillColor: Colors.black,
                                    focusColor: Colors.black,
                                    hintText: '  Arduino',
                                    hintStyle:
                                        TextStyle(fontWeight: FontWeight.bold),
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.zero,
                                      borderSide: BorderSide(
                                        width: 4.0,
                                        color: Colors.black,
                                        style: BorderStyle.solid,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(
                                width: 145,
                                child: TextFormField(
                                  decoration: const InputDecoration(
                                    fillColor: Colors.black,
                                    focusColor: Colors.black,
                                    hintText: '    Coordinates',
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.zero,
                                      borderSide: BorderSide(
                                        width: 4.0,
                                        color: Colors.black,
                                        style: BorderStyle.solid,
                                      ),
                                    ),
                                  ),
                                  controller: arduinolatitudeController,
                                  validator: (value) {
                                    if (value == null) {
                                      setState(() {
                                        isLoading = false;
                                      });
                                      return 'Please Enter valid coordinates';
                                    } else {
                                      /*
                                      String coordinates =
                                          arduinoCoordinateController.text;
                                      List<String> latLng =
                                          coordinates.split(",");
                                      latitude = 0;
                                      latitude = double.parse(latLng[0].trim());
                                      */
                                      return null;
                                    }
                                  },
                                ),
                              ),
                              SizedBox(
                                width: 145,
                                child: TextFormField(
                                  decoration: const InputDecoration(
                                    fillColor: Colors.black,
                                    focusColor: Colors.black,
                                    hintText: '    Coordinates',
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.zero,
                                      borderSide: BorderSide(
                                        width: 4.0,
                                        color: Colors.black,
                                        style: BorderStyle.solid,
                                      ),
                                    ),
                                  ),
                                  controller: arduinolongitudeController,
                                  validator: (value) {
                                    if (value == null) {
                                      setState(() {
                                        isLoading = false;
                                      });
                                      return 'Please Enter valid coordinates';
                                    } else {
                                      /*
                                      String coordinates =
                                          arduinoCoordinateController.text;
                                      List<String> latLng =
                                          coordinates.split(",");
                                      longitude = 0;
                                      longitude =
                                          double.parse(latLng[1].trim());
                                          */
                                      return null;
                                    }
                                  },
                                ),
                              ),
                            ],
                          ),

                          //3rd Row
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              SizedBox(
                                width: 100,
                                child: TextFormField(
                                  focusNode: _textFieldFocusNode,
                                  onTap: () {
                                    _textFieldFocusNode.unfocus();
                                  },
                                  decoration: const InputDecoration(
                                    fillColor: Colors.black,
                                    focusColor: Colors.black,
                                    hintText: '  Hospital',
                                    hintStyle:
                                        TextStyle(fontWeight: FontWeight.bold),
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.zero,
                                      borderSide: BorderSide(
                                        width: 4.0,
                                        color: Colors.black,
                                        style: BorderStyle.solid,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(
                                width: 145,
                                child: TextFormField(
                                  decoration: const InputDecoration(
                                    fillColor: Colors.black,
                                    focusColor: Colors.black,
                                    hintText: '    Coordinates',
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.zero,
                                      borderSide: BorderSide(
                                        width: 4.0,
                                        color: Colors.black,
                                        style: BorderStyle.solid,
                                      ),
                                    ),
                                  ),
                                  controller: hospitallatitudeController,
                                  validator: (value) {
                                    if (value == null) {
                                      setState(() {
                                        isLoading = false;
                                      });
                                      return 'Please Enter valid coordinates';
                                    } else {
                                      /*
                                      String coordinates =
                                          arduinoCoordinateController.text;
                                      List<String> latLng =
                                          coordinates.split(",");
                                      latitude = 0;
                                      latitude = double.parse(latLng[0].trim());
                                      */
                                      return null;
                                    }
                                  },
                                ),
                              ),
                              SizedBox(
                                width: 145,
                                child: TextFormField(
                                  decoration: const InputDecoration(
                                    fillColor: Colors.black,
                                    focusColor: Colors.black,
                                    hintText: '    Coordinates',
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.zero,
                                      borderSide: BorderSide(
                                        width: 4.0,
                                        color: Colors.black,
                                        style: BorderStyle.solid,
                                      ),
                                    ),
                                  ),
                                  controller: hospitallongitudeController,
                                  validator: (value) {
                                    if (value == null) {
                                      setState(() {
                                        isLoading = false;
                                      });
                                      return 'Please Enter valid coordinates';
                                    } else {
                                      /*
                                      String coordinates =
                                          arduinoCoordinateController.text;
                                      List<String> latLng =
                                          coordinates.split(",");
                                      longitude = 0;
                                      longitude =
                                          double.parse(latLng[1].trim());
                                          */
                                      return null;
                                    }
                                  },
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    SizedBox(
                      height: 55,
                      width: 200,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.green,
                          elevation: 4,
                          shape: RoundedRectangleBorder(
                            //to set border radius to button
                            borderRadius: BorderRadius.circular(15),
                          ),
                          padding: const EdgeInsets.all(10),
                        ),
                        onPressed: () {
                          if (_formKey.currentState!.validate()) {
                            setState(() {
                              isLoading = true;
                            });
                            submitData();
                          }
                        },
                        child: isLoading
                            ? const CircularProgressIndicator(
                                color: Colors.white,
                              )
                            : const Text('Submit'),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          bottomSheet: Row(
            children: const [
              SizedBox(
                width: 130,
              ),
              Text(
                'Made with ',
                style: TextStyle(),
              ),
              Icon(
                Icons.favorite,
                color: Colors.red,
              ),
              Text(
                ' by',
                style: TextStyle(),
              ),
              Text(
                ' Null_Byte',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void submitData() {
    debugPrint('arduino');
    debugPrint(arduinolatitudeController.text.toString());
    debugPrint(arduinolongitudeController.text.toString());

    debugPrint('hospital');
    debugPrint(hospitallatitudeController.text.toString());
    debugPrint(hospitallongitudeController.text.toString());


    /*
    //String arduinoCoordinates = arduinoCoordinateController.text;
    String coordinates = arduinoCoordinateController.text;
    List<String> latLng = coordinates.split(",");
    double arduinolatitude = double.parse(latLng[0].trim());
    double arduinolongitude = double.parse(latLng[1].trim());
    debugPrint('arduino');
    debugPrint(arduinolatitude.toString());
    debugPrint(arduinolongitude.toString());

    String coordinate = hospitalCoordinateController.text;
    List<String> latLg = coordinate.split(",");
    double hospitallatitude = double.parse(latLg[0].trim());
    double hospitallongitude = double.parse(latLg[1].trim());
    debugPrint('hospital');
    debugPrint(hospitallatitude.toString());
    debugPrint(hospitallongitude.toString());

    //String hospitalCoordinates = arduinoCoordinateController.text;
    //debugPrint('hospital');
    //debugPrint(hospitalCoordinates);

    */
    return;
  }
}
