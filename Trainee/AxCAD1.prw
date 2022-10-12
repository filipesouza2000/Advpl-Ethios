#INCLUDE "TOTVS.CH"

/*

    Exemplo de AxCadastro - Modelo 1 (Uma unica tabela)

    Este exemplo acessa tabela no banco de dados e por isso deve ser executado via 
	SmartClient.

*/

User Function AxCAD1()

Local aRotAdic	:= {} 
Local bPre		:= {||MsgAlert('Chamada antes da funcao',   'TITULO')}
Local bOK		:= {||MsgAlert('Chamada ao clicar em OK',   'TITULO'), .T.}
Local bTTS		:= {||MsgAlert('Chamada durante transacao', 'TITULO')}
Local bNoTTS	:= {||MsgAlert('Chamada apos transacao',    'TITULO')}    

// Adiciona botoes na tela de inclusao, alteracao, visualizacao e exclusao
Local aButtons	:= {}

// Adiciona chamada no aRotina
aAdd(aButtons,{ "PRODUTO", {|| MsgAlert("Teste", 'TITULO')}, "Teste", "Botao Teste" }  )
aAdd(aRotAdic,{ "Adicional","U_Adic()", 0 , 6 })

AxCadastro("SA1", "Clientes", "U_DelOk()", "U_COK()", aRotAdic, bPre, bOK, bTTS, bNoTTS, , , aButtons, , )  

Return(.T.)                        

User Function DelOk()  
MsgAlert("Chamada antes do delete") 
Return 

User Function COK()    
MsgAlert("Clicou botao OK") 
Return .t.      

User Function Adic()   
MsgAlert("Rotina adicional") 
Return
