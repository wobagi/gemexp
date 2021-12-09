#!/usr/bin/env python3

import argparse

GEM_SETTINGS_NML = "gem_settings.nml"

def main(args):
    with open(GEM_SETTINGS_NML, "w") as f:
        f.write("""\
    &grid
    Grd_typ_S = 'GV',
    Grd_ni = 257,
    Grd_nj = 240,
    Grd_nila = 150,
    Grd_njla = 150,
    Grd_dx = 0.1,
    Grd_dy = 0.1,
    Grd_dxmax = 4.0,
    Grd_dymax = 4.0,
    Grd_xlon1 = 19.0,
    Grd_xlat1 = 52.0,
    Grd_xlon2 = 109.0,
    Grd_xlat2 = 0.0,
    /

    &ptopo
    Ptopo_npex = 3,
    Ptopo_npey = 3,
    Ptopo_nblocx = 1,
    Ptopo_nblocy = 1,
    /        
    """)

def cli():
    parser = argparse.ArgumentParser(description="Setup and run GEM-AQ experiment")
    parser.add_argument("-v", "--verbose", action="store_true", help="Verbose mode")
    args = parser.parse_args()
    main(args)

if __name__=="__main__":
    cli()