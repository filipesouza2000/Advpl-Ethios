#INCLUDE 'Protheus.ch'

    /*/{Protheus.doc} fCalc
	Função para resolver as 4 operações atitméticas,
	recebendo dois números como parâmetro
	@type  Function
	@author Filipe Souza
	@since 10/10/2021
    /*/
User Function fCalc()	
	
	Local nOp := Val(FWInputBox("Qual operação?"+Chr(13)+" 1-Soma"+Chr(13)+"2-Subtração"+Chr(13)+"3-Multiplicação"+Chr(13)+"4-Divizão",""))

	Local n1 := Val(FWInputBox("Número1: ",""))
	Local n2 := Val(FWInputBox("Número2: ",""))
	//MsgInfo('Funções:' + Chr(13)+'Soma'+ Chr(13)+'Sub'+ Chr(13)+'Mult'+ Chr(13)+'Div','Operações')
	if nOp = 1 
	fSoma(n1,n2)
		elseif nOp = 2
		fSubt(n1,n2)
			elseif nOp = 3
			fMult(n1,n2)
				elseif nOp = 4
				fDiviz(n1,n2)
				else
					MsgAlert("Opção inválida", "Alerta!")
	endif

Return


Static Function fSoma(n1,n2)
	Local nResultado
	nResultado := n1 + n2
	MsgAlert('Soma: '+cValTochar(nResultado), 'Soma')
return

Static Function fSubt(n1,n2)
	Local nResultado
	nResultado := n1 - n2
	MsgAlert('subtração: '+cValTochar(nResultado), 'Subtração')
Return

Static Function fMult(n1,n2)
	Local nResultado
	nResultado := n1 * n2
	MsgAlert('Multiplicação: '+cValTochar(nResultado), 'Multiplicação')
Return

Static Function fDiviz(n1,n2)
	Local nResultado
	nResultado := n1 / n2
	MsgAlert('Divizão: '+cValTochar(nResultado), 'Divizão')
Return
