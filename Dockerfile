# Usando a imagem oficial do Python como base
FROM python:3.9-slim

# Definir o diretório de trabalho dentro do contêiner
WORKDIR /app

# Copiar os arquivos de dependências (se existir um requirements.txt)
COPY requirements.txt .

# Instalar as dependências do Python
RUN pip install -r requirements.txt

# Copiar o código da aplicação para o contêiner
COPY . .

# Expõe a porta em que a aplicação Flask estará rodando
EXPOSE 5000

# Comando para rodar a aplicação Flask
CMD ["python", "app/app.py"]