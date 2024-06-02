import logging
import random
import psycopg2
import os

from psycopg2 import DatabaseError
from contextlib import contextmanager

from faker import Faker
from dotenv import load_dotenv

# Load environment variables
load_dotenv()

# Initialize Faker
fake = Faker('uk_UA')

# Configure logging
logging.basicConfig(level=logging.INFO)

# Database connection parameters
DB_NAME = os.getenv("DB_NAME")
DB_USER = os.getenv("DB_USER")
DB_PASSWORD = os.getenv("DB_PASSWORD")
DB_HOST = os.getenv("DB_HOST")


@contextmanager
def create_connection():
    conn = None
    try:
        """ create a database connection to database """
        conn = psycopg2.connect(host=DB_HOST, database=DB_NAME, user=DB_USER, password=DB_PASSWORD)
        yield conn
    except psycopg2.OperationalError as err:
        logging.error(f"Failed to create database connection: {err}")
        raise RuntimeError(f"Failed to create database connection: {err}")
    finally:
        if conn:
            conn.close()


def create_data():
    with create_connection() as conn:
        cur = conn.cursor()
        try:
            # Insert data into grups
            for _ in range(3):
                cur.execute("INSERT INTO grups (gr_name) VALUES (%s)", (fake.word(),))

            # Insert data into teachers
            for _ in range(5):
                cur.execute("INSERT INTO teachers (teach_name) VALUES (%s)", (fake.name(),))

            # Insert data into subjects
            for teacher_id in range(1, 6):
                for _ in range(2):
                    cur.execute("INSERT INTO subjects (subject, teacher_id) VALUES (%s, %s)", (fake.word(), teacher_id))

            # Insert data into students and grades
            for group_id in range(1, 4):
                for _ in range(50):
                    cur.execute("INSERT INTO students (st_name, group_id) VALUES (%s, %s) RETURNING id",
                                (fake.name(), group_id))
                    student_id = cur.fetchone()[0]
                    for subject_id in range(1, 7):
                        for _ in range(3):
                            cur.execute(
                                "INSERT INTO grades (student_id, subject_id, grade, grade_date) VALUES (%s, %s, %s, %s)",
                                (student_id, subject_id, random.randint(0, 100), fake.date_this_year()))

            # Commit transaction
            conn.commit()
        except DatabaseError as err:
            logging.error(f"Database error: {err}")
            conn.rollback()
            raise RuntimeError(f"Database error: {err}")
        finally:
            if cur:
                cur.close()


if __name__ == "__main__":
    try:
        create_data()
        logging.info("Data creation completed successfully.")
    except RuntimeError as err:
        logging.error(f"Runtime error: {err}")
