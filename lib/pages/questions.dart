import 'dart:convert';

import 'package:countdown_progress_indicator/countdown_progress_indicator.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ujian_app/models/soalModel.dart';
import 'package:ujian_app/pages/result.dart';
import 'package:http/http.dart' as myHttp;
import 'package:flutter_dotenv/flutter_dotenv.dart';

class Questions extends StatefulWidget {
  final soalModel, username;
  const Questions({ required this.soalModel, required this.username, super.key});

  @override
  State<Questions> createState() => _StartState();
}

class _StartState extends State<Questions> {
  @override
  
  final _controller = CountDownController();
  int index = 0;
  int hasil = 0;

  final url = dotenv.env['API_URL'];
  late SoalModel jawabanAkhir;

  // Fungsi untuk mengirim data ke Google Sheets API
  void sendDataToGoogleSheet(String username, int hasil) async {
    try {
      final send = await myHttp.post(
        Uri.parse('$url'), // Endpoint API untuk menyimpan data ke Google Sheets
        body: json.encode({
          'username': username,
          'hasil': hasil.toString(),
        }),
      );

      if (send.statusCode == 200) {
        print('Data berhasil dikirim ke Google Sheets');
      } else {
        print('Gagal mengirim data ke Google Sheets');
      }
    } catch (err) {
      print('Terjadi kesalahan saat mengirim data: $err');
    }
  }
  // void navigate(String jawaban){
  //   setState(() {
  //     if ( jawaban == (widget.soalModel.data[index].kunciJawaban)){
  //       hasil++;
  //       print('Bisaa');
  //     }
  //     print(index);
  //     print(widget.soalModel.data.length);
  //     if( index <= widget.soalModel.data.length){
  //       index++;
  //     }

  //     // if (widget.soalModel != null &&
  //     // widget.soalModel.data != null &&
  //     // index < widget.soalModel.data.length) {
  //     // setState(() {
  //     //   // ... kode lainnya seperti sebelumnya ...
  //     // });
  //     // }

  //     if (index == widget.soalModel.data.length){
  //       print(hasil);
  //       Navigator.of(context).push(MaterialPageRoute(builder: (context)=> Hasil(hasil: hasil,))).then((value) {
  //         setState(() {});
  //       });
  //     }
  //   });
  // }

  void navigate(String jawaban) {
    if (widget.soalModel != null &&
        widget.soalModel.data != null &&
        index < widget.soalModel.data.length) {
      setState(() {
        if (jawaban == widget.soalModel.data[index].kunciJawaban) {
          hasil++;
          print('Jawaban Benar');
        }
        print(index);
        if (index + 1 < widget.soalModel.data.length) {
          index++;
        } else {
          print('Hasilnya : ' + hasil.toString());

          // Panggil fungsi untuk mengirim data ke Google Sheets saat tes selesai
          sendDataToGoogleSheet(widget.username, hasil);

          Navigator.of(context)
              .pushReplacement(MaterialPageRoute(
                  builder: (context) => Hasil(
                        hasil: hasil,
                      )))
              .then((value) {
            setState(() {});
          });
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.deepPurpleAccent,
      body: SafeArea(
          child: ListView(
        children: [
          Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      '${widget.soalModel.data[index].no.toString()} / ${widget.soalModel.data.length.toString()}',
                      style: GoogleFonts.pacifico(
                          fontSize: 20, color: Colors.white),
                    ),
                    Text(
                      widget.username,
                      style: GoogleFonts.pacifico(
                        fontSize: 20,
                        color: Colors.white,
                      ),
                      textAlign: TextAlign.left,
                    )
                  ],
                ),
              ),

              //
              SizedBox(
                height: 150,
                width: 150,
                child: CountDownProgressIndicator(
                  controller: _controller,
                  valueColor: Colors.red,
                  backgroundColor: Colors.white,
                  initialPosition: 0,
                  duration: 60,
                  text: 'Detik',
                  onComplete: () {
                    Navigator.of(context)
                        .pushReplacement(MaterialPageRoute(
                            builder: (context) => Hasil(
                                  hasil: hasil,
                                )))
                        .then((value) {
                      setState(() {});
                    });
                  },
                ),
              ),

              SizedBox(
                height: 50,
              ),

              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  widget.soalModel.data[index].pertanyaan.toString(),
                  textAlign: TextAlign.center,
                  style: GoogleFonts.poppins(fontSize: 20, color: Colors.white),
                ),
              ),

              SizedBox(
                height: 50,
              ),

              GestureDetector(
                onTap: () {
                  navigate('a');
                },
                child: optionWidget(
                  abc: 'A.',
                  soal: widget.soalModel.data[index].pilihanA.toString(),
                  warna: Colors.red,
                ),
              ),

              GestureDetector(
                onTap: () {
                  navigate('b');
                },
                child: optionWidget(
                  abc: 'B.',
                  soal: widget.soalModel.data[index].pilihanB.toString(),
                  warna: Colors.green,
                ),
              ),

              MouseRegion(
                cursor: SystemMouseCursors.click,
                child: GestureDetector(
                  onTap: () {
                    navigate('c');
                  },
                  child: optionWidget(
                    abc: 'C.',
                    soal: widget.soalModel.data[index].pilihanC.toString(),
                    warna: Colors.deepOrange,
                  ),
                ),
              ),

              MouseRegion(
                cursor: SystemMouseCursors.click,
                child: GestureDetector(
                  onTap: () {
                    navigate('d');
                  },
                  child: optionWidget(
                    abc: 'D.',
                    soal: widget.soalModel.data[index].pilihanD.toString(),
                    warna: Colors.indigo,
                  ),
                ),
              )
            ],
          ),
        ],
      )),
    );
  }
}

class optionWidget extends StatelessWidget {
  final String abc;
  final String soal;
  final Color warna;

  const optionWidget({
    required this.abc,
    required this.soal,
    required this.warna,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      child: Container(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Row(
            children: [
              Text(
                abc,
                style:
                    GoogleFonts.montserrat(fontSize: 20, color: Colors.white),
              ),
              SizedBox(
                width: 20,
              ),
              Expanded(
                child: Text(
                  soal,
                  style:
                      GoogleFonts.montserrat(fontSize: 20, color: Colors.white),
                  textAlign: TextAlign.left,
                ),
              ),
            ],
          ),
        ),
        decoration: BoxDecoration(color: warna),
      ),
    );
  }
}
