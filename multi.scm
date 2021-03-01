#! /usr/bin/env -S chibi-scheme -r -A ./ -I ${modules}/schemeR7RS

(import (chibi) (chibi match) (chibi pathname)
	(lib misc)
	(scheme cxr)
	)

(define (simple-multicall-script args)
	;; args will be available from (main). 
	;; (path-strip-directory) is available from
	;; (chibi pathname)
	;; allows (load)-ing as well as running as a script
	;; or renaming and running different parts
	;; Honestly not sure what to do with this.
	(let ( (fn (path-strip-directory (car args))) )
		(if (string=? fn "code-notes.scm")
			(dspl "main file called: " fn
				"\nFirst arg: " (or (and (pair? (cdr args)) (cadr args))
				(cdr args)))
			(dspl "Multicall!: " fn)))
	)


(define (main args)
	(simple-multicall-script args)
  (dsp ""))
