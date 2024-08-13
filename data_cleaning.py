from pyspark.sql import SparkSession

from pyspark.sql.functions import col, trim, lower, to_date

# Inicia una sesión de Spark
spark = SparkSession.builder.appName("ClinicalTrialsCleaning").getOrCreate()

# Cargar datos desde un archivo CSV
df = spark.read.csv("clinical_trials_data.csv", header=True, inferSchema=True)

# Manejar valores nulos, normalizar texto y convertir formatos de fecha
df_cleaned = df.fillna("") \
               .withColumn("Study Title", trim(lower(col("Study Title")))) \
               .withColumn("Start Date", to_date(col("Start Date"), "yyyy-MM-dd")) \
               .withColumn("Completion Date", to_date(col("Completion Date"), "yyyy-MM-dd")) \
               .dropDuplicates(["NCT Number"])

# Mostrar los primeros registros del DataFrame limpio
df_cleaned.show()

# Guardar los datos limpios en un archivo CSV
df_cleaned.write.csv("clinical_trials_data_cleaned.csv", header=True)

# Alternativamente, guardar como tabla en Databricks
#df_cleaned.write.saveAsTable("cleaned_clinical_trials")
