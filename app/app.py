# API - Back End - filmes_t99 - acesso sem front end
# Python -> não conversa diretamento com o banco -> plugin
# Flask - micro Framework para criação de API e Web

"""
    Bloco de comentário no Python

    Python trabalha com indentação, o que está indentado está dentro do bloco.

    portugol         python          php           C#
    escreva()        print()        echo ""       Console.WriteLine()
    leia()           input()        html          Console.ReadLine()

    Instalamos as dependências usando o comando pip:
        pip install flask ...
    
    Frameworks python:
        - Flask - web/api - leve
        - Django - web - ecommerce
        - Kivy - android/ioS

    O Python trabalha com o conceito de PACOTES ( PACKAGES )
"""
# importando das bibliotecas
from flask import Flask, redirect, send_from_directory, jsonify, request
import mysql.connector

app = Flask(__name__) # define como arquivo de início
#----------- Início das Funções das rotas da aplicação

#-------------------------
# Acesso ao Banco de Dados
#-------------------------
def conecta_mysql():
    try: # tenta a conexão
        conexao = mysql.connector.connect(
            host="db",# container ou externo
            port=3306,
            user="root",
            password="root",
            database="filmes_t99"
        )

        return conexao # retorna a conexão com BD

    except Exception as erro: # se der erro
        #print( f"{ "erro":"Problema ao Conectar! O erro foi: {erro}" }" )
        # print("Erro:", erro )
        #print( '{"erro" : "Problema ao Conectar!"' + erro +' }')
        print( '{"erro" : "Problema ao Conectar!"}')
        return None

@app.route( '/registrar/', methods=['POST'] )
def cadastrar_usuario():

    # retornado da função conecta_mysql()
    conexao = conecta_mysql()

    # se a conexão não está nula
    if conexao != None:

        # posiciona o cursor 
        cursor = conexao.cursor()

        # receber os dados do formulário usando request
        form = request.get_json()

        sql = 'INSERT INTO usuarios ( email, senha, usuario ) VALUES ("' + form['email'] + '","' + form['senha'] + '", "' + form['usuario'] + '");' # comando do SQL

        cursor.execute(sql) # executa o comando SQL

        #dados = cursor.fetchall()  # retorna todos os dados (select)
        #dados = cursor.fetchone()  # retorna o primeiro (select)

        return jsonify( '{"mensagem" : "Cadastro Realizado!"}' )

    else:
        return jsonify( { "erro":"Problema com os dados!" } ) 
    
@app.route('/usuarios/')
def busca_usuarios():
    conexao = conecta_mysql() # conecta com o BD
    cursor = conexao.cursor() # cria o cursor para executa
    sql = "SELECT * FROM usuarios;"
    cursor.execute( sql ) # executar o sql
    dados = cursor.fetchall() # mostra todos os dados

    return jsonify( dados ) # retorna os dados usando JSON

#-------------------------
# Rota Inicial (Home)
#-------------------------
@app.route('/')
def home():
    # envia o html da pasta interna
    return send_from_directory( './public', 'index.html' )

@app.route('/senac/') # define a rota ( url / endpoint )
def redireciona_senac():
    return redirect( "https://www.sp.senac.br" )

#-------------------------
# Rotas de Acesso
#-------------------------
@app.route("/login/") # rota GET ( pela url )
def entrar_sistema():
    return send_from_directory('./public', 'login_form.html')

#-------------------------
# Rotas de Cadastro
#-------------------------
@app.route("/cadastrar/")
def cadastrar_sistema():
    return send_from_directory('./public', 'cadastrar_form.html')

#----------- Final das funções
if __name__ == '__main__':
    # permitir a conexão de qualquer local (IP)
    app.run( debug=True, host='0.0.0.0', port=5000 )
