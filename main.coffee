require './stdlib'

print '\n================================='
print '         SEJA BEM VINDO!           '
print '=================================\n'


while true
    print "\nVOCÊ PODE ESCOLHER UMA OPÇAO"
    print "SISTEMA DE CONTAS DE USUARIO   - 1"
    print "SISTEMA DE ARQUIVOS DO USUARIO - 2"
    print "SAIR - 0\n"
    process.stdout.write "Digite uma opção: "
    opcao = input()

    if opcao == '1'
        while(true)
            print '\n================================='
            print '        CONTAS DO USUÁRIO!         '
            print '=================================\n'

            print("\n         MENU        ")
            print("Suas opções:    ")
            print "Cadastrar usuario  - 1"
            print "Logar na conta     - 2"
            print "Remover usuario    - 3"
            print "Sorteio de usuario - 4"
            print "Sair do sistema    - 0\n"
            process.stdout.write "Escolha uma ação: "
            opcao = input()


            if (opcao == '1')
                cadastroDeUsuario = require './cadastro/cadastrar'
                cadastroDeUsuario()
                sincronizarUsuarios = require './sincronizarHdContas'
                sincronizarUsuarios()
            else if (opcao == '2') 
                verificarLogin = require './cadastro/logado'
                verificarLogin()
            else if (opcao == '3')
                removerUsuario =  require './cadastro/removerUsuario'
                removerUsuario()
                sincronizarUsuarios()
            else if (opcao == '4')
                sorteioUsuario = require './sorteioUsuario'
                sorteioUsuario()
            else if (opcao == '0')
                break
            else
                print color('r', "\nOpção Inválida!!")

        print '\n=================================='
        print '  OBRIGADO POR USAR NOSSO SISTEMA  '
        print '===================================\n'
    else if opcao == '2'
        print '\n================================='
        print '       ARQUIVOS DO USUÁRIO!        '
        print '=================================\n'

        arquivoUsuario = require './arquivosUsuario'
        arquivoUsuario()
    else if opcao == '0'
        print '\n=================================='
        print '  OBRIGADO POR USAR NOSSO SISTEMA  '
        print '===================================\n'
        break
    else
        print color('r', 'Opção inválida!!\n')



