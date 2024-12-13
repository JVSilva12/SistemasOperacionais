require './stdlib'

sincronizarHd = -> 
    # Carregar dados de contas.yaml
    if file_exists 'arquivos/contas.yaml'
      contas = load_yaml 'arquivos/contas.yaml'
    else
      contas = []   
    # Carregar dados de hd.yaml
    if file_exists 'arquivos/hd.yaml'
      hd = load_yaml 'arquivos/hd.yaml'
    else
      hd = []   
    
    # Obter lista de usuários já no HD
    usuariosExistentes = hd.map (entrada) -> entrada?.usuario   
    
    # Sincronizar usuários
    for conta in contas
      unless conta.user in usuariosExistentes
        # Adicionar novo usuário com estrutura inicial
        hd.push(
          usuario: conta.user
          arquivo: [ { nome: null, tamanho: null } ]  # Inicializa um arquivo vazio para o usuário
          tamanho: 0
        )   
    
    # Salvar o arquivo atualizado
    save_yaml 'arquivos/hd.yaml', hd
    print color("g", "\nSincronização concluída com sucesso!")  
    
module.exports = sincronizarHd
