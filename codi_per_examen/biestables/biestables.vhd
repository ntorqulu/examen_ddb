--definirem entitats i arquitectures ifthen de
--latch i flip-flop D
--latch i flip-flop JK
--latch i flip-flop T
--tant per flanc de baixada com de pujada
--les entrades asíncrones preset i clear son active-low,es a dir, 
--s'actives quan son 0.

---Comencem definint les entitats i arquitectures




-------------------------------------biestables D


---LATCH D per nivell alt, actiu quan el Clk esta a 1
ENTITY Latch_D_pujada IS
PORT(D,Clk,Pre,Clr: IN BIT; Q,NO_Q: OUT BIT);
END Latch_D_pujada;

ARCHITECTURE ifthen OF Latch_D_pujada IS
SIGNAL qint: BIT;

BEGIN

PROCESS(D,Clk,Pre,Clr)
--preset i clear implementats com active-low
BEGIN
IF Clr='0' THEN qint<='0' AFTER 2 ns;--donem prioritat al clear
	ELSIF Pre='0' THEN qint<='1' AFTER 2 ns;--si el clear no esta actiu, llavors ens fixem amb el preset
	ELSIF Clk='1' THEN qint <= D AFTER 2 ns;--actiu per nivell alt
	ELSE qint <= qint after 2 ns;

END IF;

END PROCESS;

Q<=qint; NO_Q<=NOT qint;

END ifthen;


---LATCH D per nivell baix, actiu quan el Clk esta a 0
ENTITY Latch_D_baixada IS
PORT(D,Clk,Pre,Clr: IN BIT; Q,NO_Q: OUT BIT);
END Latch_D_baixada;

ARCHITECTURE ifthen OF Latch_D_baixada IS
SIGNAL qint: BIT;

BEGIN

PROCESS(D,Clk,Pre,Clr)
--preset i clear implementats com active-low
BEGIN
IF Clr='0' THEN qint<='0' AFTER 2 ns;--donem prioritat al clear
	ELSIF Pre='0' THEN qint<='1' AFTER 2 ns;--si el clear no esta actiu, llavors ens fixem amb el preset
	ELSIF Clk='0' THEN qint <= D AFTER 2 ns;--actiu per nivell alt
	ELSE qint <= qint after 2 ns;

END IF;

END PROCESS;
Q<=qint; NO_Q<=NOT qint;

END ifthen;



---FF D actiu per flanc de pujada
ENTITY FF_D_pujada IS
PORT(D,Clk,Pre,Clr: IN BIT; Q,NO_Q: OUT BIT);
END FF_D_pujada;

ARCHITECTURE ifthen OF FF_D_pujada IS
SIGNAL qint: BIT;

BEGIN

PROCESS(D,Clk,Pre,Clr)
BEGIN
IF Clr='0' THEN qint<='0' AFTER 2 ns;

      ELSIF Pre='0' THEN qint<='1' AFTER 2 ns;

      ELSIF Clk'EVENT AND Clk='1' THEN
-- si clk ha patit un canvi de valor(flanc) i ara es troba a 0(flanc de pujada)
      qint <= D AFTER 2 ns;
END IF;
END PROCESS;
Q<=qint; NO_Q<=NOT qint;

END ifthen;

--Flip-Flop D implementat per flanc de baixada
ENTITY FF_D_baixada IS
PORT(D,Clk,Pre,Clr: IN BIT; Q,NO_Q: OUT BIT);
END FF_D_baixada;

ARCHITECTURE ifthen OF FF_D_baixada IS
SIGNAL qint: BIT;

BEGIN

PROCESS(D,Clk,Pre,Clr)
BEGIN
IF Clr='0' THEN qint<='0' AFTER 2 ns;

      ELSIF Pre='0' THEN qint<='1' AFTER 2 ns;

      ELSIF Clk'EVENT AND Clk='0' THEN
-- si clk ha patit un canvi de valor(flanc) i ara es troba a 0(flanc de pujada)
      qint <= D AFTER 2 ns;
