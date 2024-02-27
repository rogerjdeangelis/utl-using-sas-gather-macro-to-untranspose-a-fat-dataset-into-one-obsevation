%let pgm=utl-using-sas-gather-macro-to-untranspose-a-fat-dataset-into-one-obsevation;

Using sas gather macro to untranspose a fat dataset into one obsevation

github
http://tinyurl.com/3cyshdm9
https://github.com/rogerjdeangelis/utl-using-sas-gather-macro-to-untranspose-a-fat-dataset-into-one-obsevation

I could not get the untranspose macro to handle this case. Noe that gather is
very useful for normalizarion and variable, vakue pairs.
R also has a similar gather macro.
Gather by lea Iacta aleaiacta95@gmail.com and in github

The gather2 macro is at

https://tinyurl.com/y9nfugth
https://github.com/rogerjdeangelis/utl-macros-used-in-many-of-rogerjdeangelis-repositories
/*               _     _
 _ __  _ __ ___ | |__ | | ___ _ __ ___
| `_ \| `__/ _ \| `_ \| |/ _ \ `_ ` _ \
| |_) | | | (_) | |_) | |  __/ | | | | |
| .__/|_|  \___/|_.__/|_|\___|_| |_| |_|
|_|
*/

/**************************************************************************************************************************/
/*                      |                     |                                                                           */
/*     INPUT            |    PROCESS          |                                   OUTPUT                                  */
/*                      |                     |                                                                           */
/* CHR NUM  RES   TST   |   %utl_gather2(     |   A_NUM A_RES A_TST B_NUM B_RES B_TST C_NUM C_RES C_TST D_NUM D_RES D_TST */
/*                      |      have           |                                                                           */
/*  A   2  0.44  0.001  |     ,var            |     2   0.44  0.001   1   0.54   0.1    1   0.21   0.2    2   0.102 0.01  */
/*  B   1  0.54  0.1    |     ,val            |                                                                           */
/*  C   1  0.21  0.2    |     ,chr            |                                                                           */
/*  D   2  0.102 0.01   |     ,long_df        |                                                                           */
/*                      |     ,ValFormat=$5.);|                                                                           */
/*                      |                     |                                                                           */
/*                      |   proc transpose    |                                                                           */
/*                      |    data=long_df     |                                                                           */
/*                      |    out=havxpo       |                                                                           */
/*                      |      (drop=_name_); |                                                                           */
/*                      |   var val;          |                                                                           */
/*                      |   id chr var;       |                                                                           */
/*                      |   run;quit;         |                                                                           */
/*                      |                     |                                                                           */
/**************************************************************************************************************************/

/*                   _
(_)_ __  _ __  _   _| |_
| | `_ \| `_ \| | | | __|
| | | | | |_) | |_| | |_
|_|_| |_| .__/ \__,_|\__|
        |_|
*/

data have;
input
 (chr num res tst ) ($);
cards4;
A_ 2 0.44 0.001
B_ 1 0.54 0.1
C_ 1 0.21 0.2
D_ 2 0.102 0.01
;;;;
run;quit;

/**************************************************************************************************************************/
/*                                                                                                                        */
/* Obs    CHR    NUM     RES      TST                                                                                     */
/*                                                                                                                        */
/*  1     A_      2     0.44     0.001                                                                                    */
/*  2     B_      1     0.54     0.1                                                                                      */
/*  3     C_      1     0.21     0.2                                                                                      */
/*  4     D_      2     0.102    0.01                                                                                     */
/*                                                                                                                        */
/**************************************************************************************************************************/

/*
 _ __  _ __ ___   ___ ___  ___ ___
| `_ \| `__/ _ \ / __/ _ \/ __/ __|
| |_) | | | (_) | (_|  __/\__ \__ \
| .__/|_|  \___/ \___\___||___/___/
|_|
*/

%utl_gather2(have, var, val, chr, long_df, ValFormat=$5.);

proc transpose data=long_df out=havxpo(drop=_name_);
var val;
id chr var;
run;quit;

/**************************************************************************************************************************/
/*                                                                                                                        */
/*  OUTPUT of GATHER                                                                                                      */
/*                                                                                                                        */
/*  Obs    CHR    VAR    VAL                                                                                              */
/*                                                                                                                        */
/*    1    A_     NUM    2                                                                                                */
/*    2    A_     RES    0.44                                                                                             */
/*    3    A_     TST    0.001                                                                                            */
/*    4    B_     NUM    1                                                                                                */
/*    5    B_     RES    0.54                                                                                             */
/*    6    B_     TST    0.1                                                                                              */
/*    7    C_     NUM    1                                                                                                */
/*    8    C_     RES    0.21                                                                                             */
/*    9    C_     TST    0.2                                                                                              */
/*   10    D_     NUM    2                                                                                                */
/*   11    D_     RES    0.102                                                                                            */
/*   12    D_     TST    0.01                                                                                             */
/*                                                                                                                        */
/* FINAL OUTPUT                                                                                                           */
/*                                                                                                                        */
/*                                   OUTPUT                                                                               */
/*                                                                                                                        */
/*   A_NUM A_RES A_TST B_NUM B_RES B_TST C_NUM C_RES C_TST D_NUM D_RES D_TST                                              */
/*                                                                                                                        */
/*     2   0.44  0.001   1   0.54   0.1    1   0.21   0.2    2   0.102 0.01                                               */
/*                                                                                                                        */
/*                                                                                                                        */
/**************************************************************************************************************************/

/*              _
  ___ _ __   __| |
 / _ \ `_ \ / _` |
|  __/ | | | (_| |
 \___|_| |_|\__,_|

*/
