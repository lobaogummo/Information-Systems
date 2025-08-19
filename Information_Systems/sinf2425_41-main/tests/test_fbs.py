import unittest
import psycopg2
import sys


sys.path.insert(0, "docker/data")
from fb import POSTGRE_DB_INSERT, MACHINE_SIMULATOR


class PostgreSQL(unittest.TestCase):

    def setUp(self):

        self.config = {
            "host": "localhost",
            "port": 5432,
            "user": "sinf",
            "password": "sinf",
            "dbname": "sinf",
            "schema": "DINASORE",
            "table": "pressing_samples",
        }

        # Check if Postgre is available
        psycopg2.connect(
            dbname=self.config["dbname"],
            user=self.config["user"],
            password=self.config["password"],
            host=self.config["host"],
            port=self.config["port"],
        )

    def test_POSTGRE_DB_INSERT(self):
        """
        Evaluate POSTGRE_DB_INSERT function block
        """
        function_block = POSTGRE_DB_INSERT.POSTGRE_DB_INSERT()

        function_block.schedule(event_name="INIT", **self.config)

        result = function_block.schedule(
            event_name="RUN",
            data="'2025-02-05 15:59:47',15.945,18.914,18.956,True",
            **self.config
        )

        self.assertTrue(result[-1])


class Sensors(unittest.TestCase):

    def setUp(self):

        self.config = {
            "params_data": "[((15, 0.4), (10, 0.4)), ((19, 0.1), (16, 0.1))]",
            "ratio": 0.3,
            "params_mtbf": "(18, 1.5)",
            "params_mtts": "(2, 1.5)",
            "params_mttr": "(5, 1.5)",
            "delay": 1.0,
        }

    def test_MACHINE_SIMULATOR(self):
        """
        Evaluate MACHINE SIMULATOR function block
        """
        function_block = MACHINE_SIMULATOR.MACHINE_SIMULATOR()

        function_block.schedule(event_name="INIT", **self.config)

        # Activate machine
        function_block.schedule(event_name="ON-OFF", **self.config)

        # Obtain results
        result = function_block.schedule(event_name="READ", **self.config)
        sensors = result[-2].split(",")

        self.assertTrue(result[-1], "WORK" and sensors[-1] == "False")


if __name__ == "__main__":
    unittest.main()
