from faker import Faker
import random

fake = Faker('pt_BR')

def generate_first_name():
    return fake.first_name()

def generate_last_name():
    return fake.last_name()

def generate_email():
    return fake.email()

def generate_cpf():
    def calculate_digit(digs):
        s = sum(v * (len(digs)+1-i) for i, v in enumerate(digs))
        digit = 11 - (s % 11)
        return digit if digit < 10 else 0

    n1, n2, n3 = random.randint(100, 999), random.randint(100, 999), random.randint(100, 999)
    base_cpf = [int(x) for x in f"{n1:03}{n2:03}{n3:03}"]

    d1 = calculate_digit(base_cpf)
    d2 = calculate_digit(base_cpf + [d1])

    return f"{n1:03}{n2:03}{n3:03}{d1}{d2}"

def generate_password():
    return fake.password()
