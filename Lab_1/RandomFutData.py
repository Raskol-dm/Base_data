from faker import Faker
from random import randint
from random import choice

MAX = 1000
sex = ['male', 'female']
arm = ['left', 'right']
positions = ['MMA', 'BOKS', 'MORTAL_COMBAT', 'AIKIDO', 'SAMBO', 'ARB', 'KUNFU', 'USHU', 'KARATE']

def generateBoksers():
    faker = Faker()
    f = open('boksers.csv', 'w')
    for i in range(1000):
        rating = randint(0, 99)
        age = randint(16,45)
        line = "{0},{1},{2},{3},{4},{5}\n".format( i+1,
                                                  faker.name(),
                                                  choice(sex),
                                                  age,
                                                  choice(arm),
                                                  rating)
        f.write(line)
    f.close()

def generateClubs():
    faker = Faker()
    f = open('clubs.csv', 'w')
    for i in range(1000):
        rating = randint(100, 999)
        sportsmenNum = randint(0, 50)
        trophiesNum = randint(70, 240)
        line = "{0},{1},{2},{3},{4}\n".format(i+1,faker.city(), rating, trophiesNum, sportsmenNum)
        f.write(line)
    f.close()

def generateSponsors():
    faker = Faker()
    f = open('sponsors.csv', 'w')
    for i in range(1000):
        clients = randint(1, 40)
        budget = randint(10000, 500000)
        line = "{0},{1},{2},{3},{4}\n".format( i+1,
                                                  faker.name(),
                                                  faker.city(),
                                                  clients,
                                                  budget)
        f.write(line)
    f.close()

def generateTransfers():
    f = open('transfers.csv', 'w')
    for i in range(1000):
        line = "{0},{1},{2},{3}\n".format(randint(1, MAX-1), randint(1, MAX-1), randint(1, MAX-1), choice(positions))
        f.write(line)
    f.close()


if __name__ == "__main__":
    generateBoksers()
    generateClubs()
    generateSponsors()
    generateTransfers()