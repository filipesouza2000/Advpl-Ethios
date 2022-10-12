#INCLUDE 'Protheus.ch'

    /*/{Protheus.doc} fCalc
	Fun��o para resolver as 4 opera��es atitm�ticas,
	recebendo dois n�meros como par�metro
	@type  Function
	@author Filipe Souza
	@since 10/10/2021
    /*/
User Function fCalc()	
	
	Local nOp := Val(FWInputBox("Qual opera��o?"+Chr(13)+" 1-Soma"+Chr(13)+"2-Subtra��o"+Chr(13)+"3-Multiplica��o"+Chr(13)+"4-Diviz�o",""))

	Local n1 := Val(FWInputBox("N�mero1: ",""))
	Local n2 := Val(FWInputBox("N�mero2: ",""))
	//MsgInfo('Fun��es:' + Chr(13)+'Soma'+ Chr(13)+'Sub'+ Chr(13)+'Mult'+ Chr(13)+'Div','Opera��es')
	if nOp = 1 
	fSoma(n1,n2)
		elseif nOp = 2
		fSubt(n1,n2)
			elseif nOp = 3
			fMult(n1,n2)
				elseif nOp = 4
				fDiviz(n1,n2)
				else
					MsgAlert("Op��o inv�lida", "Alerta!")
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
	MsgAlert('subtra��o: '+cValTochar(nResultado), 'Subtra��o')
Return

Static Function fMult(n1,n2)
	Local nResultado
	nResultado := n1 * n2
	MsgAlert('Multiplica��o: '+cValTochar(nResultado), 'Multiplica��o')
Return

Static Function fDiviz(n1,n2)
	Local nResultado
	nResultado := n1 / n2
	MsgAlert('Diviz�o: '+cValTochar(nResultado), 'Diviz�o')
Return
