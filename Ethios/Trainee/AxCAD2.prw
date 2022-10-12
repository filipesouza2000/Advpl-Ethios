#INCLUDE "TOTVS.CH"
#INCLUDE "Protheus.CH"
/*

    Exemplo de AxCadastro - Modelo 2 (Uma unica tabela)

    Este exemplo acessa tabela no banco de dados e dicionarios, por isso deve ser executado via SIGAMDI

*/

User Function AxCAD2()
Private nOpcx := 3

	//+-----------------------------------------------+
	//Â¦ Montando aHeader para a Getdados              Â¦
	//+-----------------------------------------------+

	// A tabela SX3 do Dicionario de Dados define de uma forma padronizada a estrutura de campos das tabelas disponiveis dentro do Ambiente Microsiga Protheus.

	// Toda modificao que se deseje fazer na estrutura de tabelas do Microsiga Protheus, no que se diz respeito a campos deverá ser feita nesta tabela. É importante salientar e reforçar o uso da ferramenta disponivel para manipulacao do SX3 dentro do Microsiga Protheus, chamado de Configurador, pois algumas modificacoes sao rao replicadas ao banco de dados caso efetuemos a alteracap via ferramenta.

	// O SX3 abre o um leque de infemeras possibilidades para a customizacoes das tabelas do sistema.

	dbSelectArea("Sx3")
/*
	O dbSelectArea() Define a area de trabalho especificada como ativa.
	Observacoes
	xArea pode ser do tipo numerico, indicando o numero da area de trabalho, ou do tipo caractere, indicando o alias de uma área de trabalho.
	Opcoes sele de uma area de trabalho, todas as operacoes subsequentes serao realizadas nesta area de trabalho, a menos que outra área seja informada ou que se utilize alias para se referenciar a outra area de trabalho.
	Se xArea contiver uma string com uma alias que nao foi aberto, o programa sera enncerrado com ocorreria de erro recuperável "Alias does not exist: AAA", onde AAA indica o alias informado.
	Se xArea contiver um numero menor ou igual a 0 (zero) ou for maior que o numero de areas de trabalho informado pela chave "MaxWorkAreas" da seção do ambiente no arquivo ini do AppServer, o programa sera encerrado com ocorroniia de erro recuperavel "Work area does not exist".
	Se for informado em xArea um numero de area de trabalho valido, mas nao aberto, ou uma string com um alias inexistente, ou o valor nulo (Nil), a área de trabalho atual será desativada.
	Cada area de trabalho corresponde as informacoes de um unico alias.
*/


	dbSetOrder(1)

/*
	O dbSetOrder() Seleciona a ordem ativa da area de trabalho.
	Esta ordem responsosavl sequencia logica dos registros da tabela corrente.
*/

	dbSeek("SX5")

