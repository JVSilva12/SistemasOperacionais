# QUESTÃO 7 DA LISTA 1 DE SO

require './stdlib'

# Carrega os dados presentes no arquivo .yaml
if file_exists 'arquivos/lang.yaml'
    lang = load_yaml 'arquivos/lang.yaml'
else 
    lang = []

# Mostrando os idiomas disponíveis
size = len(lang)

print color("g", "\nIdiomas cadastrados:")

for i in [0...size]
    print "#{i+1}. #{lang[i].idioma}"

process.stdout.write color('w', "\nDigite o Idioma de sua preferência: ")
idioma = input()

find_idioma = false

# Procura e mostra a mensagem no idioma digitado 
for i in [0...size]
    if lang[i].idioma == idioma
        print color('g', "\n#{lang[i].saudacao}")
        find_idioma = true

if !find_idioma # Não achou o idioma digitado
    print color('w', "\nIdioma não encontrado")
    process.stdout.write color('w', "\nDeseja adicionar um novo idioma [sim/nao]? ")
    opcao = input()
    if opcao == "sim" or opcao == "Sim" or opcao == "SIM" # Adiciona um novo idioma e saudação
        process.stdout.write color('w', "Digite o idioma que deseja cadastrar: ")
        idioma = input()
        process.stdout.write color('w', "Digite a saudação:")
        saudacao = input()
        lang.push(idioma:idioma, saudacao:saudacao)
        save_yaml 'arquivos/lang.yaml', lang
    
print color('w', "\nFim do programa")

 