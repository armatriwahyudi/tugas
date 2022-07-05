import 'package:animated_button/animated_button.dart';
import 'package:cool_alert/cool_alert.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hexcolor/hexcolor.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  // double? _berat;
  String? selecteda;
  String? selectedb;
  double _berat = 0.0;
  int hargaSamaKota = 10000;
  int hargaBedaKota = 20000;
  int hargaBerat = 1000;
  double total = 0.0;

  List<String> kotaAsal = [
    "Surabaya",
    "Jakarta",
    "Bandung",
    "Malang",
    "Tangerang Selatan",
    "Bekasi",
    "Bogor",
    "Depok",
    "Semarang",
    "Yogyakarta",
    "Blitar",
  ];

  List<String> kotaTujuan = [
    "Jakarta",
    "Bandung",
    "Surabaya",
    "Malang",
    "Blitar",
    "Tangerang Selatan",
    "Bekasi",
    "Bogor",
    "Depok",
    "Semarang",
    "Yogyakarta",
  ];

  @override
  Widget build(BuildContext context) {
    double _width = MediaQuery.of(context).size.width;
    return Scaffold(
      body: Center(
          child: Stack(
        children: <Widget>[
          Align(
            alignment: Alignment(0, -1),
            child: Container(
              alignment: Alignment.topCenter,
              height: 200,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [HexColor('#D83E83'), HexColor('#F776AF')],
                  stops: [0, 1],
                  begin: Alignment(0.64, -1),
                  end: Alignment(-0.64, 1),
                ),
              ),
            ),
          ),
          Column(
            children: <Widget>[
              Align(
                alignment: Alignment(0, -1),
                child: Padding(
                    padding: EdgeInsets.only(top: 70),
                    child: Text(
                      'Aplikasi Cek Ongkir',
                      style: GoogleFonts.poppins(
                        fontSize: 26,
                        fontWeight: FontWeight.w600,
                        color: Colors.white,
                      ),
                    )),
              ),
              Align(
                alignment: Alignment(0, -2),
                child: Container(
                  margin: EdgeInsets.fromLTRB(15, 50, 15, 10),
                  height: 500,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5),
                    color: Colors.white,
                  ),
                  child: Column(
                    children: <Widget>[
                      Container(
                        alignment: Alignment.center,
                        width: _width,
                        margin: EdgeInsets.fromLTRB(25, 35, 25, 5),
                        child: DropdownSearch<String>(
                          mode: Mode.MENU,
                          items: kotaAsal,
                          label: "Pick Up",
                          hint: "Pilih Kota Asal",
                          onChanged: (value) {
                            setState(() {
                              selecteda = value;
                            });
                          },
                          selectedItem: selecteda,
                          showSearchBox: true,
                        ),
                      ),
                      Container(
                        alignment: Alignment.center,
                        width: _width,
                        margin: EdgeInsets.fromLTRB(25, 15, 25, 5),
                        child: DropdownSearch<String>(
                          mode: Mode.MENU,
                          clearButton: Icon(EvaIcons.arrowBack),
                          items: kotaTujuan,
                          label: "Kota Tujuan",
                          hint: "Pilih Kota Tujuan",
                          onChanged: (value) {
                            setState(() {
                              selectedb = value;
                            });
                          },
                          selectedItem: selectedb,
                          showSearchBox: true,
                        ),
                      ),
                      Container(
                          alignment: Alignment.center,
                          width: _width,
                          margin: EdgeInsets.fromLTRB(25, 20, 25, 5),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Text(
                                'Berat Barang : ' +
                                    _berat.round().toString() +
                                    ' Kg',
                                style: GoogleFonts.poppins(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w600,
                                    color: Color.fromARGB(255, 210, 25, 111)),
                              ),
                              Slider(
                                  value: _berat,
                                  min: 0,
                                  max: 10,
                                  onChanged: (valBerat) {
                                    setState(() {
                                      this._berat = valBerat;
                                    });
                                  }),
                            ],
                          )),
                      Container(
                        alignment: Alignment.center,
                        width: _width,
                        margin: EdgeInsets.fromLTRB(25, 25, 25, 5),
                        child: AnimatedButton(
                            height: 50,
                            onPressed: () => cekOngkir(),
                            child: Text(
                              'Cek Ongkir',
                              style: GoogleFonts.poppins(
                                  fontSize: 18,
                                  fontWeight: FontWeight.w600,
                                  color: Colors.white),
                            )),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ],
      )),
    );
  }

  cekOngkir() {
    setState(() {
      if (selecteda.toString() == selectedb.toString()) {
        if (_berat > 0) {
          total = (_berat.roundToDouble() * hargaBerat) + hargaSamaKota;
          showBottomSheet();
        } else {
          CoolAlert.show(
            context: context,
            type: CoolAlertType.error,
            text: "Berat harus di isi",
            loopAnimation: true,
          );
        }
      } else {
        if (_berat > 0) {
          total = (_berat.roundToDouble() * hargaBerat) + hargaBedaKota;
          showBottomSheet();
        } else {
          CoolAlert.show(
            context: context,
            type: CoolAlertType.error,
            text: "Berat harus di isi",
            loopAnimation: true,
          );
        }
      }

      // Modal Sheet Bottom
    });
  }

  showBottomSheet() {
    double total_ongkir = total.roundToDouble();
    showModalBottomSheet(
        enableDrag: true,
        elevation: 2,
        context: context,
        builder: (context) {
          return Container(
            alignment: Alignment.center,
            height: 650,
            child: Padding(
              padding: EdgeInsets.all(10),
              child: Column(
                children: <Widget>[
                  ListTile(
                    leading: Image.network(
                      'https://upload.wikimedia.org/wikipedia/commons/9/92/New_Logo_JNE.png',
                      width: 50,
                      height: 50,
                    ),
                    title: Text(
                      'JNE',
                      style: GoogleFonts.poppins(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                          color: Color.fromARGB(255, 210, 25, 111)),
                    ),
                    subtitle: Text(
                      '2 - 3 Hari',
                      style: GoogleFonts.poppins(
                          fontSize: 12,
                          fontWeight: FontWeight.normal,
                          color: Color.fromARGB(255, 210, 25, 111)),
                    ),
                    trailing: Text(
                      'IDR ${total_ongkir + 5000}',
                      style: GoogleFonts.poppins(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                          color: Color.fromARGB(255, 210, 25, 111)),
                    ),
                  ),
                ],
              ),
            ),
          );
        });
  }
}
