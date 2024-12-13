require '../stdlib'

cadastroDeUsuario = -> 
    # Carregando logins e hash das senhas de usuários já cadastrados
    if file_exists 'arquivos/contas.yaml'
      logins = load_yaml 'arquivos/contas.yaml'
    else
      logins = []

    opcao = "s"
    print '\n================================='
    print ' VOCÊ ESTÁ NA TELA DE CADASTRO! '
    print '=================================\n'

    while opcao == "s"
        while(true)
            process.stdout.write "Digite seu nome de usuário: "
            user = input()
            if user    
                break
            else 
                print color('r', 'Login não informado.\n')

        # Quantidade de usuários cadastrados
        loginsTamanho = len(logins)
        usuarioBusca = false

        # Procurando se o nome de usuário digitado já está na base de dados
        for i in [0...loginsTamanho]
            if logins[i].user == user
                usuarioBusca = true
                break

        if usuarioBusca
            print color("r", "Nome de usuário já cadastrado, tente novamente.\n")
        else
            while true
                process.stdout.write "Digite sua senha: "
                password = input_password("*")

                if password.length < 8
                    print color('r', "\nSenha deve conter pelo menos 8 caracteres!")
                else
                    password_hash = hash_md5(password)
                    break

            # Guardando usuário e senha na base de dados
            logins.push {user: user, password_hash: password_hash}
            save_yaml 'arquivos/contas.yaml', logins

            print "\nUsuário cadastrado com sucesso!"
            process.stdout.write "\nNovo cadastro? (s/N): "
            opcao = input()
    


    

    print '\n================================='
    print ' SAINDO DA TELA DE CADASTRO! '
    print '=================================\n'

module.exports = cadastroDeUsuario