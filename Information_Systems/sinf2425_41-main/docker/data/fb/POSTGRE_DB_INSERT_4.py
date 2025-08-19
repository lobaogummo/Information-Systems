import psycopg2
from typing import Optional, Union


class POSTGRE_DB_INSERT_4:

    def __init__(self):
        self.conn = None
        self.cursor = None

    def schedule(
        self,
        event_name: Union[str, None] = None,
        event_value: Optional[Union[str, None]] = None,
        host: Optional[Union[str, None]] = None,
        port: Optional[Union[int, None]] = None,
        user: Optional[Union[str, None]] = None,
        password: Optional[Union[str, None]] = None,
        dbname: Optional[Union[str, None]] = None,
        schema: Optional[Union[str, None]] = None,
        table: Optional[Union[str, None]] = None,
        data: Optional[Union[str, None]] = None,
    ):
        if event_name not in ["INIT", "RUN"]:
            raise ValueError("Invalid event name.")

        if event_name == "INIT":
            try:
                self.conn = psycopg2.connect(
                    dbname=dbname,
                    user=user,
                    password=password,
                    host=host,
                    port=port,
                )
                self.cursor = self.conn.cursor()
                return [event_value, None, True]
            except psycopg2.OperationalError as err:
                self.conn = None
                print(err)
                return [event_value, None, False]

        elif event_name == "RUN":
            # 1) Verifica conexão
            if self.conn is None:
                print("No connection to PostgreSQL DB.")
                return [event_value, None, False]

            # 2) Se não há dados, apenas propaga
            if not data:
                return [None, event_value, True]

            try:
                # 3) Parse do CSV: [timestamp, v1, v2, …, vN, anomaly]
                parts   = data.split(',')
                ts      = parts[0].strip()
                anomaly = parts[-1].strip().lower() in ("true", "t", "1")
                values  = [float(x) for x in parts[1:-1]]

                # 4) Gera sensor_ids [1,2,3,…] em ordem
                sensor_ids = (23,24,25,26,27)

                # 5) Loop de INSERTs, um por sensor
                for sid, val in zip(sensor_ids, values):
                    self.cursor.execute(
                        f'INSERT INTO "{schema}"."{table}" '
                        '(timestamp, measurement_value, anomaly_flag, sensor_id) '
                        'VALUES (%s, %s, %s, %s)',
                        (ts, val, anomaly, sid)
                    )

                # 6) Commit único ao final
                self.conn.commit()
                return [None, event_value, True]

            except Exception as err:
                # 7) Em caso de erro, rollback e retorno falso
                self.conn.rollback()
                print("Erro ao inserir RUN:", err)
                return [None, event_value, False]
