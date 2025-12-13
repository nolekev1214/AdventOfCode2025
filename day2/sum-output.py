def sum_numbers_in_file(filename):
    total = 0
    try:
        with open(filename, "r") as file:
            for line in file:
                line = line.strip()  # Remove any leading/trailing whitespace
                if line:  # Skip empty lines
                    try:
                        number = float(line)  # Convert line to a number
                        total += number
                    except ValueError:
                        print(
                            f"Warning: '{line}' is not a valid number and will be skipped."
                        )
        return total
    except FileNotFoundError:
        print(f"Error: The file '{filename}' was not found.")
        return None


if __name__ == "__main__":
    total = sum_numbers_in_file("bad_ids.csv")
    if total is not None:
        print(f"The sum of all numbers is: {total}")
