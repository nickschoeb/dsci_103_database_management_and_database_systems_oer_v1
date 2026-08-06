from faker import Faker
import csv
import pandas as pd
import random

def main():
    """
    DOCS:

    ScriptName:
    Example_02_000_datagen.py

    Purpose:
    Script to generate data in csv format
    Expanded people
    """

    print("Example_2000_datagen Started")
    fake = Faker()
    number_to_gen =1000 # change this for a different number of data points
    data = []
    employee_id_counter = 1
    for i in range(number_to_gen):
        # dob between 20 and 60 years old
        date_between = fake.date_between(start_date="-60y", end_date="-20y")
        first_name = fake.first_name()
        last_name = fake.last_name()
        person = Person(
            employee_id="EMP" + f"{employee_id_counter:05}",
            first_name=first_name,
            last_name=last_name,
            email=first_name + "_" + last_name + str(date_between.year) + "@" + fake.domain_name(),
            dob=date_between.strftime("%Y-%m-%d"), # Fromat: 'YYYY-MM-DD'
            # hire when at least 20 years old until now
            year_hired=fake.pyint(min_value=date_between.year + 20, max_value=2026),
            is_active=fake.pybool(truth_probability=90))
        data.append(person)
        employee_id_counter = employee_id_counter + 1

    # Use pandas for csv file
    random.shuffle(data) # randomize so not in order of employee id
    df = pd.DataFrame([i.__dict__ for i in data])
    df.to_csv("data.csv", # change this for a different file name
              index=False,
              escapechar="\\",
              quotechar="'",
              quoting=csv.QUOTE_NONNUMERIC)

    # SQL insert format in another file
    with open('data.csv', 'r') as source_file, open('data_sql.txt', 'w') as dest_file:
        for line in source_file:
            dest_file.write("(" + line.rstrip('\n') + "),\n")

    print(str(number_to_gen) + " data points generated")
    print("Example_2000_datagen Complete")

class Person:
    # constructor which initializes attributes
    def __init__(self, employee_id, first_name, last_name, email, dob, year_hired, is_active):
        self.employee_id = employee_id
        self.first_name = first_name
        self.last_name = last_name
        self.email = email
        self.dob = dob
        self.year_hired = year_hired
        self.is_active = is_active

if __name__ == "__main__":
    main()
