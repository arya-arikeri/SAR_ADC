.subckt sar_fsm_4bit clk rst start comp_out eoc sar_out.3 sar_out.2 sar_out.1 sar_out.0 sample_enable

* -- Stabilized Dictionary (RC-Delay + Ground Path) --
.subckt __NOT_ Y A
B1 Y_id 0 V=IF(V(A)<1.6, 3.3, 0)
R1 Y_id Y 100
C1 Y 0 10p ic=0
.ends

.subckt __NAND_ Y A B
B1 Y_id 0 V=IF((V(A)>1.6) & (V(B)>1.6), 0, 3.3)
R1 Y_id Y 100
C1 Y 0 10p ic=0
.ends

.subckt __NOR_ Y A B
B1 Y_id 0 V=IF((V(A)>1.6) | (V(B)>1.6), 0, 3.3)
R1 Y_id Y 100
C1 Y 0 10p ic=0
.ends

* ======================================================================
* ======================================================================
* ======================================================================
* --- TRUE MASTER-SLAVE EDGE-TRIGGERED FLIP-FLOPS ---

.subckt __DFF_PP0_ Q D R C
B1 QM_id 0 V=IF(V(R)>1.6, 0, IF(V(C)<1.6, V(D), V(QM)))
R1 QM_id QM 100
C1 QM 0 10p ic=0
B2 Q_id 0 V=IF(V(R)>1.6, 0, IF(V(C)>1.6, V(QM), V(Q_delay)))
R2 Q_id Q_delay 100
C2 Q_delay 0 10p ic=0
B3 Q 0 V=V(Q_delay)
.ends

.subckt __DFF_PP1_ Q D R C
B1 QM_id 0 V=IF(V(R)>1.6, 3.3, IF(V(C)<1.6, V(D), V(QM)))
R1 QM_id QM 100
C1 QM 0 10p ic=3.3
B2 Q_id 0 V=IF(V(R)>1.6, 3.3, IF(V(C)>1.6, V(QM), V(Q_delay)))
R2 Q_id Q_delay 100
C2 Q_delay 0 10p ic=3.3
B3 Q 0 V=V(Q_delay)
.ends

.subckt __DFFE_PP0N_ Q D EN R C
B_Deff Deff 0 V=IF(V(EN)<1.6, V(D), V(Q_delay))
B1 QM_id 0 V=IF(V(R)>1.6, 0, IF(V(C)<1.6, V(Deff), V(QM)))
R1 QM_id QM 100
C1 QM 0 10p ic=0
B2 Q_id 0 V=IF(V(R)>1.6, 0, IF(V(C)>1.6, V(QM), V(Q_delay)))
R2 Q_id Q_delay 100
C2 Q_delay 0 10p ic=0
B3 Q 0 V=V(Q_delay)
.ends

.subckt __DFFE_PP0P_ Q D EN R C
B_Deff Deff 0 V=IF(V(EN)>1.6, V(D), V(Q_delay))
B1 QM_id 0 V=IF(V(R)>1.6, 0, IF(V(C)<1.6, V(Deff), V(QM)))
R1 QM_id QM 100
C1 QM 0 10p ic=0
B2 Q_id 0 V=IF(V(R)>1.6, 0, IF(V(C)>1.6, V(QM), V(Q_delay)))
R2 Q_id Q_delay 100
C2 Q_delay 0 10p ic=0
B3 Q 0 V=V(Q_delay)
.ends

.subckt __DFFE_PP1P_ Q D EN R C
B_Deff Deff 0 V=IF(V(EN)>1.6, V(D), V(Q_delay))
B1 QM_id 0 V=IF(V(R)>1.6, 3.3, IF(V(C)<1.6, V(Deff), V(QM)))
R1 QM_id QM 100
C1 QM 0 10p ic=3.3
B2 Q_id 0 V=IF(V(R)>1.6, 3.3, IF(V(C)>1.6, V(QM), V(Q_delay)))
R2 Q_id Q_delay 100
C2 Q_delay 0 10p ic=3.3
B3 Q 0 V=V(Q_delay)
.ends

