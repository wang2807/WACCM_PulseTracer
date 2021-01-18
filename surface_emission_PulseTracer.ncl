do yyyy = 1988,1988
setfileoption("nc","Format","LargeFile") 
dir="/glade/work/xinyuew/"
filelb="LBC_1975_nh_pulse_c_" + (yyyy - 1) +"0708.nc"  ;  original (monthly) emission file
fileout="/glade/scracth/xinyuew/LBC_1975_nh_pulse_c_"+yyyy+"07.nc" 
f1=addfile(dir+filelb,"r")
fout=addfile(fileout,"c")

date=f1->date
time=f1->time
lat=f1->lat
lon=f1->lon
nlat=dimsizes(lat)
nlon=dimsizes(lon)
inlon=ind(lon.ge.0 .and. lon.le.360)
inlat=ind(lat.ge.0 .and. lat.le.90) ;Northern Hemisphere

d1_s=0  ; 1975-01-01
d1_e=(yyyy-1975)*12+(yyyy-1981)*28+d1_s+6  ; 1981-07-01
print(date(d1_e))
di_p=2
d2_s=d1_e+1  ; 1981-08-01
d2_e=dimsizes(date)-1  ; 2015-12-01

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; we want to release tracer in weeknum weeks during July ;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
weeknum   = 5

CO2_LBC=f1->CO2_LBC 
CO2_LBC_mean=f1->CO2_LBC_mean
CH4_LBC=f1->CH4_LBC 
CH4_LBC_mean=f1->CH4_LBC_mean
N2O_LBC=f1->N2O_LBC

CCL4_LBC=f1->CCL4_LBC
CF2CLBR_LBC=f1->CF2CLBR_LBC
CF3BR_LBC=f1->CF3BR_LBC
CFC113_LBC=f1->CFC113_LBC
CH3BR_LBC=f1->CH3BR_LBC
CH3BR_LBC_mean=f1->CH3BR_LBC_mean

CH3CCL3_LBC=f1->CH3CCL3_LBC
CH3CL_LBC=f1->CH3CL_LBC
H2_LBC=f1->H2_LBC
HCFC22_LBC=f1->HCFC22_LBC
HCFC22_LBC_mean=f1->HCFC22_LBC_mean

CFC114_LBC=f1->CFC114_LBC
CFC115_LBC=f1->CFC115_LBC
HCFC141B_LBC=f1->HCFC141B_LBC
HCFC141B_LBC_mean=f1->HCFC141B_LBC_mean

HCFC142B_LBC=f1->HCFC142B_LBC
HCFC142B_LBC_mean=f1->HCFC142B_LBC_mean

CH2BR2_LBC=f1->CH2BR2_LBC
CHBR3_LBC=f1->CHBR3_LBC
H1202_LBC=f1->H1202_LBC
H2402_LBC=f1->H2402_LBC
OCS_LBC=f1->OCS_LBC

CFCL3_LBC=f1->CFCL3_LBC
CF2CL2_LBC=f1->CF2CL2_LBC
TOT_CLOY=f1->TOT_CLOY
TOT_BROY=f1->TOT_BROY
TOT_FOY=f1->TOT_FOY
SF6_LBC=f1->SF6_LBC

;  assign new dates for all species
CO2_LBC_mean1=CO2_LBC_mean(d1_s:d1_e)
CO2_LBC_mean2=CO2_LBC_mean(d2_s:d2_e)
CO2_LBC_meani=new(weeknum*3-1,float)
CO2_LBC_meani=CO2_LBC_mean(d1_e) 
CO2_LBC_mean_new=array_append_record(array_append_record(CO2_LBC_mean1,CO2_LBC_meani,0),CO2_LBC_mean2,0)
delete([/CO2_LBC_mean1, CO2_LBC_mean2, CO2_LBC_meani, CO2_LBC_mean/])
CO2_LBC1=CO2_LBC(d1_s:d1_e,:)
CO2_LBC2=CO2_LBC(d2_s:d2_e,:)
CO2_LBCi=CO2_LBC((/d1_e,d1_e,d1_e/),:) 
        do comi      = 1,weeknum-1
            if comi.eq.4
                CO2_LBCnew   = array_append_record(CO2_LBCi, CO2_LBC((/d1_e,d1_e/),:), 0)
                delete(CO2_LBCi)
                CO2_LBCi     = CO2_LBCnew
                delete(CO2_LBCnew)
            else
                CO2_LBCnew   = array_append_record(CO2_LBCi, CO2_LBC((/d1_e,d1_e,d1_e/),:), 0)
                delete(CO2_LBCi)
                CO2_LBCi     = CO2_LBCnew
                delete(CO2_LBCnew)
            end if
        end do
CO2_LBC_new=array_append_record(array_append_record(CO2_LBC1,CO2_LBCi,0),CO2_LBC2,0)
delete([/CO2_LBC1, CO2_LBC2, CO2_LBCi, CO2_LBC/])

CH4_LBC_mean1=CH4_LBC_mean(d1_s:d1_e)
CH4_LBC_mean2=CH4_LBC_mean(d2_s:d2_e)
CH4_LBC_meani=new(weeknum*3-1,float)
CH4_LBC_meani=CH4_LBC_mean(d1_e) 
CH4_LBC_mean_new=array_append_record(array_append_record(CH4_LBC_mean1,CH4_LBC_meani,0),CH4_LBC_mean2,0)
delete([/CH4_LBC_mean1, CH4_LBC_mean2, CH4_LBC_meani, CH4_LBC_mean/])
CH4_LBC1=CH4_LBC(d1_s:d1_e,:)
CH4_LBC2=CH4_LBC(d2_s:d2_e,:)
CH4_LBCi=CH4_LBC((/d1_e,d1_e,d1_e/),:) 
        do comi      = 1,weeknum-1
            if comi.eq.4
                CH4_LBCnew   = array_append_record(CH4_LBCi, CH4_LBC((/d1_e,d1_e/),:), 0)
                delete(CH4_LBCi)
                CH4_LBCi     = CH4_LBCnew
                delete(CH4_LBCnew)
            else
                CH4_LBCnew   = array_append_record(CH4_LBCi, CH4_LBC((/d1_e,d1_e,d1_e/),:), 0)
                delete(CH4_LBCi)
                CH4_LBCi     = CH4_LBCnew
                delete(CH4_LBCnew)
            end if
        end do
CH4_LBC_new=array_append_record(array_append_record(CH4_LBC1,CH4_LBCi,0),CH4_LBC2,0)
delete([/CH4_LBC1, CH4_LBC2, CH4_LBCi, CH4_LBC/])

N2O_LBC1=N2O_LBC(d1_s:d1_e,:)
N2O_LBC2=N2O_LBC(d2_s:d2_e,:)
N2O_LBCi=N2O_LBC((/d1_e,d1_e,d1_e/),:) 
        do comi      = 1,weeknum-1
            if comi.eq.4
                N2O_LBCnew   = array_append_record(N2O_LBCi, N2O_LBC((/d1_e,d1_e/),:), 0)
                delete(N2O_LBCi)
                N2O_LBCi     = N2O_LBCnew
                delete(N2O_LBCnew)
            else
                N2O_LBCnew   = array_append_record(N2O_LBCi, N2O_LBC((/d1_e,d1_e,d1_e/),:), 0)
                delete(N2O_LBCi)
                N2O_LBCi     = N2O_LBCnew
                delete(N2O_LBCnew)
            end if
        end do
N2O_LBC_new=array_append_record(array_append_record(N2O_LBC1,N2O_LBCi,0),N2O_LBC2,0)
delete([/N2O_LBC1, N2O_LBC2, N2O_LBCi, N2O_LBC/])

CCL4_LBC1=CCL4_LBC(d1_s:d1_e,:)
CCL4_LBC2=CCL4_LBC(d2_s:d2_e,:)
CCL4_LBCi=CCL4_LBC((/d1_e,d1_e,d1_e/),:) 
        do comi      = 1,weeknum-1
            if comi.eq.4
                CCL4_LBCnew   = array_append_record(CCL4_LBCi, CCL4_LBC((/d1_e,d1_e/),:), 0)
                delete(CCL4_LBCi)
                CCL4_LBCi     = CCL4_LBCnew
                delete(CCL4_LBCnew)
            else
                CCL4_LBCnew   = array_append_record(CCL4_LBCi, CCL4_LBC((/d1_e,d1_e,d1_e/),:), 0)
                delete(CCL4_LBCi)
                CCL4_LBCi     = CCL4_LBCnew
                delete(CCL4_LBCnew)
            end if
        end do
CCL4_LBC_new=array_append_record(array_append_record(CCL4_LBC1,CCL4_LBCi,0),CCL4_LBC2,0)
delete([/CCL4_LBC1, CCL4_LBC2, CCL4_LBCi, CCL4_LBC/])

CF2CLBR_LBC1=CF2CLBR_LBC(d1_s:d1_e,:)
CF2CLBR_LBC2=CF2CLBR_LBC(d2_s:d2_e,:)
CF2CLBR_LBCi=CF2CLBR_LBC((/d1_e,d1_e,d1_e/),:) 
        do comi      = 1,weeknum-1
            if comi.eq.4
                CF2CLBR_LBCnew   = array_append_record(CF2CLBR_LBCi, CF2CLBR_LBC((/d1_e,d1_e/),:), 0)
                delete(CF2CLBR_LBCi)
                CF2CLBR_LBCi     = CF2CLBR_LBCnew
                delete(CF2CLBR_LBCnew)
            else
                CF2CLBR_LBCnew   = array_append_record(CF2CLBR_LBCi, CF2CLBR_LBC((/d1_e,d1_e,d1_e/),:), 0)
                delete(CF2CLBR_LBCi)
                CF2CLBR_LBCi     = CF2CLBR_LBCnew
                delete(CF2CLBR_LBCnew)
            end if
        end do
CF2CLBR_LBC_new=array_append_record(array_append_record(CF2CLBR_LBC1,CF2CLBR_LBCi,0),CF2CLBR_LBC2,0)
delete([/CF2CLBR_LBC1, CF2CLBR_LBC2, CF2CLBR_LBCi, CF2CLBR_LBC/])

CF3BR_LBC1=CF3BR_LBC(d1_s:d1_e,:)
CF3BR_LBC2=CF3BR_LBC(d2_s:d2_e,:)
CF3BR_LBCi=CF3BR_LBC((/d1_e,d1_e,d1_e/),:) 
        do comi      = 1,weeknum-1
            if comi.eq.4
                CF3BR_LBCnew   = array_append_record(CF3BR_LBCi, CF3BR_LBC((/d1_e,d1_e/),:), 0)
                delete(CF3BR_LBCi)
                CF3BR_LBCi     = CF3BR_LBCnew
                delete(CF3BR_LBCnew)
            else
                CF3BR_LBCnew   = array_append_record(CF3BR_LBCi, CF3BR_LBC((/d1_e,d1_e,d1_e/),:), 0)
                delete(CF3BR_LBCi)
                CF3BR_LBCi     = CF3BR_LBCnew
                delete(CF3BR_LBCnew)
            end if
        end do
CF3BR_LBC_new=array_append_record(array_append_record(CF3BR_LBC1,CF3BR_LBCi,0),CF3BR_LBC2,0)
delete([/CF3BR_LBC1, CF3BR_LBC2, CF3BR_LBCi, CF3BR_LBC/])

