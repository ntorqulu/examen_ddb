
--Comencem amb el biestable Latch D per flanc de PUJADA
ENTITY D_Latch_PreClr IS
	PORT(D, Clk, Pre, Clr: IN BIT; Q, NO_Q:OUT BIT);
END D_Latch_PreClr;

ARCHITECTURE ifthen OF D_Latch_PreClr IS
	SIGNAL qint: BIT;--senyal interna que assignarem a la sortida Q
BEGIN
PROCESS(D, Clk, Pre, Clr)
BEGIN
	IF Pre = '1' THEN qint <= '1' AFTER 2 ns;--aqui el preset i clear funcionen quan son 0(active-high)
	ELSE--fem que preset tingui prioritat
		IF Clr = '1' THEN qint<= '0' AFTER 2 ns;
		ELSE
			IF Clk = '1' THEN --es un latch, nomes s'activa quan rellotge es 1
				IF D = '1' THEN qint <='1' AFTER 6 ns;-- si el rellotge es 1, sortida pren el valor de D
				ELSE qint<='0' AFTER 6 ns;
				END IF;
			END IF;
		END IF;
	END IF;
END PROCESS;

Q <= qint;
NO_Q <= NOT qint;
END ifthen;--acabem arquitectura


-- Seguim amb el biestable FF JK per flanc de pujada
ENTITY JK_Pujada_PreClr IS
	PORT(J, K, Clk, Pre, Clr:IN BIT; Q,NO_Q:OUT BIT);
END JK_Pujada_PreClr;

ARCHITECTURE ifthen OF JK_Pujada_PreClr IS
	SIGNAL qint:BIT;
BEGIN
PROCESS(J, K, Clk, Pre, Clr)
BEGIN
	IF Pre = '1' THEN qint <= '1' AFTER 2 ns;
	ELSE
		IF Clr = '1' THEN qint <= '0' AFTER 2 ns;
		ELSE--si el rellotge te flanc de pujada(canvia de valor de 0 a 1) analitzem J i K
			IF Clk'EVENT AND Clk = '1' THEN -- llavors se segueix la taula d'excitacion de J i K
				IF J = '0' AND K = '0' THEN qint <= qint AFTER 6 ns;
				ELSIF J = '0' AND K = '1' THEN qint <='0' AFTER 6 ns;
				ELSIF J = '1' AND K = '0' THEN qint <='1' AFTER 6 ns;
				ELSIF J = '1' AND K = '1' THEN qint <=NOT qint AFTER 6 ns;--aquesta seria la diff amb FF RS
				END IF;
			END IF;
		END IF;
	END IF;
END PROCESS;
Q <= qint;
NO_Q <= NOT qint;
END ifthen;
