# QUESTÃO 4 DA LISTA 1 DE SO
sorteioUsuario = ->

    require './stdlib'

    # Carregando logins e hash das senhas de usuários já cadastrados
    logins = load_yaml './arquivos/contas.yaml'

    print '\n================================='
    print ' VOCÊ ESTÁ NA TELA DE SORTEIO! '
    print '=================================\n'

    opcao = "s"
    loop 
        # Quantidade de usuários cadastrados
        tamanho_logins = len(logins)

        # Número aleatório
        idx = random 1, tamanho_logins

        # Usuário ganhador
        print color('m', "\nO usuário '#{logins[idx].user}' ganhou o sorteio!! 😄")

        process.stdout.write "\nNovo sorteio s/N? "
        opcao = input()
        break unless opcao == "s"
    print '\n================================='
    print ' SAINDO DA TELA DE SORTEIO! '
    print '=================================\n' 

module.exports = sorteioUsuario