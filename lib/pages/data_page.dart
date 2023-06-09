import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

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
  TextEditingController laneController1 = TextEditingController();
  TextEditingController laneController2 = TextEditingController();

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
                    const SizedBox(
                      height: 10,
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Center(
                        child: SizedBox(
                          //width: double.infinity,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              //1st row
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  SizedBox(
                                    width: 95,
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
                                    width: 140,
                                    child: TextFormField(
                                      focusNode: _textFieldFocusNode,
                                      onTap: () {
                                        _textFieldFocusNode.unfocus();
                                      },
                                      decoration: const InputDecoration(
                                        fillColor: Colors.black,
                                        focusColor: Colors.black,
                                        hintText: '       Latitude',
                                        hintStyle: TextStyle(
                                            fontWeight: FontWeight.bold),
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
                                    width: 140,
                                    child: TextFormField(
                                      focusNode: _textFieldFocusNode,
                                      onTap: () {
                                        _textFieldFocusNode.unfocus();
                                      },
                                      decoration: const InputDecoration(
                                        fillColor: Colors.black,
                                        focusColor: Colors.black,
                                        hintText: '      Longitude',
                                        hintStyle: TextStyle(
                                            fontWeight: FontWeight.bold),
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
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  SizedBox(
                                    width: 95,
                                    child: TextFormField(
                                      focusNode: _textFieldFocusNode,
                                      onTap: () {
                                        _textFieldFocusNode.unfocus();
                                      },
                                      decoration: const InputDecoration(
                                        fillColor: Colors.black,
                                        focusColor: Colors.black,
                                        hintText: '  Arduino',
                                        hintStyle: TextStyle(
                                            fontWeight: FontWeight.bold),
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
                                    width: 140,
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
                                    width: 140,
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
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  SizedBox(
                                    width: 95,
                                    child: TextFormField(
                                      focusNode: _textFieldFocusNode,
                                      onTap: () {
                                        _textFieldFocusNode.unfocus();
                                      },
                                      decoration: const InputDecoration(
                                        fillColor: Colors.black,
                                        focusColor: Colors.black,
                                        hintText: '  Hospital',
                                        hintStyle: TextStyle(
                                            fontWeight: FontWeight.bold),
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
                                    width: 140,
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
                                    width: 140,
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
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Center(
                      child: Padding(
                        padding: const EdgeInsets.only(
                            left: 20, right: 20, bottom: 10),
                        child: TextFormField(
                          decoration: const InputDecoration(
                            fillColor: Colors.black,
                            focusColor: Colors.black,
                            //hintText: 'Username',
                            labelText: 'Source Lane',
                            prefixIcon: Icon(Icons.add_road),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.zero,
                              borderSide: BorderSide(
                                width: 4.0,
                                color: Colors.black,
                                style: BorderStyle.solid,
                              ),
                            ),
                          ),
                          controller: laneController1,
                          validator: (value) {
                            if (value == null) {
                              setState(() {
                                isLoading = false;
                              });
                              return 'Please Enter valid value';
                            } else {
                              return null;
                            }
                          },
                        ),
                      ),
                    ),
                    Center(
                      child: Padding(
                        padding: const EdgeInsets.only(left: 20, right: 20),
                        child: TextFormField(
                          decoration: const InputDecoration(
                            fillColor: Colors.black,
                            focusColor: Colors.black,
                            //hintText: 'Username',
                            labelText: 'Destination Lane',
                            prefixIcon: Icon(Icons.add_road),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.zero,
                              borderSide: BorderSide(
                                width: 4.0,
                                color: Colors.black,
                                style: BorderStyle.solid,
                              ),
                            ),
                          ),
                          controller: laneController2,
                          validator: (value) {
                            if (value == null) {
                              setState(() {
                                isLoading = false;
                              });
                              return 'Please Enter valid value';
                            } else {
                              return null;
                            }
                          },
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 20,
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

  Future<void> submitData() async {
    // debugPrint('arduino');
    // debugPrint(arduinolatitudeController.text.toString());
    // debugPrint(arduinolongitudeController.text.toString());

    // debugPrint('hospital');
    // debugPrint(hospitallatitudeController.text.toString());
    // debugPrint(hospitallongitudeController.text.toString());

    // debugPrint(laneController1.text.toString());
    // debugPrint(laneController2.text.toString());

    Map<String, String> data = {
      'arduinoLatitude': '${arduinolatitudeController.text.toString()}',
      'arduinoLongitude': '${arduinolongitudeController.text.toString()}',
      'hospitalLatitude': '${hospitallatitudeController.text.toString()}',
      'hospitalLongitude': '${hospitallongitudeController.text.toString()}',
      'sourceLane': '${laneController1.text.toString()}',
      'destinationLane': '${laneController2.text.toString()}'
    };

    // Create a POST request.
    Uri uri = Uri.parse('https://resq.sahilkamate.repl.co/post-coordinates');
    http.Response response = await http.post(
      uri,
      body: data,
    );

    setState(() {
      isLoading = false;
    });
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
