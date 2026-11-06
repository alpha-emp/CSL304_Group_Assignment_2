(define (domain mars-rover)
  (:requirements :strips :typing)

  (:types rover location sample bay equipment)

  (:predicates
    (at ?r - rover ?l - location)
    (connected ?from - location ?to - location)
    (sample-at ?s - sample ?l - location)
    (soft ?s - sample)
    (hard ?s - sample)
    (bay-empty ?b - bay)
    (stored ?s - sample ?b - bay)
    (drill-at ?d - equipment ?l - location)
    (has-drill ?r - rover)
  )

  (:action move
    :parameters (?r - rover ?from - location ?to - location)
    :precondition (and (at ?r ?from) (connected ?from ?to))
    :effect (and (not (at ?r ?from)) (at ?r ?to))
  )

  (:action pick-drill
    :parameters (?r - rover ?d - equipment ?l - location)
    :precondition (and (at ?r ?l) (drill-at ?d ?l) (not (has-drill ?r)))
    :effect (and (not (drill-at ?d ?l)) (has-drill ?r))
  )

  (:action collect-soft
    :parameters (?r - rover ?s - sample ?b - bay ?l - location)
    :precondition (and (at ?r ?l) (sample-at ?s ?l) (soft ?s) (bay-empty ?b))
    :effect (and (not (sample-at ?s ?l)) (not (bay-empty ?b)) (stored ?s ?b))
  )

  (:action collect-hard
    :parameters (?r - rover ?s - sample ?b - bay ?l - location)
    :precondition (and (at ?r ?l) (sample-at ?s ?l) (hard ?s)
                      (has-drill ?r) (bay-empty ?b))
    :effect (and (not (sample-at ?s ?l)) (not (bay-empty ?b)) (stored ?s ?b))
  )

  (:action deposit
    :parameters (?r - rover ?s - sample ?b - bay ?l - location)
    :precondition (and (at ?r ?l) (stored ?s ?b))
    :effect (and (not (stored ?s ?b)) (bay-empty ?b) (sample-at ?s ?l))
  )
)
