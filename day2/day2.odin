package main

import "core:fmt"
import "core:os"
import "core:slice"
import "core:strconv"
import "core:strings"

import "../utils"

direction :: enum {
	Increasing,
	Decreasing,
	Unknown,
}

main :: proc() {
	input, err := utils.load_file("day2/input.txt")
	if err != nil {
		fmt.println("error loading input file: ", err)
		return
	}

	reports := process_input(input)

	safe_reports_count := 0
	safe_reports_dampener_count := 0

	for r in reports {
		if is_report_safe(r) {
			safe_reports_count += 1
			safe_reports_dampener_count += 1

			continue
		}

		if is_report_safe_dampener(r) {
			safe_reports_dampener_count += 1
		}
	}

	fmt.println("Safe report: ", safe_reports_count)
	fmt.println("Safe report (problem dampener): ", safe_reports_dampener_count)
}

report_without_idx :: proc(source: []int, idx: int) -> []int {
	output := make([]int, len(source) - 1)

	j := 0
	for i in 0 ..< len(source) {
		if i != idx {
			output[j] = source[i]
			j += 1
		}
	}

	return output
}

is_report_safe_dampener :: proc(report: []int) -> bool {
	for i in 0 ..< len(report) {
		if is_report_safe(report_without_idx(report, i)) {
			return true
		}
	}

	return false
}


is_report_safe :: proc(report: []int) -> bool {
	dir := direction.Unknown

	for i in 0 ..< len(report) - 1 {
		n1 := report[i]
		n2 := report[i + 1]
		diff := abs(n1 - n2)

		if diff < 1 || diff > 3 {
			return false
		}

		dirdir := get_direction(n1, n2)

		if dir == direction.Unknown {
			dir = dirdir
			continue
		}

		if dir != dirdir {
			return false
		}
	}

	return true
}

get_direction :: proc(n1: int, n2: int) -> direction {
	if n1 < n2 {
		return direction.Increasing
	}

	return direction.Decreasing
}

process_input :: proc(input: []string) -> [][]int {
	r := make([][]int, len(input))

	for line, i in input {
		split, _ := strings.split(line, " ")
		r[i] = convertStringToInt(split)
	}

	return r
}

convertStringToInt :: proc(str: []string) -> []int {
	numbers := make([]int, len(str))

	for i in 0 ..< len(str) {
		numbers[i] = strconv.atoi(str[i])
	}

	return numbers
}
