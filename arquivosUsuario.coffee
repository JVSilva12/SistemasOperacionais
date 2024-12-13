require './stdlib'

calcularEspacoUsado = -> 
    # Carregar dados do arquivo hd.yaml
    if file_exists 'arquivos/hd.yaml'
      arquivos = load_yaml 'arquivos/hd.yaml'
    else
      arquivos = [] 

    print '\n================================='
    print ' CÁLCULO DE ESPAÇO USADO POR USUÁRIO '
    print '=================================\n' 

    process.stdout.write "Digite o nome do usuário: "
    usuario = input().trim()    

    # Encontrar o usuário no arquivo
    entradaUsuario = arquivos.find (entrada) -> entrada?.usuario == usuario

    if not entradaUsuario
      print color("r", "\nUsuário '#{usuario}' não encontrado.")
      return

    # Filtrar os arquivos do usuário
    arquivosDoUsuario = entradaUsuario.arquivo.filter (arq) -> arq?.nome? and arq?.tamanho?
    if arquivosDoUsuario.length == 0
        print color("r", "\nNenhum arquivo encontrado para o usuário '#{usuario}'.")

    # Mostrar os arquivos do usuário
    print "\nArquivos do usuário '#{usuario}':"
    espacoTotal = 0
    
    for arq in arquivosDoUsuario
        print " - #{arq.nome} (#{arq.tamanho} MB)"
        espacoTotal += arq.tamanho

        arquivosDoUsuario.tamanho = espacoTotal
        maiorArquivo = arquivosDoUsuario.reduce((maior, atual) ->
            if atual.tamanho > maior.tamanho then atual else maior
        )
        print "Maior arquivo: #{maiorArquivo.nome} (#{maiorArquivo.tamanho} MB)"
        print color("g", "\nEspaço total ocupado: #{espacoTotal} MB")
 
    
    #Adicionar novos arquivos
    while true
        process.stdout.write "Inserir novo arquivo s/N? "
        opcao = input().toLowerCase()   

        if opcao == 's' or opcao == 'sim'
            process.stdout.write "Informe nome do arquivo com extensão (arquivo.txt): "
            novoArquivo = input()
            process.stdout.write "Informe tamanho do arquivo: "
            tamanhoNovoArquivo = parseInt(input())
            if isNaN(tamanhoNovoArquivo) or tamanhoNovoArquivo <= 0
              print color("r", "Tamanho inválido! Tente novamente.")
              continue 

            #Encontrar o índice do usário em `arquivo`
            indiceUsuario = arquivos.findIndex (entrada) -> entrada?.usuario == usuario
            if indiceUsuario >= 0
                #Atualizar os dados do usuário com o novo arquivo
                arquivos[indiceUsuario].arquivo ?= [] #Certifica que `arquivo` em uma lista
                arquivos[indiceUsuario].arquivo.push
                    nome: novoArquivo
                    tamanho: tamanhoNovoArquivo
                
                #Filtrar os arquivos do usuário
                arquivosDoUsuario = arquivos.filter (entrada) -> entrada?.usuario == usuario
                # Salvar mudanças no arquivo hd.yaml
                save_yaml 'arquivos/hd.yaml', arquivos
                print color("g", "\nArquivo '#{novoArquivo}' de #{tamanhoNovoArquivo} MB adicionado com sucesso!")

        else
            break    
    
    print '\n================================='
    print '           FIM DO PROGRAMA         '
    print '=================================\n'

module.exports = calcularEspacoUsado
