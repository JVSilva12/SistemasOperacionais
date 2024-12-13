require '../stdlib'

verificarLogin = (usuario, senha) ->
  # Carregar dados de login
  if file_exists 'arquivos/contas.yaml'
    logins = load_yaml 'arquivos/contas.yaml'
  else
    logins = []

  # Verificar se a senha está definida e não é vazia
  if not senha or senha == ''
    print color('r', "\nSenha não pode estar vazia.")
    return false

  # Gerar hash da senha
  senha_hash = hash_md5(senha)

  # Verificar se as credenciais estão corretas
  logins.some (login) -> login.user == usuario && login.password_hash == senha_hash

# Função principal que controla o fluxo do login
fazerLogin = ->
  print '\n================================='
  print ' VOCÊ ESTÁ NA TELA DE LOGIN! '
  print '=================================\n'

  bool = true
  while(bool)
    process.stdout.write "\nDigite seu usuário: "
    usuario = input()
    
    process.stdout.write "Digite sua senha: "
    senha = input_password('*')

    # Verificação do login
    if verificarLogin(usuario, senha)
      print "\nBem-vindo(a) de volta, #{usuario}!"
      bool = false
    else
      print color("r", "\nUsuário ou senha incorretos.")

  print '\n================================='
  print ' SAINDO DA TELA DE LOGIN! '
  print '=================================\n'

module.exports = fazerLogin
