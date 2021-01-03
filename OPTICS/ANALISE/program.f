        program exp
        implicit none
        integer nmax1,countu,N,I,IO,nmax
        real c,h,pi
        parameter(c=2.99792E10)
        parameter(h=4.13566733E-15)
        parameter(pi=3.1416)
        real,allocatable,dimension(:) :: Eev,x,y,z,xy,yz,zx,eimg,
     .  ereal,Eevr,xr,yr 
        real,allocatable,dimension(:) :: zr,xyr,yzr,zxr,abor,freq,
     .  refractive,energylossspectrum, extinction,reflectivity
        countu=0
        OPEN(1,FILE = 'no')
        READ(1,*) nmax1
        nmax=nmax1-1
        allocate(Eev(nmax))
        allocate(x(nmax))
        allocate(y(nmax))
        allocate(z(nmax))
        allocate(xy(nmax))
        allocate(yz(nmax))
        allocate(zx(nmax))
        allocate(Eevr(nmax))
        allocate(xr(nmax))
        allocate(yr(nmax))
        allocate(zr(nmax))
        allocate(xyr(nmax))
        allocate(yzr(nmax))
        allocate(zxr(nmax))
        allocate(eimg(nmax))
        allocate(ereal(nmax))
        allocate(abor(nmax))
        allocate(freq(nmax)) 
        allocate(refractive(nmax))
        allocate(energylossspectrum(nmax)) 
        allocate(extinction(nmax))
        allocate(reflectivity(nmax))
        OPEN(2,FILE = 'img.dat',STATUS='OLD') 
        OPEN(3,FILE = 'rel.dat',STATUS='OLD')
        OPEN(4,FILE = 'abor.dat') 
        OPEN(5,FILE = 'refractivecoefficient.dat')
        OPEN(6,FILE = 'energylossspectrum.dat') 
        OPEN(7,FILE = 'extinction.dat')
        OPEN(8,FILE = 'reflectivity.dat')
       !read the number of points

       do i=1,nmax
C       READ(2,*) Eev(i),x(i),y(i),z(i),xy(i),yz(i),zx(i)
       READ(2,*) Eev(i),x(i)
       countu=countu+1
       end do

       do i=1,nmax
C       eimg(i)=(x(i)+y(i))/2
       eimg(i)=x(i)
       end do

       do i=1,nmax
C       READ(3,*) Eevr(i),xr(i),yr(i),zr(i),xyr(i),yzr(i),zxr(i)
       READ(3,*) Eevr(i),xr(i)
       countu=countu+1
       end do

       do i=1,nmax
C       ereal(i)=(xr(i)+yr(i))/2
       ereal(i)=xr(i)
       freq(i)=(Eevr(i)*1.4142)/h
C       freq(i)=(Eevr(i)*1.4142)/h
       end do

       do i=1,nmax
       abor(i) = (4*pi*Eevr(i))/(h*c)*(SQRT(((-ereal(i)+
     .            SQRT(eimg(i)*eimg(i)+ereal(i)*ereal(i)))/(2))   ))

C       abor(i)=1.4142*(freq(i)/h)*(SQRT(-ereal(i)
C     . +SQRT(eimg(i)*eimg(i)+ereal(i)*ereal(i))))
       end do

       do i=1,nmax
       refractive(i)=(SQRT(ereal(i)+SQRT(eimg(i)*eimg(i)+
     . ereal(i)*ereal(i))))/1.4142
       end do
       do i=1,nmax
       energylossspectrum(i)=eimg(i)/(eimg(i)*eimg(i)+ereal(i)*ereal(i))
       end do
       do i=1,nmax
       extinction(i)=(SQRT(-ereal(i)+SQRT(eimg(i)*eimg(i)+
     . ereal(i)*ereal(i))))/1.4142
       end do
       do i=1,nmax
       reflectivity(i)=((refractive(i)-1)*(refractive(i)-1)+
     . extinction(i)*extinction(i))/((refractive(i)+1)*
     . (refractive(i)+1)+extinction(i)*extinction(i))
       end do
       ! write(*,*) c ,h 

       do i=1,nmax
        write(4,*) Eev(i),abor(i)
       end do

       do i=1,nmax
       write(5,*) Eev(i),refractive(i) 
       end do

       do i=1,nmax
       write(6,*) Eev(i),energylossspectrum(i) 
       end do

       do i=1,nmax
       write(7,*) Eev(i),extinction(i)
       end do

       do i=1,nmax
       write(8,*) Eev(i),reflectivity(i)
       end do

       deallocate(Eev)
       deallocate(x)
       deallocate(y)
       deallocate(z)
       deallocate(xy)
       deallocate(yz)
       deallocate(zx)
       deallocate(Eevr)
       deallocate(xr)
       deallocate(yr)
       deallocate(zr)
       deallocate(xyr)
       deallocate(yzr)
       deallocate(zxr)
       deallocate(eimg)
       deallocate(ereal)
       deallocate(abor)
       deallocate(freq)
       deallocate(refractive) 
       deallocate(energylossspectrum)
       deallocate(extinction) 
       deallocate(reflectivity)
       CLOSE(2)
       CLOSE(3)
       CLOSE(4)
       CLOSE(5)
       CLOSE(6)
       CLOSE(7) 
       CLOSE(8)
       end program exp