CFC113_LBC1=CFC113_LBC(d1_s:d1_e,:)
CFC113_LBC2=CFC113_LBC(d2_s:d2_e,:)
CFC113_LBCi=CFC113_LBC((/d1_e,d1_e,d1_e/),:) 
        do comi      = 1,weeknum-1
            if comi.eq.4
                CFC113_LBCnew   = array_append_record(CFC113_LBCi, CFC113_LBC((/d1_e,d1_e/),:), 0)
                delete(CFC113_LBCi)
                CFC113_LBCi     = CFC113_LBCnew
                delete(CFC113_LBCnew)
            else
                CFC113_LBCnew   = array_append_record(CFC113_LBCi, CFC113_LBC((/d1_e,d1_e,d1_e/),:), 0)
                delete(CFC113_LBCi)
                CFC113_LBCi     = CFC113_LBCnew
                delete(CFC113_LBCnew)
            end if
        end do
CFC113_LBC_new=array_append_record(array_append_record(CFC113_LBC1,CFC113_LBCi,0),CFC113_LBC2,0)
delete([/CFC113_LBC1, CFC113_LBC2, CFC113_LBCi, CFC113_LBC/])

CH3BR_LBC_mean1=CH3BR_LBC_mean(d1_s:d1_e)
CH3BR_LBC_mean2=CH3BR_LBC_mean(d2_s:d2_e)
CH3BR_LBC_meani=new(weeknum*3-1,float)
CH3BR_LBC_meani=CH3BR_LBC_mean(d1_e) 
CH3BR_LBC_mean_new=array_append_record(array_append_record(CH3BR_LBC_mean1,CH3BR_LBC_meani,0),CH3BR_LBC_mean2,0)
delete([/CH3BR_LBC_mean1, CH3BR_LBC_mean2, CH3BR_LBC_meani, CH3BR_LBC_mean/])
CH3BR_LBC1=CH3BR_LBC(d1_s:d1_e,:)
CH3BR_LBC2=CH3BR_LBC(d2_s:d2_e,:)
CH3BR_LBCi=CH3BR_LBC((/d1_e,d1_e,d1_e/),:) 
        do comi      = 1,weeknum-1
            if comi.eq.4
                CH3BR_LBCnew   = array_append_record(CH3BR_LBCi, CH3BR_LBC((/d1_e,d1_e/),:), 0)
                delete(CH3BR_LBCi)
                CH3BR_LBCi     = CH3BR_LBCnew
                delete(CH3BR_LBCnew)
            else
                CH3BR_LBCnew   = array_append_record(CH3BR_LBCi, CH3BR_LBC((/d1_e,d1_e,d1_e/),:), 0)
                delete(CH3BR_LBCi)
                CH3BR_LBCi     = CH3BR_LBCnew
                delete(CH3BR_LBCnew)
            end if
        end do
CH3BR_LBC_new=array_append_record(array_append_record(CH3BR_LBC1,CH3BR_LBCi,0),CH3BR_LBC2,0)
delete([/CH3BR_LBC1, CH3BR_LBC2, CH3BR_LBCi, CH3BR_LBC/])

CH3CCL3_LBC1=CH3CCL3_LBC(d1_s:d1_e,:)
CH3CCL3_LBC2=CH3CCL3_LBC(d2_s:d2_e,:)
CH3CCL3_LBCi=CH3CCL3_LBC((/d1_e,d1_e,d1_e/),:) 
        do comi      = 1,weeknum-1
            if comi.eq.4
                CH3CCL3_LBCnew   = array_append_record(CH3CCL3_LBCi, CH3CCL3_LBC((/d1_e,d1_e/),:), 0)
                delete(CH3CCL3_LBCi)
                CH3CCL3_LBCi     = CH3CCL3_LBCnew
                delete(CH3CCL3_LBCnew)
            else
                CH3CCL3_LBCnew   = array_append_record(CH3CCL3_LBCi, CH3CCL3_LBC((/d1_e,d1_e,d1_e/),:), 0)
                delete(CH3CCL3_LBCi)
                CH3CCL3_LBCi     = CH3CCL3_LBCnew
                delete(CH3CCL3_LBCnew)
            end if
        end do
CH3CCL3_LBC_new=array_append_record(array_append_record(CH3CCL3_LBC1,CH3CCL3_LBCi,0),CH3CCL3_LBC2,0)
delete([/CH3CCL3_LBC1, CH3CCL3_LBC2, CH3CCL3_LBCi, CH3CCL3_LBC/])

CH3CL_LBC1=CH3CL_LBC(d1_s:d1_e,:)
CH3CL_LBC2=CH3CL_LBC(d2_s:d2_e,:)
CH3CL_LBCi=CH3CL_LBC((/d1_e,d1_e,d1_e/),:) 
        do comi      = 1,weeknum-1
            if comi.eq.4
                CH3CL_LBCnew   = array_append_record(CH3CL_LBCi, CH3CL_LBC((/d1_e,d1_e/),:), 0)
                delete(CH3CL_LBCi)
                CH3CL_LBCi     = CH3CL_LBCnew
                delete(CH3CL_LBCnew)
            else
                CH3CL_LBCnew   = array_append_record(CH3CL_LBCi, CH3CL_LBC((/d1_e,d1_e,d1_e/),:), 0)
                delete(CH3CL_LBCi)
                CH3CL_LBCi     = CH3CL_LBCnew
                delete(CH3CL_LBCnew)
            end if
        end do
CH3CL_LBC_new=array_append_record(array_append_record(CH3CL_LBC1,CH3CL_LBCi,0),CH3CL_LBC2,0)
delete([/CH3CL_LBC1, CH3CL_LBC2, CH3CL_LBCi, CH3CL_LBC/])

H2_LBC1=H2_LBC(d1_s:d1_e,:)
H2_LBC2=H2_LBC(d2_s:d2_e,:)
H2_LBCi=H2_LBC((/d1_e,d1_e,d1_e/),:) 
        do comi      = 1,weeknum-1
            if comi.eq.4
                H2_LBCnew   = array_append_record(H2_LBCi, H2_LBC((/d1_e,d1_e/),:), 0)
                delete(H2_LBCi)
                H2_LBCi     = H2_LBCnew
                delete(H2_LBCnew)
            else
                H2_LBCnew   = array_append_record(H2_LBCi, H2_LBC((/d1_e,d1_e,d1_e/),:), 0)
                delete(H2_LBCi)
                H2_LBCi     = H2_LBCnew
                delete(H2_LBCnew)
            end if
        end do
H2_LBC_new=array_append_record(array_append_record(H2_LBC1,H2_LBCi,0),H2_LBC2,0)
delete([/H2_LBC1, H2_LBC2, H2_LBCi, H2_LBC/])

HCFC22_LBC_mean1=HCFC22_LBC_mean(d1_s:d1_e)
HCFC22_LBC_mean2=HCFC22_LBC_mean(d2_s:d2_e)
HCFC22_LBC_meani=new(weeknum*3-1,float)
HCFC22_LBC_meani=HCFC22_LBC_mean(d1_e) 
HCFC22_LBC_mean_new=array_append_record(array_append_record(HCFC22_LBC_mean1,HCFC22_LBC_meani,0),HCFC22_LBC_mean2,0)
delete([/HCFC22_LBC_mean1, HCFC22_LBC_mean2, HCFC22_LBC_meani, HCFC22_LBC_mean/])
HCFC22_LBC1=HCFC22_LBC(d1_s:d1_e,:)
HCFC22_LBC2=HCFC22_LBC(d2_s:d2_e,:)
HCFC22_LBCi=HCFC22_LBC((/d1_e,d1_e,d1_e/),:) 
        do comi      = 1,weeknum-1
            if comi.eq.4
                HCFC22_LBCnew   = array_append_record(HCFC22_LBCi, HCFC22_LBC((/d1_e,d1_e/),:), 0)
                delete(HCFC22_LBCi)
                HCFC22_LBCi     = HCFC22_LBCnew
                delete(HCFC22_LBCnew)
            else
                HCFC22_LBCnew   = array_append_record(HCFC22_LBCi, HCFC22_LBC((/d1_e,d1_e,d1_e/),:), 0)
                delete(HCFC22_LBCi)
                HCFC22_LBCi     = HCFC22_LBCnew
                delete(HCFC22_LBCnew)
            end if
        end do
HCFC22_LBC_new=array_append_record(array_append_record(HCFC22_LBC1,HCFC22_LBCi,0),HCFC22_LBC2,0)
delete([/HCFC22_LBC1, HCFC22_LBC2, HCFC22_LBCi, HCFC22_LBC/])

CFC114_LBC1=CFC114_LBC(d1_s:d1_e,:)
CFC114_LBC2=CFC114_LBC(d2_s:d2_e,:)
CFC114_LBCi=CFC114_LBC((/d1_e,d1_e,d1_e/),:) 
        do comi      = 1,weeknum-1
            if comi.eq.4
                CFC114_LBCnew   = array_append_record(CFC114_LBCi, CFC114_LBC((/d1_e,d1_e/),:), 0)
                delete(CFC114_LBCi)
                CFC114_LBCi     = CFC114_LBCnew
                delete(CFC114_LBCnew)
            else
                CFC114_LBCnew   = array_append_record(CFC114_LBCi, CFC114_LBC((/d1_e,d1_e,d1_e/),:), 0)
                delete(CFC114_LBCi)
                CFC114_LBCi     = CFC114_LBCnew
                delete(CFC114_LBCnew)
            end if
        end do
CFC114_LBC_new=array_append_record(array_append_record(CFC114_LBC1,CFC114_LBCi,0),CFC114_LBC2,0)
delete([/CFC114_LBC1, CFC114_LBC2, CFC114_LBCi, CFC114_LBC/])

CFC115_LBC1=CFC115_LBC(d1_s:d1_e,:)
CFC115_LBC2=CFC115_LBC(d2_s:d2_e,:)
CFC115_LBCi=CFC115_LBC((/d1_e,d1_e,d1_e/),:) 
        do comi      = 1,weeknum-1
            if comi.eq.4
                CFC115_LBCnew   = array_append_record(CFC115_LBCi, CFC115_LBC((/d1_e,d1_e/),:), 0)
                delete(CFC115_LBCi)
                CFC115_LBCi     = CFC115_LBCnew
                delete(CFC115_LBCnew)
            else
                CFC115_LBCnew   = array_append_record(CFC115_LBCi, CFC115_LBC((/d1_e,d1_e,d1_e/),:), 0)
                delete(CFC115_LBCi)
                CFC115_LBCi     = CFC115_LBCnew
                delete(CFC115_LBCnew)
            end if
        end do
CFC115_LBC_new=array_append_record(array_append_record(CFC115_LBC1,CFC115_LBCi,0),CFC115_LBC2,0)
delete([/CFC115_LBC1, CFC115_LBC2, CFC115_LBCi, CFC115_LBC/])

