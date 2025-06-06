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
        print( '{"mensagem" : "Problema ao Conectar!"   }')
        return None

@app.route( '/registrar/', methods=['POST'] )
def cadastrar_usuario():

    # retornado da função conecta_mysql()
    conexao = conecta_mysql()

    if conexao != None: # se não conectar

        # posiciona o cursor 
        cursor = conexao.cursor()

        # receber os dados do formulário usando request
        form = request.get_json()

        sql = "INSERT INTO usuarios (email, senha, nome_usuario) VALUES ('" + form['email'] + "',MD5('" + form['senha'] + "'),'" + form['usuario'] + "');"

        cursor.execute( sql ) # executa o comando SQL

        conexao.commit() # confirma a execução do comando SQL

        conexao.close() # fecha a conexão

        return jsonify( {"mensagem": "Cadastro realizado!" } )

    else:
        return jsonify( { "erro":"Cadastro não realizado!" } ) 

@app.route('/usuarios/', methods=['POST'])
def busca_usuarios():
    conexao = conecta_mysql() # conecta com o BD
    cursor = conexao.cursor() # cria o cursor para executa
    sql = "SELECT * FROM usuarios;"
    cursor.execute( sql ) # executar o sql
    #dados = cursor.fetchall() # mostra todos os dados

    # Montando o JSON para o padrão do front end
    colunas = [desc[0] for desc in cursor.description]
    # Cria uma lista de dicionários usando os nomes das colunas
    dados = [dict(zip(colunas, linha)) for linha in cursor.fetchall()]

    return jsonify( dados ) # retorna os dados usando JSON

#-------------------------
# Rota Atualizar usuários
#-------------------------
@app.route('/atualizar/', methods= ['PUT'])
def atualizar_usuarios():
    # 1. Conectar ao banco
    conexao = conecta_mysql()
    # 2. Cria o objeto cursor
    cursor = conexao.cursor()
    # 3. receber os dados do formulário html
    dados = request.get_json() # dados['usuario']
    # 4. comando do SQL
    sql= "UPDATE filmes_t99.usuarios SET email='" + dados['newEmail'] + "', nome_usuario='"+ dados['newUsuario'] +"' WHERE id_usuario = "+ dados['index'] +";"
    # 5. Rodar o comando SQL (testa)
    cursor.execute(sql)
    # 6. Gravar a alteração no BD
    conexao.commit()
    # 7. fechar a conexao
    conexao.close()
    # 8. dar retorno para o usuário
    return jsonify({'mensagem':'Alterado com sucesso!'})

#-------------------------
# Rota Apagar usuários
#-------------------------
@app.route('/apagar/', methods=['DELETE'])
def apagar_usuario():
    dados = request.get_json()

    if not dados or 'index' not in dados:
       return jsonify({'mensagem': 'ID não informado'}), 400

    conexao = conecta_mysql()

    cursor = conexao.cursor()

    sql = "DELETE FROM filmes_t99.usuarios WHERE id_usuario = " + str(dados['index']) + ";"

    cursor.execute(sql)

    conexao.commit()

    conexao.close()

    return jsonify({'mensagem': "Usuário excluído com sucesso!"}), 200

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
