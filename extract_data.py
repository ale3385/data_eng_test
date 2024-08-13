import requests
import pandas as pd
from io import StringIO

# Configuración de la URL y headers
url = "https://clinicaltrials.gov/api/v2/studies?format=csv&pageSize=10"
headers = {
    "accept": "application/json"
}

# Realizar la solicitud GET a la API
response = requests.get(url, headers=headers)

if response.status_code == 200:
    # Leer el CSV desde el contenido de la respuesta usando pandas
    data = StringIO(response.text)
    df = pd.read_csv(data)
    
    # Mostrar los primeros registros para verificar el contenido
    print(df.head())
    
    # Guardar el DataFrame en un archivo CSV local
    df.to_csv("clinical_trials_data.csv", index=False)
    print("Datos guardados en 'clinical_trials_data.csv'")
else:
    print(f"Error: {response.status_code}")