END IF;
END PROCESS;
Q<=qint; NO_Q<=NOT qint;
END ifthen;


-------------------------------------------------------biestables JK


---LATCH JK
ENTITY Latch_JK_pujada IS
PORT(J,K,Clk,Pre,Clr: IN BIT; Q,NO_Q: OUT BIT);
END Latch_JK_pujada;

ARCHITECTURE ifthen OF Latch_JK_pujada IS
SIGNAL qint: BIT;
BEGIN
PROCESS (J,K,Clk,Pre,Clr,qint)
BEGIN
IF Clr='0' THEN qint<='0' AFTER 2 ns;
ELSE
	IF Pre='0' THEN qint<='1' AFTER 2 ns;
ELSE
		IF Clk='1' THEN
			IF J='0' AND K='0' THEN qint<=qint AFTER 2 ns;
			ELSIF J='0' AND K='1' THEN qint<='0' AFTER 2 ns;
			ELSIF J='1' AND K='0' THEN qint<='1' AFTER 2 ns;
			ELSIF J='1' AND K='1' THEN qint<= NOT qint AFTER 2 ns;
			END IF;

		END IF;
	END IF;
END IF;

END PROCESS;
Q<=qint; NO_Q<=NOT qint;
END ifthen;


--latch JK per flanc de baixada

ENTITY Latch_JK_baixada IS
PORT(J,K,Clk,Pre,Clr: IN BIT; Q,NO_Q: OUT BIT);
END Latch_JK_baixada;

ARCHITECTURE ifthen OF Latch_JK_baixada IS
SIGNAL qint: BIT;
BEGIN
PROCESS (J,K,Clk,Pre,Clr,qint)
BEGIN
IF Clr='0' THEN qint<='0' AFTER 2 ns;
ELSE
IF Pre='0' THEN qint<='1' AFTER 2 ns;
ELSE
		IF Clk='0' THEN
			IF J='0' AND K='0' THEN qint<=qint AFTER 2 ns;
			ELSIF J='0' AND K='1' THEN qint<='0' AFTER 2 ns;
			ELSIF J='1' AND K='0' THEN qint<='1' AFTER 2 ns;
			ELSIF J='1' AND K='1' THEN qint<= NOT qint AFTER 2 ns;
			END IF;

		END IF;
	END IF;
END IF;

END PROCESS;
Q<=qint; NO_Q<=NOT qint;
END ifthen;



---ENTITY FF_JK per flanc de pujada
ENTITY FF_JK_pujada IS
PORT(J,K,Clk,Pre,Clr: IN BIT; Q,NO_Q: OUT BIT);
END FF_JK_pujada;

ARCHITECTURE ifthen OF FF_JK_pujada IS
SIGNAL qint: BIT;
BEGIN
PROCESS (J,K,Clk,Pre,Clr,qint)
BEGIN
IF Clr='0' THEN qint<='0' AFTER 2 ns;
ELSE
IF Pre='0' THEN qint<='1' AFTER 2 ns;
ELSE
		IF Clk='1' AND Clk'EVENT THEN
			IF J='0' AND K='0' THEN qint<=qint AFTER 2 ns;
			ELSIF J='0' AND K='1' THEN qint<='0' AFTER 2 ns;
			ELSIF J='1' AND K='0' THEN qint<='1' AFTER 2 ns;
			ELSIF J='1' AND K='1' THEN qint<= NOT qint AFTER 2 ns;
			END IF;

		END IF;
	END IF;
END IF;

END PROCESS;
Q<=qint; NO_Q<=NOT qint;
END ifthen;


---ENTITY FF_JK per flanc de baixada
ENTITY FF_JK_baixada IS
PORT(J,K,Clk,Pre,Clr: IN BIT; Q,NO_Q: OUT BIT);
END FF_JK_baixada;

