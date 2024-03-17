% pattern matching for head and tail

declare
fun {Head X|_} X end

fun {Tail _|X} X end

{Browse {Head [1 2 3]}}
{Browse {Tail [1 2 3]}}