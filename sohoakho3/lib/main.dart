import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: DatePickerExample.routeName,
      routes: {
        DatePickerExample.routeName: (context) => DatePickerExample(),
      },
    );
  }
}

class DatePickerExample extends StatefulWidget {
  static const routeName = '/date-picker-example';
  @override
  _DatePickerExampleState createState() => _DatePickerExampleState();
}

class _DatePickerExampleState extends State<DatePickerExample> {
  DateTime? _fromDate;
  DateTime? _toDate;
  String? _selectedXe;
  String? _selectedBonXuat;
  String? _selectedTrangThai;

  List<Map<String, String>> allRows = [
    {
      'loaiPhieu': 'Phiếu xuất ra xe tra nạp',
      'thoiGian': '08/08/2024 9:54:35',
      'bonXuat': 'T001',
      'xeNhan': 'T01-PQ',
      'soPhieu': '00002',
      'trangThai': 'Đã xuất',
      'lyDoXuat': 'Chuyển bồn',
      'nguoiGiao': 'Văn Hữu Tính',
      'nguoiNhan': 'Nguyễn Văn Chiêu'
    },
    {
      'loaiPhieu': 'Phiếu xuất ra xe tra nạp',
      'thoiGian': '08/08/2024 17:25:02',
      'bonXuat': 'T005',
      'xeNhan': 'T02-PQ',
      'soPhieu': '00080',
      'trangThai': 'Đã xuất',
      'lyDoXuat': 'Chuyển bồn',
      'nguoiGiao': 'Hoàng Văn Khách',
      'nguoiNhan': 'Nguyễn Kim Long'
    },
    {
      'loaiPhieu': 'Phiếu xuất ra xe tra nạp',
      'thoiGian': '08/08/2024 10:15:30',
      'bonXuat': 'T008',
      'xeNhan': 'T03-PQ',
      'soPhieu': '00006',
      'trangThai': 'Đã xuất',
      'lyDoXuat': 'Chuyển bồn',
      'nguoiGiao': 'Trần Văn Long',
      'nguoiNhan': 'Lê Hoàng Dũng'
    },
  ];

  List<Map<String, String>> get filteredRows {
    return allRows.where((row) {
      final matchXe = _selectedXe == null || row['xeNhan'] == _selectedXe;
      final matchBonXuat =
          _selectedBonXuat == null || row['bonXuat'] == _selectedBonXuat;
      final matchTrangThai =
          _selectedTrangThai == null || row['trangThai'] == _selectedTrangThai;
      return matchXe && matchBonXuat && matchTrangThai;
    }).toList();
  }

