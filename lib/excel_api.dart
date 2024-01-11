import 'package:excel/excel.dart';
import 'package:excel_export/data.dart';

class ExcelAPI {
  void fillExcelSheet(String fileName) {
    var excel = Excel.createExcel();
    Sheet sheetObject = excel['demoSheet'];

    CellInfo cellInfo = CellInfo();

    for (var rows in tableData) {
      
      for (var items in rows) {
        var cell = sheetObject.cell(
          CellIndex.indexByString(cellInfo.toString()),
        );
        cell.value = TextCellValue(items);
        cell.cellStyle = CellStyle();
        cellInfo.incrementCellLetter();
      }
      cellInfo.resetLetter();
      cellInfo.incrementCellNumber();
    }

    excel.save(
      fileName: '$fileName.xlsx',
    );
  }
}

class CellInfo {
  String cellLetter;
  int cellNumber;

  CellInfo({this.cellLetter = 'A', this.cellNumber = 1});

  @override
  String toString() => '$cellLetter${cellNumber.toString()}';

  incrementCellNumber() {
    cellNumber = cellNumber + 1;
  }

  void resetNumber(){
    cellNumber = 1;
  }
  void resetLetter(){
    cellLetter = 'A';
  }
  

  incrementCellLetter() {
    cellLetter = String.fromCharCode(cellLetter.codeUnitAt(0) + 1);
  }
}
