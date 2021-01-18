sig Wheel {} {
	this in (Bicycle.front + Bicycle.rear)
}

sig Bicycle {
	front: Wheel,
	rear: Wheel
}

fact {
	all b : Bicycle | b.front != b.rear
	all b1,b2 : Bicycle |
		b1 != b2 =>
		b1.front not in (b2.front + b2.rear) &&
		b1.rear not in (b2.front + b2.rear)
}

run {}
