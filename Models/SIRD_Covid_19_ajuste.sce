// SIRD model applied to Covid-19
// Reference: Fanelli and Piazza 2020
// https://www.researchgate.net/publication/339887331

clear; clc;

M = [1	1	0	0	;
2	1	0	0	;
3	1	0	0	;
4	1	0	0	;
5	2	0	0	;
6	2	0	0	;
7	2	0	0	;
8	2	0	0	;
9	3	0	0	;
10	8	0	0	;
11	12	1	0	;
12	12	1	0	;
13	24	1	0	;
14	24	1	0	;
15	32	2	0	;
16	50	2	0	;
17	75	2	0	;
18	96	2	0	;
19	118	3	0	;
20	192	8	0	;
21	221	13	0	;
22	278	12	1	;
23	403	21	4	;
24	596	19	6	;
25	870	23	11	;
26	1076	34	18	;
27	1469	52	25	;
28	1793	64	34	;
29	2080	75	46	;
30	2233	143	57	;
31	2681	157	77	;
32	3126	199	92	;
33	2487	314	114	;
34	2796	485	136	;
35	3675	745	159	;
36	4589	927	201	;
37	5290	1305	241	;
38	6019	1592	299	;
39	6855	1842	359	;
40	8697	2001	432	;
41	9141	2429	486	;
42	10300	2864	553	;
43	13012	2248	667	;
44	14440	2617	800	;
45	15059	3638	941	;
46	15010	4661	1056	;
47	15333	5712	1124	;
48	15520	6687	1223	;
49	16206	7728	1328	;
50	17190	9598	1532	;
51	18369	10320	1736	;
52	19965	11793	1924	;
53	20672	13786	2141	;
54	20797	15510	2347	;
55	20943	17176	2462	;
56	22352	18152	2575	;
57	23588	19428	2741	;
58	26062	20524	2906	;
59	27733	21949	3313	;
60	30189	24650	3670	;
61	31463	26409	4016	;
62	32819	29477	4205	;
63	35287	32056	4543	;
64	39508	33637	5017	;
65	44799	35115	5466	;
66	48510	37178	5901	;
67	50802	39428	6329	;
68	51655	42742	6750	;
69	54785	45970	7025	;
70	56206	51188	7321	;
71	63330	53967	7921	;
72	68605	57965	8536	;
73	73442	62740	9146	;
74	77777	68265	9897	;
75	77319	74753	10627	;
76	76742	80466	11123	;
77	81030	85040	11519	;
78	87827	88747	12400	;
79	95138	94631	13149	;
80	103508	100722	13993	;
81	107924	110401	14817	;
82	105974	119473	15633	;
83	108892	129210	16118	;
84	115689	139147	16792	;
85	128880	144728	17971	;
86	141756	149472	18859	;
87	153301	157542	20047	;
88	158424	167926	21048	;
89	160293	180905	22013	;
90	156675	195557	22666	;
91	158080	209669	23473	;
92	170741	216568	24512	;
93	184018	228622	25598	;
94	193538	244874	26754	;
95	206861	263701	27878	;
96	204762	281253	28834	;
97	195557	301576	29314	;
98	207985	317461	29937	;
99	220805	332012	31199	;
100	240043	342350	32548	] //;
//101	254519	357201	34021	;
//102	261025	376774	35047	;
//103	253520	402340	35898	;
//104	242246	428755	36411	;
//105	241063	461356	37084	;
//106	257567	476511	38338	;
//107	276381	486845	39602	;
//108	273427	514555	40828	]
//
//
//
texp = M(:,1); Iexp=M(:,2); Rexp=M(:,3); Dexp=M(:,4);


//// Rates (parameters fitted for Italy)
//r = 1.46e-5; // infection rate (day^-1)
//a = 2.13e-2; // recovery rate
//d = 1.45e-2; // death rate
//S0 = 2.303e4;  // number of initially susceptible individuals
//I0 = 3; // // number of initially infected individuals
//t0 = 20; // initial time (days)
//tf = 200; // final time (days)

//// Rates (parameters fitted for China)
//r = 3.95e-6; // infection rate (day^-1)
//a = 3.53e-2; // recovery rate
//d = 3.1e-3; // death rate
//S0 = 8.33e4;  // number of initially susceptible individuals
//I0 = 3; // // number of initially infected individuals
//R0=0; D0 = 0;
//t0 = 1; // initial time (days)
//tf = length(texp); // final time (days)
//t=(t0:tf)
//nt0 = 1

//Parameters fitting for Brazil:

nt0 = 8; // initial point in time
t0 = 8; // initial time (days)
tf = length(texp); // final time (days)
t = texp(nt0:$)
I0 = Iexp(nt0); // number of initially infected individuals
R0 = Rexp(nt0); // initially recovered individuals
D0 = Dexp(nt0); // initially dead individuals

//Estimativa para o parâmetro ad = a + d:

