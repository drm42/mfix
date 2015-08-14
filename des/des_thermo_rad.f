!vvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvv!
!                                                                      !
!  Module name: DES_RADIATION                                          !
!                                                                      !
!  Purpose:                                                            !
!                                                                      !
!  Author: J.Musser                                   Date: 25-Jun-10  !
!                                                                      !
!  Commen:                                                             !
!                                                                      !
!^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^!
      SUBROUTINE DES_RADIATION(I, iM, iIJK, FOCUS)

      USE constant
      USE geometry
      USE des_thermo
      USE discretelement
      USE fldvar
      USE param1
      USE physprop, only: SMAX
      USE toleranc
      USE compar
      USE functions
      USE indices
      USE run
      USE rte_do

      IMPLICIT NONE

! Passed variables
!---------------------------------------------------------------------//
! Global index of particle
      INTEGER, INTENT(IN) :: I
! Solid phase of particle I
      INTEGER, INTENT(IN) :: iM
! Fluid cell index containing particle I
      INTEGER, INTENT(IN) :: iIJK
! Logical used for debugging
      LOGICAL, INTENT(IN) :: FOCUS

! Local variables
!---------------------------------------------------------------------//
! Surface area of particle
      DOUBLE PRECISION :: A_S
! Radiative heat transfer
      DOUBLE PRECISION :: Qrd
! Environment temperature
      DOUBLE PRECISION :: Tenv
! Particle Emmisivity
      DOUBLE PRECISION :: lEm
      INTEGER :: IJK, J
	  
      DO J = 2, PART_CELLS(I,1) + 1 
         IJK = PART_CELLS(I,J)
         IF(.NOT.FLUID_AT(IJK)) CYCLE
         IF(PART_VOL_INTERSEC(IJK,I) == 0.0d0) CYCLE
         Q_SOURCE(I) = Q_SOURCE(I) + &
           PART_VOL_INTERSEC(IJK,I)/TOT_VOL_INTERSEC(IJK)*&
           S_DES(IJK)*VOL(IJK)
      END DO

      RETURN

      END SUBROUTINE DES_RADIATION