ARCHITECTURE ifthen OF FF_JK_baixada IS
SIGNAL qint: BIT;
BEGIN
PROCESS (J,K,Clk,Pre,Clr,qint)
BEGIN
IF Clr='0' THEN qint<='0' AFTER 2 ns;
ELSE
IF Pre='0' THEN qint<='1' AFTER 2 ns;
ELSE
		IF Clk='0' AND Clk'EVENT THEN
			IF J='0' AND K='0' THEN qint<=qint AFTER 2 ns;
			ELSIF J='0' AND K='1' THEN qint<='0' AFTER 2 ns;
			ELSIF J='1' AND K='0' THEN qint<='1' AFTER 2 ns;
			ELSIF J='1' AND K='1' THEN qint<= NOT qint AFTER 2 ns;
			END IF;

		END IF;
	END IF;
END IF;

END PROCESS;
Q<=qint; NO_Q<=NOT qint;
END ifthen;


---entity Latch_t pujada
ENTITY Latch_T_pujada IS
PORT(T,Clk,Pre,Clr: IN BIT; Q,NO_Q: OUT BIT);
END Latch_T_pujada;

ARCHITECTURE ifthen OF Latch_T_pujada IS
SIGNAL qint: BIT;
BEGIN
PROCESS (T,Clk,Pre,Clr,qint)
BEGIN
IF Clr='0' THEN qint<='0' AFTER 2 ns;
ELSE
IF Pre='0' THEN qint<='1' AFTER 2 ns;
ELSE
		IF Clk='1' THEN
			IF T='0' THEN qint<=qint AFTER 2 ns;
			ELSIF T='1' THEN qint<= NOT qint AFTER 2 ns;
			END IF;

		END IF;
	END IF;
END IF;

END PROCESS;
Q<=qint; NO_Q<=NOT qint;
END ifthen;


---entity Latch_t baixada
ENTITY Latch_T_baixada IS
PORT(T,Clk,Pre,Clr: IN BIT; Q,NO_Q: OUT BIT);
END Latch_T_baixada;

ARCHITECTURE ifthen OF Latch_T_baixada IS
SIGNAL qint: BIT;
BEGIN
PROCESS (T,Clk,Pre,Clr,qint)
BEGIN
IF Clr='0' THEN qint<='0' AFTER 2 ns;
ELSE
IF Pre='0' THEN qint<='1' AFTER 2 ns;
ELSE
		IF Clk='0' THEN
			IF T='0' THEN qint<=qint AFTER 2 ns;
			ELSIF T='1' THEN qint<= NOT qint AFTER 2 ns;
			END IF;

		END IF;
	END IF;
END IF;

END PROCESS;
Q<=qint; NO_Q<=NOT qint;
END ifthen;




---entity FF_T pujada
ENTITY FF_T_pujada IS
PORT(T,Clk,Pre,Clr: IN BIT; Q,NO_Q: OUT BIT);
END FF_T_pujada;

ARCHITECTURE ifthen OF FF_T_pujada IS
SIGNAL qint: BIT;
BEGIN
PROCESS (T,Clk,Pre,Clr,qint)
BEGIN
IF Clr='0' THEN qint<='0' AFTER 2 ns;
ELSE
IF Pre='0' THEN qint<='1' AFTER 2 ns;
ELSE
		IF Clk='1' AND Clk'EVENT THEN
			IF T='0' THEN qint<=qint AFTER 2 ns;
			ELSIF T='1' THEN qint<= NOT qint AFTER 2 ns;
			END IF;

		END IF;
	END IF;
END IF;

END PROCESS;
Q<=qint; NO_Q<=NOT qint;
END ifthen;


--ff t per flanc de baixada
ENTITY FF_T_baixada IS
PORT(T,Clk,Pre,Clr: IN BIT; Q,NO_Q: OUT BIT);
END FF_T_baixada;

