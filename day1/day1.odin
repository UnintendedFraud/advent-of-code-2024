package main

import "core:fmt"
import "core:os"
import "core:slice"
import "core:strconv"
import "core:strings"

import "../utils"

main :: proc() {
	input, err := utils.load_file("day1/input.txt")
	if err != nil {
		fmt.println("error loading input file: ", err)
		return
	}

	n1, n2 := process_input(input)

	distance := calc_distance(n1, n2)
	similarity := calc_similarity(n1, n2)

	fmt.println("Distance: ", distance)
	fmt.println("Similarity: ", similarity)
}

calc_distance :: proc(n1: []int, n2: []int) -> int {
	diff := 0

	for i in 0 ..< len(n1) {
		diff += abs(n1[i] - n2[i])
	}

	return diff
}

calc_similarity :: proc(n1: []int, n2: []int) -> int {
	similarity := 0

	for i in 0 ..< len(n1) {
		n := n1[i]
		similarity += n * slice.count(n2, n)
	}

	return similarity
}

process_input :: proc(input: []string) -> ([]int, []int) {
	first := make([]int, len(input))
	second := make([]int, len(input))

	for line, i in input {
		split := strings.split(line, " ")

		first[i] = strconv.atoi(split[0])
		second[i] = strconv.atoi(split[len(split) - 1])
	}

	slice.sort(first)
	slice.sort(second)

	return first, second
}
