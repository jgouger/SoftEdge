import pyodbc 
CongressConn = pyodbc.connect('DRIVER={ODBC Driver 17 for SQL Server};'
                      'SERVER=tcp:172.16.20.17;'
                      'DATABASE=Congress;'
                      'UID=congress;'
					  'PWD=congress117')