ARCHITECTURE ifthen OF FF_T_baixada IS
SIGNAL qint: BIT;
BEGIN
PROCESS (T,Clk,Pre,Clr,qint)
BEGIN
IF Clr='0' THEN qint<='0' AFTER 2 ns;
ELSE
IF Pre='0' THEN qint<='1' AFTER 2 ns;
ELSE
		IF Clk='0' AND Clk'EVENT THEN
			IF T='0' THEN qint<=qint AFTER 2 ns;
			ELSIF T='1' THEN qint<= NOT qint AFTER 2 ns;
			END IF;

		END IF;
	END IF;
END IF;

END PROCESS;
Q<=qint; NO_Q<=NOT qint;
END ifthen;



-- Banc de Proves dambos
ENTITY banc_proves IS
END banc_proves;

ARCHITECTURE test OF banc_proves IS

COMPONENT comp_Latch_D IS
PORT(D,Clk,Pre,Clr: IN BIT; Q,NO_Q: OUT BIT);
END COMPONENT;

COMPONENT comp_FF_D IS
PORT(D,Clk,Pre,Clr: IN BIT; Q,NO_Q: OUT BIT);
END COMPONENT;

COMPONENT comp_Latch_JK IS
PORT(J,K,Clk,Pre,Clr: IN BIT; Q,NO_Q: OUT BIT);
END COMPONENT;

COMPONENT comp_FF_JK IS
PORT(J,K,Clk,Pre,Clr: IN BIT; Q,NO_Q: OUT BIT);
END COMPONENT;

COMPONENT comp_Latch_T IS
PORT(T,Clk,Pre,Clr: IN BIT; Q,NO_Q: OUT BIT);
END COMPONENT;

COMPONENT comp_FF_T IS
PORT(T,Clk,Pre,Clr: IN BIT; Q,NO_Q: OUT BIT);
END COMPONENT;



SIGNAL ent1,ent2,clock,preset,clear,latch_Dsort_Q,latch_Dsort_noQ,FF_Dsort_Q,FF_Dsort_noQ, latch_JKsort_Q,latch_JKsort_noQ,FF_JKsort_Q,FF_JKsort_noQ, latch_Tsort_Q,latch_Tsort_noQ,FF_Tsort_Q,FF_Tsort_noQ: BIT;
FOR DUT1: comp_Latch_D USE ENTITY WORK.Latch_D_pujada(ifthen);
FOR DUT2: comp_FF_D USE ENTITY WORK.FF_D_pujada(ifthen);
FOR DUT3: comp_Latch_JK USE ENTITY WORK.Latch_JK_pujada(ifthen);
FOR DUT4: comp_FF_JK USE ENTITY WORK.FF_JK_pujada(ifthen);
FOR DUT5: comp_Latch_T USE ENTITY WORK.Latch_T_pujada(ifthen);
FOR DUT6: comp_FF_T USE ENTITY WORK.FF_T_pujada(ifthen);

BEGIN
DUT1: comp_Latch_D PORT MAP (ent1,clock,preset,clear,latch_Dsort_Q,latch_Dsort_noQ);
DUT2: comp_FF_D PORT MAP (ent1,clock,preset,clear,FF_Dsort_Q,FF_Dsort_noQ);
DUT3: comp_Latch_JK PORT MAP (ent1, ent2,clock,preset,clear,latch_JKsort_Q,latch_JKsort_noQ);
DUT4: comp_FF_JK PORT MAP (ent1,ent2,clock,preset,clear,FF_JKsort_Q,FF_JKsort_noQ);
DUT5: comp_Latch_T PORT MAP (ent1,clock,preset,clear,latch_Tsort_Q,latch_Tsort_noQ);
DUT6: comp_FF_T PORT MAP (ent1,clock,preset,clear,FF_Tsort_Q,FF_Tsort_noQ);

ent1 <= NOT ent1 AFTER 800 ns;
ent2 <= NOT ent2 AFTER 400 ns;
clock <= NOT clock AFTER 500 ns;
preset <= '0', '1' AFTER 600 ns;
clear <= '1','0' AFTER 200 ns, '1' AFTER 400 ns;
-- simuleu fins a 15000 ns
END test;


