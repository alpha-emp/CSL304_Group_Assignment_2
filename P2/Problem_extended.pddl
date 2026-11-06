(define (problem mars-rover-extended)
  (:domain mars-rover)
  (:objects curiosity - rover
    base sitea siteb sitec sited sitee sitef - location
    rock1 rock2 rock3 rock4 rock5 rock6 rock7 - sample
    bay1 bay2 - bay
    drill1 - equipment
  )
  (:init
    (at curiosity base) (drill-at drill1 sitee) (bay-empty bay1) (bay-empty bay2) (connected base sitea) (connected sitea base) (connected sitea sitec) (connected sitec sitea) (connected siteb sited) (connected sited siteb) (connected sitec sitee) (connected sitee sitec) (connected sited sitee) (connected sitee sited) (connected sitee sitef) (connected sitef sitee) (connected sitec sited) (soft rock1) (soft rock2) (hard rock3) (soft rock4) (hard rock5) (soft rock6) (hard rock7) (sample-at rock1 sitea) (sample-at rock2 siteb) (sample-at rock3 sitec) (sample-at rock4 sited) (sample-at rock5 sitef) (sample-at rock6 sitee) (sample-at rock7 sitef)
  )
  (:goal (and (at curiosity base) (bay-empty bay1) (bay-empty bay2) (sample-at rock1 base) (sample-at rock2 base) (sample-at rock3 base) (sample-at rock4 base) (sample-at rock5 base) (sample-at rock6 base) (sample-at rock7 base)))
)
