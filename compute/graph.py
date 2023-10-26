import matplotlib.pyplot as plt
import os

# Initialize lists to store data
thread_counts = []
matrix_sizes = []
serial_times = []
parallel_times = []

# Read data from the log file
with open("matrix_multiplication_log.txt", "r") as file:
    lines = file.readlines()
    for line in lines:
        parts = line.split(", ")
        thread_count = int(parts[0].split(": ")[1])
        matrix_size = int(parts[1].split(": ")[1])
        serial_time = float(parts[2].split(": ")[1])
        parallel_time = float(parts[3].split(": ")[1])

        thread_counts.append(thread_count)
        matrix_sizes.append(matrix_size)
        serial_times.append(serial_time)
        parallel_times.append(parallel_time)

# Get unique thread counts
unique_thread_counts = list(set(thread_counts))

# Create a directory for saving the subplot
os.makedirs("subplot", exist_ok=True)

# Create a subplot to contain all graphs
fig, axes = plt.subplots(len(unique_thread_counts), 1, figsize=(10, 6 * len(unique_thread_counts)))

for index, thread_count in enumerate(unique_thread_counts):
    ax = axes[index]
    for i in range(len(thread_counts)):
        if thread_counts[i] == thread_count:
            ax.plot(matrix_sizes[i], serial_times[i], marker='o', label=f'Serial Time (N={matrix_sizes[i]})', color='blue')
        if thread_counts[i] == thread_count:
            ax.plot(matrix_sizes[i], parallel_times[i], marker='o', label=f'Parallel Time (N={matrix_sizes[i]})', color='red')
    
    ax.set_xlabel('Matrix Size (N)')
    ax.set_ylabel('Time (seconds)')
    ax.set_title(f'Matrix Multiplication Execution Time (Thread Count={thread_count})')
    ax.grid(True)
    ax.legend(loc='upper right')

# Save the subplot as a single image
plt.tight_layout()
plt.savefig("subplot/matrix_multiplication_subplot.png")

print("Subplot saved as 'matrix_multiplication_subplot.png'.")
