#!/bin/bash

DIR=$(dirname "$0")

echo "GEM Experiment. Current directory: $DIR"

EXP_NAME="wb_gvp10"


# get-abs
#!/bin/sh
# GEM-CLIM used as GEM-DM
# CDR=code
#
# cp -vp $CDR/maingemclimdm_Linux_x86-64_3.3.2.Abs  maingemdm_Linux_x86-64_3.3.2.Abs
# cp -vp $CDR/maingemclimntr_Linux_x86-64_3.3.2.Abs maingemntr_Linux_x86-64_3.3.2.Abs 
#
# Static files:


EXP_BASEDIR=/mnt/disk3/ocena/2020/
EXP_NAME="hdd_gvp10"
#
EXP=${BASEDIR}/${EXP_NAME}/exp_common
NODES=${BASEDIR}/${EXP_NAME}/nodes

EXP_LOCAL_DIR=.
#/home/ocena/projects/gem332/hdd_gvp10

#
ln -s ${EXP} .
ln -s ${EXP}/configexp.dot.cfg
ln -s ${EXP}/input
#
cp  ${EXP}/outcfg.out .
cp  ${EXP}/*.sh .
#
cp  ${EXP}/run1 .
#
cp ${EXP}/maingemdm_Linux_x86-64_3.3.2.Abs  .
cp ${EXP}/maingemntr_Linux_x86-64_3.3.2.Abs .
#
ln -s ${NODES}/${TRUE_HOST}        arc
ln -s ${NODES}/${TRUE_HOST}/out    out 
#
ls -al
#
IC=ic2019122600_gemaq
#
cp /mnt/disk3/ocena/2020/hdd_gvp10/ic/${IC} ic_curr.rpn
#
SNAP_F1=CBE_2019_PL_500m_base_v3_EMEP_2018_EU_10km_base_v1_gvp10.fst
SNAP_F2=CBE_2019_PL_500m_PT_v3_EMEP_2018_EU_10km_PT_v1_PH_metale_gvp10.fst
#
declare -A ETIKET_DICT  # associative array
ETIKET_DICT["a02"]=GVP10_BASE
ETIKET_DICT["a03"]=GVP10_HDD15C
ETIKET_DICT["a10"]=GVP10_TEST

ETIKET=$ETIKET_DICT[${TRUE_HOST}]

if [ ${TRUE_HOST} == "a02"  ] ; then ETIKET=GVP10_BASE ;fi
if [ ${TRUE_HOST} == "a03"  ] ; then ETIKET=GVP10_HDD15C ;fi
if [ ${TRUE_HOST} == "a10"  ] ; then ETIKET=GVP10_TEST ;fi

#touch 0-${TRUE_HOST}-ocena-2020-gvp10_start-${ETIKET}_HDD_testing
#

SOX=1.0
VOC=1.0
NH3=1.0
PM=1.0
NOX=1.0
#
#
echo 'gvp10_make_gem_settings_cam.sh: '${ETIKET}'   '${SOX}'   '${VOC}'   '${NH3}'   '${PM}'   '${NOX}
#
#
cat >gem_settings.nml <<EOF
 &grid
  Grd_typ_S       = 'GV'       , 
  Grd_ni          = 257        , Grd_nj          = 240        ,
  Grd_nila        = 150        , Grd_njla        = 150        ,
  Grd_dx          = 0.1        , Grd_dy          = 0.1        ,
  Grd_dxmax       = 4.0        , Grd_dymax       = 4.0        ,
  Grd_xlon1       =  19.       , Grd_xlat1       = 52.        ,
  Grd_xlon2       =  109.      , Grd_xlat2       = 0.         ,
/

 &ptopo
  Ptopo_npex      = 6          , Ptopo_npey      = 6     ,
  Ptopo_nblocx    = 1          , Ptopo_nblocy    = 1          ,
/

 &gement
  e_schm_stlag    = .true.     , e_schm_adcub    = .true.     ,

  Topo_filmx_L    = .true.     , Topo_init_L     = .true.     , 
  Topo_dgfmx_L    = .true.     , Topo_dgfms_L    = .true.     ,

                                 E_geol_hscon_L  = .false.    ,
  E_geol_glanl_L  = .true.     , E_geol_hsanl_L  = .true.     ,
  E_geol_glreg_L  = .false.    , E_geol_hsreg_L  = .false.    ,
  E_geol_gls      = 30.        , E_geol_hss      = 20.        ,
  E_geol_gln      = 80.        , E_geol_hsn      = 80.        ,
  E_geol_glw      = 220.       , E_geol_hsw      = 220.       ,
  E_geol_gle      = 320.       , E_geol_hse      = 320.       ,

  E_geol_hsea     = 3000       , E_geol_poin     = 3          ,
  E_geol_z0cst    = -1.        ,

  E_tr3d_list_S   = 
   'C2H6', 'C3H8', 'ALKA', 'TOLU', 'AROM', 'C2H2', 'CH4= 1.7e-6',  
   'H2O2', 'FRMA', 'N2O5', 'PAN',  'DIAL', 'MOOH', 'PAA',  
   'HONO', 'HNO4', 'SO2',  'ISOP', 'CRES', 'SO4',  'ALKE', 
   'RNO3', 'MOH',  'ETHE', 'ROOH', 'MGLY', 'ACTA', 'HNO3', 
   'O3',   'MEK',  'NO',   'CO',   'ALD2', 'NO2',  'HCHO',
   'BAP1', 'BAP2', 'NH3',  'NH4',  
   'PT25', 'PTCO', 'PH25', 'PHCO',
   'PMAS', 'PMCD', 'PMPB', 'PMNI',
   'SS01','SS02','SS03','SS04','SS05','SS06','SS07','SS08','SS09','SS10','SS11','SS12',
   'SF01','SF02','SF03','SF04','SF05','SF06','SF07','SF08','SF09','SF10','SF11','SF12',
   'BC01','BC02','BC03','BC04','BC05','BC06','BC07','BC08','BC09','BC10','BC11','BC12',
   'OC01','OC02','OC03','OC04','OC05','OC06','OC07','OC08','OC09','OC10','OC11','OC12',
   'SD01','SD02','SD03','SD04','SD05','SD06','SD07','SD08','SD09','SD10','SD11','SD12',
   'ADMS','AH2S',

 /

 &chem_cfgs
  AC_nskip_chem=2,

  Emis_Scale_SOX=${SOX} ,
  Emis_Scale_VOC=${VOC} ,
  Emis_Scale_NH3=${NH3} ,
  Emis_Scale_PM =${PM}  ,
  Emis_Scale_NOX=${NOX} ,

  AEROSOL_model='CAM',
  so4_gas_part=0.50,

  AERO_soil_file_S(1)='${EXP_LOCAL_DIR}/input/eko_cam/soil_1p5_gvp10.rpn',
  AERO_soil_file_S(2)='${EXP_LOCAL_DIR}/input/eko_cam/clay_1p5_gvp10.rpn',
  AERO_soil_file_S(3)='${EXP_LOCAL_DIR}/input/eko_cam/sand_1p5_gvp10.rpn',
  AERO_config_file_S ='${EXP_LOCAL_DIR}/input/eko_cam/AEROSOL5T_ok',
  AERO_emis_file_S   ='${EXP_LOCAL_DIR}/input/eko_cam/geia_emis_1.5x1.5_gcm_gvp10.rpn',

  GAS_chem_S = 'ADOM_CAM',
  GAS_land_S = 'BATS15',
  GAS_wetdepo_S = 'WETDEP_JS'
  GAS_drydepo_S= 'DRYDEP_AR'
! 
!      months       1    2    3    4    5    6    7    8    9    10   11   12
! GAS_drydepo_o3 = 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0,
! GAS_drydepo_o3 = 1.0, 1.0, 1.0, 1.0, 1.5, 2.0, 2.0, 2.0, 2.0, 1.5, 1.0, 1.2,    ! JS: February 5, 2021 
  GAS_drydepo_o3 = 1.2, 1.2, 1.2, 1.2, 1.7, 2.2, 2.2, 2.2, 2.2, 1.7, 1.2, 1.4,    ! JS: February 13, 2021 
!
  GAS_conv_S = 'ZMF'
  GAS_vdiff_S ='VD2'
  AERO_emis_S = 'GEIA_FULL'

  GAS_land_file_S='${EXP_LOCAL_DIR}/input/geophys/landuse_gengeo_gvp10.fst'

  GAS_emis_type='EMEP_SNAP'

  GAS_emis_file_S='${EXP_LOCAL_DIR}/input/emis/combined_nilu-eclipse_emissions-global05x05_gemaq-unit_anth+ship_gvp10.fst'
! 
! CBE - v3  Feb 22, 2021
! 
  GAS_emis_file_S_snap='${EXP_LOCAL_DIR}/input/emis/${SNAP_F1}',
  GAS_emis_file_S_mask='${EXP_LOCAL_DIR}/input/emis/${SNAP_F1}',
   PT_emis_file_S_snap='${EXP_LOCAL_DIR}/input/emis/${SNAP_F2}',

  HDD15_grid_avr_file_S='${EXP_LOCAL_DIR}/input/hdd15_2020_daily_grid_average.dat'
! 
  GAS_top_lev_file_S='${EXP_LOCAL_DIR}/input/top/haloe_cmam_top_10mb_gvp10.rpn',

/

 &gem_cfgs
  hyb = .0  , .011, .027, .051, .075,
        .101, .127, .155, .185, .219,
        .258, .302, .351, .405, .460,
        .516, .574, .631, .688, .744,
        .796, .842, .884, .922, .955,
        .980, .993, 1.00,

  Grd_rcoef = 1.0,      Pres_ptop       = 11.0 ,   

  Level_ip12000_L = .true.     ,

  Mem_mx3db=  800,

  Step_total      = 144        , Step_rsti  = 999999        ,
  Step_gstat      = 6         , Step_cleanup  = 479952        ,

  Rstri_glbcol_L  = .false.    ,

  Adw_interp_type_S = 'LAG3D'  ,

  Clim_climat_L   = .false.     ,
  Clim_inincr_L   = .false.     ,

  Cstv_dt_8       =  600.      , Cstv_tstr_8     = 200.0      ,
  Cstv_uvdf_8     = 30000.     , Cstv_phidf_8    = 30000.      ,
  Cstv_pitop_8    = -1.0       , Cstv_pisrf_8    = 1000.0     ,

  Hspng_mf        = 0          ,
  Hspng_nj        = 0          , 

  Hzd_rwnd_L    = .true.       ,

  Hzd_type_S      = "HO"       , Hzd_lnR         = .1        ,
  Hzd_pwr         = 6          , Hzd_uvwdt_L     = .true.     ,

  Init_balgm_L    = .false.    , Init_dftr_L     = .false.    ,
  Init_dfwin_L    = .true.     , Init_dfnp       =  25 ,
  Init_dfpl_8     = 21600.     ,

  Offc_a0_8       = 1.0        , Offc_a1_8       = -1.0       ,
  Offc_b0_8       = 0.6        , Offc_b1_8       =  0.4       ,

  Out3_etik_s     = '${ETIKET}',

  Out3_zund       = 2500, 2000, 1500,
  Out3_nbitg      = 32         , Out3_cliph_L     = .true.    ,
  Out3_unit_S     = 'H'        , Out3_vt2gz_L     = .true.    ,
  Out3_ndigits    =  8         ,
  Out3_cubzt_L    = .false.    , Out3_cubuv_L     = .false.   ,
  Out3_cubds_L    = .false.    , Out3_cubqs_L     = .false.   ,
  Out3_cubdd_L    = .false.    , Out3_cubqq_L     = .false.   ,
  Out3_cubww_L    = .false.    , Out3_linbot      =  3        ,

  Schm_hydro_L    = .false.     , Schm_nonhy_8    = 1.0        ,
  Schm_xwvt3      = 0          , Schm_hdlast_L   = .true.     ,
  Schm_itcn       = 2          , Schm_modcn      = 1          ,
  Schm_itnlh      = 2          , Schm_itraj      = 3          , 
  Schm_moist_L    = .true.     , Schm_adcub_L    = .true.     ,
  Schm_difqp_L    = .true.     , Schm_psadj_L    = .true.    ,
  Schm_sfix_L     = .false.    , Schm_wload_L    = .false.    ,

  P_lmvd_valml_8  = 0.0        ,
  P_pbd_dumpbus   = 0          ,

  p_pset_second_L = .false.    ,
  p_pset_xofset   = 60         , p_pset_yofset   = 30         ,
  p_pset_xblnd    = 1          , p_pset_yblnd    = 1          ,

  Vspng_mf        = 10.        , Vspng_nk        = 5          ,
  Vspng_uvwdt_L   = .true.     , Vspng_rwnd_L    = .true.     ,
  Vspng_njpole    = 0          , Vspng_zmean_L   = .false.    ,

  Vrtd_L          = .true.     ,

/

 &physics_cfgs

 RADNIVL          = 01,02,03,04,05,06,07,08,09,10,
                    11,12,13,14,15,16,17,18,19,20,
                    21,22,23,24,25,26,27,28,

 PHY_PCK_VERSION  = 'RPN-CMC_5.0.4' ,

 RADIA            = 'cccmarad'   , KNTRAD          = 6          ,
 RADFILES         = 'std'      , 
 FOMIC            = .false.    , SIMISCCP        = .false.    ,

 NON_ORO = .false. ,
 STRATOS = .false. ,

 MOYHR            =  0         ,

 SCHMSOL          = 'FCREST'     ,
 GWDRAG           = 'gwd86'    ,

 LONGMEL          = 'boujo'   ,
 FLUVERT          = 'moistke'  , DRAG            = .true.     ,
 BKGALB           = .true.    , Z0TLAT          = 20., 25.   ,
 CHAUF            = .true.     , EVAP            = .true.     ,
 DBGMEM           = .false.    , SNOWMELT        = .false.    ,
 STOMATE          = .false.    , TYPSOL          = .true.     ,
 AGREGAT          = .true.     , CORTM           = .true.     ,
                                 DRYLAPS         = .true.     ,
                                 ICEMELT         = .true.     ,
 IMPFLX           = .true.    ,

 PARSOL(5)        = 0.1E-06    , PARSOL(2)       = 0.8E+06    ,

 SHLCVT           = 'conres','ktrsnt',
 KFCPCP           = 'conspcpn' ,
 CONVEC           = 'FCP'      , STCOND          ='CONSUN'    ,
 HC2              = 0.8        ,
 HF2              = 0.8        , HM2             = 0.8        ,
 SATUCO           = .true.     , INILWC          = .true.     ,
 KFCMOM           = .false.    , 
 KFCTRIG4         = 0. , 0., 0.034, 0.034                     ,
 KFCTRIGA         = 50.        ,
 KFCRAD           = 1500.      , KFCDEPTH        = 4000.      ,
 KFCDLEV          = 0.5        , KFCDET          = 0.         ,
 KFCTIMEC         = 2700.      , KFCTIMEA        = 2700.      ,
 PCPTYPE          = 'bourge'   , KTICEFRAC       = .false.    ,

 EPONGE           = 450. , 449.6292 , 362.0958 , 106.7958 ,

 BETA2  = 0.85,
 QCO2   = 380.0,
 ADVECTKE = .true.,

/

EOF
