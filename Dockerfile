# Usa una imagen base de Python con dbt-core y dbt-postgres instalados
FROM python:3.10-slim

# Instala dbt-core y el adaptador de PostgreSQL
RUN pip install dbt-core dbt-postgres

# Establece el directorio de trabajo dentro del contenedor
WORKDIR /app

# Copia el contenido del proyecto al contenedor
COPY . .

# Copia el archivo profiles.yml desde la carpeta .dbt en tu proyecto al directorio esperado en el contenedor
RUN mkdir -p /root/.dbt && cp /app/.dbt/profiles.yml /root/.dbt/profiles.yml

# No necesitas ejecutar dbt init si ya tienes un proyecto configurado
# RUN if [ ! -d "/app/clinical_trials_project" ]; then dbt init clinical_trials_project --profile clinical_trials_project; fi

# Establece el punto de entrada (opcional, según tu aplicación)
CMD ["tail", "-f", "/dev/null"]
