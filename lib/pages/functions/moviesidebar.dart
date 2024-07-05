import 'package:flutter/material.dart';

class MovieSideBarPage extends StatefulWidget {
  const MovieSideBarPage({Key? key}) : super(key: key);

  @override
  State<MovieSideBarPage> createState() => _MovieSideBarPageState();
}

class Movie {
  String name;
  String year;

  Movie({required this.name, required this.year});
}

class _MovieSideBarPageState extends State<MovieSideBarPage> {
  TextEditingController nameController = TextEditingController();
  TextEditingController yearController = TextEditingController();
  List<Movie> Movies = List.empty(growable: true);

  int selectedIndex = -1;
  int currentPage = 0;
  final int rowsPerPage = 5;

  @override
  void initState() {
    super.initState();
    // Thêm một số dữ liệu giả lập
    Movies.add(Movie(name: "Phim A", year: "2020"));
    Movies.add(Movie(name: "Phim B", year: "2021"));
    Movies.add(Movie(name: "Phim C", year: "2022"));
    Movies.add(Movie(name: "Phim D", year: "2023"));
    Movies.add(Movie(name: "Phim E", year: "2024"));
    Movies.add(Movie(name: "Phim F", year: "2025"));
    Movies.add(Movie(name: "Phim G", year: "2026"));
    Movies.add(Movie(name: "Phim H", year: "2027"));
    Movies.add(Movie(name: "Phim I", year: "2028"));
    Movies.add(Movie(name: "Phim J", year: "2029"));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Movies List'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            const SizedBox(height: 10),
            searchBox(),
            const SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(
                  onPressed: () {
                    String name = nameController.text.trim();
                    String year = yearController.text.trim();
                    if (name.isNotEmpty && year.isNotEmpty) {
                      setState(() {
                        nameController.text = '';
                        yearController.text = '';
                        Movies.add(Movie(name: name, year: year));
                      });
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.green,
                    foregroundColor: Colors.white,
                    // Màu nền cho nút Add
                  ),
                  child: Row(
                    children: [
                      Icon(Icons.add),
                      const SizedBox(width: 5),
                      const Text('Add'),
                    ],
                  ),
                ),
                ElevatedButton(
                  onPressed: () {
                    if (selectedIndex != -1) {
                      setState(() {
                        Movies.removeAt(selectedIndex);
                        selectedIndex = -1;
                        nameController.text = '';
                        yearController.text = '';
                      });
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.red,
                    foregroundColor: Colors.white, // Màu nền cho nút Add
                  ),
                  child: Row(
                    children: [
                      Icon(Icons.delete),
                      const SizedBox(width: 5),
                      const Text('Delete'),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 10),
            Expanded(
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: DataTable(
                  columns: const [
                    DataColumn(
                      label: Text(
                        'Name',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      ),
                    ),
                    DataColumn(
                      label: Text(
                        'Year',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      ),
                    ),
                    DataColumn(
                      label: Text(
                        'Actions',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      ),
                    ),
                  ],
                  rows: Movies
                      .skip(currentPage * rowsPerPage)
                      .take(rowsPerPage)
                      .map((Movie) {
                    int index = Movies.indexOf(Movie);
                    return DataRow(
                      color: MaterialStateProperty.resolveWith<Color?>(
                        (Set<MaterialState> states) {
                          return index.isEven ? Colors.white : Colors.grey[200];
                        },
                      ),
                      cells: [
                        DataCell(
                          Text(
                            Movie.name,
                            style: TextStyle(
                              color: Color.fromARGB(
                                  255, 0, 0, 0), // Màu chữ của tên sách
                            ),
                          ),
                        ),
                        DataCell(
                          Text(
                            Movie.year,
                            style: TextStyle(
                              color: Color.fromARGB(
                                  255, 0, 0, 0), // Màu chữ của năm xuất bản
                            ),
                          ),
                        ),
                        DataCell(
                          Row(
                            children: [
                              IconButton(
                                icon: const Icon(Icons.edit,
                                    color: Colors.blue),
                                onPressed: () {
                                  nameController.text = Movie.name;
                                  yearController.text = Movie.year;
                                  setState(() {
                                    selectedIndex = index;
                                  });
                                },
                              ),
                              IconButton(
                                icon: const Icon(Icons.delete,
                                    color: Colors.red), 
                                onPressed: () {
                                  setState(() {
                                    Movies.removeAt(index);
                                  });
                                },
                              ),
                            ],
                          ),
                        ),
                      ],
                    );
                  }).toList(),
                ),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                IconButton(
                  icon: const Icon(Icons.arrow_back),
                  onPressed: currentPage > 0
                      ? () {
                          setState(() {
                            currentPage--;
                          });
                        }
                      : null,
                ),
                Text(
                    'Trang ${currentPage + 1} của ${(Movies.length / rowsPerPage).ceil()}'),
                IconButton(
                  icon: const Icon(Icons.arrow_forward),
                  onPressed: (currentPage + 1) * rowsPerPage < Movies.length
                      ? () {
                          setState(() {
                            currentPage++;
                          });
                        }
                      : null,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget searchBox() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 15),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 2,
            blurRadius: 5,
            offset: Offset(0, 3), // changes position of shadow
          ),
        ],
      ),
      child: TextField(
        decoration: InputDecoration(
          contentPadding: EdgeInsets.all(0),
          prefixIcon: Icon(
            Icons.search,
            color: Colors.black26,
            size: 20,
          ),
          prefixIconConstraints: BoxConstraints(
            maxHeight: 20,
            minWidth: 25,
          ),
          border: InputBorder.none,
          hintText: 'Search',
          hintStyle: TextStyle(color: Colors.blueGrey),
        ),
      ),
    );
  }
}