  Future<void> _selectDate(BuildContext context, bool isFromDate) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    );
    if (picked != null) {
      setState(() {
        if (isFromDate) {
          _fromDate = picked;
        } else {
          _toDate = picked;
        }
      });
    }
  }

  String _formatDate(DateTime? date) {
    if (date == null) return '';
    return DateFormat('dd/MM/yyyy').format(date);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Danh sách phiếu xuất'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            Row(
              children: [
                SizedBox(width: 270),
                Expanded(
                  child: Row(
                    children: [
                      Text('Xe nhận'),
                      SizedBox(width: 20),
                      Expanded(
                        child: DropdownButtonFormField<String>(
                          value: _selectedXe,
                          decoration: InputDecoration(
                            border: OutlineInputBorder(),
                            contentPadding:
                                EdgeInsets.symmetric(horizontal: 10),
                            labelText: _selectedXe == null ? 'Chọn xe' : null,
                          ),
                          items: ['T01-PQ', 'T02-PQ', 'T03-PQ']
                              .map((String value) {
                            return DropdownMenuItem<String>(
                              value: value,
                              child: Text(value),
                            );
                          }).toList(),
                          onChanged: (String? value) {
                            setState(() {
                              _selectedXe = value;
                            });
                          },
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(width: 100),
                Expanded(
                  child: Row(
                    children: [
                      Text('Bồn xuất'),
                      SizedBox(width: 20),
                      Expanded(
                        child: DropdownButtonFormField<String>(
                          value: _selectedBonXuat,
                          decoration: InputDecoration(
                            border: OutlineInputBorder(),
                            contentPadding:
                                EdgeInsets.symmetric(horizontal: 10),
                            labelText: _selectedBonXuat == null
                                ? 'Chọn bồn xuất'
                                : null,
                          ),
                          items: ['T001', 'T005', 'T008'].map((String value) {
                            return DropdownMenuItem<String>(
                              value: value,
                              child: Text(value),
                            );
                          }).toList(),
                          onChanged: (String? value) {
                            setState(() {
                              _selectedBonXuat = value;
                            });
                          },
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(width: 270),
              ],
            ),
            SizedBox(height: 25),
            Row(
              children: [
                SizedBox(width: 270),
                Expanded(
                  child: Row(
                    children: [
                      Text('Từ ngày'),
                      SizedBox(width: 21),
                      Expanded(
                        child: GestureDetector(
                          onTap: () => _selectDate(context, true),
                          child: AbsorbPointer(
                            child: TextFormField(
                              decoration: InputDecoration(
                                border: OutlineInputBorder(),
                                suffixIcon: Icon(Icons.calendar_today),
                                contentPadding:
                                    EdgeInsets.symmetric(horizontal: 10),
                              ),
                              controller: TextEditingController(
                                text: _formatDate(_fromDate),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(width: 100),
                Expanded(
                  child: Row(
                    children: [
                      Text('Đến ngày'),
                      SizedBox(width: 18),
                      Expanded(
                        child: GestureDetector(
                          onTap: () => _selectDate(context, false),
                          child: AbsorbPointer(
                            child: TextFormField(
                              decoration: InputDecoration(
                                border: OutlineInputBorder(),
                                suffixIcon: Icon(Icons.calendar_today),
                                contentPadding:
                                    EdgeInsets.symmetric(horizontal: 10),
                              ),
                              controller: TextEditingController(
                                text: _formatDate(_toDate),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(width: 270),
              ],
            ),
            SizedBox(height: 25),
            Row(
              children: [
                SizedBox(width: 270),
                Expanded(
                  child: Row(
                    children: [
                      Text('Trạng thái'),
                      SizedBox(width: 7),
                      Expanded(
                        child: DropdownButtonFormField<String>(
                          value: _selectedTrangThai,
                          decoration: InputDecoration(
                            border: OutlineInputBorder(),
                            contentPadding:
                                EdgeInsets.symmetric(horizontal: 10),
                            labelText:
                                _selectedTrangThai == null ? 'Đã xuất' : null,
                          ),
                          items: ['Đã xuất', 'Chưa xuất'].map((String value) {
                            return DropdownMenuItem<String>(
                              value: value,
                              child: Text(value),
                            );
                          }).toList(),
                          onChanged: (String? value) {
                            setState(() {
                              _selectedTrangThai = value;
                            });
                          },
                        ),
                      ),
                      SizedBox(width: 250),
                      OutlinedButton(
                        onPressed: () {},
                        child: Text('Tìm kiếm'),
                      ),
                    ],
                  ),
                ),
                SizedBox(width: 328),
              ],
            ),
            SizedBox(height: 70),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Container(
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.black),
                ),
                child: DataTable(
                  columnSpacing: 20, // Reduce spacing between columns
                  headingRowHeight: 35, // Smaller header row height
                  dataRowHeight: 65, // Smaller data row height
                  columns: const <DataColumn>[
                    DataColumn(
                      label: SizedBox(
                          width: 120,
                          child: Text('Loại phiếu',
                              style: TextStyle(fontSize: 12))),
                    ),
                    DataColumn(
                      label: SizedBox(
                          width: 120,
                          child: Text('Thời gian',
                              style: TextStyle(fontSize: 12))),
                    ),
                    DataColumn(
                      label: SizedBox(
                          width: 80,
                          child:
                              Text('Bồn xuất', style: TextStyle(fontSize: 12))),
                    ),
                    DataColumn(
                      label: SizedBox(
                          width: 80,
                          child:
                              Text('Xe nhận', style: TextStyle(fontSize: 12))),
                    ),
                    DataColumn(
                      label: SizedBox(
                          width: 80,
                          child:
                              Text('Số phiếu', style: TextStyle(fontSize: 12))),
                    ),
                    DataColumn(
                      label: SizedBox(
                          width: 80,
                          child: Text('Trạng thái',
                              style: TextStyle(fontSize: 12))),
                    ),
                    DataColumn(
                      label: SizedBox(
                          width: 120,
                          child: Text('Lý do xuất',
                              style: TextStyle(fontSize: 12))),
                    ),
                    DataColumn(
                      label: SizedBox(
                          width: 120,
                          child: Text('Người giao',
                              style: TextStyle(fontSize: 12))),
                    ),
                    DataColumn(
                      label: SizedBox(
                          width: 120,
                          child: Text('Người nhận',
                              style: TextStyle(fontSize: 12))),
                    ),
                    DataColumn(
                      label: SizedBox(
                          width: 80,
                          child: Center(
                              child: Text('Button',
                                  style: TextStyle(fontSize: 12)))),
                    ),
                  ],
                  rows: filteredRows.map<DataRow>((row) {
                    return DataRow(
                      cells: <DataCell>[
                        DataCell(SizedBox(
                            width: 120,
                            child: Text(row['loaiPhieu']!,
                                style: TextStyle(fontSize: 12)))),
                        DataCell(SizedBox(
                            width: 120,
                            child: Text(row['thoiGian']!,
                                style: TextStyle(fontSize: 12)))),
                        DataCell(SizedBox(
                            width: 80,
                            child: Text(row['bonXuat']!,
                                style: TextStyle(fontSize: 12)))),
                        DataCell(SizedBox(
                            width: 80,
                            child: Text(row['xeNhan']!,
                                style: TextStyle(fontSize: 12)))),
                        DataCell(SizedBox(
                            width: 80,
                            child: Text(row['soPhieu']!,
                                style: TextStyle(fontSize: 12)))),
                        DataCell(SizedBox(
                            width: 80,
                            child: Text(row['trangThai']!,
                                style: TextStyle(fontSize: 12)))),
                        DataCell(SizedBox(
                            width: 120,
                            child: Text(row['lyDoXuat']!,
                                style: TextStyle(fontSize: 12)))),
                        DataCell(SizedBox(
                            width: 120,
                            child: Text(row['nguoiGiao']!,
                                style: TextStyle(fontSize: 12)))),
                        DataCell(SizedBox(
                            width: 120,
                            child: Text(row['nguoiNhan']!,
                                style: TextStyle(fontSize: 12)))),
                        DataCell(
                          SizedBox(
                            width: 80,
                            child: ElevatedButton(
                              onPressed: () {},
                              child: Text('Button',
                                  style: TextStyle(fontSize: 10)),
                            ),
                          ),
                        ),
                      ],
                    );
                  }).toList(),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
