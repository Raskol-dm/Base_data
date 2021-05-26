# вариант 2 Расколотов Д.Ю. ИУ7-54Б
import psycopg2

conn = psycopg2.connect(dbname='test3', user='postgres',
                               password='123cemD123', host='localhost')
cursor = conn.cursor()

def f1():
    try:
        cursor.execute(
            "select distinct unit from workers except (select distinct unit from workers where(extract(year from current_date) - extract(year from birthdate)) < 25)")
        for row in cursor:
            print(row, "\n")
    except:
        print("NOT OK")

def f2():
    try:
        cursor.execute(
            "select id_worker, min(wtime) as min_t from register where inout=1 and wdatea=current_date group by id_worker order by min_t limit 1")
        for row in cursor:
            print(row, "\n")
    except:
        print("NOT OK")

def f3():
    try:
        cursor.execute("select wk.id from ( select people.id_worker, count(*) from (select id_worker, min(wtime) as Ftime from register group by id_worker) as people where people.Ftime > '9:00' group by people.id_worker) count_people join workers wk on count_people.id_worker=wk.id where count >= 5")
        for row in cursor:
            print(row, "\n")
    except:
        print("NOT OK")

cursor.close()
conn.close()

f1()
f2()
