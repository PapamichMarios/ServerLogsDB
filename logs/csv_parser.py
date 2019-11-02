import csv

def main():

	# create csv based on schema
	with open("logs.csv", "w") as csv_file:
		csv_writer = csv.writer(csv_file, delimiter="\t")
		csv_writer.writerow(["log_id", "source_ip", "timestamp", "type"])
	csv_file.close()

	with open("access.csv", "w") as csv_file:
		csv_writer = csv.writer(csv_file, delimiter="\t")
		csv_writer.writerow(["log_id", "user_id", "http_method", "resource", "http_response", "referer", "user_agent"])
	csv_file.close()
	
	with open("hdfs.csv", "w") as csv_file:
		csv_writer = csv.writer(csv_file, delimiter="\t")
		csv_writer.writerow(["log_id", "size"])
	csv_file.close()

	with open("blocks.csv", "w") as csv_file:
		csv_writer = csv.writer(csv_file, delimiter="\t")
		csv_writer.writerow(["log_id", "block_id"])
	csv_file.close()

	with open("destinations.csv", "w") as csv_file:
		csv_writer = csv.writer(csv_file, delimiter="\t")
		csv_writer.writerow(["log_id", "destination_ip"])
	csv_file.close()

	log_id = 0;
	with open("logs.csv", "a") as logs_csv:
		log_writer = csv.writer(logs_csv, delimiter="\t")

		# parse access.log
		f = open("access.log", "r")
		lines = f.readlines()

		with open("access.csv", "a") as access_csv:

			access_writer = csv.writer(access_csv, delimiter="\t")
			# parse data to file
			for line in lines:
				words = line.split()

				log_writer.writerow([log_id, words[0], words[3][1:], "access"])
				access_writer.writerow([log_id, words[2], words[5][1:], words[6], words[8], words[10][1:-1], words[11:-1][1:-1]])

				log_id+=1

		access_csv.close()
		f.close()

		# parse HDFS_DataXceiver.log
		f = open("HDFS_DataXceiver.log", "r")
		lines = f.readlines()

		# header for csv
		with open("hdfs.csv", "a") as hdfs_csv, open("blocks.csv", "a") as blocks_csv, open("destinations.csv", "a") as destinations_csv:
		
			hdfs_writer = csv.writer(hdfs_csv, delimiter="\t")
			blocks_writer = csv.writer(blocks_csv, delimiter="\t")
			destinations_writer = csv.writer(destinations_csv, delimiter="\t")

			# parse data to file
			for line in lines:
				words = line.split()

				if(words[5] == "Received"):
					log_writer.writerow([log_id, words[9][1:], words[0] + words[1], words[5]])
					hdfs_writer.writerow([log_id, words[14]])
					blocks_writer.writerow([log_id, words[7]])
					destinations_writer.writerow([log_id, words[11][1:]])

				elif (words[5] == "Receiving"):
					log_writer.writerow([log_id, words[9][1:], words[0] + words[1], words[5]])
					hdfs_writer.writerow([log_id, ''])
					blocks_writer.writerow([log_id, words[7]])
					destinations_writer.writerow([log_id, words[11][1:]])

				elif (words[6] == "Served"):
					log_writer.writerow([log_id, words[5], words[0] + words[1], words[6]])
					hdfs_writer.writerow([log_id, ''])
					blocks_writer.writerow([log_id, words[8]])
					destinations_writer.writerow([log_id, words[10][1:]])

				log_id +=1

		hdfs_csv.close()
		blocks_csv.close()
		destinations_csv.close()
		f.close()

		# HDFS_FS_Namesystem.log
		f = open("HDFS_FS_Namesystem.log", "r")
		lines = f.readlines()

		with open("hdfs", "a") as hdfs_csv, open("blocks.csv", "a") as blocks_csv, open("destinations.csv", "a") as destinations_csv:
			
			hdfs_writer = csv.writer(hdfs_csv, delimiter="\t")
			blocks_writer = csv.writer(blocks_csv, delimiter="\t")
			destinations_writer = csv.writer(destinations_csv, delimiter="\t")

			# parse data to file
			for line in lines:
				words = line.split()

				# insert into csv
				if (words[9] == "replicate"):
					for dest in words[13:]:
						destinations_writer.writerow([log_id, dest])

					hdfs_writer.writerow([log_id, ''])
					blocks_writer.writerow([log_id, words[10]])
					log_writer.writerow([log_id, words[7], words[0]+words[1], "replicate"])

				elif (words[9] == "delete"):
					for block in words[10:]:
						blocks_writer.writerow([log_id, block])

					hdfs_writer.writerow([log_id, ''])
					# no destinations writer
					log_writer.writerow([log_id, words[7], words[0]+words[1], "delete"])

				log_id +=1
	

		hdfs_csv.close()
		blocks_csv.close()
		destinations_csv.close()
		f.close()

	logs_csv.close()

if __name__ == "__main__":
	main()
