#! /usr/bin/env -S chibi-scheme -r -A ./ -I ${modules}/schemeR7RS

(import (chibi) (chibi match) (chibi pathname)
	(lib misc)
	(scheme cxr)
	)

(define (arbitrary-precision)
  ;; This is the start for working out an arbitrary
  ;; precision library.  The explanation I'm using as
  ;; a guide can be found here:
  ;; stackoverflow.com/questions/1218149/arbitrary-precision-arithmetic-explanation
  ;; see also this:
  ;; https://cp-algorithms.com/algebra/big-integer.html


  ;; ban = 0-9
  ;; num = list of ban
  (define (ban+ c a b)
    (let ( (r (+ c a b)) )
      (if (> r 9)
	  (cons (floor (/ r 10)) (remainder r 10))
	  (cons 0 r)) ) )

  (define (num+ a b)
    (let lop ( (c 0) (a a) (b b) )
      (cond
       ((and (null? a) (null? b)) `(,c) )
       ((null? b)
	(let* ( (r (ban+ c (car a) 0))
		(c (car r))
		(d (cdr r)) )
	  (if (= c 0)
	      (cons d (cdr a))
	      (cons d (lop c (cdr a) b))) ) )
       ((null? a)
	(let* ( (r (ban+ c (car b) 0))
		(c (car r))
		(d (cdr r)) )
	  (if (= c 0)
	      (cons d (cdr b))
	      (cons d (lop c a (cdr b)))) ) )
       (else
	(let* ( (r (ban+ c (car a) (car b)))
		(c (car r))
		(d (cdr r)) )
	  (cons d (lop c (cdr a) (cdr b))) ) )) ) )
  )


(define (main args)
  (dsp ""))
