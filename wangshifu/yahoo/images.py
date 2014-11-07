import sys
import os
import time
from multiprocessing import Pool, Queue
from Yahoo import ImageQuery, listAt


thread = 32
task_filename = 'task/keywords.txt'
done_filename = 'task/images.task'
result_filename = 'task/images.txt'

task_queue = Queue()
done_queue = Queue()
result_queue = Queue()

def logger():
	global thread
	worker_done = 0
	try:
		done_file = open(done_filename, 'a+')
		result_file = open(result_filename, 'a+')
		while True:
			if not result_queue.empty():
				result = result_queue.get()
				result_file.write(result + "\n")

			if not done_queue.empty():
				done = done_queue.get()
				if done == "DONE":
					worker_done += 1
				else:
					done_file.write(done + "\n")

			if task_queue.empty() and result_queue.empty() and done_queue.empty() and worker_done == thread:
				return True
	except:
		return False
	finally:
		done_file.close()
		result_file.close()

def worker():
	try:
		while True:
			if not task_queue.empty():
				task = task_queue.get()
				if task:
					data = task.split('^')
					shopId = listAt(data, 0)
					keyword = "%s %s" % (listAt(data, 1), listAt(data, 3))
					if (shopId):
						google = ImageQuery()
						result = google.query(keyword)
						if (not result == False) and (not result == None):
							print "%s--%s" % (shopId, len(result))
							for image in result:
								imageUrl = "%s\t%s" % (shopId, image)
								result_queue.put(imageUrl)
							done_queue.put(task)
						else:
							print result
			else:
				done_queue.put('DONE')
				return True
	except:
		return False

def process(taskId):
	try:
		if taskId:
			return worker()
		else:
			return logger()
	except:
		return False

def main():
	if not os.path.isfile(task_filename):
		print 'Tasks not exist.'
		return None
	tasks = [task.strip('\r').strip('\n').strip() for task in open(task_filename, 'r').readlines()]

	dones = []
	if os.path.isfile(done_filename):
		dones = [task.strip('\r').strip('\n').strip() for task in open(done_filename, 'r').readlines()]

	for task in tasks:
		if not task in dones:
			task_queue.put(task)

	time.sleep(1)

	if not task_queue.empty():
		pool = Pool(thread + 1)
		try:
			pool.map(process, range(thread + 1))
			pool.close()
			pool.join()
			print '\n*************************************'
			print '*           Tasks all done          *'
			print '*************************************'
		except:
			print '\n*************************************'
			print '*        Tasks be terminated        *'
			print '*************************************'
		finally:
			task_queue.cancel_join_thread()
			done_queue.cancel_join_thread()
			result_queue.cancel_join_thread()
			pool.terminate()

def main2():
	tasks = [task.strip('\r').strip('\n').strip() for task in open(task_filename, 'r').readlines(2)]
	data = task.split('^')
	shopId = listAt(data, 0)
	keyword = "%s %s" % (listAt(data, 1), listAt(data, 3))
	if (shopId):
		google = ImageQuery()
		print keyword
		result = google.query(keyword)
		print result
		

if __name__ == '__main__':
	reload(sys) 
	sys.setdefaultencoding('utf8')
	main()