* -- Netlist --
X0 1 bit_idx.0 __NOT_
X1 2 bit_idx.1 __NOT_
X2 3 state.1 __NOT_
X3 4 bit_idx.2 __NOT_
X4 5 comp_out __NOT_
X5 6 state.2 __NOT_
X6 7 sar_out.1 __NOT_
X7 8 start __NOT_
X8 9 state.0 __NOT_
X9 10 bit_idx.1 bit_idx.0 __NOR_
X10 11 bit_idx.1 bit_idx.0 __NAND_
X11 12 11 state.1 __NAND_
X12 13 12 10 __NOR_
X13 14 13 __NOT_
X14 15 state.1 bit_idx.0 __NAND_
X15 16 bit_idx.2 2 __NOR_
X16 17 16 1 __NAND_
X17 18 17 comp_out __NOR_
X18 19 16 sar_out.2 __NOR_
X19 20 18 state.2 __NOR_
X20 21 20 __NOT_
X21 22 21 19 __NOR_
X22 23 bit_idx.2 1 __NOR_
X23 24 4 bit_idx.0 __NAND_
X24 25 24 bit_idx.1 __NOR_
X25 26 25 __NOT_
X26 27 25 7 __NOR_
X27 28 25 comp_out __NAND_
X28 29 28 17 __NAND_
X29 30 29 27 __NOR_
X30 31 30 state.2 __NOR_
X31 32 10 4 __NAND_
X32 33 32 sar_out.0 __NAND_
X33 34 33 26 __NAND_
X34 35 32 5 __NOR_
X35 36 35 34 __NOR_
X36 37 32 state.2 __NOR_
X37 38 36 state.2 __NOR_
X38 39 state.0 start __NAND_
X39 40 39 __NOT_
X40 41 state.2 state.1 __NOR_
X41 42 41 37 __NOR_
X42 43 state.3 state.0 __NOR_
X43 44 43 __NOT_
X44 45 state.3 8 __NOR_
X45 46 45 43 __NOR_
X46 47 10 bit_idx.2 __NAND_
X47 48 47 __NOT_
X48 49 10 bit_idx.2 __NOR_
X49 50 49 __NOT_
X50 51 50 state.1 __NAND_
X51 52 51 48 __NOR_
X52 53 32 3 __NOR_
X53 54 53 41 __NOR_
X54 55 41 9 __NAND_
X55 56 23 bit_idx.1 __NAND_
X56 57 56 sar_out.3 __NAND_
X57 58 47 6 __NAND_
X58 59 56 5 __NOR_
X59 60 59 58 __NOR_
X60 61 60 57 __NAND_
X61 sar_out.0 38 44 rst clk __DFFE_PP0N_
X62 state.3 53 rst clk __DFF_PP0_
X63 bit_idx.1 14 54 rst clk __DFFE_PP1P_
X64 bit_idx.0 15 54 rst clk __DFFE_PP1P_
X65 eoc state.3 44 rst clk __DFFE_PP0P_
X66 state.2 40 rst clk __DFF_PP0_
X67 bit_idx.2 52 54 rst clk __DFFE_PP0P_
X68 state.1 42 rst clk __DFF_PP0_
X69 sar_out.3 61 44 rst clk __DFFE_PP0N_
X70 state.0 46 rst clk __DFF_PP1_
X71 sample_enable state.2 55 rst clk __DFFE_PP0P_
X72 sar_out.2 22 44 rst clk __DFFE_PP0N_
X73 sar_out.1 31 44 rst clk __DFFE_PP0N_
V0 bit_idx.0 62 DC 0
V1 bit_idx.1 63 DC 0
V2 state.1 64 DC 0
V3 14 65.1 DC 0
V4 15 65.0 DC 0
V5 bit_idx.2 66 DC 0
V6 comp_out 67 DC 0
V7 sar_out.2 68 DC 0
V8 state.2 69 DC 0
V9 22 70.2 DC 0
V10 sar_out.1 71 DC 0
V11 31 70.1 DC 0
V12 sar_out.0 72 DC 0
V13 38 70.0 DC 0
V14 start 73 DC 0
V15 state.0 74 DC 0
V16 40 75 DC 0
V17 42 76 DC 0
V18 state.3 77 DC 0
V19 44 78 DC 0
V20 46 79 DC 0
V21 52 65.2 DC 0
V22 53 80 DC 0
V23 54 81 DC 0
V24 55 82 DC 0
V25 sar_out.3 83 DC 0
V26 61 70.3 DC 0
.ends
