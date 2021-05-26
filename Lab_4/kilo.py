import psycopg2
import numpy

conn = psycopg2.connect(dbname='rk3', user='postgres',
                        password='123cemD123', host='localhost')
cursor = conn.cursor()

def get_profit_by_id_python():
    id_f = int(input("Введите id = "))
    try:
        cursor.execute(
            "SELECT * FROM employee join record on employee.id = record.id_employee  WHERE id = %(id)s", {'id': id_f})
        for row in cursor:
            print(row, "\n")
    except:
        print('Невалидный запрос, попробуй еще раз!\n')

get_profit_by_id_python();

cursor.close()
conn.close()
