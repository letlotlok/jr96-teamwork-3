deftemplate cValue (multislot number))

(deffunction aAnswer (?answer ?number)
	(if (lexemep ?answer)
	then 
		(bind ?answer (lowcase ?answer))
	
		(if (or (eq ?answer "n") (eq ?answer "nickel") (eq ?answer "5") (eq ?answer "R5") )
		then 
			(bind ?answer (or(+ (?number 5)(?number 2)(?number 1)))
			)
		else
			(if (or (eq ?answer "q") (eq ?answer "quarter") (eq ?answer "50") (eq ?answer "50c") ) 
			then 
				(bind ?answer (or(+( ?number 50) (?number 20) (?number 10))))
			else
				(bind ?answer ?number) 
			)
		)
	)
	(return ?answer)
)

(defrule Start
	(declare (salience 2))
	=>
	(printout t "Starting program:" crlf)
)

(defrule Process
	(declare (salience 0))
	?fact <- (cValue (number ?num))
	=>
	(printout t "Add a Nickel(R5),(R2),(R1) or a Quarter(50c),(20c),(10c): [Q or N]   --> Current amount: " ?num "c" or "R" crlf ":> ")
	(bind ?ans (readline))
		(retract ?fact)					
		(assert (cValue (number (aAnswer ?ans ?num) )))
)

(defrule End
	(declare (salience 1))
	?fact <- (cValue (number ?total))
		(test(>= ?total 35))
	=>
	(printout t "DONE !!!   --> Current amount: " ?total "c" crlf crlf crlf)
		(retract ?fact)
		(reset)
		(run)
)

(deffacts vending
	(cValue (number 0))	
)