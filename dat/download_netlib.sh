#!/bin/bash
mkdir netlib  # directory where .mps files will be saved

# Download netlib and kennington instances
wget -O netlib/cre-a.mps http://users.clas.ufl.edu/hager/LPTest/MPS/cre-a
wget -O netlib/cre-b.mps http://users.clas.ufl.edu/hager/LPTest/MPS/cre-b
wget -O netlib/cre-c.mps http://users.clas.ufl.edu/hager/LPTest/MPS/cre-c
wget -O netlib/cre-d.mps http://users.clas.ufl.edu/hager/LPTest/MPS/cre-d
wget -O netlib/ken-07.mps http://users.clas.ufl.edu/hager/LPTest/MPS/ken-07
wget -O netlib/ken-11.mps http://users.clas.ufl.edu/hager/LPTest/MPS/ken-11
wget -O netlib/ken-13.mps http://users.clas.ufl.edu/hager/LPTest/MPS/ken-13
wget -O netlib/ken-18.mps http://users.clas.ufl.edu/hager/LPTest/MPS/ken-18
wget -O netlib/osa-07.mps http://users.clas.ufl.edu/hager/LPTest/MPS/osa-07
wget -O netlib/osa-14.mps http://users.clas.ufl.edu/hager/LPTest/MPS/osa-14
wget -O netlib/osa-30.mps http://users.clas.ufl.edu/hager/LPTest/MPS/osa-30
wget -O netlib/osa-60.mps http://users.clas.ufl.edu/hager/LPTest/MPS/osa-60
wget -O netlib/pds-02.mps http://users.clas.ufl.edu/hager/LPTest/MPS/pds-02
wget -O netlib/pds-06.mps http://users.clas.ufl.edu/hager/LPTest/MPS/pds-06
wget -O netlib/pds-10.mps http://users.clas.ufl.edu/hager/LPTest/MPS/pds-10
wget -O netlib/pds-20.mps http://users.clas.ufl.edu/hager/LPTest/MPS/pds-20
wget -O netlib/25fv47.mps http://users.clas.ufl.edu/hager/LPTest/MPS/25fv47
wget -O netlib/80bau3b.mps http://users.clas.ufl.edu/hager/LPTest/MPS/80bau3b
wget -O netlib/adlittle.mps http://users.clas.ufl.edu/hager/LPTest/MPS/adlittle
wget -O netlib/afiro.mps http://users.clas.ufl.edu/hager/LPTest/MPS/afiro
wget -O netlib/agg.mps http://users.clas.ufl.edu/hager/LPTest/MPS/agg
wget -O netlib/agg2.mps http://users.clas.ufl.edu/hager/LPTest/MPS/agg2
wget -O netlib/agg3.mps http://users.clas.ufl.edu/hager/LPTest/MPS/agg3
wget -O netlib/bandm.mps http://users.clas.ufl.edu/hager/LPTest/MPS/bandm
wget -O netlib/beaconfd.mps http://users.clas.ufl.edu/hager/LPTest/MPS/beaconfd
wget -O netlib/blend.mps http://users.clas.ufl.edu/hager/LPTest/MPS/blend
wget -O netlib/bnl1.mps http://users.clas.ufl.edu/hager/LPTest/MPS/bnl1
wget -O netlib/bnl2.mps http://users.clas.ufl.edu/hager/LPTest/MPS/bnl2
wget -O netlib/boeing1.mps http://users.clas.ufl.edu/hager/LPTest/MPS/boeing1
wget -O netlib/boeing2.mps http://users.clas.ufl.edu/hager/LPTest/MPS/boeing2
wget -O netlib/bore3d.mps http://users.clas.ufl.edu/hager/LPTest/MPS/bore3d
wget -O netlib/brandy.mps http://users.clas.ufl.edu/hager/LPTest/MPS/brandy
wget -O netlib/capri.mps http://users.clas.ufl.edu/hager/LPTest/MPS/capri
wget -O netlib/cycle.mps http://users.clas.ufl.edu/hager/LPTest/MPS/cycle
wget -O netlib/czprob.mps http://users.clas.ufl.edu/hager/LPTest/MPS/czprob
wget -O netlib/d2q06c.mps http://users.clas.ufl.edu/hager/LPTest/MPS/d2q06c
wget -O netlib/d6cube.mps http://users.clas.ufl.edu/hager/LPTest/MPS/d6cube
wget -O netlib/degen2.mps http://users.clas.ufl.edu/hager/LPTest/MPS/degen2
wget -O netlib/degen3.mps http://users.clas.ufl.edu/hager/LPTest/MPS/degen3
wget -O netlib/dfl001.mps http://users.clas.ufl.edu/hager/LPTest/MPS/dfl001
wget -O netlib/e226.mps http://users.clas.ufl.edu/hager/LPTest/MPS/e226
wget -O netlib/etamacro.mps http://users.clas.ufl.edu/hager/LPTest/MPS/etamacro
wget -O netlib/fffff800.mps http://users.clas.ufl.edu/hager/LPTest/MPS/fffff800
wget -O netlib/finnis.mps http://users.clas.ufl.edu/hager/LPTest/MPS/finnis
wget -O netlib/fit1d.mps http://users.clas.ufl.edu/hager/LPTest/MPS/fit1d
wget -O netlib/fit1p.mps http://users.clas.ufl.edu/hager/LPTest/MPS/fit1p
wget -O netlib/fit2d.mps http://users.clas.ufl.edu/hager/LPTest/MPS/fit2d
wget -O netlib/fit2p.mps http://users.clas.ufl.edu/hager/LPTest/MPS/fit2p
wget -O netlib/forplan.mps http://users.clas.ufl.edu/hager/LPTest/MPS/forplan
wget -O netlib/ganges.mps http://users.clas.ufl.edu/hager/LPTest/MPS/ganges
wget -O netlib/gfrd-pnc.mps http://users.clas.ufl.edu/hager/LPTest/MPS/gfrd-pnc
wget -O netlib/greenbea.mps http://users.clas.ufl.edu/hager/LPTest/MPS/greenbea
wget -O netlib/greenbeb.mps http://users.clas.ufl.edu/hager/LPTest/MPS/greenbeb
wget -O netlib/grow15.mps http://users.clas.ufl.edu/hager/LPTest/MPS/grow15
wget -O netlib/grow22.mps http://users.clas.ufl.edu/hager/LPTest/MPS/grow22
wget -O netlib/grow7.mps http://users.clas.ufl.edu/hager/LPTest/MPS/grow7
wget -O netlib/israel.mps http://users.clas.ufl.edu/hager/LPTest/MPS/israel
wget -O netlib/kb2.mps http://users.clas.ufl.edu/hager/LPTest/MPS/kb2
wget -O netlib/lotfi.mps http://users.clas.ufl.edu/hager/LPTest/MPS/lotfi
wget -O netlib/maros-r7.mps http://users.clas.ufl.edu/hager/LPTest/MPS/maros-r7
wget -O netlib/maros.mps http://users.clas.ufl.edu/hager/LPTest/MPS/maros
wget -O netlib/modszk1.mps http://users.clas.ufl.edu/hager/LPTest/MPS/modszk1
wget -O netlib/nesm.mps http://users.clas.ufl.edu/hager/LPTest/MPS/nesm
wget -O netlib/perold.mps http://users.clas.ufl.edu/hager/LPTest/MPS/perold
wget -O netlib/pilot.ja.mps http://users.clas.ufl.edu/hager/LPTest/MPS/pilot.ja
wget -O netlib/pilot.we.mps http://users.clas.ufl.edu/hager/LPTest/MPS/pilot.we
wget -O netlib/pilot.mps http://users.clas.ufl.edu/hager/LPTest/MPS/pilot
wget -O netlib/pilot4.mps http://users.clas.ufl.edu/hager/LPTest/MPS/pilot4
wget -O netlib/pilot87.mps http://users.clas.ufl.edu/hager/LPTest/MPS/pilot87
wget -O netlib/pilotnov.mps http://users.clas.ufl.edu/hager/LPTest/MPS/pilotnov
wget -O netlib/recipe.mps http://users.clas.ufl.edu/hager/LPTest/MPS/recipe
wget -O netlib/sc105.mps http://users.clas.ufl.edu/hager/LPTest/MPS/sc105
wget -O netlib/sc205.mps http://users.clas.ufl.edu/hager/LPTest/MPS/sc205
wget -O netlib/sc50a.mps http://users.clas.ufl.edu/hager/LPTest/MPS/sc50a
wget -O netlib/sc50b.mps http://users.clas.ufl.edu/hager/LPTest/MPS/sc50b
wget -O netlib/scagr25.mps http://users.clas.ufl.edu/hager/LPTest/MPS/scagr25
wget -O netlib/scagr7.mps http://users.clas.ufl.edu/hager/LPTest/MPS/scagr7
wget -O netlib/scfxm1.mps http://users.clas.ufl.edu/hager/LPTest/MPS/scfxm1
wget -O netlib/scfxm2.mps http://users.clas.ufl.edu/hager/LPTest/MPS/scfxm2
wget -O netlib/scfxm3.mps http://users.clas.ufl.edu/hager/LPTest/MPS/scfxm3
wget -O netlib/scorpion.mps http://users.clas.ufl.edu/hager/LPTest/MPS/scorpion
wget -O netlib/scrs8.mps http://users.clas.ufl.edu/hager/LPTest/MPS/scrs8
wget -O netlib/scsd1.mps http://users.clas.ufl.edu/hager/LPTest/MPS/scsd1
wget -O netlib/scsd6.mps http://users.clas.ufl.edu/hager/LPTest/MPS/scsd6
wget -O netlib/scsd8.mps http://users.clas.ufl.edu/hager/LPTest/MPS/scsd8
wget -O netlib/sctap1.mps http://users.clas.ufl.edu/hager/LPTest/MPS/sctap1
wget -O netlib/sctap2.mps http://users.clas.ufl.edu/hager/LPTest/MPS/sctap2
wget -O netlib/sctap3.mps http://users.clas.ufl.edu/hager/LPTest/MPS/sctap3
wget -O netlib/seba.mps http://users.clas.ufl.edu/hager/LPTest/MPS/seba
wget -O netlib/share1b.mps http://users.clas.ufl.edu/hager/LPTest/MPS/share1b
wget -O netlib/share2b.mps http://users.clas.ufl.edu/hager/LPTest/MPS/share2b
wget -O netlib/shell.mps http://users.clas.ufl.edu/hager/LPTest/MPS/shell
wget -O netlib/ship04l.mps http://users.clas.ufl.edu/hager/LPTest/MPS/ship04l
wget -O netlib/ship04s.mps http://users.clas.ufl.edu/hager/LPTest/MPS/ship04s
wget -O netlib/ship08l.mps http://users.clas.ufl.edu/hager/LPTest/MPS/ship08l
wget -O netlib/ship08s.mps http://users.clas.ufl.edu/hager/LPTest/MPS/ship08s
wget -O netlib/ship12l.mps http://users.clas.ufl.edu/hager/LPTest/MPS/ship12l
wget -O netlib/ship12s.mps http://users.clas.ufl.edu/hager/LPTest/MPS/ship12s
wget -O netlib/sierra.mps http://users.clas.ufl.edu/hager/LPTest/MPS/sierra
wget -O netlib/stair.mps http://users.clas.ufl.edu/hager/LPTest/MPS/stair
wget -O netlib/standata.mps http://users.clas.ufl.edu/hager/LPTest/MPS/standata
wget -O netlib/standgub.mps http://users.clas.ufl.edu/hager/LPTest/MPS/standgub
wget -O netlib/standmps.mps http://users.clas.ufl.edu/hager/LPTest/MPS/standmps
wget -O netlib/stocfor1.mps http://users.clas.ufl.edu/hager/LPTest/MPS/stocfor1
wget -O netlib/stocfor2.mps http://users.clas.ufl.edu/hager/LPTest/MPS/stocfor2
wget -O netlib/stocfor3.mps http://users.clas.ufl.edu/hager/LPTest/MPS/stocfor3
wget -O netlib/truss.mps http://users.clas.ufl.edu/hager/LPTest/MPS/truss
wget -O netlib/tuff.mps http://users.clas.ufl.edu/hager/LPTest/MPS/tuff
wget -O netlib/vtp_base.mps http://users.clas.ufl.edu/hager/LPTest/MPS/vtp_base
wget -O netlib/wood1p.mps http://users.clas.ufl.edu/hager/LPTest/MPS/wood1p
wget -O netlib/woodw.mps http://users.clas.ufl.edu/hager/LPTest/MPS/woodw

# Download QAP instances
# create sub-directories
mkdir qap_data

# Download instances and generator
wget www.netlib.org/lp/generators/qap/data.8
wget www.netlib.org/lp/generators/qap/data.12
wget www.netlib.org/lp/generators/qap/data.15
wget www.netlib.org/lp/generators/qap/newlp.f

# Compile generator
gfortran newlp.f -o newlp

# Generate instances
cat data.8  | ./newlp > netlib/qap8.mps
cat data.12 | ./newlp > netlib/qap12.mps
cat data.15 | ./newlp > netlib/qap15.mps

# move data files
mv data.8  ./qap_data/data.8
mv data.12 ./qap_data/data.12
mv data.15 ./qap_data/data.15
mv newlp.f ./qap_data/newlp.f
mv newlp   ./qap_data/newlp