HCFC141B_LBC_mean1=HCFC141B_LBC_mean(d1_s:d1_e)
HCFC141B_LBC_mean2=HCFC141B_LBC_mean(d2_s:d2_e)
HCFC141B_LBC_meani=new(weeknum*3-1,float)
HCFC141B_LBC_meani=HCFC141B_LBC_mean(d1_e) 
HCFC141B_LBC_mean_new=array_append_record(array_append_record(HCFC141B_LBC_mean1,HCFC141B_LBC_meani,0),HCFC141B_LBC_mean2,0)
delete([/HCFC141B_LBC_mean1, HCFC141B_LBC_mean2, HCFC141B_LBC_meani, HCFC141B_LBC_mean/])
HCFC141B_LBC1=HCFC141B_LBC(d1_s:d1_e,:)
HCFC141B_LBC2=HCFC141B_LBC(d2_s:d2_e,:)
HCFC141B_LBCi=HCFC141B_LBC((/d1_e,d1_e,d1_e/),:) 
        do comi      = 1,weeknum-1
            if comi.eq.4
                HCFC141B_LBCnew   = array_append_record(HCFC141B_LBCi, HCFC141B_LBC((/d1_e,d1_e/),:), 0)
                delete(HCFC141B_LBCi)
                HCFC141B_LBCi     = HCFC141B_LBCnew
                delete(HCFC141B_LBCnew)
            else
                HCFC141B_LBCnew   = array_append_record(HCFC141B_LBCi, HCFC141B_LBC((/d1_e,d1_e,d1_e/),:), 0)
                delete(HCFC141B_LBCi)
                HCFC141B_LBCi     = HCFC141B_LBCnew
                delete(HCFC141B_LBCnew)
            end if
        end do
HCFC141B_LBC_new=array_append_record(array_append_record(HCFC141B_LBC1,HCFC141B_LBCi,0),HCFC141B_LBC2,0)
delete([/HCFC141B_LBC1, HCFC141B_LBC2, HCFC141B_LBCi, HCFC141B_LBC/])

HCFC142B_LBC_mean1=HCFC142B_LBC_mean(d1_s:d1_e)
HCFC142B_LBC_mean2=HCFC142B_LBC_mean(d2_s:d2_e)
HCFC142B_LBC_meani=new(weeknum*3-1,float)
HCFC142B_LBC_meani=HCFC142B_LBC_mean(d1_e) 
HCFC142B_LBC_mean_new=array_append_record(array_append_record(HCFC142B_LBC_mean1,HCFC142B_LBC_meani,0),HCFC142B_LBC_mean2,0)
delete([/HCFC142B_LBC_mean1, HCFC142B_LBC_mean2, HCFC142B_LBC_meani, HCFC142B_LBC_mean/])
HCFC142B_LBC1=HCFC142B_LBC(d1_s:d1_e,:)
HCFC142B_LBC2=HCFC142B_LBC(d2_s:d2_e,:)
HCFC142B_LBCi=HCFC142B_LBC((/d1_e,d1_e,d1_e/),:) 
        do comi      = 1,weeknum-1
            if comi.eq.4
                HCFC142B_LBCnew   = array_append_record(HCFC142B_LBCi, HCFC142B_LBC((/d1_e,d1_e/),:), 0)
                delete(HCFC142B_LBCi)
                HCFC142B_LBCi     = HCFC142B_LBCnew
                delete(HCFC142B_LBCnew)
            else
                HCFC142B_LBCnew   = array_append_record(HCFC142B_LBCi, HCFC142B_LBC((/d1_e,d1_e,d1_e/),:), 0)
                delete(HCFC142B_LBCi)
                HCFC142B_LBCi     = HCFC142B_LBCnew
                delete(HCFC142B_LBCnew)
            end if
        end do
HCFC142B_LBC_new=array_append_record(array_append_record(HCFC142B_LBC1,HCFC142B_LBCi,0),HCFC142B_LBC2,0)
delete([/HCFC142B_LBC1, HCFC142B_LBC2, HCFC142B_LBCi, HCFC142B_LBC/])

CH2BR2_LBC1=CH2BR2_LBC(d1_s:d1_e,:)
CH2BR2_LBC2=CH2BR2_LBC(d2_s:d2_e,:)
CH2BR2_LBCi=CH2BR2_LBC((/d1_e,d1_e,d1_e/),:) 
        do comi      = 1,weeknum-1
            if comi.eq.4
                CH2BR2_LBCnew   = array_append_record(CH2BR2_LBCi, CH2BR2_LBC((/d1_e,d1_e/),:), 0)
                delete(CH2BR2_LBCi)
                CH2BR2_LBCi     = CH2BR2_LBCnew
                delete(CH2BR2_LBCnew)
            else
                CH2BR2_LBCnew   = array_append_record(CH2BR2_LBCi, CH2BR2_LBC((/d1_e,d1_e,d1_e/),:), 0)
                delete(CH2BR2_LBCi)
                CH2BR2_LBCi     = CH2BR2_LBCnew
                delete(CH2BR2_LBCnew)
            end if
        end do
CH2BR2_LBC_new=array_append_record(array_append_record(CH2BR2_LBC1,CH2BR2_LBCi,0),CH2BR2_LBC2,0)
delete([/CH2BR2_LBC1, CH2BR2_LBC2, CH2BR2_LBCi, CH2BR2_LBC/])

CHBR3_LBC1=CHBR3_LBC(d1_s:d1_e,:)
CHBR3_LBC2=CHBR3_LBC(d2_s:d2_e,:)
CHBR3_LBCi=CHBR3_LBC((/d1_e,d1_e,d1_e/),:) 
        do comi      = 1,weeknum-1
            if comi.eq.4
                CHBR3_LBCnew   = array_append_record(CHBR3_LBCi, CHBR3_LBC((/d1_e,d1_e/),:), 0)
                delete(CHBR3_LBCi)
                CHBR3_LBCi     = CHBR3_LBCnew
                delete(CHBR3_LBCnew)
            else
                CHBR3_LBCnew   = array_append_record(CHBR3_LBCi, CHBR3_LBC((/d1_e,d1_e,d1_e/),:), 0)
                delete(CHBR3_LBCi)
                CHBR3_LBCi     = CHBR3_LBCnew
                delete(CHBR3_LBCnew)
            end if
        end do
CHBR3_LBC_new=array_append_record(array_append_record(CHBR3_LBC1,CHBR3_LBCi,0),CHBR3_LBC2,0)
delete([/CHBR3_LBC1, CHBR3_LBC2, CHBR3_LBCi, CHBR3_LBC/])

H1202_LBC1=H1202_LBC(d1_s:d1_e,:)
H1202_LBC2=H1202_LBC(d2_s:d2_e,:)
H1202_LBCi=H1202_LBC((/d1_e,d1_e,d1_e/),:) 
        do comi      = 1,weeknum-1
            if comi.eq.4
                H1202_LBCnew   = array_append_record(H1202_LBCi, H1202_LBC((/d1_e,d1_e/),:), 0)
                delete(H1202_LBCi)
                H1202_LBCi     = H1202_LBCnew
                delete(H1202_LBCnew)
            else
                H1202_LBCnew   = array_append_record(H1202_LBCi, H1202_LBC((/d1_e,d1_e,d1_e/),:), 0)
                delete(H1202_LBCi)
                H1202_LBCi     = H1202_LBCnew
                delete(H1202_LBCnew)
            end if
        end do
H1202_LBC_new=array_append_record(array_append_record(H1202_LBC1,H1202_LBCi,0),H1202_LBC2,0)
delete([/H1202_LBC1, H1202_LBC2, H1202_LBCi, H1202_LBC/])

H2402_LBC1=H2402_LBC(d1_s:d1_e,:)
H2402_LBC2=H2402_LBC(d2_s:d2_e,:)
H2402_LBCi=H2402_LBC((/d1_e,d1_e,d1_e/),:) 
        do comi      = 1,weeknum-1
            if comi.eq.4
                H2402_LBCnew   = array_append_record(H2402_LBCi, H2402_LBC((/d1_e,d1_e/),:), 0)
                delete(H2402_LBCi)
                H2402_LBCi     = H2402_LBCnew
                delete(H2402_LBCnew)
            else
                H2402_LBCnew   = array_append_record(H2402_LBCi, H2402_LBC((/d1_e,d1_e,d1_e/),:), 0)
                delete(H2402_LBCi)
                H2402_LBCi     = H2402_LBCnew
                delete(H2402_LBCnew)
            end if
        end do
H2402_LBC_new=array_append_record(array_append_record(H2402_LBC1,H2402_LBCi,0),H2402_LBC2,0)
delete([/H2402_LBC1, H2402_LBC2, H2402_LBCi, H2402_LBC/])

OCS_LBC1=OCS_LBC(d1_s:d1_e,:)
OCS_LBC2=OCS_LBC(d2_s:d2_e,:)
OCS_LBCi=OCS_LBC((/d1_e,d1_e,d1_e/),:) 
        do comi      = 1,weeknum-1
            if comi.eq.4
                OCS_LBCnew   = array_append_record(OCS_LBCi, OCS_LBC((/d1_e,d1_e/),:), 0)
                delete(OCS_LBCi)
                OCS_LBCi     = OCS_LBCnew
                delete(OCS_LBCnew)
            else
                OCS_LBCnew   = array_append_record(OCS_LBCi, OCS_LBC((/d1_e,d1_e,d1_e/),:), 0)
                delete(OCS_LBCi)
                OCS_LBCi     = OCS_LBCnew
                delete(OCS_LBCnew)
            end if
        end do
OCS_LBC_new=array_append_record(array_append_record(OCS_LBC1,OCS_LBCi,0),OCS_LBC2,0)
delete([/OCS_LBC1, OCS_LBC2, OCS_LBCi, OCS_LBC/])

CFCL3_LBC1=CFCL3_LBC(d1_s:d1_e,:)
CFCL3_LBC2=CFCL3_LBC(d2_s:d2_e,:)
CFCL3_LBCi=CFCL3_LBC((/d1_e,d1_e,d1_e/),:) 
        do comi      = 1,weeknum-1
            if comi.eq.4
                CFCL3_LBCnew   = array_append_record(CFCL3_LBCi, CFCL3_LBC((/d1_e,d1_e/),:), 0)
                delete(CFCL3_LBCi)
                CFCL3_LBCi     = CFCL3_LBCnew
                delete(CFCL3_LBCnew)
            else
                CFCL3_LBCnew   = array_append_record(CFCL3_LBCi, CFCL3_LBC((/d1_e,d1_e,d1_e/),:), 0)
                delete(CFCL3_LBCi)
                CFCL3_LBCi     = CFCL3_LBCnew
                delete(CFCL3_LBCnew)
            end if
        end do
CFCL3_LBC_new=array_append_record(array_append_record(CFCL3_LBC1,CFCL3_LBCi,0),CFCL3_LBC2,0)
delete([/CFCL3_LBC1, CFCL3_LBC2, CFCL3_LBCi, CFCL3_LBC/])

CF2CL2_LBC1=CF2CL2_LBC(d1_s:d1_e,:)
CF2CL2_LBC2=CF2CL2_LBC(d2_s:d2_e,:)
CF2CL2_LBCi=CF2CL2_LBC((/d1_e,d1_e,d1_e/),:) 
        do comi      = 1,weeknum-1
            if comi.eq.4
                CF2CL2_LBCnew   = array_append_record(CF2CL2_LBCi, CF2CL2_LBC((/d1_e,d1_e/),:), 0)
                delete(CF2CL2_LBCi)
                CF2CL2_LBCi     = CF2CL2_LBCnew
                delete(CF2CL2_LBCnew)
            else
                CF2CL2_LBCnew   = array_append_record(CF2CL2_LBCi, CF2CL2_LBC((/d1_e,d1_e,d1_e/),:), 0)
                delete(CF2CL2_LBCi)
                CF2CL2_LBCi     = CF2CL2_LBCnew
                delete(CF2CL2_LBCnew)
            end if
        end do
