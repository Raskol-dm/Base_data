import psycopg2
from contextlib import closing

#1 Выполнить скалярный запрос


def get_profit_by_id_python():
    id_f = int(input("Введите id = "))
    with closing(psycopg2.connect(dbname='Boksers', user='postgres',
                                  password='123cemD123', host='localhost')) as conn:
        with conn.cursor() as cursor:
            try:
                cursor.execute(
                    "SELECT * FROM boksers WHERE id = %(id)s", {'id': id_f})
                for row in cursor:
                    print(row, "\n")
            except:
                print('Невалидный запрос, попробуй еще раз!\n')

#2 Выполнить запрос с несколькими соединениями (JOIN)


def get_info_about_sport():
    hs_f = int(input("Введите id = "))
    with closing(psycopg2.connect(dbname='Boksers', user='postgres',
                                  password='123cemD123', host='localhost')) as conn:
        with conn.cursor() as cursor:
            try:
                cursor.execute(
                    "select boksers.name, cl.name, trs.position from boksers join transfers trs on boksers.id = trs.bokser join clubs cl on cl.id = trs.club where boksers.id = %(id)s", {'id': hs_f})
                for row in cursor:
                    print(row, "\n")
            except:
                print('Невалидный запрос, попробуй еще раз!\n')


#3 Выполнить запрос с ОТВ(CTE) и оконными функциями
#ищет среднее кол-во спортсменов в клубах

def get_OTB():
    with closing(psycopg2.connect(dbname='Boksers', user='postgres',
                                  password='123cemD123', host='localhost')) as conn:
        with conn.cursor() as cursor:
            try:
                cursor.execute("with CTE(sportsmennum, num) as ( select clubs.sportsmennum, count(*) from clubs group by clubs.sportsmennum) select cast(avg(num) as numeric(3, 0)) as SrednSp from CTE")
                for row in cursor:
                    print(row, "\n")
            except:
                print('Невалидный запрос, попробуй еще раз!\n')

#4 Выполнить запрос к метаданным


def get_info_meta():
    with closing(psycopg2.connect(dbname='Boksers', user='postgres',
                                  password='123cemD123', host='localhost')) as conn:
        with conn.cursor() as cursor:
            try:
                cursor.execute(
                    "select table_name as name, table_type as type from information_schema.tables where table_schema = 'public'")
                for row in cursor:
                    print(row, "\n")
            except:
                print('Невалидный запрос, попробуй еще раз!\n')

#5 Вызвать скалярную функцию (написанную в третьей лабораторной работе)


def get_func_lab_3_1():

    with closing(psycopg2.connect(dbname='Boksers', user='postgres',
                                  password='123cemD123', host='localhost')) as conn:
        with conn.cursor() as cursor:
            try:
                cursor.execute("select maxRatingBox()")
                for row in cursor:
                    print(row, "\n")
            except:
                print('Невалидный запрос, попробуй еще раз!\n')

#6 Вызвать многооператорную или табличную функцию (написанную в третьей лабораторной работе)


def get_func_lab_3_2():
    sponsor_n = input("Введите имя компании = ")
    budget_f = int(input("Введите добавочный бюджет = "))
    with closing(psycopg2.connect(dbname='Boksers', user='postgres',
                                  password='123cemD123', host='localhost')) as conn:
        with conn.cursor() as cursor:
            try:
                cursor.execute(
                    "select * from AddOneClient(%(sponsor)s,%(budget)s)", {'sponsor': sponsor_n, 'budget': budget_f})
                for row in cursor:
                    print(row, "\n")
            except:
                print('Невалидный запрос, попробуй еще раз!\n')

#7 Вызвать хранимую процедуру (написанную в третьей лабораторной работе)


def get_func_lab_3_3():
    new_rt = int(input("Введите новый рейтинг = "))
    low_rt = int(input("Введите нижнюю планку = "))
    high_rt = int(input("Введите верхнюю планку = "))
    with closing(psycopg2.connect(dbname='Boksers', user='postgres',
                                  password='123cemD123', host='localhost')) as conn:
        with conn.cursor() as cursor:
            try:
                cursor.execute("drop table if exists cl; select * into temp cl from clubs; call updateClubRate(%(newRate)s, %(low)s, %(high)s)", {
                               'newRate': new_rt, 'low': low_rt, 'high': high_rt})
            except:
                print('Невалидный запрос, попробуй еще раз!\n')



