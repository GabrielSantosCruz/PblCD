module ErroCaixa(Low, Mid, High, Temp, Usolo, Uar, ErroMedida, Aspersor, Gotejamento, VEntrada, Alarme);

input Low, Mid, High, Temp, Usolo, Uar;
output ErroMedida, Aspersor, Gotejamento, VEntrada, Alarme;
	
	// Sistema de erro
	//=================================================
	wire Low_inv, Mid_inv, NotAB, NotBC;
	
	// Inversao:
	not UI1(Low_inv, Low);
	not UI2(Mid_inv, Mid);
	
	// Portas AND:
	and UI3(NotAB, Low_inv, Mid);
	and UI4(NotBC, Mid_inv, High);
	or ErroNivel(ErroMedida, NotBC, NotAB);
	// SAIDA: LED 9
	//=================================================
	
	// Sistema de Aspersao
	//=================================================
	wire Erro_inv;
	
	not UI6(Erro_inv, ErroMedida);
	
	and UI8(Aspersao, Usolo, Uar);
	and UI10(Aspersor, Aspersao, Erro_inv);
	// SAIDA: LED  7
	//=================================================
	
	// Alarme
	//=================================================
		// Como ja tem o erro de nivel, caso o sensor Low esteja desativado, significa que a caixa ta no nivel critico
	or UI12(Alarme, Low_inv, ErroMedida);
	// SAIDA: LED RGB
	//=================================================
	
endmodule 