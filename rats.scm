#! /usr/bin/env -S chibi-scheme -r -A ./ -I ${modules}/schemeR7RS

(import (chibi) (chibi match) (chibi pathname)
	(lib misc)
	(scheme cxr)
	)

(define (rational-arithmetic)
  ;; This description does not handle negative numbers at
  ;; all.  I'm very keen to rewatch the SICP video on data
  ;; abstraction and implementing something similar to what
  ;; they did.  I think it would be a very cool exercise.
  (define (a-mod a b) (remainder a b))
  (define (a-gcd a b)
    (if (= b 0) a (a-gcd b (a-mod a b))))

  ;; Make a rational number representation (-> (int int) rat)
  ;; Note that all numbers are in canonical form here
  (define (// a b)
    (let ( (x (a-gcd a b)) )
      (cons (/ a x) (/ b x))))
  (define (int->rat a) (// a 1)) ;; convert an integer to a rational

  ;; The type for the next two is (-> rat int)
  (define (//n a) (car a))       ;; get the numerator
  (define (//d a) (cdr a))       ;; get the denomerator

  ;; rational equality there are two ways of doing this:
  ;; (// a b) = (// c d) iff (* a d) = (* b c)
  ;; alternatively, given the numbers in canonical form (as I have)
  ;; one may do this:
  ;; iff a = c and b = d
  ;; The type is (-> (rat rat) bool)
  (define (rat=? a b) (and (= (//n a) (//n b)) (= (//d a) (//d b))))

  ;; Utility functions to make the ideas clearer
  (define (*nd a b) (* (//n a) (//d b)))
  (define (*nn a b) (* (//n a) (//n b)))
  (define (*dd a b) (* (//d a) (//d b)))

  ;; Rational ordering
  (define (rat<? a b) (< (*nd a b) (*nd b a)))

  ;; Rational addition
  (define (rat+ a b) (// (+ (*nd a b) (*nd b a)) (*dd a b)))

  ;; Rational subtraction
  (define (rat- a b) (// (- (*nd a b) (*nd b a)) (*dd a b)))

  ;; Rational multiplication
  (define (rat* a b) (// (*nn a b) (*dd a b)))

  ;; Rational division
  (define (rat/ a b) (// (*nd a b) (*nd b a)))


  ;; Things I have left out at present:
  ;; Inverses:
  ;;   additive: (- (// a b)) = (// (- a) b)
  ;;   multiplicative: (expt (// a b) -1) = (// b a)
  ;;                   (expt (// (- a) b)) = (// -b -a)
  ;; canonical forms:
  ;;   (let ( (x (gcd a b)) )
  ;;     (if (< (/ b x) 0) (cons (- a) (- b)) (cons a b)))
  ;; exponentiation (integer power):
  ;;   (rat^ (// a b) n) = (// (expt a n) (expt b n))
  ;;   (rat^ (// a b) 0) = 1
  ;;   iff a ≠ 0 (rat^ (// a b) -n) = (// (expt b n) (expt a n))
  ;;   iff a/b is canonical then canonical result is
  ;;   bⁿ/aⁿ if a > 0 or n is even.
  ;;   Otherwise the canonical form is -bⁿ/-aⁿ
  )


(define (main args)
  (dsp ""))