#8 Вызвать системную функцию или процедуру


def get_func_lab_3_4():
    with closing(psycopg2.connect(dbname='Boksers', user='postgres',
                                  password='123cemD123', host='localhost')) as conn:
        with conn.cursor() as cursor:
            try:
                cursor.execute('SELECT current_database()')
                for row in cursor:
                    print(row, "\n")
            except:
                print('Невалидный запрос, попробуй еще раз!\n')

#9 Создать таблицу в базе данных, соответствующую тематике БД


def get_func_lab_3_5():
    with closing(psycopg2.connect(dbname='Boksers', user='postgres',
                                  password='123cemD123', host='localhost')) as conn:
        with conn.cursor() as cursor:
            try:
                cursor.execute("drop table if exists identification; create table if not exists identification (id int PRIMARY KEY NOT NULL, type varchar(256) NOT NULL); ALTER TABLE identification ADD COLUMN id_bokser int; ALTER TABLE identification ADD CONSTRAINT FK_id_bokser FOREIGN KEY(id_bokser) REFERENCES boksers(id);")
                print("OK")
            except:
                print('Невалидный запрос, попробуй еще раз!\n')


#10 Выполнить вставку данных в созданную таблицу с использованием инструкции INSERT или COPY


def get_func_lab_3_6():
    with closing(psycopg2.connect(dbname='Boksers', user='postgres',
                                  password='123cemD123', host='localhost')) as conn:
        with conn.cursor() as cursor:
            try:
                cursor.execute(
                    "insert into identification values (1, 'Master of Sport'),(2, 'First Digit'), (3, 'Sports master candidate')")
            except:
                print('Невалидный запрос, попробуй еще раз!\n')


if __name__ == "__main__":
    flag_create = 0
    flag_insert = 0
    print(
        "Меню:\n"
        "1.Выбрать спортсмена по id\n"
        "2.Вывести информацию о спортмене, клубе и его стилю\n"
        "3.Средниe кол-во спортсменов в клубах\n"
        "4.Вывести имя, тип таблицы\n"
        "5.Вывести максимальный рейтинг у спортсменов\n"
        "6.Вывести информацию по клиенту\n"
        "7.Меняем рейтинг\n"
        "8.Имя текущей базы данных\n"
        "9.Создать таблицу\n"
        "10.Вставка данных в созданную таблицу\n"
        "0.Выход\n")

    menu = int(input("Выберите действие: "))
    while (menu != 0):
        if (menu == 1):
            get_profit_by_id_python()
        elif (menu == 2):
            get_info_about_sport()
        elif (menu == 3):
            get_OTB()
        elif (menu == 4):
            get_info_meta()
        elif (menu == 5):
            get_func_lab_3_1()
        elif (menu == 6):
            get_func_lab_3_2()
        elif (menu == 7):
            get_func_lab_3_3()
        elif (menu == 8):
            get_func_lab_3_4()
        elif (menu == 9):
            if (flag_create == 0):
                get_func_lab_3_5()
                flag_create = 1
            else:
                print("Таблица уже создана\n")
        elif (menu == 10):
            if flag_create == 1 and flag_insert == 0:
                get_func_lab_3_6()
            elif flag_create == 0:
                print("Таблица не создана\n")
            else:
                print("Данные уже добавлены\n")
        print(
            "Меню:\n"
            "1.Выбрать спортсмена по id\n"
            "2.Вывести информацию о спортмене, клубе и его стилю\n"
            "3.Средниe кол-во спортсменов в клубах\n"
            "4.Вывести имя, тип таблицы\n"
            "5.Вывести максимальный рейтинг у спортсменов\n"
            "6.Вывести информацию по клиенту\n"
            "7.Меняем рейтинг\n"
            "8.Имя текущей базы данных\n"
            "9.Создать таблицу\n"
            "10.Вставка данных в созданную таблицу\n"
            "0.Выход\n")

        menu = int(input("Выберите из списка: "))
