require '../stdlib'

removerUsuario = ->
  # Carregar dados de login
  if file_exists 'arquivos/contas.yaml'
    logins = load_yaml 'arquivos/contas.yaml'
  else
    logins = []

  print '\n================================='
  print ' VOCÊ ESTÁ NA TELA DE REMOÇÃO '
  print '=================================\n'

  bool = true
  while (bool)
    process.stdout.write "\nDigite o nome de usuário para remover: "
    usuario = input()

    # Verificar se o usuário existe
    usuarioEncontrado = false
    senhaCorreta = false
    usuarioData = null

    for login in logins
      if login.user == usuario
        usuarioEncontrado = true
        usuarioData = login
        break

    if not usuarioEncontrado
      print color("r", "\nUsuário não encontrado.")
    else
      # Confirmação para remover o usuário
      tentativas = 3
      while tentativas > 0
        process.stdout.write "Digite a senha do usuario: "
        senha = input_password('*')
        senha_hash = hash_md5(senha)

        if usuarioData.password_hash == senha_hash
          senhaCorreta = true
          break
        else 
          tentativas--
          print color("r", "Senha incorreta. Restam #{tentativas} tentativa(s).")

      if not senhaCorreta
        print color("r", "\nNúmero máximo de tentativas excedido. Operação cancelada.")
        break

      process.stdout.write "Tem certeza que deseja remover o usuário #{usuario}? (s/N): "
      opcao = input()

      if opcao == 's' or opcao == 'S'
        logins = logins.filter (login) -> login.user != usuario
        save_yaml 'arquivos/contas.yaml', logins
        print color('g', "\nUsuário #{usuario} removido com sucesso!")
        bool = false
      else
        print color("y", "\nOperação cancelada.")
        bool = false

  print '\n================================='
  print ' SAINDO DA TELA DE REMOÇÃO! '
  print '=================================\n'

module.exports = removerUsuario
