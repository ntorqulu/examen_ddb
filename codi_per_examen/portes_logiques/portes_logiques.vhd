--Tenim definides les seguents entitas amb les arquitectures
--logica i logica_retard
--and2, and3, and4
--nand2, nand3, nand4
--or2, or3, or4
--nor2, nor3, nor4
--inv
--xor2 i xnor2


--------------------------------porta and2
ENTITY and2 IS
	PORT(a, b:IN BIT; z:OUT BIT);
END and2;

ARCHITECTURE logica OF and2 IS
	BEGIN
	z <= a AND b;
END logica;

ARCHITECTURE logica_retard OF and2 IS
	BEGIN
	z <= a AND b AFTER 3 ns;
END logica_retard;


--------------------------------porta and3
ENTITY and3 IS
	PORT(a, b, c:IN BIT; z:OUT BIT);
END and3;

ARCHITECTURE logica OF and3 IS
	BEGIN
	z <= a AND b AND c;
END logica;

ARCHITECTURE logica_retard OF and3 IS
	BEGIN
	z <= a AND b AND c AFTER 3 ns;
END logica_retard;


--------------------------------porta and4
ENTITY and4 IS
	PORT(a, b, c, d:IN BIT; z:OUT BIT);
END and4;

ARCHITECTURE logica OF and4 IS
	BEGIN
	z <= a AND b AND c AND d;
END logica;


ARCHITECTURE logica_retard OF and4 IS
	BEGIN
	z <= a AND b AND c AND d AFTER 3 ns;
END logica_retard;


----------------------------------------porta or2
ENTITY or2 IS
	PORT(a, b:IN BIT; z:OUT BIT);
END or2;


ARCHITECTURE logica OF or2 IS
	BEGIN
	z <= a OR b;
END logica;


ARCHITECTURE logica_retard OF or2 IS
	BEGIN
	z <= a OR b AFTER 3 ns;
END logica_retard;


---------------------------------------porta or3
ENTITY or3 IS
	PORT(a, b, c:IN BIT; z:OUT BIT);
END or3;

ARCHITECTURE logica OF or3 IS
	BEGIN
	z <= a OR b OR c;
END logica;

ARCHITECTURE logica_retard OF or3 IS
	BEGIN
	z <= a OR b OR c AFTER 3 ns;
END logica_retard;


--------------------------porta or4
ENTITY or4 IS
	PORT(a, b, c, d:IN BIT; z:OUT BIT);
END or4;

ARCHITECTURE logica OF or4 IS
	BEGIN
	z <= a OR b OR c OR d;
END logica;

ARCHITECTURE logica_retard OF or4 IS
	BEGIN
	z <= a OR b OR c OR d AFTER 3 ns;
END logica_retard;


---------------------------------porta inversor
ENTITY inversor IS
	PORT(a:IN BIT; z:OUT BIT);
END inversor;

ARCHITECTURE logica OF inversor IS
	BEGIN
	z <= NOT a;
END logica;

ARCHITECTURE logica_retard OF inversor IS
	BEGIN
	z <= NOT a AFTER 3 ns;
END logica_retard;


---------------------------------porta xor2
ENTITY xor2 IS
	PORT(a, b:IN BIT; z:OUT BIT);
END xor2;

ARCHITECTURE logica OF xor2 IS
	BEGIN
	z <= a XOR b;
END logica;

ARCHITECTURE logica_retard OF xor2 IS
	BEGIN
	z <= a XOR b AFTER 3 ns;
END logica_retard;


---------------------------------porta xnor2
ENTITY xnor2 IS
	PORT(a, b:IN BIT; z:OUT BIT);
END xnor2;

ARCHITECTURE logica OF xnor2 IS
	BEGIN
	z <= a XNOR b;
END logica;

ARCHITECTURE logica_retard OF xnor2 IS
	BEGIN
	z <= a XNOR b AFTER 3 ns;
END logica_retard;












