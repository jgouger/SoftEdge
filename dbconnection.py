import pyodbc 
from keygen import plain_text_unencryptedpassword

CongressConn = pyodbc.connect('DRIVER={ODBC Driver 17 for SQL Server};'
                      'SERVER=tcp:172.16.20.17;'
                      'DATABASE=Congress;'
                      'UID=congress;'
					  'PWD=' + plain_text_unencryptedpassword)