CF2CL2_LBC_new=array_append_record(array_append_record(CF2CL2_LBC1,CF2CL2_LBCi,0),CF2CL2_LBC2,0)
delete([/CF2CL2_LBC1, CF2CL2_LBC2, CF2CL2_LBCi, CF2CL2_LBC/])

TOT_CLOY1=TOT_CLOY(d1_s:d1_e,:)
TOT_CLOY2=TOT_CLOY(d2_s:d2_e,:)
TOT_CLOYi=TOT_CLOY((/d1_e,d1_e,d1_e/),:) 
        do comi      = 1,weeknum-1
            if comi.eq.4
                TOT_CLOYnew   = array_append_record(TOT_CLOYi, TOT_CLOY((/d1_e,d1_e/),:), 0)
                delete(TOT_CLOYi)
                TOT_CLOYi     = TOT_CLOYnew
                delete(TOT_CLOYnew)
            else
                TOT_CLOYnew   = array_append_record(TOT_CLOYi, TOT_CLOY((/d1_e,d1_e,d1_e/),:), 0)
                delete(TOT_CLOYi)
                TOT_CLOYi     = TOT_CLOYnew
                delete(TOT_CLOYnew)
            end if
        end do
TOT_CLOY_new=array_append_record(array_append_record(TOT_CLOY1,TOT_CLOYi,0),TOT_CLOY2,0)
delete([/TOT_CLOY1, TOT_CLOY2, TOT_CLOYi, TOT_CLOY/])

TOT_BROY1=TOT_BROY(d1_s:d1_e,:)
TOT_BROY2=TOT_BROY(d2_s:d2_e,:)
TOT_BROYi=TOT_BROY((/d1_e,d1_e,d1_e/),:) 
        do comi      = 1,weeknum-1
            if comi.eq.4
                TOT_BROYnew   = array_append_record(TOT_BROYi, TOT_BROY((/d1_e,d1_e/),:), 0)
                delete(TOT_BROYi)
                TOT_BROYi     = TOT_BROYnew
                delete(TOT_BROYnew)
            else
                TOT_BROYnew   = array_append_record(TOT_BROYi, TOT_BROY((/d1_e,d1_e,d1_e/),:), 0)
                delete(TOT_BROYi)
                TOT_BROYi     = TOT_BROYnew
                delete(TOT_BROYnew)
            end if
        end do
TOT_BROY_new=array_append_record(array_append_record(TOT_BROY1,TOT_BROYi,0),TOT_BROY2,0)
delete([/TOT_BROY1, TOT_BROY2, TOT_BROYi, TOT_BROY/])

TOT_FOY1=TOT_FOY(d1_s:d1_e,:)
TOT_FOY2=TOT_FOY(d2_s:d2_e,:)
TOT_FOYi=TOT_FOY((/d1_e,d1_e,d1_e/),:) 
        do comi      = 1,weeknum-1
            if comi.eq.4
                TOT_FOYnew   = array_append_record(TOT_FOYi, TOT_FOY((/d1_e,d1_e/),:), 0)
                delete(TOT_FOYi)
                TOT_FOYi     = TOT_FOYnew
                delete(TOT_FOYnew)
            else
                TOT_FOYnew   = array_append_record(TOT_FOYi, TOT_FOY((/d1_e,d1_e,d1_e/),:), 0)
                delete(TOT_FOYi)
                TOT_FOYi     = TOT_FOYnew
                delete(TOT_FOYnew)
            end if
        end do
TOT_FOY_new=array_append_record(array_append_record(TOT_FOY1,TOT_FOYi,0),TOT_FOY2,0)
delete([/TOT_FOY1, TOT_FOY2, TOT_FOYi, TOT_FOY/])

SF6_LBC1=SF6_LBC(d1_s:d1_e,:)
SF6_LBC2=SF6_LBC(d2_s:d2_e,:)
SF6_LBCi=SF6_LBC((/d1_e,d1_e,d1_e/),:) 
        do comi      = 1,weeknum-1
            if comi.eq.4
                SF6_LBCnew   = array_append_record(SF6_LBCi, SF6_LBC((/d1_e,d1_e/),:), 0)
                delete(SF6_LBCi)
                SF6_LBCi     = SF6_LBCnew
                delete(SF6_LBCnew)
            else
                SF6_LBCnew   = array_append_record(SF6_LBCi, SF6_LBC((/d1_e,d1_e,d1_e/),:), 0)
                delete(SF6_LBCi)
                SF6_LBCi     = SF6_LBCnew
                delete(SF6_LBCnew)
            end if
        end do
SF6_LBC_new=array_append_record(array_append_record(SF6_LBC1,SF6_LBCi,0),SF6_LBC2,0)
delete([/SF6_LBC1, SF6_LBC2, SF6_LBCi, SF6_LBC/])

    date1=date(d1_s:d1_e)  ;  1975-01-01 to 1975-07-01
    time1=time(d1_s:d1_e)
    datei=(/date(d1_e)+di_p-1,date(d1_e)+di_p,date(d1_e)+di_p+1/)  
    timei=(/time(d1_e)+di_p-1,time(d1_e)+di_p,time(d1_e)+di_p+1/)

    date2=date(d2_s:d2_e)  ;  1975-08-01 to end
    time2=time(d2_s:d2_e)

    do weeks   = 1 , weeknum-1
        
        di_p = 2 + weeks*7
        if weeks.eq.4
            datenew  = array_append_record(datei,(/date(d1_e)+di_p-1,date(d1_e)+di_p/),0)
            timenew  = array_append_record(timei,(/time(d1_e)+di_p-1,time(d1_e)+di_p/),0)
            delete([/timei, datei/])
            datei    =  datenew
            timei    =  timenew
            delete([/datenew, timenew/])
        else 
            datenew  = array_append_record(datei,(/date(d1_e)+di_p-1,date(d1_e)+di_p,date(d1_e)+di_p+1/),0)
            timenew  = array_append_record(timei,(/time(d1_e)+di_p-1,time(d1_e)+di_p,time(d1_e)+di_p+1/),0)
            delete([/timei, datei/])
            datei    =  datenew
            timei    =  timenew
            delete([/datenew, timenew/])
         end if

    end do

    date_new=array_append_record(array_append_record(date1,datei,0),date2,0)
    time_new=array_append_record(array_append_record(time1,timei,0),time2,0) 
    delete([/date1, date2, datei, date/])
    delete([/time1, time2, timei, time/])
    ntime=dimsizes(time_new)
    fout->time=time_new
    fout->date=date_new
    fout->lat=lat
    fout->lon=lon

    tracer_num = (yyyy-1981)*10

    do tcnum = 1 , tracer_num
       vname = (/"T" + tcnum + "_LBC"/)
       var   = f1->$vname(0)$
       var1=var(d1_s:d1_e,:,:)
       var2=var(d2_s:d2_e,:,:)
       vari=var((/d1_e,d1_e,d1_e/),:,:) 
            do comi      = 1,weeknum-1
                if comi.eq.4
                    varnew   = array_append_record(vari, var((/d1_e,d1_e/),:,:), 0)
                    delete(vari)
                    vari     = varnew
                    delete(varnew)
                else
                    varnew   = array_append_record(vari, var((/d1_e,d1_e,d1_e/),:,:), 0)
                    delete(vari)
                    vari     = varnew
                    delete(varnew)
                end if
            end do
    var_new=array_append_record(array_append_record(var1,vari,0),var2,0)
    delete([/var1, var2, vari, var/])
    fout->$vname(0)$=var_new
    delete(var_new)
    end do
    
    do weeks = 1 , 5
    tcname= tracer_num + weeks
    vname = (/"T"+tcname+"_LBC"/)
    var= new((/ntime,nlat,nlon/),"float")
    var!0="time"
    var!1="lat"
    var!2="lon"
    var&time=time_new
    var&lat=lat
    var&lon=lon
        ; extend to longitude
    var(:,:,:)=0
    var@units="mol/mol"
    var@long_name="pulse tracer nh"

    itime=(yyyy-1975)*12+(yyyy-1981)*28 + 8 +(weeks-1)*3
    print(date_new(itime))
    var( itime, inlat, inlon) = 1.
    fout->$vname(0)$=var
    delete([/var, vname, tcname/])

    end do

fout->CO2_LBC_mean=CO2_LBC_mean_new
fout->CO2_LBC=CO2_LBC_new
fout->CH4_LBC_mean=CH4_LBC_mean_new
fout->CH4_LBC=CH4_LBC_new
fout->N2O_LBC=N2O_LBC_new
fout->CCL4_LBC=CCL4_LBC_new
fout->CF2CLBR_LBC=CF2CLBR_LBC_new
fout->CF3BR_LBC=CF3BR_LBC_new
fout->CFC113_LBC=CFC113_LBC_new
fout->CH3BR_LBC_mean=CH3BR_LBC_mean_new
fout->CH3BR_LBC=CH3BR_LBC_new
fout->CH3CCL3_LBC=CH3CCL3_LBC_new
fout->CH3CL_LBC=CH3CL_LBC_new
fout->H2_LBC=H2_LBC_new
fout->HCFC22_LBC_mean=HCFC22_LBC_mean_new
fout->HCFC22_LBC=HCFC22_LBC_new
fout->CFC114_LBC=CFC114_LBC_new
fout->CFC115_LBC=CFC115_LBC_new
fout->HCFC141B_LBC_mean=HCFC141B_LBC_mean_new
fout->HCFC141B_LBC=HCFC141B_LBC_new
fout->HCFC142B_LBC_mean=HCFC142B_LBC_mean_new
fout->HCFC142B_LBC=HCFC142B_LBC_new
fout->CH2BR2_LBC=CH2BR2_LBC_new
fout->CHBR3_LBC=CHBR3_LBC_new
fout->H1202_LBC=H1202_LBC_new
fout->H2402_LBC=H2402_LBC_new
fout->OCS_LBC=OCS_LBC_new
fout->CFCL3_LBC=CFCL3_LBC_new
fout->CF2CL2_LBC=CF2CL2_LBC_new
fout->TOT_CLOY=TOT_CLOY_new
fout->TOT_BROY=TOT_BROY_new
fout->TOT_FOY=TOT_FOY_new
fout->SF6_LBC=SF6_LBC_new

delete([/fileout, f1, date_new, time_new, d1_s, d1_e, d2_s, d2_e/])
delete([/ CO2_LBC_mean_new, CO2_LBC_new, CH4_LBC_mean_new, CH4_LBC_new/])
delete([/ N2O_LBC_new, CCL4_LBC_new, CF2CLBR_LBC_new, CF3BR_LBC_new /])
delete([/ CFC113_LBC_new, CH3BR_LBC_mean_new, CH3BR_LBC_new, CH3CCL3_LBC_new /])
delete([/ CH3CL_LBC_new, H2_LBC_new, HCFC22_LBC_mean_new, HCFC22_LBC_new /])
delete([/ CFC114_LBC_new, CFC115_LBC_new, HCFC141B_LBC_mean_new, HCFC141B_LBC_new /])
delete([/ HCFC142B_LBC_mean_new, HCFC142B_LBC_new, CH2BR2_LBC_new, CHBR3_LBC_new /])
delete([/ H1202_LBC_new, H2402_LBC_new, OCS_LBC_new, CFCL3_LBC_new /])
delete([/ CF2CL2_LBC_new, TOT_CLOY_new, TOT_BROY_new, TOT_FOY_new, SF6_LBC_new /])

