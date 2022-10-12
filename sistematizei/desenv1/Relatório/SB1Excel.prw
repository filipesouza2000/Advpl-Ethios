#INCLUDE 'Protheus.ch'
#INCLUDE 'TopConn.ch'
 // Formação Desenvolvedor Protheus
 // Módulo 7- Aula 2- Exportando um comando SQL para o Excel
 //DLGToExcel descontinuada, atual é FWMsExcelEx()

User Function SB1Excel()
//PREPARE ENVIRONMENT EMPRESA "99" FILIAL "01"
RpcSetEnv("99","01",,,"COM")

Local cFile    := GetTempPath()+'sb1.xml'
Local cQuery := ""//variável que armazenará sql query
Local oExcel := FWMsExcelEx():New()
oExcel:addWorkSheet("planilhaP")
oExcel:addTable("planilhaP","TabPro")
oExcel:addColumn("planilhaP","TabPro","FILIAL",2,1,.F.)
oExcel:addColumn("planilhaP","TabPro","CODIGO",2,1,.F.)
oExcel:addColumn("planilhaP","TabPro","DESCRICAO",2,1,.F.)
oExcel:addColumn("planilhaP","TabPro","TIPO",2,1,.F.)

cQuery := "SELECT B1_FILIAL, B1_COD, B1_DESC, B1_TIPO "
cQuery += " FROM "+RetSqlName("SB1")+" as SB1"
cQuery += " WHERE D_E_L_E_T_ = ''"

TCQUERY cQuery new Alias "SB1" // existe outra forma mais segura de executar
if SELECT ("SB1") >0 //verifica se o alias já está aberto por outra sessão
    SB1->(DBCLOSEAREA())    
endif

while !SB1->(EOF())
    oExcel:addRow("planilhaP","TabPro",{SB1->B1_FILIAL, SB1->B1_COD, SB1->B1_DESC, SB1->B1_TIPO})
    SB1->(DBSKIP())
ENDDO
SB1->(DBCLOSEAREA())    
    oExcel:ACTIVATE()
    oExcel:GetXMLFile(cFile)

  //Abrindo o excel e abrindo o arquivo xml
    oExcel := MsExcel():New()       //Abre uma nova conexão com Excel
    oExcel:WorkBooks:Open(cFile)    //Abre uma planilha
    oExcel:SetVisible(.T.)          //Visualiza a planilha
    oExcel:Destroy()                //Encerra o processo do gerenciador de tarefas
Return

