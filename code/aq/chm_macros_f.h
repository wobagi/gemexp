!copyright (C) 2001  MSC-RPN COMM  %%%RPNPHY%%%
#ifdef DOC
!
! Successive calls to the following macros generate
! two common blocks:
!
!    * MARK_COMCHM_BEG: marks the beginning of the common block
!      of "pointers" (of type INTEGER) that define the structure
!      of the bus
!    * MARK_COMCHM_END: marks the end of the same common block
!    * DCL_CHMVAR: this macro has to be called for each variable
!      included in the bus. If DCLCHAR is not defined, then only
!      the common block of "pointers" is created. If DCLCHAR is
!      defined, then both the common block of "pointers" and the
!      common block of the corresponding "names" (of type CHARACTER)
!      are created.
!
! Example:
!       SUBROUTINE BIDON
! #define DCLCHAR
! #include "chm_macros_f.h"
!       MARK_COMCHM_BEG (phybus)           ! Begins the common block "chmbus"
!       DCL_CHMVAR( AL        ,chmbus)     ! Adds one "pointer" to the common block
!       DCL_CHMVAR( MG        ,chmbus)
!       ...
!       DCL_CHMVAR( Z0        ,phybus)
!       MARK_COMCHM_END (phybus)           ! Ends the common block "chmbus"
!       equivalence (chmbus_i_first(1),AL) ! "pointer" AL is now the first element
!                                            of the common block "chmbus"
!       ...
!       return
!       end
!
! For details of implementation, see comdeck "chmbus.cdk"
! and subroutine "chm_ini.ftn" in the chemistry library.
!
! Author : Vivian Lee (Nov 2000, phy_macros_f.h) - adapted by B. Bilodeau.
!          renamed and adapted for chemistry by A.Kallaur (March 2005)
!
#endif

#define _cat_(name1,name2) name1##name2

#define _cat3_(name1,name2,name3) name1##name2##name3

#define AUTOMATIC(name,type,dims) ~~\
type _cat_(name,dims)

#ifndef DCLCHAR

#define DCL_CHMVAR(__TOKEN__,_COM_)~~\
integer __TOKEN__~~\
common/_cat_(_COM_,_i)/__TOKEN__~~\

#define MARK_COMCHM_BEG(_COM_) ~~\
integer _cat3_(_COM_,_i,_first(-1:0))~~\
common /_cat_(_COM_,_i)/_cat3_(_COM_,_i,_first)

#else

#define DCL_CHMVAR(__TOKEN__,_COM_)~~\
integer __TOKEN__~~\
character*16 _cat_(__TOKEN__,_c)~~\
data  _cat_(__TOKEN__,_c) /'__TOKEN__'/~~\
common/_cat_(_COM_,_i)/__TOKEN__~~\
common/_cat_(_COM_,_c)/_cat_(__TOKEN__,_c)

#define MARK_COMCHM_BEG(_COM_)~~\
integer _cat3_(_COM_,_i,_first(-1:0))~~\
common /_cat_(_COM_,_i)/_cat3_(_COM_,_i,_first)~~\
character*16 _cat3_(_COM_,_c,_first(-1:0))~~\
common /_cat_(_COM_,_c)/_cat3_(_COM_,_c,_first)

#endif

#define MARK_COMCHM_END(_COM_)~~\
integer _cat3_(_COM_,_i,_last)~~\
common /_cat_(_COM_,_i)/_cat3_(_COM_,_i,_last)

#define COMCHM_SIZE(_COM_) (loc(_cat3_(_COM_,_i,_last))-\
loc(_cat3_(_COM_,_i,_first(0)))-1)/(loc(_cat3_(_COM_,_i,_first(0)))-\
loc(_cat3_(_COM_,_i,_first(-1))))

