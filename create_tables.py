import psycopg2
import logging
from contextlib import contextmanager

# Configure logging
logging.basicConfig(level=logging.ERROR, format='%(asctime)s %(levelname)s:%(message)s')


@contextmanager
def create_connection():
    conn = None
    cur = None

    try:
        """ create a database connection to database """
        conn = psycopg2.connect(host="localhost", database="postgres", user="admin", password="example")
        yield conn

    except psycopg2.OperationalError as err:
        logging.error(f"Failed to create database connection: {err}")
        raise RuntimeError(f"Failed to create database connection: {err}")

    finally:
        if conn:
            conn.close()


def setup_database():
    with create_connection() as conn:
        cur = conn.cursor()
        try:
            cur.execute("""
            DROP TABLE IF EXISTS grups;
            CREATE TABLE grups (
                id SERIAL PRIMARY KEY,
                gr_name VARCHAR(50)
            );
            """)
            cur.execute("""
            DROP TABLE IF EXISTS students;
            CREATE TABLE students (
                id SERIAL PRIMARY KEY,
                st_name VARCHAR(50) NOT NULL,
                group_id INT,
                FOREIGN KEY (group_id) REFERENCES grups (id));
            """)
            cur.execute("""
            DROP TABLE IF EXISTS teachers;
            CREATE TABLE teachers (
                id SERIAL PRIMARY KEY,
                teach_name VARCHAR(50));
            """)
            cur.execute("""
            DROP TABLE IF EXISTS subjects;
            CREATE TABLE subjects (
                id SERIAL PRIMARY KEY,
                subject VARCHAR(50),
                teacher_id INT,
                FOREIGN KEY (teacher_id) REFERENCES teachers (id));
            """)

            cur.execute("""
            DROP TABLE IF EXISTS grades;
            CREATE TABLE grades (
                id SERIAL PRIMARY KEY,
                student_id INT,
                subject_id INT,
                grade INT CHECK (grade >= 0 AND grade <= 100),
                grade_date DATE NOT NULL,
                FOREIGN KEY (student_id) REFERENCES students (id),
                FOREIGN KEY (subject_id) REFERENCES subjects (id));
            """)
            conn.commit()

        except Exception as e:
            logging.error(f"Failed to setup the database: {e}")
            conn.rollback()

        finally:
            cur.close()


if __name__ == "__main__":
    setup_database()