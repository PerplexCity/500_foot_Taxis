import csv
import itertools

#this script breaks the map into tiny coordinates and counts how many rides went there

LL = []

for i in range(200):
	for j in range(300):
		longg = round(-74.05+i*.001, 3)
		lat = round(40.6 + j*.001, 3)
		LL.append((longg, lat))

count = {}
for i in LL:
	count[i] = 0


reader = csv.reader(open('nyc_taxi_data.csv', 'rb'))

	
for row in itertools.islice(reader, 1, 165114362):
	num +=1
	if num%1000000 ==0:
		print num
	#to get short rides, flip the greater than sign
	if float(row[4]) > 0.1:

		try:
			pickup = (round(float(row[5]), 3), round(float(row[6]), 3))
			dropoff = (round(float(row[9]), 3), round(float(row[10]), 3))

			try:
				count[pickup] += 1
				count[dropoff] += 1
			except KeyError:
				pass


		except ValueError:
			pass



writer = csv.writer(open('long.csv', 'wb'))
for key, value in count.items():
   writer.writerow([key, value])


