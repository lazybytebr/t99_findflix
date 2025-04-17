from flask import Flask, request, jsonify
import mysql.connector

app = Flask(__name__)

# Configuração do banco de dados
conn = mysql.connector.connect(
    host="localhost",
    user="root",
    password="",
    database="testdb"
)
cursor = conn.cursor()

# Criar tabela (se não existir)
cursor.execute("""
CREATE TABLE IF NOT EXISTS users (
    id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(255),
    email VARCHAR(255)
)
""")
conn.commit()

# Criar um usuário
@app.route('/users', methods=['POST'])
def create_user():
    data = request.get_json()
    cursor.execute("INSERT INTO users (name, email) VALUES (%s, %s)", (data['name'], data['email']))
    conn.commit()
    return jsonify({"message": "Usuário criado com sucesso!"})

# Listar todos os usuários
@app.route('/users', methods=['GET'])
def get_users():
    cursor.execute("SELECT * FROM users")
    users = cursor.fetchall()
    return jsonify(users)

# Buscar um usuário por ID
@app.route('/users/<int:id>', methods=['GET'])
def get_user(id):
    cursor.execute("SELECT * FROM users WHERE id = %s", (id,))
    user = cursor.fetchone()
    return jsonify(user)

# Atualizar um usuário
@app.route('/users/<int:id>', methods=['PUT'])
def update_user(id):
    data = request.get_json()
    cursor.execute("UPDATE users SET name = %s, email = %s WHERE id = %s", (data['name'], data['email'], id))
    conn.commit()
    return jsonify({"message": "Usuário atualizado com sucesso!"})

# Deletar um usuário
@app.route('/users/<int:id>', methods=['DELETE'])
def delete_user(id):
    cursor.execute("DELETE FROM users WHERE id = %s", (id,))
    conn.commit()
    return jsonify({"message": "Usuário deletado com sucesso!"})

if __name__ == '__main__':
    app.run(debug=True)
