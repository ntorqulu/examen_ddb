ENTITY bdp_portes IS
END bdp_portes;

ARCHITECTURE test OF bdp_portes IS

COMPONENT la_porta_and2
	PORT(a, b:IN BIT; z:OUT BIT);
END COMPONENT;

COMPONENT la_porta_and3
	PORT(a, b, c:IN BIT; z:OUT BIT);
END COMPONENT;

COMPONENT la_porta_and4
	PORT(a, b, c, d:IN BIT; z: OUT BIT);
END COMPONENT;

COMPONENT la_porta_or2
	PORT(a, b:IN BIT; z:OUT BIT);
END COMPONENT;

COMPONENT la_porta_or3
	PORT(a, b, c:IN BIT; z:OUT BIT);
END COMPONENT;

COMPONENT la_porta_or4
	PORT(a, b, c, d:IN BIT; z: OUT BIT);
END COMPONENT;

COMPONENT la_porta_inv
	PORT(a:IN BIT; z:OUT BIT);
END COMPONENT;

COMPONENT la_porta_xor2
	PORT(a, b:IN BIT; z:OUT BIT);
END COMPONENT;

COMPONENT la_porta_xnor2
	PORT(a, b:IN BIT; z:OUT BIT);
END COMPONENT;

SIGNAL ent1, ent2, ent3, ent4, sort_and2_log, sort_and3_log,sort_and4_log, sort_or2_log, sort_or3_log, sort_or4_log, sort_inv_log, sort_xor2_log, sort_xnor2_log:BIT;
SIGNAL sort_and2_ret, sort_and3_ret,sort_and4_ret, sort_or2_ret, sort_or3_ret, sort_or4_ret, sort_inv_ret, sort_xor2_ret, sort_xnor2_ret:BIT;


for DUT1: la_porta_and2 USE ENTITY WORK.and2(logica);
for DUT2: la_porta_and3 USE ENTITY WORK.and3(logica);
for DUT3: la_porta_and4 USE ENTITY WORK.and4(logica);
for DUT4: la_porta_or2 USE ENTITY WORK.or2(logica);
for DUT5: la_porta_or3 USE ENTITY WORK.or3(logica);
for DUT6: la_porta_or4 USE ENTITY WORK.or4(logica);
for DUT7: la_porta_inv USE ENTITY WORK.inversor(logica);
for DUT8: la_porta_xor2 USE ENTITY WORK.xor2(logica);
for DUT9: la_porta_xnor2 USE ENTITY WORK.xnor2(logica);

for DUT10: la_porta_and2 USE ENTITY WORK.and2(logica_retard);
for DUT11: la_porta_and3 USE ENTITY WORK.and3(logica_retard);
for DUT12: la_porta_and4 USE ENTITY WORK.and4(logica_retard);
for DUT13: la_porta_or2 USE ENTITY WORK.or2(logica_retard);
for DUT14: la_porta_or3 USE ENTITY WORK.or3(logica_retard);
for DUT15: la_porta_or4 USE ENTITY WORK.or4(logica_retard);
for DUT16: la_porta_inv USE ENTITY WORK.inversor(logica_retard);
for DUT17: la_porta_xor2 USE ENTITY WORK.xor2(logica_retard);
for DUT18: la_porta_xnor2 USE ENTITY WORK.xnor2(logica_retard);

BEGIN
DUT1: la_porta_and2 PORT MAP(ent1, ent2, sort_and2_log);
DUT2: la_porta_and3 PORT MAP(ent1, ent2,ent3, sort_and3_log);
DUT3: la_porta_and4 PORT MAP(ent1, ent2,ent3, ent4, sort_and4_log);
DUT4: la_porta_or2 PORT MAP(ent1, ent2, sort_or2_log);
DUT5: la_porta_or3 PORT MAP(ent1, ent2,ent3, sort_or3_log);
DUT6: la_porta_or4 PORT MAP(ent1, ent2, ent3, ent4, sort_or4_log);
DUT7: la_porta_inv PORT MAP(ent1, sort_inv_log);
DUT8: la_porta_xor2 PORT MAP(ent1, ent2,sort_xor2_log);
DUT9: la_porta_xnor2 PORT MAP(ent1, ent2, sort_xnor2_log);

DUT10: la_porta_and2 PORT MAP(ent1, ent2, sort_and2_ret);
DUT11: la_porta_and3 PORT MAP(ent1, ent2,ent3, sort_and3_ret);
DUT12: la_porta_and4 PORT MAP(ent1, ent2,ent3, ent4, sort_and4_ret);
DUT13: la_porta_or2 PORT MAP(ent1, ent2, sort_or2_ret);
DUT14: la_porta_or3 PORT MAP(ent1, ent2,ent3, sort_or3_ret);
DUT15: la_porta_or4 PORT MAP(ent1, ent2, ent3, ent4, sort_or4_ret);
DUT16: la_porta_inv PORT MAP(ent1, sort_inv_ret);
DUT17: la_porta_xor2 PORT MAP(ent1, ent2,sort_xor2_ret);
DUT18: la_porta_xnor2 PORT MAP(ent1, ent2, sort_xnor2_ret);

PROCESS(ent1, ent2, ent3, ent4)
BEGIN
ent1<=NOT ent1 AFTER 50 ns;
ent2 <= NOT ent2 AFTER 100 ns;
ent3 <= NOT ent3 AFTER 200 ns;
ent4 <= NOT ent4 AFTER 400 ns;
END PROCESS;
END test;
   