dir = "/glade/scracth/xinyuew/"
filelb="LBC_1975_nh_pulse_c_"+yyyy+"07.nc"  ;  original (monthly) emission file
fileout="/glade/scracth/xinyuew/LBC_1975_nh_pulse_c_"+yyyy+"0708.nc"  ; create a surface emission on 1975-07-03 for example
f1=addfile(dir+filelb,"r")
fout=addfile(fileout,"c")
date=f1->date
time=f1->time
lat=f1->lat
lon=f1->lon
nlat=dimsizes(lat)
nlon=dimsizes(lon)
inlon=ind(lon.ge.0 .and. lon.le.360)
inlat=ind(lat.ge.0 .and. lat.le.90) ;Northern Hemisphere

d1_s=0  ; 1975-01-01
d1_e=(yyyy-1975)*12+(yyyy-1981)*28+d1_s+21  ;yyyy-08-01
print(date(d1_e))
di_p=2
d2_s=d1_e+1   ;(1975-09-01)
d2_e=dimsizes(date)-1  ; 2015-12-01
;;;;beginfrom
weeknum   = 5

CO2_LBC=f1->CO2_LBC 
CO2_LBC_mean=f1->CO2_LBC_mean
CH4_LBC=f1->CH4_LBC 
CH4_LBC_mean=f1->CH4_LBC_mean
N2O_LBC=f1->N2O_LBC

CCL4_LBC=f1->CCL4_LBC
CF2CLBR_LBC=f1->CF2CLBR_LBC
CF3BR_LBC=f1->CF3BR_LBC
CFC113_LBC=f1->CFC113_LBC
CH3BR_LBC=f1->CH3BR_LBC
CH3BR_LBC_mean=f1->CH3BR_LBC_mean

CH3CCL3_LBC=f1->CH3CCL3_LBC
CH3CL_LBC=f1->CH3CL_LBC
H2_LBC=f1->H2_LBC
HCFC22_LBC=f1->HCFC22_LBC
HCFC22_LBC_mean=f1->HCFC22_LBC_mean

CFC114_LBC=f1->CFC114_LBC
CFC115_LBC=f1->CFC115_LBC
HCFC141B_LBC=f1->HCFC141B_LBC
HCFC141B_LBC_mean=f1->HCFC141B_LBC_mean

HCFC142B_LBC=f1->HCFC142B_LBC
HCFC142B_LBC_mean=f1->HCFC142B_LBC_mean

CH2BR2_LBC=f1->CH2BR2_LBC
CHBR3_LBC=f1->CHBR3_LBC
H1202_LBC=f1->H1202_LBC
H2402_LBC=f1->H2402_LBC
OCS_LBC=f1->OCS_LBC

CFCL3_LBC=f1->CFCL3_LBC
CF2CL2_LBC=f1->CF2CL2_LBC
TOT_CLOY=f1->TOT_CLOY
TOT_BROY=f1->TOT_BROY
TOT_FOY=f1->TOT_FOY
SF6_LBC=f1->SF6_LBC

CO2_LBC_mean1=CO2_LBC_mean(d1_s:d1_e)
CO2_LBC_mean2=CO2_LBC_mean(d2_s:d2_e)
CO2_LBC_meani=new(weeknum*3-1,float)
CO2_LBC_meani=CO2_LBC_mean(d1_e) 
CO2_LBC_mean_new=array_append_record(array_append_record(CO2_LBC_mean1,CO2_LBC_meani,0),CO2_LBC_mean2,0)
delete([/CO2_LBC_mean1, CO2_LBC_mean2, CO2_LBC_meani, CO2_LBC_mean/])
CO2_LBC1=CO2_LBC(d1_s:d1_e,:)
CO2_LBC2=CO2_LBC(d2_s:d2_e,:)
CO2_LBCi=CO2_LBC((/d1_e,d1_e,d1_e/),:) 
        do comi      = 1,weeknum-1
            if comi.eq.4
                CO2_LBCnew   = array_append_record(CO2_LBCi, CO2_LBC((/d1_e,d1_e/),:), 0)
                delete(CO2_LBCi)
                CO2_LBCi     = CO2_LBCnew
                delete(CO2_LBCnew)
            else
                CO2_LBCnew   = array_append_record(CO2_LBCi, CO2_LBC((/d1_e,d1_e,d1_e/),:), 0)
                delete(CO2_LBCi)
                CO2_LBCi     = CO2_LBCnew
                delete(CO2_LBCnew)
            end if
        end do
CO2_LBC_new=array_append_record(array_append_record(CO2_LBC1,CO2_LBCi,0),CO2_LBC2,0)
delete([/CO2_LBC1, CO2_LBC2, CO2_LBCi, CO2_LBC/])

CH4_LBC_mean1=CH4_LBC_mean(d1_s:d1_e)
CH4_LBC_mean2=CH4_LBC_mean(d2_s:d2_e)
CH4_LBC_meani=new(weeknum*3-1,float)
CH4_LBC_meani=CH4_LBC_mean(d1_e) 
CH4_LBC_mean_new=array_append_record(array_append_record(CH4_LBC_mean1,CH4_LBC_meani,0),CH4_LBC_mean2,0)
delete([/CH4_LBC_mean1, CH4_LBC_mean2, CH4_LBC_meani, CH4_LBC_mean/])
CH4_LBC1=CH4_LBC(d1_s:d1_e,:)
CH4_LBC2=CH4_LBC(d2_s:d2_e,:)
CH4_LBCi=CH4_LBC((/d1_e,d1_e,d1_e/),:) 
        do comi      = 1,weeknum-1
            if comi.eq.4
                CH4_LBCnew   = array_append_record(CH4_LBCi, CH4_LBC((/d1_e,d1_e/),:), 0)
                delete(CH4_LBCi)
                CH4_LBCi     = CH4_LBCnew
                delete(CH4_LBCnew)
            else
                CH4_LBCnew   = array_append_record(CH4_LBCi, CH4_LBC((/d1_e,d1_e,d1_e/),:), 0)
                delete(CH4_LBCi)
                CH4_LBCi     = CH4_LBCnew
                delete(CH4_LBCnew)
            end if
        end do
CH4_LBC_new=array_append_record(array_append_record(CH4_LBC1,CH4_LBCi,0),CH4_LBC2,0)
delete([/CH4_LBC1, CH4_LBC2, CH4_LBCi, CH4_LBC/])

N2O_LBC1=N2O_LBC(d1_s:d1_e,:)
N2O_LBC2=N2O_LBC(d2_s:d2_e,:)
N2O_LBCi=N2O_LBC((/d1_e,d1_e,d1_e/),:) 
        do comi      = 1,weeknum-1
            if comi.eq.4
                N2O_LBCnew   = array_append_record(N2O_LBCi, N2O_LBC((/d1_e,d1_e/),:), 0)
                delete(N2O_LBCi)
                N2O_LBCi     = N2O_LBCnew
                delete(N2O_LBCnew)
            else
                N2O_LBCnew   = array_append_record(N2O_LBCi, N2O_LBC((/d1_e,d1_e,d1_e/),:), 0)
                delete(N2O_LBCi)
                N2O_LBCi     = N2O_LBCnew
                delete(N2O_LBCnew)
            end if
        end do
N2O_LBC_new=array_append_record(array_append_record(N2O_LBC1,N2O_LBCi,0),N2O_LBC2,0)
delete([/N2O_LBC1, N2O_LBC2, N2O_LBCi, N2O_LBC/])

CCL4_LBC1=CCL4_LBC(d1_s:d1_e,:)
CCL4_LBC2=CCL4_LBC(d2_s:d2_e,:)
CCL4_LBCi=CCL4_LBC((/d1_e,d1_e,d1_e/),:) 
        do comi      = 1,weeknum-1
            if comi.eq.4
                CCL4_LBCnew   = array_append_record(CCL4_LBCi, CCL4_LBC((/d1_e,d1_e/),:), 0)
                delete(CCL4_LBCi)
                CCL4_LBCi     = CCL4_LBCnew
                delete(CCL4_LBCnew)
            else
                CCL4_LBCnew   = array_append_record(CCL4_LBCi, CCL4_LBC((/d1_e,d1_e,d1_e/),:), 0)
                delete(CCL4_LBCi)
                CCL4_LBCi     = CCL4_LBCnew
                delete(CCL4_LBCnew)
            end if
        end do
CCL4_LBC_new=array_append_record(array_append_record(CCL4_LBC1,CCL4_LBCi,0),CCL4_LBC2,0)
delete([/CCL4_LBC1, CCL4_LBC2, CCL4_LBCi, CCL4_LBC/])

CF2CLBR_LBC1=CF2CLBR_LBC(d1_s:d1_e,:)
CF2CLBR_LBC2=CF2CLBR_LBC(d2_s:d2_e,:)
CF2CLBR_LBCi=CF2CLBR_LBC((/d1_e,d1_e,d1_e/),:) 
        do comi      = 1,weeknum-1
            if comi.eq.4
                CF2CLBR_LBCnew   = array_append_record(CF2CLBR_LBCi, CF2CLBR_LBC((/d1_e,d1_e/),:), 0)
                delete(CF2CLBR_LBCi)
                CF2CLBR_LBCi     = CF2CLBR_LBCnew
                delete(CF2CLBR_LBCnew)
            else
                CF2CLBR_LBCnew   = array_append_record(CF2CLBR_LBCi, CF2CLBR_LBC((/d1_e,d1_e,d1_e/),:), 0)
                delete(CF2CLBR_LBCi)
                CF2CLBR_LBCi     = CF2CLBR_LBCnew
                delete(CF2CLBR_LBCnew)
            end if
        end do
CF2CLBR_LBC_new=array_append_record(array_append_record(CF2CLBR_LBC1,CF2CLBR_LBCi,0),CF2CLBR_LBC2,0)
delete([/CF2CLBR_LBC1, CF2CLBR_LBC2, CF2CLBR_LBCi, CF2CLBR_LBC/])

CF3BR_LBC1=CF3BR_LBC(d1_s:d1_e,:)
CF3BR_LBC2=CF3BR_LBC(d2_s:d2_e,:)
CF3BR_LBCi=CF3BR_LBC((/d1_e,d1_e,d1_e/),:) 
        do comi      = 1,weeknum-1
            if comi.eq.4
                CF3BR_LBCnew   = array_append_record(CF3BR_LBCi, CF3BR_LBC((/d1_e,d1_e/),:), 0)
                delete(CF3BR_LBCi)
                CF3BR_LBCi     = CF3BR_LBCnew
                delete(CF3BR_LBCnew)
            else
                CF3BR_LBCnew   = array_append_record(CF3BR_LBCi, CF3BR_LBC((/d1_e,d1_e,d1_e/),:), 0)
                delete(CF3BR_LBCi)
                CF3BR_LBCi     = CF3BR_LBCnew
                delete(CF3BR_LBCnew)
            end if
        end do
CF3BR_LBC_new=array_append_record(array_append_record(CF3BR_LBC1,CF3BR_LBCi,0),CF3BR_LBC2,0)
delete([/CF3BR_LBC1, CF3BR_LBC2, CF3BR_LBCi, CF3BR_LBC/])

