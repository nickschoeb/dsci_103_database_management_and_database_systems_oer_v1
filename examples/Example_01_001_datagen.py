from faker import Faker
import csv
import pandas as pd

def main():
    """
    DOCS:

    ScriptName:
    Example_1000_datagen.py

    Purpose:
    Script to generate data in csv format
    Person:
    First Name
    Middle Name
    Last Name
    Age (between 18 and 99)

    Notes:
    File will be overwritten each time
    You can open this in Excel
    Other scripts will follow a similar format
    """

    print("Example_1000_datagen Started")
    fake = Faker()
    number_to_gen = 20 # change this for a different number of data points
    data = []
    for i in range(number_to_gen):
        first_name = fake.first_name()
        middle_name = fake.first_name()
        last_name = fake.last_name()
        age = fake.pyint(min_value=18, max_value=99)
        person = Person(first_name=first_name, middle_name=middle_name, last_name=last_name, age=age)
        data.append(person)

    # Use pandas for csv file
    df = pd.DataFrame([i.__dict__ for i in data])
    df.to_csv("data.csv", # change this for a different file name
              index=False,
              escapechar="\\",
              quoting=csv.QUOTE_ALL)

    print(str(number_to_gen) + " data points generated")
    print("Example_1000_datagen Complete")

class Person:
    # constructor which initializes attributes
    def __init__(self, first_name, middle_name, last_name, age):
        self.first_name = first_name
        self.middle_name = middle_name
        self.last_name = last_name
        self.age = age

if __name__ == "__main__":
    main()
