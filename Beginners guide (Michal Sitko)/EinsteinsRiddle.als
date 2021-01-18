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

// pred left[h1:House,h2:House] {}

fact constraints {
	Brit.house.color = Red
	Swede.pet = Dogs
	Dane.beverage = Tea
	all h1, h2 : House | h1.color = Green && h2.color = White => h1 = h2.prev
	all o : Owner | o.house.color = Green => o.beverage = Coffee
	all o : Owner | o.cigar = PallMall => o.pet = Birds
	all o : Owner | o.house.color = Yellow => o.cigar = Dunhill
	all o : Owner | o.house = next[next[first]] => o.beverage = Milk
	Norwegian.house = first
	all o1, o2 : Owner | o1.cigar = Blend && o2.pet = Cats =>
		o1.house = o2.house.prev || o1.house = o2.house.next
	all o1, o2 : Owner | o1.pet = Horses && o2.cigar = Dunhill =>
		o1.house = o2.house.prev || o1.house = o2.house.next
	all o : Owner | o.cigar = BlueMaster => o.beverage = Beer
	German.cigar = Prince
	all h : House | h.color = Blue =>
		(Norwegian.house = h.prev || Norwegian.house = h.next)
	all o1, o2 : Owner | o1.cigar = Blend && o2.beverage = Water =>
		o1.house = prev[o2.house] || o1.house = next[o2.house]

	// copy-pasta from YouTube
	// one b: Brit | b.house.color = Red
	// one s: Swede | s.pet = Dogs
	// one d:Dane | d.beverage = Tea
	// one h : House | h.color = Green && h.next.color=White
	// one o : Owner | o.house.color = Green && o.beverage = Coffee
	// one o : Owner | o.pet = Birds && o.cigar = PallMall
	// one o : Owner | o.house.color = Yellow && o.cigar = Dunhill
	// one o : Owner | o.beverage = Milk && #(o.house.prev) = #(o.house.next)
	// one n : Norwegian | no n.house.prev
	// one o1,o2 : Owner | o1.pet= Horses && o2.cigar = Dunhill &&(o1.house.prev = o2.house|| o1.house.next = o2.house)
	// one o : Owner | o.cigar = BlueMaster && o.beverage = Beer
	// one g: German | g.cigar = Prince
	// one n : Norwegian | n.house.prev.color = Blue|| n.house.next.color = Blue
	// one o1,o2 : Owner | o1.cigar= Blend && o2.beverage = Water && (o1.house.prev = o2.house|| o1.house.next = o2.house)
	// one o1,o2 : Owner | o1.cigar= Blend && o2.pet = Cats && (o1.house.prev = o2.house|| o1.house.next = o2.house)

	#House = 5
}

run {} for 5

// https://udel.edu/~os/riddle.html
