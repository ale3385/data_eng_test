import psycopg2
import csv

# Conectar a la base de datos PostgreSQL
conn = psycopg2.connect(
    dbname="clinical_trials",
    user="user",
    password="password",
    host="localhost",  # Cambia a "db" si estás usando Docker
    port="5433"
)

# Crear un cursor para ejecutar comandos SQL
cur = conn.cursor()

# Crear la tabla clinical_trials_data
cur.execute("""
    CREATE TABLE IF NOT EXISTS clinical_trials_data (
        "NCT Number" VARCHAR PRIMARY KEY,
        "Study Title" VARCHAR,
        "Study Status" VARCHAR,
        "Start Date" VARCHAR,
        "Completion Date" VARCHAR
    )
""")

# Leer los datos del archivo CSV e insertarlos en la tabla
with open('clinical_trials_data.csv', 'r') as f:
    reader = csv.DictReader(f)
    for row in reader:
        cur.execute("""
            INSERT INTO clinical_trials_data ("NCT Number", "Study Title", "Study Status", "Start Date", "Completion Date")
            VALUES (%s, %s, %s, %s, %s)
            ON CONFLICT ("NCT Number") DO NOTHING
        """, (row["NCT Number"], row["Study Title"], row["Study Status"], row["Start Date"], row["Completion Date"]))

# Confirmar la transacción
conn.commit()

# Cerrar la conexión
cur.close()
conn.close()

print("Tabla creada y datos cargados con éxito.")