// Integral de I_exp*dt

//function Int=int(y,h) 
//// método dos trapézios; h = passo no tempo; y função a ser integrada    
//    Int = (y(1)+y($))/2
//    for i=2:(length(y)-1) 
//        Int = Int + y(i)
//    end
//endfunction
//
//// a+d
//ad = Rexp($)/int(Iexp,1)
//
////razão D/R
//DR = mean(Dexp(11:$)./Rexp(11:$))
//
////Estimativas iniciais dos parâmetros a serem ajustados:
//a = ad/(1+DR); // recovery rate
a = 0.069;
//d = DR*a;      // death rate
d = 0.008;
r = 5.0e-7; // infection rate (day^-1)
S0 = 5.0e5;  // number of initially susceptible individuals
par0 = [r;a;d;S0]

function SIRD = sird(r,a,d,S0)
    // SIRD model
    // ODE system:

    function dydt = f(t,y)
        S = y(1); I=y(2); R=y(3); D=y(4);
        dydt = [-r*S*I;
            r*S*I-(a+d)*I;
            a*I;
            d*I]
    endfunction

    // Solving the ODE system:

    y0=[S0;I0;R0;D0];
    
    SIRD = ode(y0,t0,t,f)
    
endfunction

//limites inferiores dos parâmetros:
parmin = [1e-8; //rmin
          3e-2; // amin
          5e-3; //dmin  
          1.2e6]; //S0min 
//limites superiores dos parâmetros
parmax = [1e-6; //rmax
          9e-2//8e-2; // amax
          8e-2; //dmax 
          2e6]; //S0max    

//Função objetivo:
function Fobj=fobj(par)
    par = parmin+(parmax-parmin)./(1+0.01*par^2) // renormalizando os parâmetros
    
    r = par(1); a = par(2); d = par(3); S0= par(4);
    
    SIRD = sird(r,a,d,S0)
    S = SIRD(1,:)'; I=SIRD(2,:)'; R=SIRD(3,:)'; D=SIRD(4,:)';
    Fobj = norm(I-Iexp(nt0:$)) + norm(R-Rexp(nt0:$)) + norm(D-Dexp(nt0:$)) 
endfunction
[par, fval, exitflag, output] = fminsearch (fobj,[r,a,d,S0]) 
disp(par,"par =")
par = par'
par = parmin+(parmax-parmin)./(1+0.01*par^2);
disp(par,"par =")
disp(fval,"Fobj =")
 
r = par(1); a = par(2); d = par(3); S0= par(4);

y = sird(r,a,d,S0)

S = y(1,:)'; I=y(2,:)'; R=y(3,:)'; D=y(4,:)';
k=0;
scf(k)
plot2d(t,[S,I,R,D,Iexp(nt0:$),Rexp(nt0:$),Dexp(nt0:$)],style=[6;5;2;1;-1;-2;-3]);
//plot2d(t,[S,I,R,D],style=[6;5;2;1]);
legend("S","I","R","D","Iexp","Rexp","Dexp");
k=k+1;
scf(k)
plot2d(t,[I,R,D,Iexp(nt0:$),Rexp(nt0:$),Dexp(nt0:$)],style=[5;2;1;-1;-2;-3]);
//plot2d(t,[S,I,R,D],style=[6;5;2;1]);
legend("S","I","R","D","Iexp","Rexp","Dexp");

//r = (1e-8:1e-8:1e-6)'
//for i=1:length(r)
//    par = par0
//    par(1)=r(i)
//    par = sqrt(100*(parmax-par)./(par-parmin))
//    Fobjr(i) = fobj(par)
//end
//k=k+1
//scf(k)
//plot2d(r,Fobjr)
//
//a = (0.03:0.001:0.08)'
//for i=1:length(a)
//    par = par0
//    par(2)=a(i)
//    par = sqrt(100*(parmax-par)./(par-parmin))
//    Fobja(i) = fobj(par)
//end
//k=k+1
//scf(k)
//plot2d(a,Fobja)
//
//d = (0.005:0.001:0.08)'
//for i=1:length(d)
//    par = par0
//    par(3)=d(i)
//    par = sqrt(100*(parmax-par)./(par-parmin))
//    Fobjd(i) = fobj(par)
//end
//k=k+1
//scf(k)
//plot2d(d,Fobjd)
//
//S0 = (4e5:1e4:1e6)'
//for i=1:length(S0)
//    par = par0
//    par(4)=S0(i)
//    par = sqrt(100*(parmax-par)./(par-parmin))
//    FobjS0(i) = fobj(par)
//end
//k=k+1
//scf(k)
//plot2d(S0,FobjS0)
////
//par2 = [5e-7;7.3e-2; 8e-3;4.9e5]
//par2 = sqrt(100*(parmax-par)./(par2-parmin))
//disp(fobj(par2),"Fobj2=")
