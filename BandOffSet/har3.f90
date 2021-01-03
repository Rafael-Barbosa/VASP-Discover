PROGRAM har3
!  Purpose:
!    Calcule the Hartree potential in Z-axis (default)
!
!  Record of revisions:
!       Date         Programmer     Description of change
!    ==========    =============    =====================
!    10 000 BC     José Padilha     Original code
!    02/16/2018    Rafael Dexter    Improvement
!
IMPLICIT NONE
!--- Data dictionary: declare variable types, definitions, & units
INTEGER, PARAMETER :: NGXM=1048, NOUTM=1048
CHARACTER(80) :: header, system, in_system, pos_type
INTEGER :: direction, i
INTEGER :: NIONS,NPLWV,nout,IX,IY,IZ,IPL,NGX,NGY,NGZ
INTEGER :: int1= 0, int2= 0, int3= 0, int4= 0, int5=0, int6=0
!REAL, DIMENSION (NGXM*NGXM*NGXM) :: Vlocal
REAL, DIMENSION (:), ALLOCATABLE :: Vlocal
REAL, DIMENSION (NOUTM) :: vav= .0
REAL :: factor, axx, ayy, azz, bxx, byy, bzz, cxx, cyy, czz
REAL :: RDUM1,RDUM2,RDUM3,fact_scale
! The default implicit typing rule is that if the first letter of the name is I, J,
! K, L, M, or N, then the data type is integer, otherwise it is real.
!WRITE(*,*) 'Which direction to keep? (1-3 --- 1=X,2=Y,3=Z)'
!READ(*,*) direction
WRITE(*,*) 'Potential out-plane (3=Z)'
direction=3
direction=MOD(direction+20,3)+1
OPEN(100,FILE='LOCPOT',STATUS='OLD',ERR=1000)
READ(100,'(A)',ERR=1000,END=1000) system
READ(100,*,ERR=1000,END=1000) factor ! scaling factor or lattice constant
READ(100,*,ERR=1000,END=1000) axx, ayy, azz
READ(100,*,ERR=1000,END=1000) bxx, byy, bzz
READ(100,*,ERR=1000,END=1000) cxx, cyy, czz
READ(100,'(A)',ERR=1000,END=1000) in_system
READ(100,'(A)',ERR=1000,END=1000) header ! number of ions
READ(header,*,ERR=1200,END=1200) int1,int2,int3,int4,int5,int6
1200 NIONS=int1+int2+int3+int4+int5+int6
READ(100,'(A)',ERR=1000,END=1000) pos_type ! cartesian or direct lattice
!--- Echo the user's variables input value
WRITE(*,*) 'system', system
WRITE(*,*) 'factor', factor
WRITE(*,*) 'axx yy', axx, ayy, azz
WRITE(*,*) 'bxx yy', bxx, byy, bzz
WRITE(*,*) 'cxx yy', cxx, cyy, czz
WRITE(*,*) 'in_sys', in_system
WRITE(*,*) 'header', header
WRITE(*,*) 'int1..', int1,int2,int3,int4,int5,int6
WRITE(*,*) 'NIONS ', NIONS
WRITE(*,*) 'pos_ty', pos_type

! Loop for read the atoms positions
positions: DO i=1, NIONS
  READ(100,*,ERR=1000,END=1000) RDUM1,RDUM2,RDUM3
END DO positions
WRITE(*,*) 'positions read'

READ(100,*,ERR=1000,END=1000) ! linha em branco
READ(100,*,ERR=1000,END=1000) NGX,NGY,NGZ
NPLWV=NGX*NGY*NGZ
ALLOCATE(Vlocal(NPLWV))
IF (direction == 1) nout=NGX
IF (direction == 2) nout=NGY
IF (direction == 3) nout=NGZ
IF (NPLWV >= (NGXM*NGXM*NGXM)) THEN
  WRITE(*,*) 'NPLWV >= NGXM**3 (',NPLWV,').'
  STOP
ENDIF
IF (nout >= NOUTM) THEN
  WRITE(*,*) 'nout >= NOUTM (',nout,').'
  STOP
ENDIF

! Reading the charge density
READ(100,*,ERR=1000,END=1000) ( Vlocal(i), i=1, NPLWV )
WRITE(*,*) 'charge density read'
CLOSE(100)

! Loop
!DO 20 i=1, NOUTM
!20 vav(i) .0
fact_scale=1.0/FLOAT(NPLWV/nout)
WRITE(*,*) 'fact_scale =', fact_scale
IF (direction == 1) THEN
  DO IX=1,NGX
    DO IZ=1,NGZ
      DO IY=1,NGY
        IPL=IX+((IY-1)+(IZ-1)*NGY)*NGX
        vav(IX)=vav(IX)+Vlocal(IPL)*fact_scale
      END DO
    END DO
  END DO
ELSE IF (direction == 2) THEN
  DO IY=1,NGY
    DO IZ=1,NGZ
      DO IX=1,NGX
        IPL=IX+((IY-1)+(IZ-1)*NGY)*NGX
        vav(IY)=vav(IY)+Vlocal(IPL)*fact_scale
      END DO
    END DO
  END DO
ELSE IF (direction == 3) THEN
  DO IZ=1,NGZ
    DO IY=1,NGY
      DO IX=1,NGX
        IPL=IX+((IY-1)+(IZ-1)*NGY)*NGX
        vav(IZ)=vav(IZ)+Vlocal(IPL)*fact_scale
      END DO
    END DO
  END DO
ELSE
  WRITE(*,*) 'Hmmm?? Wrong direction ',direction
  STOP
ENDIF
! Writing the outputs
OPEN(200, FILE='VLINE', STATUS='REPLACE')
WRITE(200,*) ' # ', nout, direction
escreva: DO i=1,nout
  IF (ISNAN(vav(i))) CYCLE
  WRITE(200,'(1X,I6,2X,E18.11)') i, vav(i)
END DO escreva
CLOSE(200)
DEALLOCATE(Vlocal)

1000 WRITE(*,*) 'Error opening or reading file LOCPOT.'
     WRITE(*,*) 'item :', i
END PROGRAM har3
