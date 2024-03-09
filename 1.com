def get_matrix(rows, cols):
    matrix = []
    print(f"Enter elements for a {rows}x{cols} matrix:")
    for i in range(rows):
        row = []
        for j in range(cols):
            element = float(input(f"Enter element at position ({i + 1},{j + 1}): "))
            row.append(element)
        matrix.append(row)
    return matrix

def print_matrix(matrix):
    for row in matrix:
        print(row)

def transpose_matrix(matrix):
    
    transposed_matrix = [list(row) for row in zip(*matrix)]
    return transposed_matrix

def add_matrices(matrix1, matrix2):
   
    if len(matrix1) != len(matrix2) or len(matrix1[0]) != len(matrix2[0]):
        print("Matrices must be of the same size for addition.")
        return None
    
    result_matrix = [[matrix1[i][j] + matrix2[i][j] for j in range(len(matrix1[0]))] for i in range(len(matrix1))]
    return result_matrix

def multiply_matrices(matrix1, matrix2):

    if len(matrix1[0]) != len(matrix2):
        print("Number of columns in the first matrix must be equal to the number of rows in the second matrix for multiplication.")
        return None
    
    result_matrix = [[sum(matrix1[i][k] * matrix2[k][j] for k in range(len(matrix2))) for j in range(len(matrix2[0]))] for i in range(len(matrix1))]
    return result_matrix


rows = int(input("Enter the number of rows for the matrix: "))
cols = int(input("Enter the number of columns for the matrix: "))


original_matrix = get_matrix(rows, cols)


print("\nOriginal Matrix:")
print_matrix(original_matrix)


transposed_matrix = transpose_matrix(original_matrix)
print("\nTransposed Matrix:")
print_matrix(transposed_matrix)


second_matrix = get_matrix(rows, cols)


sum_matrix = add_matrices(original_matrix, second_matrix)
if sum_matrix is not None:
    print("\nSum of Matrices:")
    print_matrix(sum_matrix)


product_matrix = multiply_matrices(original_matrix, second_matrix)
if product_matrix is not None:
    print("\nProduct of Matrices:")
    print_matrix(product_matrix)
