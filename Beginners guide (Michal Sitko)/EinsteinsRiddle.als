open util/ordering[House]

enum Color {Red, White, Blue, Green, Yellow}

enum Pet {Birds, Cats, Dogs, Fish, Horses}

enum Cigar {Blend, BlueMaster, Dunhill, PallMall, Prince}

enum Beverage {Beer, Coffee, Milk, Tea, Water}

sig House {
	color : disj Color,
} { this in Owner.house }

abstract sig Owner {
	house : disj House,
	pet : disj Pet,
	cigar : disj Cigar,
	beverage : disj Beverage,
}

one sig Brit extends Owner {}
one sig Swede extends Owner {}
one sig Dane extends Owner {}
one sig Norwegian extends Owner {}
one sig German extends Owner {}

pred left[h1:House,h2:House] {}

fact constraints {
        one b: Brit | b.house.color = Red
        one s: Swede | s.pet = Dogs
        one d: Dane | d.beverage = Tea
				
        // TODO: add more predicates

        #House = 5
}

run {} for 5

// https://udel.edu/~os/riddle.html
