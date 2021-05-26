#Найти все отделы, в которых работает более 10 сотрудников

import numpy
import psycopg2
# def find_dep_1():
#  # try:
# cursor = connection.cursor(cursor_factory=DictCursor)
# query = '''
# select department
# from employee
# group by department
# having count(id) > 10;
# '''
# cursor.execute(query)
# answ = cursor.fetchall()
# print("Найти все отделы, в которых работает более 10 сотрудников")
# print(tabulate(answ, headers=['Отдел']))
# cursor.close()
# # except Exception:
# # print("Error")


# def find_dep_2():


# cursor = connection.cursor(cursor_factory=DictCursor)
# cursor.execute('select * from employee')
# employee = Enumerable(cursor.fetchall())
# cursor.close()

# dep = (employee.group_by(key_names=['department'], key=lambda x: x['department']))\
#     .select(lambda g: {'department': g.key.department, 'cnt': g.count()}).where(lambda g: g['cnt'] > 10)\
#     .to_list()
# print(dep)

#Найти все отделы, в которых работает более 10 сотрудников
conn = psycopg2.connect(dbname='test2', user='postgres',
                        password='123cemD123', host='localhost')
cursor = conn.cursor()


def get_otdel_over_ten():
    try:
        cursor.execute(
            "SELECT unit FROM workers group by unit having count(*) > 10")
        for row in cursor:
            print(row, "\n")
    except:
        print('Невалидный запрос, попробуй еще раз!\n')


get_otdel_over_ten()

cursor.close()
conn.close()


#Найти сотрудников, которые не выходят с рабочего места в течение всего рабочего дня
#Целый день - один раз пришёл и один раз ушёл -> inout = 2
conn = psycopg2.connect(dbname='test2', user='postgres',
                        password='123cemD123', host='localhost')
cursor = conn.cursor()


def get_worker():
    try:
        cursor.execute(
            "SELECT id_worker, wdatea, count(inout) FROM register group by id_worker,wdatea having count(inout) <= 2")
        for row in cursor:
            print(row, "\n")
    except:
        print('Невалидный запрос, попробуй еще раз!\n')


get_worker()

cursor.close()
conn.close()

#Найти все отделы, в которых есть сотрудники, опоздавшие в определенную дату. Дату
#передавать с клавиатуры
conn = psycopg2.connect(dbname='test2', user='postgres',
                        password='123cemD123', host='localhost')
cursor = conn.cursor()


def get_unit_intime():
    my_dt = input("Введите дату = ")
    try:
        cursor.execute(
            "SELECT unit from (select register.id_worker from register where wdatea = %(Dt)s and inout = 1 group by id_worker having min(wtime) > '9:00') lvl join workers on lvl.id_worker = workers.id", {'Dt': my_dt})
        for row in cursor:
            print(row, "\n")
    except:
        print('Невалидный запрос, попробуй еще раз!\n')


get_unit_intime()

cursor.close()
conn.close()



#Лямбда
conn = psycopg2.connect(dbname='test2', user='postgres',
                        password='123cemD123', host='localhost')
cursor = conn.cursor()


def get_otdel_over_ten_lamda():
    try:
        cursor.execute("SELECT * from workers")
        workers = #?????(cursor.fetchall())
        quant = (workers.group_by(Picks=['unit'], pick=lambda x: x['unit']))\
            .select(lambda y: {'unit': y.pick.unit, 'qty': y.count()}).where(lambda y: y['qty'] > 10)\
            .to_list()
        print(quant)
    except:
        print('Невалидный запрос, попробуй еще раз!\n')


get_otdel_over_ten_lamda()

cursor.close()
conn.close()


# cursor = connection.cursor(cursor_factory=DictCursor)
# cursor.execute('select * from employee')
# employee = Enumerable(cursor.fetchall())
# cursor.close()
