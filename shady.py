import csv
import itertools

#this script logs negotiated, cash-paid, and expensive trips for different types of rides

reader = csv.reader(open('nyc_taxi_data.csv', 'rb'))

num=0

missing_short = 0
non_missing_short = 0
longg=0

cash_missing_short = 0
cash_non_missing_short = 0
cash_long= 0

nego_missing_short= 0
nego_non_missing_short= 0
nego_long= 0

fifty_missing_short= 0
fifty_non_missing_short= 0
fifty_long= 0


hundred_missing_short= 0
hundred_non_missing_short= 0
hundred_long= 0
	
for row in itertools.islice(reader, 1, 165114362):
	num +=1
	if num%1000000 ==0:
		print num
	try:
		if float(row[4]) <= 0.1:
			if float(row[5]) == 0 or float(row[6]) == 0 or float(row[9]) == 0 or float(row[10]) == 0:
				missing_short += 1
				if float(row[7]) == 5:
					nego_missing_short += 1
				if row[11] == 'CSH':
					cash_missing_short += 1
				if float(row[-1]) >= 50:
					fifty_missing_short += 1
				if float(row[-1]) >= 100:
					hundred_missing_short += 1
			else: 
				non_missing_short += 1
				if float(row[7]) == 5:
					nego_non_missing_short += 1
				if row[11] == 'CSH':
					cash_non_missing_short += 1
				if float(row[-1]) >= 50:
					fifty_non_missing_short += 1
				if float(row[-1]) >= 100:
					hundred_non_missing_short += 1

		if float(row[4]) > 0.1:
			longg += 1
			if float(row[7]) == 5:
				nego_long += 1
			if row[11] == 'CSH':
				cash_long += 1
			if float(row[-1]) >= 50:
				fifty_long += 1
			if float(row[-1]) >= 100:
				hundred_long += 1

	except ValueError:
		pass