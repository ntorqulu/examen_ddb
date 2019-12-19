--comencem def les entitats i estructures internes del circuit

--and de dues entrades
ENTITY and2 IS
	PORT(a, b: IN BIT; z: OUT BIT);
END and2;

ARCHITECTURE logicaretard OF and2 IS
BEGIN
	z <= a AND b AFTER 4 ns;
END logicaretard;


--xnor de dues entrades
ENTITY xnor2 IS
	PORT(a, b: IN BIT; z: OUT BIT);
END xnor2;

ARCHITECTURE logicaretard OF xnor2 IS
BEGIN
	z <= a XNOR b AFTER 4 ns;
END logicaretard;


--definim el biestrable flip-flop JK per flanc de pujada
ENTITY FF_JK_up IS
	PORT(J, K, Clk, Pre, Clr:IN BIT; Q,NO_Q:OUT BIT);
END FF_JK_up;

ARCHITECTURE ifthen OF FF_JK_up IS
	SIGNAL qint:BIT;
BEGIN
PROCESS(J, K, Clk, Pre, Clr)
BEGIN
	IF Pre = '1' THEN qint <= '1' AFTER 4 ns;
	ELSE
		IF Clr = '1' THEN qint <= '0' AFTER 4 ns;
		ELSE--si el rellotge te flanc de pujada(canvia de valor de 0 a 1) analitzem J i K
			IF Clk'EVENT AND Clk = '1' THEN -- llavors se segueix la taula d'excitacion de J i K
				IF J = '0' AND K = '0' THEN qint <= qint AFTER 4 ns;
				ELSIF J = '0' AND K = '1' THEN qint <='0' AFTER 4 ns;
				ELSIF J = '1' AND K = '0' THEN qint <='1' AFTER 4 ns;
				ELSIF J = '1' AND K = '1' THEN qint <=NOT qint AFTER 4 ns;--aquesta seria la diff amb FF RS
				END IF;
			END IF;
		END IF;
	END IF;
END PROCESS;
Q <= qint;
NO_Q <= NOT qint;
END ifthen;
----------------------final de les estructures internes


--definim llavors el circuit

ENTITY circuit IS
	PORT(x, clock:IN BIT; z2, z1, z0:OUT BIT);
END circuit;

ARCHITECTURE estructural OF circuit IS

COMPONENT comp_FF_JK_up IS
	PORT(J, K, Clk, Pre, Clr:IN BIT; Q, NO_Q:OUT BIT);
END COMPONENT;

COMPONENT porta_and2 IS
	PORT(a, b: IN BIT; z:OUT BIT);
END COMPONENT;

COMPONENT porta_xnor2 IS
	PORT(a, b: IN BIT; z:OUT BIT);
END COMPONENT;




-- associem els compoents a les seves definicions i arquitectures

FOR DUT1: porta_xnor2 USE ENTITY work.xnor2(logicaretard);
FOR DUT2: porta_xnor2 USE ENTITY work.xnor2(logicaretard);
FOR DUT3: porta_and2 USE ENTITY work.and2(logicaretard);
FOR DUT4: comp_FF_JK_up USE ENTITY work.FF_JK_up(ifthen);
FOR DUT5: comp_FF_JK_up USE ENTITY work.FF_JK_up(ifthen);
FOR DUT6: comp_FF_JK_up USE ENTITY work.FF_JK_up(ifthen);

-- senyals internes
SIGNAL j2, j1, j0, k2, k1, k0, exit_xnor, Pre, Clr, q0, q1, q2:BIT;

BEGIN
	j0 <= x;
	k0<= '1';
	DUT1: porta_xnor2 PORT MAP(q0, x, exit_xnor);
	DUT2: porta_xnor2 PORT MAP(q0, x, j1);
	DUT3: porta_and2 PORT MAP(q1, exit_xnor, j2);
	k2<=j2;
	k1<= j1;
	--podem ignorar les sortides negades perquè no ens les demanen
	DUT4: comp_FF_JK_up PORT MAP(j2, k2, clock, Pre, Clr, q2);
	DUT5: comp_FF_JK_up PORT MAP(j1, k1, clock, Pre, Clr, q1);
	DUT6: comp_FF_JK_up PORT MAP(j0, k0, clock, Pre, Clr, q0);
	z2 <= q2;
	z1<= q1;
	z0<=q0;
END estructural;

--Banc de proves del circuit, només mostra variables Ck i x
ENTITY bdp IS
END bdp;

ARCHITECTURE test OF bdp IS

COMPONENT comp_circuit IS
	PORT(x, clock:IN BIT; z2, z1, z0:OUT BIT);
END COMPONENT;

SIGNAL Ck, x, pre, clr, z0, z1, z2:BIT;
FOR DUT1: comp_circuit USE ENTITY work.circuit(estructural);

BEGIN
	DUT1: comp_circuit PORT MAP(x, Ck, z2, z1, z0);
PROCESS(x, Ck, pre, clr)
BEGIN
Ck <= NOT Ck AFTER 50 ns;
x <= NOT x AFTER 100 ns;
pre <= NOT pre AFTER 200 ns;
clr <= NOT clr AFTER 400 ns;
END PROCESS;--NOTA: A la practica se'ns demana explicitament que visualitzem totes les variables de la
--taula d'estats per comprovar el correcte funcionament. Simplement afegit mes waves per cada DUT podem veure aquestes variables
END test;
