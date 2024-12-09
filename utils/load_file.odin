package utils

import "core:fmt"
import "core:os"
import "core:slice"
import "core:strings"

Error :: os.Error

load_file :: proc(path: string) -> ([]string, Error) {
	file, open_err := os.open(path)
	if open_err != nil {
		return nil, open_err
	}
	defer os.close(file)

	content, read_err := os.read_entire_file_or_err(file)
	if read_err != nil {
		return nil, read_err
	}

	lines := strings.split(string(content), "\n")

	if lines[len(lines) - 1] == "" {
		lines = lines[:len(lines) - 1]
	}

	return lines, nil
}