/*
	O dbSeek() Localiza um registro com determinado valor da expressao de chave de indice.
*/
	nUsado:=0
	aHeader:={}
	While !Eof() .And. (x3_arquivo == "SX5")
	    IF X3USO(x3_usado) .AND. cNivel >= x3_nivel
		    nUsado:=nUsado+1
			AADD(aHeader,{ TRIM(x3_titulo),x3_campo,;
			             x3_picture,x3_tamanho,x3_decimal,;
						 "ExecBlock('Md2valid',.f.,.f.)",x3_usado,;
						 x3_tipo, x3_arquivo, x3_context } )
	    Endif
		/* O dbSkip() avanca para o proximo registro*/
		dbSkip()
	End
	//+-----------------------------------------------+
	//Â¦ Montando aCols para a GetDados                Â¦
	//+-----------------------------------------------+
	aCols:=Array(1,nUsado+1)
	dbSelectArea("Sx3")
	dbSeek("SX5")
	nUsado:=0
	While !Eof() .And. (x3_arquivo == "SX5")
	    IF X3USO(x3_usado) .AND. cNivel >= x3_nivel
		    nUsado:=nUsado+1
			IF nOpcx == 3
			    IF x3_tipo == "C"
				    aCOLS[1][nUsado] := SPACE(x3_tamanho)
				Elseif x3_tipo == "N"
				    aCOLS[1][nUsado] := 0
				Elseif x3_tipo == "D"
				    aCOLS[1][nUsado] := dDataBase
				Elseif x3_tipo == "M"
				    aCOLS[1][nUsado] := ""
				Else
				    aCOLS[1][nUsado] := .F.
	        	Endif
	    	Endif
	    Endif
		dbSkip()
	End
	aCOLS[1][nUsado+1] := .F.
	//+----------------------------------------------+
	//Â¦ Variaveis do Cabecalho do Modelo 2           Â¦
	//+----------------------------------------------+
	cCliente:=Space(6)
	cLoja   :=Space(2)
	dData   :=Date()
	//+----------------------------------------------+
	//Â¦ Variaveis do Rodape do Modelo 2
	//+----------------------------------------------+
	nLinGetD:=0
	//+----------------------------------------------+
	//Â¦ Titulo da Janela                             Â¦
	//+----------------------------------------------+
	cTitulo:="TESTE DE MODELO2"
	//+----------------------------------------------+
	//Â¦ Array com descricao dos campos do Cabecalho  Â¦
	//+----------------------------------------------+
	aC:={}
	#IFDEF WINDOWS 
		AADD(aC,{"cCliente" ,{15,10} ,"Cod. do Cliente","@!",'ExecBlock("MD2VLCLI",.F.,.F.)',"SA1",})
		AADD(aC,{"cLoja"    ,{15,200},"Loja","@!",,,})
		AADD(aC,{"dData"    ,{27,10} ,"Data de Emissao",,,,})
	#ELSE
		AADD(aC,{"cCliente" ,{6,5} ,"Cod. do Cliente","@!",'ExecBlock("MD2VLCLI",.F.,.F.)',"SA1",})
		AADD(aC,{"cLoja"    ,{6,40},"Loja","@!",,,})
		AADD(aC,{"dData"    ,{7,5} ,"Data de Emissao",,,,})
	#ENDIF
	//+-------------------------------------------------+
	//Â¦ Array com descricao dos campos do Rodape        Â¦
	//+-------------------------------------------------+
	aR:={}
	#IFDEF WINDOWS 
		AADD(aR,{"nLinGetD" ,{120,10},"Linha na GetDados", "@E 999",,,.F.})
	#ELSE
		AADD(aR,{"nLinGetD" ,{19,05},"Linha na GetDados","@E 999",,,.F.})
	#ENDIF
	//+------------------------------------------------+
	//Â¦ Array com coordenadas da GetDados no modelo2   Â¦
	//+------------------------------------------------+
	#IFDEF WINDOWS    
		aCGD:={44,5,118,315}
	#ELSE
	    aCGD:={10,04,15,73}
	#ENDIF
	//+----------------------------------------------+
	//Â¦ Validacoes na GetDados da Modelo 2           Â¦
	//+----------------------------------------------+
	cLinhaOk := "ExecBlock('Md2LinOk',.f.,.f.)"
	cTudoOk  := "ExecBlock('Md2TudOk',.f.,.f.)"
	//+----------------------------------------------+
	//Â¦ Chamada da Modelo2                           Â¦
	//+----------------------------------------------+
	// lRet = .t. se confirmou
	// lRet = .f. se cancelou
	//Funcao Modelo2 - Formulario para cadastro
	/*Descricao:
	  Exibe formulao para cadastro contendo: uma enchoice, uma getdados e uma area que pode ser utilizada para apresentar totalizadores ou outros dados mais reelevantes.
	  Programa Fonte:
	  MATXATU.PRW
	  Sintaxe:
	  Modelo2 - Formulario para cadastro ( cTitulo [ aC ] [ aR ] [ aGd ] [ nOp ] [ cLinhaOk ] [ cTudoOk ]aGetsD [ bF4 ] [ cIniCpos ] [ nMax ] [ aCordW ] [ lDelGetD ] [ lMaximazed ] [ aButtons ] )*/
lRet :=	Modelo2(cTitulo,aC,aR,aCGD,nOpcx,cLinhaOk,cTudoOk)

Return
