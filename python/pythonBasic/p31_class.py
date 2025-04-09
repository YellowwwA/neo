#!usr/bin/env python


class Person(object):
    total = 10

    def __init__(self, name, age):
        self.name = name
        self.age = age

    def getMame(self):
        return self.name

    def getAge(self):
        return self.age
my = Person('Moon', 23)
print(my.name)
print(my.age)
print(my.getMame())
print(my.getAge())
print(my.total)

you = Person('You', 25)
print(you.getMame())
print(you.getAge())
print(you.getMame())
print(you.total)