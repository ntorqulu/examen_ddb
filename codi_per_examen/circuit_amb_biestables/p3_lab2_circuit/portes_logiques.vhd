
--inversor
ENTITY inv IS
	PORT(a: IN BIT; z: OUT BIT);
END inv;

ARCHITECTURE logicaretard OF inv IS
BEGIN
	z <= NOT a AFTER 5 ns;
END logicaretard;


--and2
ENTITY and2 IS
	PORT(a, b: IN BIT; z: OUT BIT);
END and2;

ARCHITECTURE logicaretard OF and2 IS
BEGIN
	z <= a AND b AFTER 5 ns;
END logicaretard;

--inversor
ENTITY or2 IS
	PORT(a, b: IN BIT; z: OUT BIT);
END or2;

ARCHITECTURE logicaretard OF or2 IS
BEGIN
	z <= a OR b AFTER 5 ns;
END logicaretard;