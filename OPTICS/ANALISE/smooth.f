      implicit double precision (a-h,o-z)
      parameter (nbins=20000)
      dimension x(nbins),f(nbins),fsmo(nbins)
      data pi/3.14159265/
      data sigma/0.20/

C      OPEN(UNIT=1,FILE='eps.dat',STATUS='old',FORM='FORMATTED')
      OPEN(UNIT=1,FILE='eps.dat',STATUS='old')
      OPEN(UNIT=2,FILE='eps-smo.dat',STATUS='unknown',FORM='FORMATTED')
      num=0
10    read(1,*,end=101) xin,fin
      num=num+1
      if(num.gt.nbins) stop
      x(num)=xin
      f(num)=fin
      go to 10
101   continue
      delta=x(2)-x(1)
      ffactor=delta/sigma/sqrt(pi)

      xnorm=0.
      do i=1,num
         fsmo(i)=0.
         do l=1,num
            gauss=ffactor*exp(-((x(i)-x(l))/sigma)**2)
            fsmo(i)=fsmo(i)+f(l)*gauss
         enddo
         xnorm=xnorm+fsmo(i)
      enddo

      do i=1,num
c        write(2,110) x(i),fsmo(i)/xnorm
         write(2,110) x(i),fsmo(i)
c        write(3,110) fsmo(i), x(i)
c        write(4,110) f(i), x(i)
110      format(' ',f10.4,2x,2f15.10)
      enddo

      stop
      end
