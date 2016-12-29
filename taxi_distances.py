import csv
import itertools

#this script counts the different ride distances

reader = csv.reader(open('nyc_taxi_data.csv', 'rb'))

distances=[0, 0, 0, 0, 0, 0]

num=0
	
for row in itertools.islice(reader, 1, 165114362):
	num += 1
	print num

	if float(row[4]) <= 0.1:
		distances[0] += 1

	if float(row[4])> 0.1 and float(row[4]) <= 1:
		distances[1] += 1

	if float(row[4]) > 1 and float(row[4]) <= 2:
		distances[2] += 1

	if float(row[4]) > 2 and float(row[4]) <= 5:
		distances[3] += 1

	if float(row[4]) > 5 and float(row[4]) <= 10:
		distances[4] += 1

	if float(row[4]) > 10:
		distances[5] += 1


print distances
