#delete_demo.py

from openpyxl import Workbook


def deleting_cols_rows(path):
    workbook = Workbook()
    sheet = workbook.active
    sheet['A1'] = 'Hello'
    sheet['B1'] = 'World'
    sheet['c1'] = 'Goodbye'
    sheet['a2'] = 'Cruel'
    sheet['a3'] = 'World'
    sheet['A4'] = 'Hello'
    sheet['a5'] = 'World'
    #Delete column A
    sheet.delete_cols(idx=1)
    #Delete 2 rows starting from row 2
    sheet.delete_rows(idx=2, amount=2)
    workbook.save(path)

if __name__ == '__main__':
    deleting_cols_rows('deleting.xlsx')