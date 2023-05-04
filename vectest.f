\ see what modifying x and y vectors does to an image

0 value imagew
0 value imageh
create image 2048 allot

: set-image
  to imageh dup to imagew
  imageh 0 do ( ... str len )
    image imageh 1- i - imagew * + swap cmove
  loop ;

s"                               "
s"                               "
s"                               "
s"                               "
s"                               "
s"      ####################     "
s"      #                  #     "
s"      #                  #     "
s"      #   *          *   #     "
s"      #   *          *   #     "
s"      #   *          *   #     "
s"      #   *          *   #     "
s"      #                  #     "
s"      #                  #     "
s"      #                  #     "
s"      #                  #     "
s"      #                  #     "
s"      #                  #     "
s"      #  **          **  #     "
s"      #   **        **   #     "
s"      #     ********     #     "
s"      #                  #     "
s"      #                  #     "
s"      #                  #     "
s"      ####################     "
s"                               "
s"                               "
s"                               "
s"                               "
s"                               "
30 set-image

create xv 100 , 000 ,
000 , 100 ,
xv 2 cells + constant yv

0 value sel

: image@ ( x y -- c )
  imageh mod imagew *
  swap imagew mod +
  image + c@ ;

: v* ( x v -- x )
  >r dup r@ cell+ @ * 100 /
  swap r@ @ * 100 / swap r> drop ;

: xv* xv v* ;
: yv* yv v* ;

: ?star dup 0= if [char] * emit then 1- ;

: draw
  page
  23 0 do
    80 0 do
      i 40 - xv* j 11 - yv* rot + -rot + swap image@ emit
    loop cr
  loop
  sel
  ." TAB/+/-,  q to quit"
  20 spaces
  ." x: " ?star xv @ . ?star xv cell+ @ . space
  ." y: " ?star yv @ . ?star yv cell+ @ .
  drop ;

: incsel 1 sel cells xv + +! ;
: decsel -1 sel cells xv + +! ;

: ctl
  key
  dup [char] q = if bye then
  dup [char] + = if incsel drop exit then
  dup [char] - = if decsel drop exit then
  9 = if sel 1+ 4 mod to sel then ;

:noname begin draw ctl again ; execute

