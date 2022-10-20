import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class PenghitungNA extends StatefulWidget {
  const PenghitungNA({super.key});

  @override
  State<PenghitungNA> createState() => _PenghitungNAState();
}

class _PenghitungNAState extends State<PenghitungNA> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController tugas = TextEditingController();
  TextEditingController uts = TextEditingController();
  TextEditingController uas = TextEditingController();
  TextEditingController na = TextEditingController();
  TextEditingController index = TextEditingController();
  int _selectedIndex = 0;

  double? nilai;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Drawer(
          child: ListView(
        padding: EdgeInsets.zero,
        children: [
          const DrawerHeader(
              decoration: BoxDecoration(
                  color: Colors.white,
                  image: DecorationImage(
                      image: NetworkImage(
                          "https://likmi.ac.id/wp-content/uploads/2018/09/Logo.png"),
                      fit: BoxFit.cover)),
              child: null),
          ListTile(
            title: const Text('Home'),
            onTap: () => Navigator.pop(context),
          ),
          ListTile(
            title: const Text('About Us'),
            onTap: () => Navigator.pop(context),
          )
        ],
      )),
      appBar: AppBar(
          //backgroundColor: Colors.purple,
          leading: Builder(
            builder: (BuildContext context) {
              return IconButton(
                  onPressed: () => Scaffold.of(context).openDrawer(),
                  icon: const Icon(Icons.menu, color: Colors.white),
                  tooltip: "Navigation Menu");
            },
          ),
          centerTitle: true,
          title: const Text("Penghitung Nilai Akhir",
              style: TextStyle(fontWeight: FontWeight.bold)),
          actions: const [
            IconButton(
              onPressed: null,
              icon: Icon(
                Icons.search,
                color: Colors.white,
              ),
              tooltip: "Search",
            ),
            IconButton(
              onPressed: null,
              icon: Icon(
                Icons.more_vert,
                color: Colors.white,
              ),
              tooltip: "More",
            )
          ]),
      body: Container(
          height: MediaQuery.of(context).size.height,
          decoration: const BoxDecoration(
              gradient: LinearGradient(
                  begin: Alignment.topRight,
                  end: Alignment.bottomLeft,
                  colors: [Colors.green, Colors.yellow])),
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(10),
              child: Form(
                key: _formKey,
                //autovalidateMode: AutovalidateMode.onUserInteraction,
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: <Widget>[
                      textFormBiasa(const Icon(Icons.assignment), "Nilai Tugas",
                          "Tolong inputkan nilai Tugas anda", tugas),
                      sep(15),
                      textFormBiasa(const Icon(Icons.assessment), "Nilai UTS",
                          "Tolong inputkan nilai UTS anda", uts),
                      sep(15),
                      textFormBiasa(const Icon(Icons.history_edu), "Nilai UAS",
                          "Tolong inputkan nilai UAS anda", uas),
                      sep(15),
                      Container(
                          padding: const EdgeInsets.only(top: 10.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                    backgroundColor: Colors.green,
                                    shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(10)),
                                    shadowColor: Colors.black),
                                child: const Text('Hitung'),
                                onPressed: () {
                                  if (_formKey.currentState!.validate()) {
                                    hitungNa();
                                    hitungIndex();
                                  } else {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                        const SnackBar(
                                            content: Text(
                                                'Mohon isi semua data dengan benar')));
                                  }
                                },
                              ),
                              const SizedBox(width: 70),
                              ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                    backgroundColor:
                                        Colors.blue.withOpacity(0.3),
                                    //backgroundColor: null,
                                    shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(10)),
                                    shadowColor: Colors.black),
                                child: const Text('Clear'),
                                onPressed: () {
                                  _formKey.currentState?.reset();
                                  tugas.clear();
                                  uts.clear();
                                  uas.clear();
                                  na.clear();
                                  index.clear();
                                  setState(() {});
                                },
                              ),
                            ],
                          )),
                      sep(50),
                      textFormOutput(
                          const Icon(Icons.score), "Nilai Akhir", na),
                      sep(30),
                      textFormOutput(
                          const Icon(Icons.grade), "Index Nilai Akhir", index)
                    ]),
              ),
            ),
          )),
      bottomNavigationBar: BottomNavigationBar(
          items: const <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: Icon(Icons.home),
              label: 'Home',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.info),
              label: 'About Me',
            ),
          ],
          currentIndex: _selectedIndex,
          selectedItemColor: Colors.blue,
          onTap: (int index) {
            switch (index) {
              case 1:
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => AboutMe(),
                    ));
                break;
            }
            setState(() {
              _selectedIndex = index;
            });
          }),
    );
  }

  Widget textFormBiasa(
      Icon icon, String label, String empty, TextEditingController controller) {
    return TextFormField(
      cursorColor: Colors.black,
      style: const TextStyle(color: Colors.white),
      keyboardType: TextInputType.number,
      inputFormatters: [FilteringTextInputFormatter.allow(RegExp("[0-9]+"))],
      maxLength: 3,
      onChanged: (value) => setState(() {}),
      decoration: InputDecoration(
          filled: true,
          fillColor: Colors.grey,
          border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(50),
              borderSide: BorderSide.none),
          prefixIcon: icon,
          suffixIcon: controller.text.isEmpty
              ? null
              : IconButton(
                  onPressed: () {
                    controller.clear();
                    setState(() {});
                  },
                  icon: const Icon(Icons.clear)),
          labelText: label,
          labelStyle: const TextStyle(color: Colors.black87),
          enabledBorder: OutlineInputBorder(
              borderSide: const BorderSide(
                color: Colors.black54,
                width: 2.0,
              ),
              borderRadius: BorderRadius.circular(10))),
      controller: controller,
      validator: (value) {
        if (value!.isEmpty) {
          return empty;
        } else if (!RegExp(r'^[0-9]+$').hasMatch(value)) {
          return "Tolong inputkan angka saja";
        } else if (int.parse(value) < 0 || int.parse(value) > 100) {
          return "Tolong inputkan nilai antara 0 sampai 100";
        }
        return null;
      },
    );
  }

  Widget sep(double h) {
    return SizedBox(height: h);
  }

  Widget textFormOutput(
      Icon icon, String label, TextEditingController controller) {
    return TextFormField(
      //cursorColor: Colors.blue,
      style: const TextStyle(color: Colors.white),
      enabled: false,
      decoration: InputDecoration(
          filled: true,
          fillColor: Colors.blueAccent,
          border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(50),
              borderSide: BorderSide.none),
          prefixIcon: icon,
          labelText: label,
          labelStyle: const TextStyle(color: Colors.black87),
          enabledBorder: OutlineInputBorder(
              borderSide: const BorderSide(
                color: Colors.black54,
                width: 2.0,
              ),
              borderRadius: BorderRadius.circular(10))),
      controller: controller,
    );
  }

  void hitungNa() {
    nilai = double.parse(tugas.text) * 0.2 +
        double.parse(uts.text) * 0.3 +
        double.parse(uas.text) * 0.5;
    na.text = nilai.toString();
  }

  void hitungIndex() {
    if (nilai! >= 80.0) {
      index.text = "A";
    } else if (nilai! >= 77.0) {
      index.text = "A-";
    } else if (nilai! >= 73.0) {
      index.text = "B+";
    } else if (nilai! >= 70.0) {
      index.text = "B";
    } else if (nilai! >= 67.0) {
      index.text = "B-";
    } else if (nilai! >= 63.0) {
      index.text = "C+";
    } else if (nilai! >= 60.0) {
      index.text = "C";
    } else {
      index.text = "Tidak Lulus";
    }
  }
}

class AboutMe extends StatefulWidget {
  const AboutMe({super.key});

  @override
  State<AboutMe> createState() => _AboutMeState();
}

class _AboutMeState extends State<AboutMe> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        //backgroundColor: Colors.purple,
        centerTitle: true,
        title: const Text("About Me",
            style: TextStyle(fontWeight: FontWeight.bold)),
      ),
    );
  }
}