CFC113_LBC1=CFC113_LBC(d1_s:d1_e,:)
CFC113_LBC2=CFC113_LBC(d2_s:d2_e,:)
CFC113_LBCi=CFC113_LBC((/d1_e,d1_e,d1_e/),:) 
        do comi      = 1,weeknum-1
            if comi.eq.4
                CFC113_LBCnew   = array_append_record(CFC113_LBCi, CFC113_LBC((/d1_e,d1_e/),:), 0)
                delete(CFC113_LBCi)
                CFC113_LBCi     = CFC113_LBCnew
                delete(CFC113_LBCnew)
            else
                CFC113_LBCnew   = array_append_record(CFC113_LBCi, CFC113_LBC((/d1_e,d1_e,d1_e/),:), 0)
                delete(CFC113_LBCi)
                CFC113_LBCi     = CFC113_LBCnew
                delete(CFC113_LBCnew)
            end if
        end do
CFC113_LBC_new=array_append_record(array_append_record(CFC113_LBC1,CFC113_LBCi,0),CFC113_LBC2,0)
delete([/CFC113_LBC1, CFC113_LBC2, CFC113_LBCi, CFC113_LBC/])

CH3BR_LBC_mean1=CH3BR_LBC_mean(d1_s:d1_e)
CH3BR_LBC_mean2=CH3BR_LBC_mean(d2_s:d2_e)
CH3BR_LBC_meani=new(weeknum*3-1,float)
CH3BR_LBC_meani=CH3BR_LBC_mean(d1_e) 
CH3BR_LBC_mean_new=array_append_record(array_append_record(CH3BR_LBC_mean1,CH3BR_LBC_meani,0),CH3BR_LBC_mean2,0)
delete([/CH3BR_LBC_mean1, CH3BR_LBC_mean2, CH3BR_LBC_meani, CH3BR_LBC_mean/])
CH3BR_LBC1=CH3BR_LBC(d1_s:d1_e,:)
CH3BR_LBC2=CH3BR_LBC(d2_s:d2_e,:)
CH3BR_LBCi=CH3BR_LBC((/d1_e,d1_e,d1_e/),:) 
        do comi      = 1,weeknum-1
            if comi.eq.4
                CH3BR_LBCnew   = array_append_record(CH3BR_LBCi, CH3BR_LBC((/d1_e,d1_e/),:), 0)
                delete(CH3BR_LBCi)
                CH3BR_LBCi     = CH3BR_LBCnew
                delete(CH3BR_LBCnew)
            else
                CH3BR_LBCnew   = array_append_record(CH3BR_LBCi, CH3BR_LBC((/d1_e,d1_e,d1_e/),:), 0)
                delete(CH3BR_LBCi)
                CH3BR_LBCi     = CH3BR_LBCnew
                delete(CH3BR_LBCnew)
            end if
        end do
CH3BR_LBC_new=array_append_record(array_append_record(CH3BR_LBC1,CH3BR_LBCi,0),CH3BR_LBC2,0)
delete([/CH3BR_LBC1, CH3BR_LBC2, CH3BR_LBCi, CH3BR_LBC/])

CH3CCL3_LBC1=CH3CCL3_LBC(d1_s:d1_e,:)
CH3CCL3_LBC2=CH3CCL3_LBC(d2_s:d2_e,:)
CH3CCL3_LBCi=CH3CCL3_LBC((/d1_e,d1_e,d1_e/),:) 
        do comi      = 1,weeknum-1
            if comi.eq.4
                CH3CCL3_LBCnew   = array_append_record(CH3CCL3_LBCi, CH3CCL3_LBC((/d1_e,d1_e/),:), 0)
                delete(CH3CCL3_LBCi)
                CH3CCL3_LBCi     = CH3CCL3_LBCnew
                delete(CH3CCL3_LBCnew)
            else
                CH3CCL3_LBCnew   = array_append_record(CH3CCL3_LBCi, CH3CCL3_LBC((/d1_e,d1_e,d1_e/),:), 0)
                delete(CH3CCL3_LBCi)
                CH3CCL3_LBCi     = CH3CCL3_LBCnew
                delete(CH3CCL3_LBCnew)
            end if
        end do
CH3CCL3_LBC_new=array_append_record(array_append_record(CH3CCL3_LBC1,CH3CCL3_LBCi,0),CH3CCL3_LBC2,0)
delete([/CH3CCL3_LBC1, CH3CCL3_LBC2, CH3CCL3_LBCi, CH3CCL3_LBC/])

CH3CL_LBC1=CH3CL_LBC(d1_s:d1_e,:)
CH3CL_LBC2=CH3CL_LBC(d2_s:d2_e,:)
CH3CL_LBCi=CH3CL_LBC((/d1_e,d1_e,d1_e/),:) 
        do comi      = 1,weeknum-1
            if comi.eq.4
                CH3CL_LBCnew   = array_append_record(CH3CL_LBCi, CH3CL_LBC((/d1_e,d1_e/),:), 0)
                delete(CH3CL_LBCi)
                CH3CL_LBCi     = CH3CL_LBCnew
                delete(CH3CL_LBCnew)
            else
                CH3CL_LBCnew   = array_append_record(CH3CL_LBCi, CH3CL_LBC((/d1_e,d1_e,d1_e/),:), 0)
                delete(CH3CL_LBCi)
                CH3CL_LBCi     = CH3CL_LBCnew
                delete(CH3CL_LBCnew)
            end if
        end do
CH3CL_LBC_new=array_append_record(array_append_record(CH3CL_LBC1,CH3CL_LBCi,0),CH3CL_LBC2,0)
delete([/CH3CL_LBC1, CH3CL_LBC2, CH3CL_LBCi, CH3CL_LBC/])

H2_LBC1=H2_LBC(d1_s:d1_e,:)
H2_LBC2=H2_LBC(d2_s:d2_e,:)
H2_LBCi=H2_LBC((/d1_e,d1_e,d1_e/),:) 
        do comi      = 1,weeknum-1
            if comi.eq.4
                H2_LBCnew   = array_append_record(H2_LBCi, H2_LBC((/d1_e,d1_e/),:), 0)
                delete(H2_LBCi)
                H2_LBCi     = H2_LBCnew
                delete(H2_LBCnew)
            else
                H2_LBCnew   = array_append_record(H2_LBCi, H2_LBC((/d1_e,d1_e,d1_e/),:), 0)
                delete(H2_LBCi)
                H2_LBCi     = H2_LBCnew
                delete(H2_LBCnew)
            end if
        end do
H2_LBC_new=array_append_record(array_append_record(H2_LBC1,H2_LBCi,0),H2_LBC2,0)
delete([/H2_LBC1, H2_LBC2, H2_LBCi, H2_LBC/])

HCFC22_LBC_mean1=HCFC22_LBC_mean(d1_s:d1_e)
HCFC22_LBC_mean2=HCFC22_LBC_mean(d2_s:d2_e)
HCFC22_LBC_meani=new(weeknum*3-1,float)
HCFC22_LBC_meani=HCFC22_LBC_mean(d1_e) 
HCFC22_LBC_mean_new=array_append_record(array_append_record(HCFC22_LBC_mean1,HCFC22_LBC_meani,0),HCFC22_LBC_mean2,0)
delete([/HCFC22_LBC_mean1, HCFC22_LBC_mean2, HCFC22_LBC_meani, HCFC22_LBC_mean/])
HCFC22_LBC1=HCFC22_LBC(d1_s:d1_e,:)
HCFC22_LBC2=HCFC22_LBC(d2_s:d2_e,:)
HCFC22_LBCi=HCFC22_LBC((/d1_e,d1_e,d1_e/),:) 
        do comi      = 1,weeknum-1
            if comi.eq.4
                HCFC22_LBCnew   = array_append_record(HCFC22_LBCi, HCFC22_LBC((/d1_e,d1_e/),:), 0)
                delete(HCFC22_LBCi)
                HCFC22_LBCi     = HCFC22_LBCnew
                delete(HCFC22_LBCnew)
            else
                HCFC22_LBCnew   = array_append_record(HCFC22_LBCi, HCFC22_LBC((/d1_e,d1_e,d1_e/),:), 0)
                delete(HCFC22_LBCi)
                HCFC22_LBCi     = HCFC22_LBCnew
                delete(HCFC22_LBCnew)
            end if
        end do
HCFC22_LBC_new=array_append_record(array_append_record(HCFC22_LBC1,HCFC22_LBCi,0),HCFC22_LBC2,0)
delete([/HCFC22_LBC1, HCFC22_LBC2, HCFC22_LBCi, HCFC22_LBC/])

CFC114_LBC1=CFC114_LBC(d1_s:d1_e,:)
CFC114_LBC2=CFC114_LBC(d2_s:d2_e,:)
CFC114_LBCi=CFC114_LBC((/d1_e,d1_e,d1_e/),:) 
        do comi      = 1,weeknum-1
            if comi.eq.4
                CFC114_LBCnew   = array_append_record(CFC114_LBCi, CFC114_LBC((/d1_e,d1_e/),:), 0)
                delete(CFC114_LBCi)
                CFC114_LBCi     = CFC114_LBCnew
                delete(CFC114_LBCnew)
            else
                CFC114_LBCnew   = array_append_record(CFC114_LBCi, CFC114_LBC((/d1_e,d1_e,d1_e/),:), 0)
                delete(CFC114_LBCi)
                CFC114_LBCi     = CFC114_LBCnew
                delete(CFC114_LBCnew)
            end if
        end do
CFC114_LBC_new=array_append_record(array_append_record(CFC114_LBC1,CFC114_LBCi,0),CFC114_LBC2,0)
delete([/CFC114_LBC1, CFC114_LBC2, CFC114_LBCi, CFC114_LBC/])

CFC115_LBC1=CFC115_LBC(d1_s:d1_e,:)
CFC115_LBC2=CFC115_LBC(d2_s:d2_e,:)
CFC115_LBCi=CFC115_LBC((/d1_e,d1_e,d1_e/),:) 
        do comi      = 1,weeknum-1
            if comi.eq.4
                CFC115_LBCnew   = array_append_record(CFC115_LBCi, CFC115_LBC((/d1_e,d1_e/),:), 0)
                delete(CFC115_LBCi)
                CFC115_LBCi     = CFC115_LBCnew
                delete(CFC115_LBCnew)
            else
                CFC115_LBCnew   = array_append_record(CFC115_LBCi, CFC115_LBC((/d1_e,d1_e,d1_e/),:), 0)
                delete(CFC115_LBCi)
                CFC115_LBCi     = CFC115_LBCnew
                delete(CFC115_LBCnew)
            end if
        end do
CFC115_LBC_new=array_append_record(array_append_record(CFC115_LBC1,CFC115_LBCi,0),CFC115_LBC2,0)
delete([/CFC115_LBC1, CFC115_LBC2, CFC115_LBCi, CFC115_LBC/])

