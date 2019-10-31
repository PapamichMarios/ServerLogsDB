import csv

def main():

	# access.log
	f = open("access.log", "r")
	lines = f.readlines()

	# header for csv
	with open("access.log.csv", "w") as csv_file:
		csv_writer = csv.writer(csv_file, delimiter="\t")
		csv_writer.writerow(["client_ip", "user_id", "timestamp", "http_method", "resource_requested", "http_response_status", "response_size", "referer", "user_agent"])

		# parse data to file
		for line in lines:
			words = line.split()

			# insert into csv
			csv_writer.writerow([words[0], words[2], words[3][1:], words[5][1:], words[6], words[8], words[9], words[10][1:-1], words[11][1:]])   

	csv_file.close()
	f.close()


	# HDFS_DataXceiver.log
	f = open("HDFS_DataXceiver.log", "r")
	lines = f.readlines()

	# header for csv
	with open("HDFS_DataXceiver.log.csv", "w") as csv_file:
		csv_writer = csv.writer(csv_file, delimiter="\t")
		csv_writer.writerow(["timestamp", "block_id", "source_ip", "destination_ip", "size", "type"])

		# parse data to file
		for line in lines:
			words = line.split()

			# insert into csv
			if (words[5] == "Received"):
				csv_writer.writerow([words[0] + words[1], words[2], words[9][1:], words[11][1:], words[14], words[5]])
			elif (words[5] == "Receiving"):
				csv_writer.writerow([words[0] + words[1], words[2], words[9][1:], words[11][1:], '', words[5]])
			elif (words[5] == "writeBlock"):
				continue
			else:
				csv_writer.writerow([words[0] + words[1], words[2], words[5], words[10], '', words[6]])

	csv_file.close()
	f.close()

	# HDFS_FS_Namesystem.log
	f = open("HDFS_FS_Namesystem.log", "r")
	lines = f.readlines()

    # header for csv
	with open("HDFS_FS_Namesystem.log.csv", "w") as csv_file:
		csv_writer = csv.writer(csv_file, delimiter="\t")
		csv_writer.writerow(["timestamp", "block_id", "source_ip", "destination_ip", "type"])

		# parse data to file
		for line in lines:
			words = line.split()

			# insert into csv
			if (words[9] == "replicate"):
				for dest in words[13:]:
					csv_writer.writerow([words[0] + words[1], words[2], words[7], dest, words[9]])
			else:
				csv_writer.writerow([words[0] + words[1], words[2], words[7], '', words[9]])

	csv_file.close()
	f.close()

if __name__ == "__main__":
	main()
