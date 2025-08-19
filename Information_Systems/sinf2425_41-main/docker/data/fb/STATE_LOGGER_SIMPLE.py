import psycopg2
from datetime import datetime
from typing import Optional, Union, List

class STATE_LOGGER_SIMPLE:

    def __init__(self):
        self.conn = None
        self.cur  = None

    def schedule(
        self,
        event_name: Union[str,None]=None,
        event_value: Optional[str]=None,
        host:     Optional[str]=None,
        port:     Optional[int]=None,
        user:     Optional[str]=None,
        password: Optional[str]=None,
        dbname:   Optional[str]=None,
        schema:   Optional[str]=None,
        table:    Optional[str]=None,
        station_id: Optional[str]=None,
        state:      Optional[str]=None,
    ) -> List[Union[None,str,bool]]:

        # --- INIT: abre conexão
        if event_name == "INIT":
            try:
                self.conn = psycopg2.connect(
                    host=host, port=port,
                    user=user, password=password,
                    dbname=dbname
                )
                self.conn.autocommit = False
                self.cur = self.conn.cursor()
                return [event_value, None, True]
            except Exception as e:
                print("INIT error:", e)
                return [event_value, None, False]

        # --- RUN: insere registro
        elif event_name == "RUN":
            if not self.cur:
                print("DB não inicializado")
                return [None, event_value, False]
            try:
                sql = f'''
                  INSERT INTO "{schema}"."{table}"
                    (ts, station_id, state)
                  VALUES (%s, %s, %s);
                '''
                now = datetime.now()
                self.cur.execute(sql, (now, station_id, state))
                self.conn.commit()
                return [None, event_value, True]
            except Exception as e:
                self.conn.rollback()
                print("RUN error:", e)
                return [None, event_value, False]

        else:
            raise ValueError(f"Evento desconhecido: {event_name}")