HCFC141B_LBC_mean1=HCFC141B_LBC_mean(d1_s:d1_e)
HCFC141B_LBC_mean2=HCFC141B_LBC_mean(d2_s:d2_e)
HCFC141B_LBC_meani=new(weeknum*3-1,float)
HCFC141B_LBC_meani=HCFC141B_LBC_mean(d1_e) 
HCFC141B_LBC_mean_new=array_append_record(array_append_record(HCFC141B_LBC_mean1,HCFC141B_LBC_meani,0),HCFC141B_LBC_mean2,0)
delete([/HCFC141B_LBC_mean1, HCFC141B_LBC_mean2, HCFC141B_LBC_meani, HCFC141B_LBC_mean/])
HCFC141B_LBC1=HCFC141B_LBC(d1_s:d1_e,:)
HCFC141B_LBC2=HCFC141B_LBC(d2_s:d2_e,:)
HCFC141B_LBCi=HCFC141B_LBC((/d1_e,d1_e,d1_e/),:) 
        do comi      = 1,weeknum-1
            if comi.eq.4
                HCFC141B_LBCnew   = array_append_record(HCFC141B_LBCi, HCFC141B_LBC((/d1_e,d1_e/),:), 0)
                delete(HCFC141B_LBCi)
                HCFC141B_LBCi     = HCFC141B_LBCnew
                delete(HCFC141B_LBCnew)
            else
                HCFC141B_LBCnew   = array_append_record(HCFC141B_LBCi, HCFC141B_LBC((/d1_e,d1_e,d1_e/),:), 0)
                delete(HCFC141B_LBCi)
                HCFC141B_LBCi     = HCFC141B_LBCnew
                delete(HCFC141B_LBCnew)
            end if
        end do
HCFC141B_LBC_new=array_append_record(array_append_record(HCFC141B_LBC1,HCFC141B_LBCi,0),HCFC141B_LBC2,0)
delete([/HCFC141B_LBC1, HCFC141B_LBC2, HCFC141B_LBCi, HCFC141B_LBC/])

HCFC142B_LBC_mean1=HCFC142B_LBC_mean(d1_s:d1_e)
HCFC142B_LBC_mean2=HCFC142B_LBC_mean(d2_s:d2_e)
HCFC142B_LBC_meani=new(weeknum*3-1,float)
HCFC142B_LBC_meani=HCFC142B_LBC_mean(d1_e) 
HCFC142B_LBC_mean_new=array_append_record(array_append_record(HCFC142B_LBC_mean1,HCFC142B_LBC_meani,0),HCFC142B_LBC_mean2,0)
delete([/HCFC142B_LBC_mean1, HCFC142B_LBC_mean2, HCFC142B_LBC_meani, HCFC142B_LBC_mean/])
HCFC142B_LBC1=HCFC142B_LBC(d1_s:d1_e,:)
HCFC142B_LBC2=HCFC142B_LBC(d2_s:d2_e,:)
HCFC142B_LBCi=HCFC142B_LBC((/d1_e,d1_e,d1_e/),:) 
        do comi      = 1,weeknum-1
            if comi.eq.4
                HCFC142B_LBCnew   = array_append_record(HCFC142B_LBCi, HCFC142B_LBC((/d1_e,d1_e/),:), 0)
                delete(HCFC142B_LBCi)
                HCFC142B_LBCi     = HCFC142B_LBCnew
                delete(HCFC142B_LBCnew)
            else
                HCFC142B_LBCnew   = array_append_record(HCFC142B_LBCi, HCFC142B_LBC((/d1_e,d1_e,d1_e/),:), 0)
                delete(HCFC142B_LBCi)
                HCFC142B_LBCi     = HCFC142B_LBCnew
                delete(HCFC142B_LBCnew)
            end if
        end do
HCFC142B_LBC_new=array_append_record(array_append_record(HCFC142B_LBC1,HCFC142B_LBCi,0),HCFC142B_LBC2,0)
delete([/HCFC142B_LBC1, HCFC142B_LBC2, HCFC142B_LBCi, HCFC142B_LBC/])

CH2BR2_LBC1=CH2BR2_LBC(d1_s:d1_e,:)
CH2BR2_LBC2=CH2BR2_LBC(d2_s:d2_e,:)
CH2BR2_LBCi=CH2BR2_LBC((/d1_e,d1_e,d1_e/),:) 
        do comi      = 1,weeknum-1
            if comi.eq.4
                CH2BR2_LBCnew   = array_append_record(CH2BR2_LBCi, CH2BR2_LBC((/d1_e,d1_e/),:), 0)
                delete(CH2BR2_LBCi)
                CH2BR2_LBCi     = CH2BR2_LBCnew
                delete(CH2BR2_LBCnew)
            else
                CH2BR2_LBCnew   = array_append_record(CH2BR2_LBCi, CH2BR2_LBC((/d1_e,d1_e,d1_e/),:), 0)
                delete(CH2BR2_LBCi)
                CH2BR2_LBCi     = CH2BR2_LBCnew
                delete(CH2BR2_LBCnew)
            end if
        end do
CH2BR2_LBC_new=array_append_record(array_append_record(CH2BR2_LBC1,CH2BR2_LBCi,0),CH2BR2_LBC2,0)
delete([/CH2BR2_LBC1, CH2BR2_LBC2, CH2BR2_LBCi, CH2BR2_LBC/])

CHBR3_LBC1=CHBR3_LBC(d1_s:d1_e,:)
CHBR3_LBC2=CHBR3_LBC(d2_s:d2_e,:)
CHBR3_LBCi=CHBR3_LBC((/d1_e,d1_e,d1_e/),:) 
        do comi      = 1,weeknum-1
            if comi.eq.4
                CHBR3_LBCnew   = array_append_record(CHBR3_LBCi, CHBR3_LBC((/d1_e,d1_e/),:), 0)
                delete(CHBR3_LBCi)
                CHBR3_LBCi     = CHBR3_LBCnew
                delete(CHBR3_LBCnew)
            else
                CHBR3_LBCnew   = array_append_record(CHBR3_LBCi, CHBR3_LBC((/d1_e,d1_e,d1_e/),:), 0)
                delete(CHBR3_LBCi)
                CHBR3_LBCi     = CHBR3_LBCnew
                delete(CHBR3_LBCnew)
            end if
        end do
CHBR3_LBC_new=array_append_record(array_append_record(CHBR3_LBC1,CHBR3_LBCi,0),CHBR3_LBC2,0)
delete([/CHBR3_LBC1, CHBR3_LBC2, CHBR3_LBCi, CHBR3_LBC/])

H1202_LBC1=H1202_LBC(d1_s:d1_e,:)
H1202_LBC2=H1202_LBC(d2_s:d2_e,:)
H1202_LBCi=H1202_LBC((/d1_e,d1_e,d1_e/),:) 
        do comi      = 1,weeknum-1
            if comi.eq.4
                H1202_LBCnew   = array_append_record(H1202_LBCi, H1202_LBC((/d1_e,d1_e/),:), 0)
                delete(H1202_LBCi)
                H1202_LBCi     = H1202_LBCnew
                delete(H1202_LBCnew)
            else
                H1202_LBCnew   = array_append_record(H1202_LBCi, H1202_LBC((/d1_e,d1_e,d1_e/),:), 0)
                delete(H1202_LBCi)
                H1202_LBCi     = H1202_LBCnew
                delete(H1202_LBCnew)
            end if
        end do
H1202_LBC_new=array_append_record(array_append_record(H1202_LBC1,H1202_LBCi,0),H1202_LBC2,0)
delete([/H1202_LBC1, H1202_LBC2, H1202_LBCi, H1202_LBC/])

H2402_LBC1=H2402_LBC(d1_s:d1_e,:)
H2402_LBC2=H2402_LBC(d2_s:d2_e,:)
H2402_LBCi=H2402_LBC((/d1_e,d1_e,d1_e/),:) 
        do comi      = 1,weeknum-1
            if comi.eq.4
                H2402_LBCnew   = array_append_record(H2402_LBCi, H2402_LBC((/d1_e,d1_e/),:), 0)
                delete(H2402_LBCi)
                H2402_LBCi     = H2402_LBCnew
                delete(H2402_LBCnew)
            else
                H2402_LBCnew   = array_append_record(H2402_LBCi, H2402_LBC((/d1_e,d1_e,d1_e/),:), 0)
                delete(H2402_LBCi)
                H2402_LBCi     = H2402_LBCnew
                delete(H2402_LBCnew)
            end if
        end do
H2402_LBC_new=array_append_record(array_append_record(H2402_LBC1,H2402_LBCi,0),H2402_LBC2,0)
delete([/H2402_LBC1, H2402_LBC2, H2402_LBCi, H2402_LBC/])

OCS_LBC1=OCS_LBC(d1_s:d1_e,:)
OCS_LBC2=OCS_LBC(d2_s:d2_e,:)
OCS_LBCi=OCS_LBC((/d1_e,d1_e,d1_e/),:) 
        do comi      = 1,weeknum-1
            if comi.eq.4
                OCS_LBCnew   = array_append_record(OCS_LBCi, OCS_LBC((/d1_e,d1_e/),:), 0)
                delete(OCS_LBCi)
                OCS_LBCi     = OCS_LBCnew
                delete(OCS_LBCnew)
            else
                OCS_LBCnew   = array_append_record(OCS_LBCi, OCS_LBC((/d1_e,d1_e,d1_e/),:), 0)
                delete(OCS_LBCi)
                OCS_LBCi     = OCS_LBCnew
                delete(OCS_LBCnew)
            end if
        end do
OCS_LBC_new=array_append_record(array_append_record(OCS_LBC1,OCS_LBCi,0),OCS_LBC2,0)
delete([/OCS_LBC1, OCS_LBC2, OCS_LBCi, OCS_LBC/])

CFCL3_LBC1=CFCL3_LBC(d1_s:d1_e,:)
CFCL3_LBC2=CFCL3_LBC(d2_s:d2_e,:)
CFCL3_LBCi=CFCL3_LBC((/d1_e,d1_e,d1_e/),:) 
        do comi      = 1,weeknum-1
            if comi.eq.4
                CFCL3_LBCnew   = array_append_record(CFCL3_LBCi, CFCL3_LBC((/d1_e,d1_e/),:), 0)
                delete(CFCL3_LBCi)
                CFCL3_LBCi     = CFCL3_LBCnew
                delete(CFCL3_LBCnew)
            else
                CFCL3_LBCnew   = array_append_record(CFCL3_LBCi, CFCL3_LBC((/d1_e,d1_e,d1_e/),:), 0)
                delete(CFCL3_LBCi)
                CFCL3_LBCi     = CFCL3_LBCnew
                delete(CFCL3_LBCnew)
            end if
        end do
CFCL3_LBC_new=array_append_record(array_append_record(CFCL3_LBC1,CFCL3_LBCi,0),CFCL3_LBC2,0)
delete([/CFCL3_LBC1, CFCL3_LBC2, CFCL3_LBCi, CFCL3_LBC/])

CF2CL2_LBC1=CF2CL2_LBC(d1_s:d1_e,:)
CF2CL2_LBC2=CF2CL2_LBC(d2_s:d2_e,:)
CF2CL2_LBCi=CF2CL2_LBC((/d1_e,d1_e,d1_e/),:) 
        do comi      = 1,weeknum-1
            if comi.eq.4
                CF2CL2_LBCnew   = array_append_record(CF2CL2_LBCi, CF2CL2_LBC((/d1_e,d1_e/),:), 0)
                delete(CF2CL2_LBCi)
                CF2CL2_LBCi     = CF2CL2_LBCnew
                delete(CF2CL2_LBCnew)
            else
                CF2CL2_LBCnew   = array_append_record(CF2CL2_LBCi, CF2CL2_LBC((/d1_e,d1_e,d1_e/),:), 0)
                delete(CF2CL2_LBCi)
                CF2CL2_LBCi     = CF2CL2_LBCnew
                delete(CF2CL2_LBCnew)
            end if
        end do
