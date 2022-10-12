#INCLUDE "TOTVS.CH"
/*

    Exemplo de AxCadastro - Modelo 3 (Duas ou mais tabelas)

    Mostrado a partir da Inclusão

    Este exemplo acessa tabela no banco de dados e dicionarios, por isso deve ser executado via SIGAMDI

*/

User Function AxCAD3X()
Local _ni

Private cCadastro	:= "Pedidos de Venda"
Private cAlias1		:= "SC5"
Private cAlias2		:= "SC6"

aRotina := {{ "Pesquisa","AxPesqui",	0 , 1}		,;	      	
			{ "Visual"	,"AxVisual", 	0 , 2}		,;    	  	
			{ "Inclui"	,"U_AxInclui", 	0 , 3}		,;      		
			{ "Altera"	,"AxAltera", 	0 , 4, 20 }	,;
		    { "Exclui"	,"AxDeleta", 	0 , 5, 21 }}

mBrowse( 6,1,22,75, cAlias1,,,,,,)                    

Return

User Function AXINCLUI
//+--------------------------------------------------------------+
//| Opcoes de acesso para a Modelo 3                             |
//+--------------------------------------------------------------+
cOpcao:="INCLUIR"
Do Case	
	Case cOpcao=="INCLUIR" 
		nOpcE:=3  
		nOpcG:=3	
	Case cOpcao=="ALTERAR" 
		nOpcE:=3  
		nOpcG:=3	
	Case cOpcao=="VISUALIZAR" 
		nOpcE:=2  
		nOpcG:=2
EndCase
DbSelectArea(cAlias1)
DbSetOrder(1)
DbGotop()
//+--------------------------------------------------------------+
//| Cria variaveis M->????? da Enchoice                          |
//+--------------------------------------------------------------+
RegToMemory(cAlias1,(cOpcao=="INCLUIR"))
//+--------------------------------------------------------------+
//| Cria aHeader e aCols da GetDados                             |
//+--------------------------------------------------------------+
nUsado:=0
dbSelectArea("SX3")
DbSetOrder(1)
DbSeek(cAlias2)
aHeader:={}
While !Eof().And.(x3_arquivo== cAlias2)	
	If Alltrim(x3_campo)=="C6_ITEM"		
		dbSkip()		
		Loop	
	Endif	
	If X3USO(x3_usado).And.cNivel>=x3_nivel    	
		nUsado:=nUsado+1        
		Aadd(aHeader,{	TRIM(x3_titulo),;
						x3_campo, 		;
						x3_picture,		;
						x3_tamanho, 	;
						x3_decimal,		;
						"AllwaysTrue()",;    	     
						x3_usado,		;
						x3_tipo,		;
						x3_arquivo,		;
						x3_context } )	
	Endif    
	dbSkip()
Enddo
If cOpcao=="INCLUIR"	
	aCols:={Array(nUsado+1)}	
	aCols[1,nUsado+1]:=.F.	
	For _ni:=1 to nUsado		
		aCols[1,_ni]:=CriaVar(aHeader[_ni,2])	
	Next
Else	
	aCols:={}	
	dbSelectArea(cAlias2)	
	dbSetOrder(1)	
	dbSeek(xFilial()+M->C5_NUM)	
	While !eof().and. (cAlias2)->C6_NUM == M->C5_NUM		
		AADD(aCols,Array(nUsado+1))		
		For _ni:=1 to nUsado			
			aCols[Len(aCols),_ni]:=FieldGet(FieldPos(aHeader[_ni,2]))		
		Next 		
		aCols[Len(aCols),nUsado+1]:=.F.		
		dbSkip()	
	Enddo
Endif
If Len(aCols) > 0
//+--------------------------------------------------------------+	
//| Executa a Modelo 3                                           |	
//+--------------------------------------------------------------+	
	cTitulo			:= "Teste de Modelo3()"	
	cAliasEnchoice	:= cAlias1	
	cAliasGetD		:= cAlias2
	cLinOk			:= "AllwaysTrue()"	
	cTudOk			:= "AllwaysTrue()"	
	cFieldOk		:= "AllwaysTrue()"
	//	aCpoEnchoice:={} 
	//{"C5_CLIENTE"}	

	_lRet:=Modelo3(cTitulo,cAliasEnchoice,cAliasGetD,,cLinOk,cTudOk,nOpcE,nOpcG,cFieldOk)	

//+--------------------------------------------------------------+	
//| Executar processamento                                       |	
//+--------------------------------------------------------------+	
	If _lRet		
		Aviso("Modelo3()","Confirmada operacao!",{"Ok"})	
	Endif
Endif                 
Return

