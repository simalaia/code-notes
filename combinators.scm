#! /usr/bin/env -S chibi-scheme -r -A ./ -I ${modules}/schemeR7RS

(import (chibi) (chibi match) (chibi pathname)
	(lib misc)
	(scheme cxr)
	)

;; vararg Y combinator
(define (Y step)
	((lambda (x) (x x))         ;; ω combinator
		(lambda (g) (lambda data   ;; varargs
			(apply step (g g) data)))
		))

;; memoized vararg Y combinator
(define (Z step . args)
	(let ( (tab '()) )
		((lambda (x)               ;; ω combinator
			(let ( (r (x x)) )        ;; thunk
				(if (null? args) r       ;; if no args
					(apply r args)) ))      ;; args given
			(lambda (g) (lambda data  ;; self => varargs
				(cond
					((assoc data tab) (cdr (assoc data tab)) )
					(else (let ( (res (apply step (g g) data)) )
						(set! tab `((,data . ,res) . ,tab))
						res) )) ))) ))


(define (main args)
  (dsp ""))