CF2CL2_LBC_new=array_append_record(array_append_record(CF2CL2_LBC1,CF2CL2_LBCi,0),CF2CL2_LBC2,0)
delete([/CF2CL2_LBC1, CF2CL2_LBC2, CF2CL2_LBCi, CF2CL2_LBC/])

TOT_CLOY1=TOT_CLOY(d1_s:d1_e,:)
TOT_CLOY2=TOT_CLOY(d2_s:d2_e,:)
TOT_CLOYi=TOT_CLOY((/d1_e,d1_e,d1_e/),:) 
        do comi      = 1,weeknum-1
            if comi.eq.4
                TOT_CLOYnew   = array_append_record(TOT_CLOYi, TOT_CLOY((/d1_e,d1_e/),:), 0)
                delete(TOT_CLOYi)
                TOT_CLOYi     = TOT_CLOYnew
                delete(TOT_CLOYnew)
            else
                TOT_CLOYnew   = array_append_record(TOT_CLOYi, TOT_CLOY((/d1_e,d1_e,d1_e/),:), 0)
                delete(TOT_CLOYi)
                TOT_CLOYi     = TOT_CLOYnew
                delete(TOT_CLOYnew)
            end if
        end do
TOT_CLOY_new=array_append_record(array_append_record(TOT_CLOY1,TOT_CLOYi,0),TOT_CLOY2,0)
delete([/TOT_CLOY1, TOT_CLOY2, TOT_CLOYi, TOT_CLOY/])

TOT_BROY1=TOT_BROY(d1_s:d1_e,:)
TOT_BROY2=TOT_BROY(d2_s:d2_e,:)
TOT_BROYi=TOT_BROY((/d1_e,d1_e,d1_e/),:) 
        do comi      = 1,weeknum-1
            if comi.eq.4
                TOT_BROYnew   = array_append_record(TOT_BROYi, TOT_BROY((/d1_e,d1_e/),:), 0)
                delete(TOT_BROYi)
                TOT_BROYi     = TOT_BROYnew
                delete(TOT_BROYnew)
            else
                TOT_BROYnew   = array_append_record(TOT_BROYi, TOT_BROY((/d1_e,d1_e,d1_e/),:), 0)
                delete(TOT_BROYi)
                TOT_BROYi     = TOT_BROYnew
                delete(TOT_BROYnew)
            end if
        end do
TOT_BROY_new=array_append_record(array_append_record(TOT_BROY1,TOT_BROYi,0),TOT_BROY2,0)
delete([/TOT_BROY1, TOT_BROY2, TOT_BROYi, TOT_BROY/])

TOT_FOY1=TOT_FOY(d1_s:d1_e,:)
TOT_FOY2=TOT_FOY(d2_s:d2_e,:)
TOT_FOYi=TOT_FOY((/d1_e,d1_e,d1_e/),:) 
        do comi      = 1,weeknum-1
            if comi.eq.4
                TOT_FOYnew   = array_append_record(TOT_FOYi, TOT_FOY((/d1_e,d1_e/),:), 0)
                delete(TOT_FOYi)
                TOT_FOYi     = TOT_FOYnew
                delete(TOT_FOYnew)
            else
                TOT_FOYnew   = array_append_record(TOT_FOYi, TOT_FOY((/d1_e,d1_e,d1_e/),:), 0)
                delete(TOT_FOYi)
                TOT_FOYi     = TOT_FOYnew
                delete(TOT_FOYnew)
            end if
        end do
TOT_FOY_new=array_append_record(array_append_record(TOT_FOY1,TOT_FOYi,0),TOT_FOY2,0)
delete([/TOT_FOY1, TOT_FOY2, TOT_FOYi, TOT_FOY/])

SF6_LBC1=SF6_LBC(d1_s:d1_e,:)
SF6_LBC2=SF6_LBC(d2_s:d2_e,:)
SF6_LBCi=SF6_LBC((/d1_e,d1_e,d1_e/),:) 
        do comi      = 1,weeknum-1
            if comi.eq.4
                SF6_LBCnew   = array_append_record(SF6_LBCi, SF6_LBC((/d1_e,d1_e/),:), 0)
                delete(SF6_LBCi)
                SF6_LBCi     = SF6_LBCnew
                delete(SF6_LBCnew)
            else
                SF6_LBCnew   = array_append_record(SF6_LBCi, SF6_LBC((/d1_e,d1_e,d1_e/),:), 0)
                delete(SF6_LBCi)
                SF6_LBCi     = SF6_LBCnew
                delete(SF6_LBCnew)
            end if
        end do
SF6_LBC_new=array_append_record(array_append_record(SF6_LBC1,SF6_LBCi,0),SF6_LBC2,0)
delete([/SF6_LBC1, SF6_LBC2, SF6_LBCi, SF6_LBC/])

    date1=date(d1_s:d1_e)  ;  1975-01-01 to 1975-07-01
    time1=time(d1_s:d1_e)
    datei=(/date(d1_e)+di_p-1,date(d1_e)+di_p,date(d1_e)+di_p+1/)  
    timei=(/time(d1_e)+di_p-1,time(d1_e)+di_p,time(d1_e)+di_p+1/)

    date2=date(d2_s:d2_e)  ;  1975-08-01 to end
    time2=time(d2_s:d2_e)

    do weeks   = 1 , weeknum-1
        
        di_p = 2 + weeks*7
        if weeks.eq.4
            datenew  = array_append_record(datei,(/date(d1_e)+di_p-1,date(d1_e)+di_p/),0)
            timenew  = array_append_record(timei,(/time(d1_e)+di_p-1,time(d1_e)+di_p/),0)
            delete([/timei, datei/])
            datei    =  datenew
            timei    =  timenew
            delete([/datenew, timenew/])
        else 
            datenew  = array_append_record(datei,(/date(d1_e)+di_p-1,date(d1_e)+di_p,date(d1_e)+di_p+1/),0)
            timenew  = array_append_record(timei,(/time(d1_e)+di_p-1,time(d1_e)+di_p,time(d1_e)+di_p+1/),0)
            delete([/timei, datei/])
            datei    =  datenew
            timei    =  timenew
            delete([/datenew, timenew/])
         end if

    end do

    date_new=array_append_record(array_append_record(date1,datei,0),date2,0)
    time_new=array_append_record(array_append_record(time1,timei,0),time2,0) 
    delete([/date1, date2, datei, date/])
    delete([/time1, time2, timei, time/])
    ntime=dimsizes(time_new)
    fout->time=time_new
    fout->date=date_new
    fout->lat=lat
    fout->lon=lon

    tracer_num = (yyyy-1981)*10

    do tcnum = 1 , tracer_num + weeknum
       vname = (/"T" + tcnum + "_LBC"/)
       var   = f1->$vname(0)$
       var1=var(d1_s:d1_e,:,:)
       var2=var(d2_s:d2_e,:,:)
       vari=var((/d1_e,d1_e,d1_e/),:,:) 
            do comi      = 1,weeknum-1
                if comi.eq.4
                    varnew   = array_append_record(vari, var((/d1_e,d1_e/),:,:), 0)
                    delete(vari)
                    vari     = varnew
                    delete(varnew)
                else
                    varnew   = array_append_record(vari, var((/d1_e,d1_e,d1_e/),:,:), 0)
                    delete(vari)
                    vari     = varnew
                    delete(varnew)
                end if
            end do
    var_new=array_append_record(array_append_record(var1,vari,0),var2,0)
    delete([/var1, var2, vari, var/])
    fout->$vname(0)$=var_new
    delete(var_new)
    end do  

    do weeks =  6 , 10
    tcname= tracer_num + weeks
    vname = (/"T"+tcname+"_LBC"/)
    var= new((/ntime,nlat,nlon/),"float")
    var!0="time"
    var!1="lat"
    var!2="lon"
    var&time=time_new
    var&lat=lat
    var&lon=lon
        ; extend to longitude
    var(:,:,:)=0
    var@units="mol/mol"
    var@long_name="pulse tracer nh"

    itime=(yyyy-1975)*12 + (yyyy-1981)*28 + 23 + (weeks-6)*3
    var( itime, inlat, inlon) = 1.
    fout->$vname(0)$=var
    delete([/var, vname/])

    end do

fout->CO2_LBC_mean=CO2_LBC_mean_new
fout->CO2_LBC=CO2_LBC_new
fout->CH4_LBC_mean=CH4_LBC_mean_new
fout->CH4_LBC=CH4_LBC_new
fout->N2O_LBC=N2O_LBC_new
fout->CCL4_LBC=CCL4_LBC_new
fout->CF2CLBR_LBC=CF2CLBR_LBC_new
fout->CF3BR_LBC=CF3BR_LBC_new
fout->CFC113_LBC=CFC113_LBC_new
fout->CH3BR_LBC_mean=CH3BR_LBC_mean_new
fout->CH3BR_LBC=CH3BR_LBC_new
fout->CH3CCL3_LBC=CH3CCL3_LBC_new
fout->CH3CL_LBC=CH3CL_LBC_new
fout->H2_LBC=H2_LBC_new
fout->HCFC22_LBC_mean=HCFC22_LBC_mean_new
fout->HCFC22_LBC=HCFC22_LBC_new
fout->CFC114_LBC=CFC114_LBC_new
fout->CFC115_LBC=CFC115_LBC_new
fout->HCFC141B_LBC_mean=HCFC141B_LBC_mean_new
fout->HCFC141B_LBC=HCFC141B_LBC_new
fout->HCFC142B_LBC_mean=HCFC142B_LBC_mean_new
fout->HCFC142B_LBC=HCFC142B_LBC_new
fout->CH2BR2_LBC=CH2BR2_LBC_new
fout->CHBR3_LBC=CHBR3_LBC_new
fout->H1202_LBC=H1202_LBC_new
fout->H2402_LBC=H2402_LBC_new
fout->OCS_LBC=OCS_LBC_new
fout->CFCL3_LBC=CFCL3_LBC_new
fout->CF2CL2_LBC=CF2CL2_LBC_new
fout->TOT_CLOY=TOT_CLOY_new
fout->TOT_BROY=TOT_BROY_new
fout->TOT_FOY=TOT_FOY_new
fout->SF6_LBC=SF6_LBC_new

delete([/fileout, f1, date_new, time_new, tracer_num, d1_s, d1_e, d2_s, d2_e/])
delete([/ CO2_LBC_mean_new, CO2_LBC_new, CH4_LBC_mean_new, CH4_LBC_new/])
delete([/ N2O_LBC_new, CCL4_LBC_new, CF2CLBR_LBC_new, CF3BR_LBC_new /])
delete([/ CFC113_LBC_new, CH3BR_LBC_mean_new, CH3BR_LBC_new, CH3CCL3_LBC_new /])
delete([/ CH3CL_LBC_new, H2_LBC_new, HCFC22_LBC_mean_new, HCFC22_LBC_new /])
delete([/ CFC114_LBC_new, CFC115_LBC_new, HCFC141B_LBC_mean_new, HCFC141B_LBC_new /])
delete([/ HCFC142B_LBC_mean_new, HCFC142B_LBC_new, CH2BR2_LBC_new, CHBR3_LBC_new /])
delete([/ H1202_LBC_new, H2402_LBC_new, OCS_LBC_new, CFCL3_LBC_new /])
delete([/ CF2CL2_LBC_new, TOT_CLOY_new, TOT_BROY_new, TOT_FOY_new, SF6_LBC_new /])

end do
